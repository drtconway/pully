FROM ubuntu:groovy

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && \
    apt install -y tzdata && \
    apt install -y \
        python3-pip \
        pypy3 && \
    pypy3 -m pip install docopt
ADD pully /usr/local/bin
