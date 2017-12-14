FROM centos:7.3.1611
MAINTAINER tpham

USER root

ENV GCC_VERSION="6.3.0" \
    THREADS=4

RUN yum install -y gcc gcc-c++
RUN yum install -y git cmake wget
RUN yum install -y bzip2
RUN yum install -y make

COPY scripts/build /my_build
RUN /my_build/install.sh && rm -rf /my_build
