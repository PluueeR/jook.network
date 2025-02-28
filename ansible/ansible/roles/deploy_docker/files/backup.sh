#!/bin/bash

DATE=$(date '+%Y%m%d')

SOURCE=/srv/docker/containers
DESTINATION=/srv/docker/backups
FILENAME=$(hostname)_${DATE}.tar.gz

#Remove backups older then a month
find $DESTINATION -name '*.tar.gz' -mtime +30 -delete

#Stop all Docker containers
docker stop $(docker ps -q)

#Backup Docker
tar -czvf "$DESTINATION"/"$FILENAME" $SOURCE

#Start all Docker containers
docker start $(docker ps -a -q)

#Copy backup to TrueNAS
scp -i ~/.ssh/id_rsa "$DESTINATION"/"$FILENAME"  admin@192.168.10.14:/mnt/pool-1/dataset-1/Backup