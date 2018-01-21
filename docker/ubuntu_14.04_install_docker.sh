#########################################################################
# File Name: ubuntu_install_docker.sh
# Author: xiezg
# mail: xzghyd2008@hotmail.com
# Created Time: 2018-01-21 12:07:48
# Last modified: 2018-01-21 14:24:22
#########################################################################
#!/bin/bash

#Uninstall old versions
function uninstall_old_versions(){
    sudo apt-get remove docker docker-engine docker.io
}

function allow_apt_to_use_a_repository_over_https(){
    sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
}

function install_extra_for_aufs(){
    sudo apt-get update
    sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
}

function add_docker_official_GPG_key(){
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
}

function setup_stable_repository(){
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
}

function list_docker_ce_available_versions(){
    apt-cache madison docker-ce
}

function install_using_the_repository_last_version(){
    sudo apt-get update && sudo apt-get -y install docker-ce
}

function install_using_the_repository_specific_version(){
    sudo apt-get -y install docker-ce=$1
}

function verify_docker_ce_install_correctly(){
    sudo docker run hello-world
}

function install_using_the_repository(){
    echo "allow_apt_to_use_a_repository_over_https"
    allow_apt_to_use_a_repository_over_https

    echo "install_extra_for_aufs"
    install_extra_for_aufs

    echo "add_docker_official_GPG_key"
    add_docker_official_GPG_key

    echo "setup_stable_repository"
    setup_stable_repository

    echo "install_using_the_repository_last_version"
    install_using_the_repository_last_version
}

function install_from_a_package(){
    return
}

function install_using_the_convenience_script(){
    return
}

uninstall_old_versions
install_using_the_repository
verify_docker_ce_install_correctly

