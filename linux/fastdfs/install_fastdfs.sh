#########################################################################
# File Name: install_fastdfs.sh
# Author: xiezg
# mail: xzghyd2008@hotmail.com
# Created Time: 2018-02-08 15:14:48
# Last modified: 2018-02-08 15:47:13
#########################################################################
#!/bin/bash

download_path='/usr/local/src/'

yum -y install gcc gcc-c++ wget
if [ $? -ne 0 ];then
    echo 'yum install gcc gcc-c++ wget failed'
    exit 1
fi

pushd $download_path

libfastcomlib_name='libfastcommon-1.0.7.tar.gz'
wget https://codeload.github.com/happyfish100/libfastcommon/tar.gz/V1.0.7 -O $libfastcomlib_name
if [ $? -ne 0 ];then
    echo "$libfastcomlib_name download failed"
    exit 1
fi

fastdfs_name='fastdfs-5.08.tar.gz'
wget https://codeload.github.com/happyfish100/fastdfs/tar.gz/V5.08 -O $fastdfs_name
if [ $? -ne 0 ];then
    echo "$fastdfs_name download failed"
    exit 1
fi

tar -zxpvf $libfastcomlib_name
if [ $? -ne 0 ];then
    echo "$libfastcomlib_name unpacked failed"
    exit 1
fi

pushd ${libfastcomlib_name%.tar.gz*}
./make.sh
./make.sh install
popd


tar -zxpvf $fastdfs_name
if [ $? -ne 0 ];then
    echo "$fastdfs_name unpacked failed"
    exit 1
fi

pushd ${fastdfs_name%.tar.gz*}
./make.sh
./make.sh install
popd

popd







