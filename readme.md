# JChart 《J线正字图/J-chart:innovation of technical analysis》



## serve using voila 

```
voila \
--MappingKernelManager.cull_interval=60 \
--MappingKernelManager.cull_idle_timeout=120 \
--no-browser --port=50009 --base_url=/jchart/ \
--VoilaConfiguration.file_allowlist="['.*']" \
jchart_wdg.ipynb &
          
```

## voila's apache server config.


1. serve on your own apache server as a proxy, with user-defined entry point

edit this file : *{apache_root}/conf/extra/httpd-vhosts.conf*

```
<VirtualHost *:8080>

  <LocationMatch  "/jchart/">
      RewriteEngine on
      RewriteCond %{REQUEST_URI} /jchart/api/kernels/
      RewriteRule .*/jchart/(.*) "ws://127.0.0.1:50009/jchart/$1" [P,L]
      ProxyPreserveHost On
      ProxyPass http://127.0.0.1:50009/jchart/
      ProxyPassReverse  http://127.0.0.1:50009/jchart/
   </LocationMatch>

</VirtualHost>

```

2. restart apache

```
$ sudo apachectl -k restart
```
