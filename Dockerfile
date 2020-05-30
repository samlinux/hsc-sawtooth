
# Pull base image.
FROM ubuntu:16.04

# Install some needed things
RUN apt-get update &&  \
    apt-get -y upgrade && \
    apt-get install software-properties-common tree -y && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8AA7AF1F1091A5FD && \
    add-apt-repository 'deb http://repo.sawtooth.me/ubuntu/1.0/stable xenial universe' && \
    apt-get update \
    &&  apt-get install -y sawtooth tree

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]