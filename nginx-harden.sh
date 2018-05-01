  #return 301 https://$host$request_uri;

#securrity Changes-Start
  server_tokens off;
  more_set_headers 'Server: Eff_You_Script_Kiddies!';
# Securty Changes-End

# to be added in location block
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
add_header X-Frame-Options "SAMEORIGIN";
add_header X-XSS-Protection "1; mode=block";


#SSL Changes
ssl_session_cache  builtin:1000  shared:SSL:10m;
ssl_protocols   TLSv1.1 TLSv1.2;
ssl_ciphers HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
ssl_prefer_server_ciphers on;

real_ip_header X-Forwarded-For;
set_real_ip_from 0.0.0.0/0;

apt-get install nginx-extras -y

service nginx restart
vim /etc/nginx/sites-enabled/default
