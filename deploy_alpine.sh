#!/bin/bash

# Check for arguments
if [ $# -lt 3 ]; then
    echo "Usage: $0 <number_of_slaves> <master_port> <slave_port_1> <slave_port_2> ... <slave_port_n>"
    exit 1
fi

NUM_SLAVES=$1
MASTER_PORT=$2
shift 2
SLAVE_PORTS=("$@")

# Check if num of slaves == num of slave ports
if [ ${#SLAVE_PORTS[@]} -ne $NUM_SLAVES ]; then
    echo "Error: The number of slave ports is not equal to the number of slaves"
    exit 1
fi

# Create temporary directory
mkdir -p tmp
currentDirectory=$(pwd)

# Create the docker-compose.yml file
cat << EOF > $currentDirectory/docker-compose.yml
version: "3.8"
services:
  alpine_master:
    image: alpine:latest
    container_name: alpine_master
    hostname: alpine_master
    expose:
      - "80"
    ports:
      - "${MASTER_PORT}:80"
    networks:
      alpine_net:
    restart: unless-stopped
    command: /bin/sh

EOF

# Add Alpine Slaves to the file
for q in $(seq 1 $NUM_SLAVES); do
cat << EOF >> $currentDirectory/docker-compose.yml
  alpine_slave_$q:
    image: alpine:latest
    container_name: alpine_slave_$q
    hostname: alpine_slave_$q
    expose:
      - "80"
    ports:
      - "${SLAVE_PORTS[$((q-1))]}:80"
    networks:
      alpine_net:
    restart: unless-stopped
    command: /bin/sh

EOF
done

# Add the network to docker-compose.yml
cat << EOF >> $currentDirectory/docker-compose.yml
networks:
  alpine_net:
    driver: bridge
EOF

# Run Docker Compose to deploy the containers
docker-compose up -d
