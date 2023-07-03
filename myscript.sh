#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

check_exit_status() {
    if [ $? -ne 0]
    then
        echo "an error occured, please check the $errorlog file."
    fi
}


if grep -q "Arch" $release_file
then
    #The host is based on Arch, run e pacman update command
    sudo pacman -Syu 1>>$logfile 2>>$errorlog 
    check_exit_status();
fi

if grep -q "Pop" $release_file || grep -q "Ubuntu" $release_file
then
    # The host is based on Debian or Ubuntu
    # Run the version of the command
    sudo apt update 1>>$logfile 2>>$errorlog
    check_exit_status();
    sudo apt dist-upgrade -y 1>>$logfile 2>>$errorlog
    check_exit_status();
fi