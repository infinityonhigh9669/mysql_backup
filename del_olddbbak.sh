### Not Finished yet. ###

#! /bin/bash

# TBone Lu
# https://tbonelu.info

function die () {
  echo >&2 "$@"
  exit 1
}

CONFIG=${1:-`dirname $0`/backupmysql.conf}
[ -f "$CONFIG" ] && . "$CONFIG" || die "Could not load configuration file ${CONFIG}!"


if  [ $DELETE = "y" ]; then
  OLDDBS=`cd $BACKDIR; find . -name "*-mysqlbackup.sql.$COMPRESSION_EXTENSION" -mtime +$DAYS`
  REMOVE=`for file in $OLDDBS; do echo -n -e "delete ${file}\n"; done` # will be used in FTP
  cd $BACKDIR; for file in $OLDDBS; do rm -v ${file}; done
  if  [ $DAYS = "1" ]; then
    echo "Yesterday's backup has been deleted."
  else
    echo "The backups from $DAYS days ago and earlier have been deleted."
fi


========================================================================================================
# TBone Lu
# https://tbonelu.info

# your MySQL server's name
SERVER=`hostname -f`
# directory to backup to
BACKDIR=/backup/mysql
# date format that is appended to filename
DATE=`date +'%F-%T'`
# delete old files?
DELETE=n
# how many days of backups do you want to keep?
DAYS=30