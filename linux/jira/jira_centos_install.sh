#########################################################################
# File Name: install.sh
# Author: xiezg
# mail: xzghyd2008@hotmail.com
# Created Time: 2018-02-05 17:22:14
# Last modified: 2018-02-07 21:18:52
#########################################################################
#!/bin/bash

yum -y install wget


mysql_jdbc_name='mysql-connector-java-5.1.45.tar.gz'
wget https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.45.tar.gz --output-document=$mysql_jdbc_name

if [ $? -ne 0 ];then
    echo "download $mysql_jdbc_name failed"
    exit 1
fi

if [ "$(md5sum $mysql_jdbc_name|cut -d " " -f 1)" != "ab9ac454a959859a297b53bdbf156f3c" ];then
    echo 'mysql-connector-java-5.1.45.tar.gz chsum failed'
    exit 1
fi

exit

rpm -ivh jdk-8u161-linux-x64.rpm

yum install -y mysql-server.x86_64 mysql-connector-java.noarch

chkconfig mysqld on

service mysqld start

read -p 'mysql root default password:' mysql_root_pwd
/usr/bin/mysqladmin -u root -h localhost password $mysql_root_pwd

mysql --user=root --password="$mysql_root_pwd" <<EOF
CREATE USER 'jira'@'localhost' IDENTIFIED BY PASSWORD '*62B97B4F8AA8F4A6675075699728BC5A88E15C31';
CREATE DATABASE jiradb CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON jiradb.* TO 'jira'@'localhost';
flush privileges;
SHOW GRANTS FOR jira@'localhost';
EOF

