#!/bin/sh
# mysql_backup.sh: backup mysql databases and keep newest 5 days backup.
#
# Last updated: 2017/3/24
#
# mysql login information
# db_user is mysql username
# db_passwd is mysql password
# db_host is mysql host
# -----------------------------
db_user=""
db_passwd=""
db_host=""

# the directory for story your backup file.
backup_dir=""

# date format for backup file (dd-mm-yyyy)
time="$(date +"%Y/%m/%d-%H:%M:%S")"

# mysql, mysqldump and some other bin's path
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
MKDIR="$(which mkdir)"
RM="$(which rm)"
MV="$(which mv)"
GZIP="$(which gzip)"

# check the directory for store backup is writeable
test ! -w $backup_dir && echo "Error: $backup_dir is un-writeable." && exit 0

# the directory for story the newest backup
test ! -d "$backup_dir/backup.0/" && $MKDIR "$backup_dir/backup.0/"

# get all databases
all_db="$($MYSQL -u $db_user -h $db_host -p$db_passwd -Bse 'show databases')"

for db in $all_db
do
	$MYSQLDUMP -u $db_user -h $db_host -p$db_passwd $db | $GZIP -9 > "$backup_dir/backup.0/$time.$db.gz"
done

# delete the oldest backup
test -d "$backup_dir/backup.5/" && $RM -rf "$backup_dir/backup.5"

# rotate backup directory
for int in 4 3 2 1 0
do
	if(test -d "$backup_dir"/backup."$int")
	then
		next_int=`expr $int + 1`
		$MV "$backup_dir"/backup."$int" "$backup_dir"/backup."$next_int"
	fi
done

exit 0;