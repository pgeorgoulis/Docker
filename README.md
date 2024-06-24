## Table of contents
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [Technologies](#technologies)
- [Setup](#setup)

## General info
This project involves creating and deploying multiple Alpine Linux containers using Docker and Docker compose. 

## Technologies
Docker and Docker compose must be installed to run this project. 
The versions that where used are: 

* Docker: 26.1.4
* Docker compose: 1.29.2

## Setup

1. Clone this repo into your computer
   
   ```git clone https://github.com/pgeorgoulis/Docker.git```
2. Move into the directory
   
    ```cd Docker```
3. Give execute rights to the script
   
   ```chmod +x deploy_alpine.sh```
4. Execute the bash script giving as input the desired slave containers
   
   ```./deploy_alpine.sh <number_of_containers> <master_port> <slave_1_port> ...  <slave_n_port> ```
5. To stop and remove the containers and the temporary files use 
   
   ```clear.sh```
6. To access the terminal of a slave container use: 
   
   ```docker exec -it alpine_slave_1 /bin/sh```


