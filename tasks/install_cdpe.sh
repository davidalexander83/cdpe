#!/bin/bash
docker pull puppet/continuous-delivery-for-puppet-enterprise:latest
PFI=$(dd bs=1 if=/dev/urandom count=16 2>/dev/null | base64)

sudo tee /etc/systemd/system/cdpe.service <<EOF

[Unit]
Description=CDPE Container
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStart=/usr/bin/docker run --rm -d --name cd4pe -v cd4pe:/disk -e DB_ENDPOINT=mysql://$PT_dbserver:3306/$PT_database -e DB_USER=$PT_user -e DB_PASS=$PT_pass -e DUMP_URI=dump://localhost:7000 -e PFI_SECRET_KEY=$PFI -p 8080:8080 -p 8000:8000 -p 7000:7000 puppet/continuous-delivery-for-puppet-enterprise:latest

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl enable cdpe.service
sudo systemctl start cdpe.service
