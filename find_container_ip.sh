#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <container_name>"
    exit 1
fi

CONTAINER_NAME=$1
CONTAINER_HOSTNAME=$(docker exec "$CONTAINER_NAME" hostname)
CONTAINER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_NAME")

echo "Container Name: $CONTAINER_HOSTNAME"
echo "Container IP: $CONTAINER_IP"
