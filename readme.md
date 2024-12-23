# JChart 《J线正字图/J-chart:innovation of technical analysis》

# this is an ipywidgets/ipympl web application

## serve using voila 

```
$ pip install voila
$ voila \
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

## play with Jchart

![jchart_step1](https://github.com/user-attachments/assets/b4a532ba-b463-4631-b7fd-b9abb012e441)
![jchart_step2](https://github.com/user-attachments/assets/4bcc972a-b26f-4b00-b210-4042cf0e0f27)
![jchart_step3](https://github.com/user-attachments/assets/94994794-21e5-440f-8073-191c6fc2ef17)
![jchart_step4](https://github.com/user-attachments/assets/b4c2e55a-4851-4ded-a517-bc03e8f3f88f)
![jchart_step5](https://github.com/user-attachments/assets/8ff71932-0b86-4281-af13-07c0ee50734c)
![jchart_step6](https://github.com/user-attachments/assets/d1e203fc-903f-4411-8b79-5433b1b232b8)


