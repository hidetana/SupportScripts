#!/bin/sh

# How to use:
#  1. Set you database name at DBNAME, your user name at USERNAME and your password at PASSWORD
#  2. Set execution permision to this file. e.g. chmod 755 
#     If your user account haven't permission of administration, 
#     please customize pg_dump command line for your environment.
#
# Option: 
# This script also include deletion of the backup files in past.
# Default is 3 months ago. If you change the term of storing backup file, please change the value in the DELETEDAY.

DBNAME=set_your_db_name_here
USERNAME=set_your_user_name
PASSWORD=set_your_password

TODAY=`date '+%F'`
DELETEDAY=`date -d '3 months ago' '+%F'`

mysqldump -u${USERNAME} -p${PASSWORD} ${DBNAME} > ${DBNAME}_$TODAY.sql
gzip ${DBNAME}_$TODAY.sql

# REMOVE BACKUP FILE PAST
if [ -e ${DBNAME}_$DELETEDAY.sql.gz ]; then
        rm ${DBNAME}_$DELETEDAY.sql.gz
fi
