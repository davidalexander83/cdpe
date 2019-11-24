#!/bin/bash
# Create new MySQL database.

# Environment-configurable variables
MYSQLUSER=$PT_mysqluser
MYSQLPASS=$PT_mysqlpass

MYSQL=`which mysql`
Q1="CREATE DATABASE IF NOT EXISTS $PT_database;"
Q2="GRANT ALL ON *.* TO '$PT_user'@'%' IDENTIFIED BY '$PT_pass';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

$MYSQL -u$MYSQLUSER -p$MYSQLPASS -e "$SQL"