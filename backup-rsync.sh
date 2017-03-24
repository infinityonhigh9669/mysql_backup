#!/bin/sh

# connection info
REMOTE_HOST=
REMOTE_USER=root
REMOTE_PORT=22

# path to private key
KEY=

# path to pull files from
LOCAL_PATH=/backup

# path to push files to
REMOTE_PATH=/backup

# start the backup
rsync -au -v -e 'ssh -p '$REMOTE_PORT' -i '$KEY'' $LOCAL_PATH $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH