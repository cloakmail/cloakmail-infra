#!/bin/bash

# Slightly modified version of
# https://stackoverflow.com/questions/49090395/how-to-achieve-a-rolling-update-with-docker-compose

CONTAINER_NAME="$1"
if [ -z "$CONTAINER_NAME" ]; then
    echo "Specify the name of the container to update as first argument."
    exit 1
fi

PREVIOUS_CONTAINER=$(docker ps --format "table {{.ID}}  {{.Names}}  {{.CreatedAt}}" | grep "$CONTAINER_NAME" | awk -F  "  " '{print $1}')
docker-compose pull "$CONTAINER_NAME"
docker-compose up -d --no-deps --scale "$CONTAINER_NAME"=2 --no-recreate "$CONTAINER_NAME"
sleep 60
docker kill -s SIGTERM "$PREVIOUS_CONTAINER"
sleep 1
docker rm -f "$PREVIOUS_CONTAINER"
docker-compose up -d --no-deps --scale "$CONTAINER_NAME"=1 --no-recreate "$CONTAINER_NAME"
