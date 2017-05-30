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

# Install apache2

apt-get install -y apache2
apt-get install libapache2-mod-php7.0 -y
apt-get install libapache2-modsecurity -y


echo -e "\n\n\n"
echo "			Apache Installed	"
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
# Enable Various module's
echo "Enabling Various Modules"

a2enmod php7.0
a2enconf php7.0-fpm
a2enmod rewrite
a2enmod proxy_fcgi setenv
a2enmod headers
a2enmod mod-security


echo -e "\n\n\n"
echo "		Required Modules Enabled"
echo -e "\n\n\n"

# Increase post_max_size to 20 M
sed -i 's/post_max_size = 8M/post_max_size = 20M/'  /etc/php/7.0/apache2/php.ini
#Increase upload_max_size

sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/'  /etc/php/7.0/apache2/php.ini
#Increase KeepAliveTimeout
sed -i 's/KeepAliveTimeout 5/KeepAliveTimeout 60/' /etc/apache2/apache2.conf


# Making Apache Server Secure
echo " Header set X-XSS-Protection "1; mode=block" " >> /etc/apache2/apache2.conf
echo "Header always set X-Content-Type-Options "nosniff" " >>/etc/apache2/apache2.conf
echo "Header always set Strict-Transport-Security "max-age=63072000;includeSubDomains"" >>/etc/apache2/apache2.conf

# Stop Click JAcking
echo "Header always append X-Frame-Options SAMEORIGIN" >> /etc/apache2/apache2.conf
# Stop displaying Apache Version
echo "ServerSignature Off" >> /etc/apache2/apache2.conf

# Show servertoken as Apache
echo "ServerTokens Prod" >> /etc/apache2/apache2.conf

#Disable Etag
echo "FileETag None" >>/etc/apache2/apache2.conf
#Disable Trace
echo " TraceEnable off" >>/etc/apache2/apache2.conf
#enable actual ip Logging

sed -i 's/LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined/LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined/' /etc/apache2/apache2.conf

#Enable Directory permissions
#echo -e "<Directory /var/www/html> \n Options  FollowSymLinks\n AllowOverride all \n Require all granted \n </Directory>"  >> /etc/apache2/sites-enabled/000-default.conf

echo " 			Restarting Apache "
echo -e "\n\n\n"

systemctl restart apache2

echo "			Apache Restarted"
echo -e " \n\n\n "
echo -e "\n\n\n\n\n\n"
echo -e "\n\n\n\n\n\n"

echo "Creating a New User...."

echo -e " \n\n\n "

echo " Please enter the name of user: "
# Take input from user

usr_name=lvme

# Create a directory for user

mkdir -p /var/www/html/$usr_name

# Make a new user and  set his Password
useradd $usr_name -d /home/$usr_name -s /bin/bash

#chown -R $usr_name:$usr_name /var/www/html/$usr_name

echo "$usr_name:$usr_name-123#@"|chpasswd


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
echo -e "\n\n\n\n\n\n"
echo -e "\n\n\n\n\n\n"



#install postfix



DEBIAN_FRONTEND=noninteractive  apt-get install -y postfix
