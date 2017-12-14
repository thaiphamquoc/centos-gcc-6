function install_gcc6 {
    mkdir -p /tmp/gcc6
    cd /tmp/gcc6 && wget https://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2
    cd /tmp/gcc6 && tar xf gcc-6.3.0.tar.bz2
    cd /tmp/gcc6/gcc-6.3.0 && sed -i 's/ftp:\/\//https:\/\//' gcc-6.3.0/contrib/download_prerequisites
    /tmp/gcc6/gcc-6.3.0/contrib/download_prerequisites
    mkdir /tmp/gcc6/gcc-build
    cd /tmp/gcc6/gcc-build && ../gcc-6.3.0/configure --prefix=/home/vagrant/install/gcc-6.3.0 --enable-languages=c,c++ --disable-multilib
    /tmp/gcc6/gcc-build && make -j $THREADS && make install

    ln -s /home/vagrant/install/gcc-6.3.0/bin/gcc /usr/local/bin/gcc-6
    ln -s /home/vagrant/install/gcc-6.3.0/bin/g++ /usr/local/bin/g++-6
    ln -s /home/vagrant/install/gcc-6.3.0/bin/gcc /usr/local/bin/cc
    ln -s /home/vagrant/install/gcc-6.3.0/bin/g++ /usr/local/bin/c++
    
    export CC=gcc-6
    export CXX=g++-6    
}

function main {
    install_gcc6
}

main "$@"
