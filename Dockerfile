FROM ubuntu:trusty
MAINTAINER Maciej Czyzowicz <czyzu01@gmail.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to PL
RUN sed -i "s/http:\/\/archive./http:\/\/pl.archive./g" /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
    -o APT::Instal-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

# Create virutal environment
# Upgrade PIP in virutal environment to latest version
RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade

# Add entry point script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend
