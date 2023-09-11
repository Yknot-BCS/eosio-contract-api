#!/bin/bash

# Define the path to the backup directory
BACKUP_DIR="./backups"

# Docker Compose service name for the PostgreSQL container
PG_SERVICE_NAME="eosio-contract-api-postgres"

# Prompt for the backup file to restore
echo "Available backup files:"
ls "$BACKUP_DIR"

read -p "Enter the backup file name to restore (e.g., backup_20230911120000.sql): " BACKUP_FILE

# Check if the backup file exists
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_DIR/$BACKUP_FILE"
    exit 1
fi

# Stop the PostgreSQL container
docker stop $PG_SERVICE_NAME

# Restore the database from the backup
docker exec -i $PG_SERVICE_NAME psql -U root -d your_database_name <"$BACKUP_DIR/$BACKUP_FILE"

# Start the PostgreSQL container
docker start $PG_SERVICE_NAME

echo "Database restored successfully from $BACKUP_FILE"
