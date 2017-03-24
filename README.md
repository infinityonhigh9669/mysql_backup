  
This is a shell script that backs up your MySQL servers.  It can talk to as many servers as you'd like (remote or local), and has some features to filter out specific databases and table names.

### Requirements
To backup databases locally, you'll only need bash and gzip, which ship with just about all Linux distros.

To backup to FTP, you'll need the 'ftp' program.

To backup to email, you'll need the 'mutt' program.


### Backing up multiple servers
For each server you're backing up, you will need to copy/paste the block under `MySQL Settings` and increment the key in brackets (e.g. the first server will be 0, the next will be 1, and so on).
