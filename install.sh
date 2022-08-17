#! /bin/bash

. ./common.sh

IsCurrentRoot(){
    user=$(env | grep USER | cut -d "=" -f 2) 
    if [ "$user"x == "root"x ]; then
        return 0
    fi
    return 1
}

CheckCurrentRoot(){
    IsCurrentRoot
    if [[ $? == 0 ]]; then
        PrintGreen "Is root"
        is_root=true
    else
        PrintYellow "Is not root"
        is_root=false
    fi
}

WriteRoot(){
    Exec 'cat ./bashrc >> /etc/bashrc'
    Exec 'cat ./inputrc >> /etc/inputrc'
    Exec 'cat ./vimrc >> /etc/vimrc'
}

WriteNotRoot(){
    Exec 'cat ./bashrc >> ~/.bashrc'
    Exec 'cat ./inputrc >> ~/.inputrc'
    Exec 'cat ./vimrc >> ~/.vimrc'
}

Write(){
    if [[ "$is_root" == true ]]; then
        Exec WriteRoot
    else
        Exec WriteNotRoot
    fi
}

Main(){
    Exec CheckCurrentRoot
    Exec Write
}

Main "$@"