# Expires map
map $sent_http_content_type $expires {
    default                    off;
    text/html                  epoch;
    text/css                   max;
    application/javascript     max;
    ~image/                    max;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server;

  server_name {{ inventory_hostname }};

  expires $expires;

  root /var/www/project;
  index index.php index.html index.htm;

  # Set cookie size
  large_client_header_buffers 4 64k;
  fastcgi_buffers 16 64k; 
  fastcgi_buffer_size 64k;

  location / {
    try_files $uri $uri/ /index.php?$query_string;
  }

  # pass the PHP scripts to FastCGI
  location ~ \.php$ {
    try_files $uri /index.php =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
  }

  # deny access to .htaccess files, if Apache's document root
  # concurs with nginx's one
  location ~ /\.ht {
    deny all;
  }
}