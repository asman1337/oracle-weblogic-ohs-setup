#!/bin/bash

# Developer: Asman Mirza
# Email: rambo007.am@gmail.com
# Date: 27 January, 2024

# Common Packages Installation
install_common() {
    sudo $1 update -y
    sudo $1 install -y make gcc binutils glibc glibc-devel libaio libaio-devel libgcc libstdc++ libstdc++-devel unixODBC unixODBC-devel ksh sysstat
}

# Packages on OpenSUSE
install_opensuse() {
    install_common "zypper"
    sudo zypper install -y xorg-x11-driver-video libXext6 libXrender1 libXtst6 libXi6 libgcc_s1 libstdc++6 numactl numactl-devel
    sudo zypper install -y libstdc++6-32bit glibc-32bit libgcc_s1-32bit motif motif-devel libXext6-32bit libXtst6-32bit
}

# Packages on Debian/Ubuntu
install_debian() {
    install_common "apt-get"
    sudo apt-get install -y xorg libxext6 libxrender1 libxtst6 libxi6 libc6 libc6-dev gcc g++ libgcc1 libstdc++6 numactl libnuma-dev
    sudo apt-get install -y libstdc++6:i386 libc6:i386 libgcc1:i386 libmotif-dev libxext6:i386 libxtst6:i386
}

# Packages on Fedora
install_fedora() {
    install_common "yum"
    sudo yum install -y xorg-x11-server-Xorg libXext libXrender libXtst libXi libgcc numactl numactl-devel
    sudo yum install -y libstdc++.i686 glibc.i686 libgcc.i686 motif motif-devel libnsl ncurses-compat-libs apr apr-util compat-libcap1
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        opensuse*|sles)
            install_opensuse
            ;;
        ubuntu|debian)
            install_debian
            ;;
        rhel|centos|fedora|ol)
            install_fedora
            ;;
        *)
            echo "Unsupported distribution: $ID"
            exit 1
            ;;
    esac
else
    echo "Cannot identify the Linux distribution."
    exit 1
fi

echo "Installation complete."
