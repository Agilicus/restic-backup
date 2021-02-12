#!/bin/bash
set -e

exec 1>/proc/1/fd/1
exec 2>/proc/1/fd/2

log() {
    echo "$(date -Is): $*"
}

log "Wake backup, dir is $RESTIC_BACKUP_DIR"

if [ -n "$(ls $RESTIC_BACKUP_DIR)" ]
then
    log "Files exist to backup"
    /usr/bin/restic backup --cleanup-cache -q --host=$RESTIC_HOSTNAME $RESTIC_BACKUP_DIR
    find $RESTIC_BACKUP_DIR -type f -mmin +30 -exec rm {} \;
fi

