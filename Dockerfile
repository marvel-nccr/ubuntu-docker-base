# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# Based on Ubuntu 18.04 since v0.11
FROM phusion/baseimage:0.11

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y software-properties-common

# Fix issue with postgresql not starting
# https://forums.docker.com/t/error-in-docker-image-creation-invoke-rc-d-policy-rc-d-denied-execution-of-restart-start/880
RUN echo exit 0 > /usr/sbin/policy-rc.d

# acl fixes ansible permissions issue for unprivileged users
# See http://docs.ansible.com/ansible/latest/user_guide/become.html#becoming-an-unprivileged-user
# Note: Docker service needs to run with -s devicemapper
# echo 'DOCKER_OPTS="-H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock -s devicemapper"' | sudo tee /etc/default/docker > /dev/null
RUN apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && apt-get install -y git ansible sudo

RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# add ubuntu user with sudo privileges
RUN useradd -m -s /bin/bash --groups sudo,adm ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown -R ubuntu:ubuntu /home/ubuntu

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
