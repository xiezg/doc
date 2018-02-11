#########################################################################
# File Name: install_nginx.sh
# Author: xiezg
# mail: xzghyd2008@hotmail.com
# Created Time: 2018-02-11 16:25:25
# Last modified: 2018-02-11 22:00:50
#########################################################################
#!/bin/bash

download_path='/usr/local/src/'

yum -y install pcre-devel zlib-devel gcc wget
if [ $? -ne 0 ];then
    echo "pcre-devel gcc install failed"
    exit 1
fi


pushd $download_path

nginx_filename='nginx-1.13.8.tar.gz'
wget http://nginx.org/download/nginx-1.13.8.tar.gz -O $nginx_filename
if [ $? -ne 0 ];then
    echo "$filename download failed"
    exit 1
fi

tar -zxpvf $nginx_filename
if [ $? -ne 0 ];then
    echo "$nginx_filename unpacked failed"
    exit 1
fi

pushd ${nginx_filename%.tar.gz*}
./configure && make && make install

if [ $? -ne 0 ];then
    echo "$nginx_filename build install failed"
    exit 1
fi
popd

popd
