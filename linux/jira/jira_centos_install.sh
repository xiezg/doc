#########################################################################
# File Name: install.sh
# Author: xiezg
# mail: xzghyd2008@hotmail.com
# Created Time: 2018-02-05 17:22:14
# Last modified: 2018-02-06 11:18:54
#########################################################################
#!/bin/bash

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
EOF

