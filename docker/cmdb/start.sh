#!/bin/sh
CMDB_CONF=/var/www/netharbour/config/cmdb.conf
PHP_CONF=/etc/php5/apache2/php.ini

# Update config 
sed -i -e "/db_name =/ s/= .*/= ${MYSQL_DATABASE}/" "${CMDB_CONF}"
sed -i -e "/db_host =/ s/= .*/= db/" "${CMDB_CONF}" 
sed -i -e "/db_port =/ s/= .*/= 3306/" "${CMDB_CONF}"   
sed -i -e "/db_user =/ s/= .*/= ${MYSQL_USER}/" "${CMDB_CONF}" 
sed -i -e "/db_pass =/ s/= .*/= ${MYSQL_PASSWORD}/" "${CMDB_CONF}" 
sed -i -e "/email_to =/ s/= .*/= ${EMAIL_TO}/" "${CMDB_CONF}" 
sed -i -e "/email_from =/ s/= .*/= ${EMAIL_FROM}/" "${CMDB_CONF}" 
sed -i -e "/threshold_check =/ s/= .*/= ${THRESHOLD_CHECK}/" "${CMDB_CONF}" 

# Update timezone
sed -i -e "/date.timezone =/ s|= .*|= ${TIMEZONE}|" "${PHP_CONF}"
echo "${TIMEZONE}" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

nohup /usr/sbin/cron -f &
nohup /usr/bin/crontab /etc/cron.d/crontab & 
apachectl -DFOREGROUND
