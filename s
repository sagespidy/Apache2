<IfModule security2_module>
    SecRuleEngine on
    ServerTokens Full
    SecServerSignature " Eff_You_Script_Kiddies "
</IfModule>

LogFormat "%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined

tail -f /var/log/apache2/access.log

apache2ctl -t

vim /etc/apache2/apache2.conf

service apache2 reload
service apache2 restart

curl -I localhost

Header set X-XSS-Protection "1; mode=block"
Header always set X-Content-Type-Options "nosniff"
Header always set Strict-Transport-Security "max-age=63072000;includeSubDomains"
Header always append X-Frame-Options SAMEORIGIN
ServerSignature Off
ServerTokens Prod
FileETag None
TraceEnable off
apt-get install php7.0-c* php7.0-d* php7.0-e* php7.0-f*  php7.0-j* php7.0-l* php7.0-m* php7.0-o* php7.0-p* php7.0-r* php7.0-s* php7.0-t* php7.0-x* php7.0-z*
