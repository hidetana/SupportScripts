#!/bin/sh

# How to use:
#  1. Set you database name at DBNAME
#  2. Set execution permision to this file. e.g. chmod 755 
#     If your user account haven't permission of administration, 
#     please customize pg_dump command line for your environment.
#
# Option: 
# This script also include deletion of the backup files in past.
# Default is 3 months ago. If you change the term of storing backup file, please change the value in the DELETEDAY.

DBNAME=set_your_db_name_here

TODAY=`date '+%F'`
DELETEDAY=`date -d '3 months ago' '+%F'`

pg_dump ${DBNAME} > ${DBNAME}_$TODAY.sql
gzip ${DBNAME}_$TODAY.sql

# REMOVE BACKUP FILE PAST
if [ -e ${DBNAME}_$DELETEDAY.sql.gz ]; then
        rm ${DBNAME}_$DELETEDAY.sql.gz
fi
