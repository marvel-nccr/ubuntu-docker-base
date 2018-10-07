# ubuntu-docker-base

Docker base image for ansible provisioning using Ubuntu, 
e.g. for testing ansible roles.

[marvelnccr/ubuntu-docker-base](https://hub.docker.com/r/marvelnccr/ubuntu-docker-base/)
 is based on the [phusion](http://phusion.github.io/baseimage-docker) baseimage.

 * the v1.x series is based on Ubuntu 16.04 LTS
 * the v2.x series is based on Ubuntu 18.04 LTS

## Usage

```shell
docker pull marvelnccr/ubuntu-docker-base:latest  # latest version
docker pull marvelnccr/ubuntu-docker-base:1.0     # v1.0 tag
```
Using a specific tag is strongly recommended for reprodible builds.

## Acknowledgements

We acknowledge support from the [NCCR MARVEL](http://nccr-marvel.ch/) 
funded by the Swiss National Science Foundation and the 
EU Centre of Excellence "[MaX – Materials Design at the Exascale](http://www.max-centre.eu/)". 
(Horizon 2020 EINFRA-5, Grant No. 676598).
