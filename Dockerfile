FROM centos:7.3.1611
MAINTAINER tpham

USER root

ARG gcc_version="6.3.0"
ARG threads=4
ARG work_dir=/tmp/gcc6

RUN yum -y clean all; \
    yum install -y gcc gcc-c++ git cmake wget bzip2 make

WORKDIR ${work_dir}
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-${gcc_version}/gcc-${gcc_version}.tar.bz2 && tar xf gcc-${gcc_version}.tar.bz2 && \
    sed -i s/ftp:/https:/ gcc-${gcc_version}/contrib/download_prerequisites && \
    cd gcc-${gcc_version} && ./contrib/download_prerequisites && \
    cd .. && mkdir gcc-build && cd gcc-build && ../gcc-${gcc_version}/configure --prefix=/home/vagrant/install/gcc-${gcc_version} --enable-languages=c,c++ --disable-multilib && \
    make -j $threads && make install && \
    rm -rf ${work_dir}

WORKDIR /

RUN ln -s /home/vagrant/install/gcc-${gcc_version}/bin/gcc /usr/local/bin/gcc-6 && \
    ln -s /home/vagrant/install/gcc-${gcc_version}/bin/g++ /usr/local/bin/g++-6 && \
    ln -s /home/vagrant/install/gcc-${gcc_version}/bin/gcc /usr/local/bin/cc && \
    ln -s /home/vagrant/install/gcc-${gcc_version}/bin/g++ /usr/local/bin/c++

ENV CC=gcc-6 \
    CXX=g++-6
