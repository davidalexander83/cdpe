#!/bin/bash
docker pull puppet/continuous-delivery-for-puppet-enterprise:latest
PFI=$(dd bs=1 if=/dev/urandom count=16 2>/dev/null | base64)
docker run --rm --name cd4pe -v cd4pe:/disk -e DB_ENDPOINT=mysql://$PT_dbserver:3306/$PT_database -e DB_USER=$PT_user -e DB_PASS=$PT_pass -e DUMP_URI=dump://localhost:7000 -e PFI_SECRET_KEY=$PFI -p 8080:8080 -p 8000:8000 -p 7000:7000 puppet/continuous-delivery-for-puppet-enterprise:latest

