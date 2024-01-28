#!/bin/bash

# Developer: Asman Mirza
# Email: rambo007.am@gmail.com
# Date: 27 January, 2024

# Download and install JDK 8 on openSUSE, Fedora(Oracle, RHEL)
install_jdk8() {
    echo "Downloading JDK8 RPM..."
    wget -c --no-cookies --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm"
    echo "Installing JDK8..."
    sudo rpm -ivh jdk-8u202-linux-x64.rpm
}

# Java installation and version
check_java() {
    if type -p java; then
        echo "Found Java executable in PATH"
        _java=java
    elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
        echo "Found Java executable in JAVA_HOME"
        _java="$JAVA_HOME/bin/java"
    else
        echo "No Java installation found."
        # if the script is running on openSUSE or RHEL
        if [[ -f "/etc/os-release" ]]; then
            . /etc/os-release
            if [[ "$ID" == "suse" ]] || [[ "$ID_LIKE" == "suse" ]] || [[ "$ID" == "rhel" ]] || [[ "$ID" == "ol" ]]; then
                install_jdk8
                return
            fi
        fi
        echo "Please install Java 8 or later."
        exit 1
    fi

    if [[ "$_java" ]]; then
        version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
        echo "Java version: $version"
        if [[ "$version" < "1.8" ]]; then
            echo "Java version is less than 1.8. Please update Java."
            exit 1
        fi
    fi
}

# Download Middleware Infrastructure
download_infrastructure() {
    wget -c --no-cookies --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "https://download.oracle.com/otn/nt/middleware/12c/122140/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip"
}

# Download Oracle HTTP Server
download_ohs() {
    wget -c --no-cookies --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "https://download.oracle.com/otn/nt/middleware/12c/122140/fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1.zip"
}

# Install Middleware Infrastructure
install_infrastructure() {
    if [ -f "fmw_12.2.1.4.0_infrastructure.jar" ]; then
        echo "Installing Middleware Infrastructure..."
        java -jar fmw_12.2.1.4.0_infrastructure.jar
    elif [ -f "fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip" ]; then
        echo "Unzipping Middleware Infrastructure..."
        unzip fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip
        echo "Installing Middleware Infrastructure..."
        java -jar fmw_12.2.1.4.0_infrastructure.jar
    else
        echo "Downloading Middleware Infrastructure..."
        download_infrastructure
        unzip fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip
        echo "Installing Middleware Infrastructure..."
        java -jar fmw_12.2.1.4.0_infrastructure.jar
    fi
}

# Install Oracle HTTP Server
install_ohs() {
    if [ -f "fmw_12.2.1.4.0_ohs_linux64.bin" ]; then
        echo "Installing Oracle HTTP Server..."
        chmod +x fmw_12.2.1.4.0_ohs_linux64.bin
        ./fmw_12.2.1.4.0_ohs_linux64.bin
    elif [ -f "fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1.zip" ]; then
        echo "Unzipping Oracle HTTP Server..."
        unzip fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1.zip
        echo "Installing Oracle HTTP Server..."
        chmod +x fmw_12.2.1.4.0_ohs_linux64.bin
        ./fmw_12.2.1.4.0_ohs_linux64.bin
    else
        echo "Downloading Oracle HTTP Server..."
        download_ohs
        unzip fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1.zip
        echo "Installing Oracle HTTP Server..."
        chmod +x fmw_12.2.1.4.0_ohs_linux64.bin
        ./fmw_12.2.1.4.0_ohs_linux64.bin
    fi
}

# Main
case "$1" in
    --in)
        check_java
        install_infrastructure
        ;;
    --ohs)
        check_java
        install_ohs
        ;;
    *)
        echo "Usage: $0 [--in | --ohs]"
        echo "Options:"
        echo "  --in   Install Middleware Infrastructure"
        echo "  --ohs  Install Oracle HTTP Server"
        echo "The script checks for Java installation. If Java is not found and the OS is openSUSE, it will attempt to download and install JDK 8."
        exit 1
        ;;
esac
