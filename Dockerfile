FROM ubuntu:18.04

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
    apt-get update && apt-get install -y \
      sudo \
      git \
      ansible \
      acl

RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# add ubuntu user with sudo privileges
RUN useradd -m -s /bin/bash --groups sudo,adm ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown -R ubuntu:ubuntu /home/ubuntu

# clear apt cache to reduce image size
RUN  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/init"]
