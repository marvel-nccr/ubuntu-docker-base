FROM ubuntu:xenial

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && apt-get install -y git ansible sudo && \
    rm -rf /var/lib/apt/lists/*

RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# add ubuntu user with sudo privileges
RUN useradd -m -s /bin/bash --groups sudo,adm ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown -R ubuntu:ubuntu /home/ubuntu

ENTRYPOINT ["/sbin/init"]
