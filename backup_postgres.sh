#!/bin/bash

# Define the backup directory and retention period
# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Define the backup directory relative to the script's directory
BACKUP_DIR="$SCRIPT_DIR/backups"
RETENTION_PERIOD=7 # Number of days to keep backups

# Timestamp for the backup file
TIMESTAMP=$(date +\%Y\%m\%d\%H\%M\%S)

# Docker Compose service name for the PostgreSQL container
PG_SERVICE_NAME="eosio-contract-api-postgres"

# Perform the PostgreSQL backup
docker exec -t $PG_SERVICE_NAME pg_dump -U root -d atomic-telos >"$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Clean up old backups
find "$BACKUP_DIR" -type f -name 'backup_*' -mtime +$RETENTION_PERIOD -exec rm {} \;
