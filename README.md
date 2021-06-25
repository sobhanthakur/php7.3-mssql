<h2>Project Setup Steps</h2>
<h5>PHP Project setup with MSSQL, ODBC, SQLSRV, Composer, Git pre-configured.</h5>
<ol>
    <li>Create a directory called configurations in /home/user directory.</li>
    <li>Inside configurations, create a file called backend.conf</li>
    <li>Paste the following content:</li>
    <li>
        <p>
            <VirtualHost *:80> <br />
                ServerAdmin admin@example.com<br />
                ServerName dev.host.com<br />
                DocumentRoot /var/www/html/<project_name>/web<br />
                    ErrorLog ${APACHE_LOG_DIR}/error.log<br />
                    CustomLog ${APACHE_LOG_DIR}/access.log combined<br />
                    <Directory /var/www/html/<project_name>/web><br />

                        Options Indexes FollowSymLinks MultiViews<br />

                        AllowOverride All<br />

                        Order allow,deny<br />

                        allow from all<br />

                    </Directory><br />
            </VirtualHost><br />
        </p>
    </li>
</ol>