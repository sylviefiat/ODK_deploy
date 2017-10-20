#!/bin/bash

cd /tmp
wget https://opendatakit.org/download/4456/
mv index.html ODK.run
chmod +x ODK.run

export COMMANDS='\n\n\n\n\n\n\n\n\ny\n'${AGG_PATH}'\n3\nn\nn\n1\nn\n'${AGG_HTTP}'\n'${AGG_IP}'\nn\n'${AGG_DB_PORT}'\n'${AGG_CONTAINER_DB}'\n'${OGG_DB_USER}'\n'${AGG_DB_PWD}'\n'${AGG_DB_PWD}'\n'${AGG_DB_NAME}'\n'${AGG_DB_SCHEMA}'\n'${AGG_PROJECT}'\n'${AGG_USERNAME}'\nY\nY\n'
echo $COMMANDS

#printf '\n\n\n\n\n\n\n\n\ny\n/tmp/aggregate\n3\nn\nn\n1\nn\n8080\nhttp://10.41.2.232\nn\n\naggregatedb\n\ndocker\ndocker\n\n\naggregate\nadmin\nY\nY\n' | ./ODK.run
printf $COMMANDS | ./ODK.run
find -name "*\ *" -type d | rename 's/ /_/g' && find / -name aggregate
mv /tmp/aggregate/ODK_Aggregate/ODKAggregate.war /usr/local/tomcat/webapps/
cp /tmp/aggregate/ODK_Aggregate/create_db_and_user.sql /sql/

