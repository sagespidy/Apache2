#!/bin/bash
if [ $UID -ne 0 ] ; then
echo " 403 Error !!.  Please run me as root"
exit
fi


echo "#################################################################################################################"
echo "#                                                                                                               #"
echo "# 		Welcome!! This script will  install php-backend eviroment                                     #"
echo "#                                                       							      #"
echo "#################################################################################################################"
echo -e "\n\n\n"
echo " 				Updating System files... "
echo -e "\n\n\n"

apt-get update -y

echo -e "\n\n\n"
echo " 			Done Updating... "
echo -e "\n\n\n";
echo " 			Installing Apache... "

# Install nginx
apt-get install nginx -y
apt-get install nginx-extras -y


wget https://raw.githubusercontent.com/sagespidy/Apache2/master/nginx-php.conf
mv nginx-php.conf default
mv default /etc/nginx/sites-enabled/default
echo -e "\n\n\n"
echo "			Nginx Installed	"
echo -e "\n\n\n"
echo  "			Installing PHP 7..."
echo -e "\n\n\n"
#install php7

apt-get -y install php7.0*
apt-get remove php7.0-snmp -y

echo -e "\n\n\n"
echo "			PHP 7 Installed.	"
echo -e "\n\n\n"
echo -e "\n\n\n"

echo "		Installing MySql Client...	"
echo -e "\n\n\n"
# install MySql


apt-get install -y mysql-client


echo -e "\n\n\n"
echo "		Mysql client installed"
echo -e "\n\n\n"



echo "			Apache Restarted"
echo -e " \n\n\n "
echo -e "\n\n\n\n\n\n"
echo -e "\n\n\n\n\n\n"

echo "Creating a New User...."

echo -e " \n\n\n "

echo " Please enter the name of user: "
# Take input from user

usr_name=sportsstar

# Create a directory for user

mkdir -p /var/www/html/

# Make a new user and  set his Password
useradd $usr_name -d /var/www/html -s /bin/bash

chown -R $usr_name:$usr_name /var/www/html/

echo "$usr_name:$usr_name-%^(*)%$&^gjvgtyyi7675"|chpasswd


# Enable SSH login

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

service ssh restart

echo -e "\n\n\n\n\n\n"
echo -e "\n\n\n\n\n\n"
echo "SSH via Password Authentication enabled"

echo "$usr_name  ALL=NOPASSWD:ALL #Sudo rights for $usr_name  " >>/etc/sudoers

echo "Sudo rights to $usr_name has been been provided with NOPASSWD Authentication"

echo -e "\n\n\n\n\n\n"

echo "Synchronizing System Time"

apt-get install -y ntp
apt-get install -y htop ncdu zip unzip
echo -e "\n\n\n\n\n\n"
echo -e "\n\n\n\n\n\n"
