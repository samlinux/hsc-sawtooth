# Hyperledger sawtooth docker test environment
## Use a docker image for sawtooth 1.0.5

This is a docker based sawtooth playground for the Hyperledger Study Circle.

[The example is based on the official documentation 1.0.5.](https://sawtooth.hyperledger.org/docs/core/releases/1.0.5/app_developers_guide/ubuntu.html#installing-sawtooth)

You need 5 terminals and a running docker environment for this example. To install docker on your OS follow this link [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/).

To run this example you have two options:

1. create and build your own image
2. pull a pre build image from docker hub

## (1) Create docker image
Build your own and adapted docker image.
```bash
build -t samlinux/sawtooth_1.0.5:1 .
```

Check if the image is there.
```bash
docker images |grep sawtooth
sawtooth_1.0.5
```

## (2) Pull the pre build image
Pull the pre build image from docker hub [https://hub.docker.com/r/samlinux/hsc-sawtooth_1.0.5](https://hub.docker.com/r/samlinux/hsc-sawtooth_1.0.5).

```bash
docker pull samlinux/hsc-sawtooth_1.0.5
```

##  Run the image as container
Run the docker container in the background.
```bash
docker run -d --name sawtooth -it samlinux/hsc-sawtooth_1.0.5:1
```

Remove exited containers
```bash
docker rm $(docker ps -a -f status=exited -q)
```

Access the running container
```bash
docker exec -it sawtooth bash

# exit from the container
exit
```

Check installation
```bash
# check ubuntu version
lsb_release -a

# check if sawtooth packages are installed
dpkg -l '*sawtooth*'
```

## Stop the running container
```bash
docker stop sawtooth  
``` 

## Remove the container
```bash
docker rm sawtooth
``` 

## Remove the image
```bash
docker rmi samlinux/hsc-sawtooth_1.0.5:1
``` 

# Sawtooth related part
## Creating the Genesis Block

```bash
sawtooth keygen
sawset genesis
sawadm genesis config-genesis.batch
```

## Starting the Validator
```bash
sawadm keygen
sawtooth-validator -vv
```

## Starting the REST API
Open a new terminal and jump into the container.
```bash
# switch into the container
docker exec -it sawtooth bash

# start the api
sawtooth-rest-api -v
```

## Starting the IntegerKey Transaction Processor
Open a new terminal and jump into the container.
```bash 
# switch into the container
docker exec -it sawtooth bash

# start an IntegerKey transaction processor
intkey-tp-python -v
```

## Starting the Settings Family Transaction Processor
Open a new terminal and jump into the container.
```bash 
# switch into the container
docker exec -it sawtooth bash

# start the Settings family transaction processor
settings-tp -v
```

## Verifying that the REST API is Running
Open a new terminal and jump into the container.
```bash
# switch into the container
docker exec -it sawtooth bash

# check if REST API is running
ps aux | grep sawtooth-rest-api
```

## Configuring the List of Transaction Families (Ubuntu version)
To create and submit the batch containing the new settings, enter the following command:

```bash
# switch into the container
docker exec -it sawtooth bash

sawset proposal create sawtooth.validator.transaction_families='[{"family": "intkey", "version": "1.0"}, {"family":"sawtooth_settings", "version":"1.0"}]'
```

## Creating and Submitting Transactions

Run the following commands:
```bash 
intkey create_batch

intkey load
```

## Viewing Blocks and State
Enter the command sawtooth block list to view the blocks stored by the state:
```bash
sawtooth block list

```

## Viewing a Particular Block
Using the output from the sawtooth block list above, copy the block id you want to view, then paste it in place of {BLOCK_ID} in the following sawtooth block show command:
```bash 
sawtooth block show {Block ID}
```

## Viewing Global State
Use the command sawtooth state list to list the nodes in the Merkle tree:
```bash
sawtooth state list
```

## Viewing Data in a Node
You can use sawtooth state show command to view data for a specific node. Using the output from the sawtooth state list command above, copy the node id you want to view, then paste it in place of {NODE_ID} in the following command:
```bash
sawtooth state show {NODE_ID}
```