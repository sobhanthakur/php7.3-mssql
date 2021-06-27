# Project Setup Steps #
### Symfony Project setup with MSSQL, ODBC, SQLSRV, Composer, git pre-configured. ###

1.  Create a directory called configurations in /home/user directory.
2.  Inside configurations, create a file called backend.conf
3.  Paste the following content:
        
        <VirtualHost *:80>
        ServerAdmin admin@example.com
        ServerName dev.host.com
        DocumentRoot /var/www/html/project_name/web
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        <Directory /var/www/html/project_name/web>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
        </Directory>
        </VirtualHost>

4.  sudo su
5.  docker pull sobhanthakur/php7.3-mssql 
6.  `docker run -v /home/user/configurations:/etc/apache2/sites-available -v <path_to_project_dir_in_local_machine>:/var/www/html/<project_name>  -p 8000:8000 --name php-mssql-container -d sobhanthakur/php7.3-mssql`
7.  docker ps -a
8.  copy the container ID for the above container
9.  `docker exec -it <ContainerID> /bin/bash`
10. `cd /var/www/html/<project-dir>`
11. composer install
12. provide environment variables / create parameters.yml
13. cd /etc/apache2/sites-available && a2ensite backend.conf
14. /etc/init.d/apache2 restart
15. exit
16. `docker inspect <ContainerID>`
17. Copy the IP Address.
18. vi /etc/hosts
19. 
    Add following line: 
    > <IP_Address> dev.host.com        
20. /etc/init.d/apache2 restart
21. Go to the project directory in your local machine
22. php bin/console cache:clear --env=prod
23. chmod -R 777 var/cache/ var/logs/ var/sessions/
25. exit
26. Go to browser and type dev.host.com