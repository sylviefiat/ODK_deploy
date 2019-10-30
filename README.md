# Docker project used to deploy ODK AGGREGATE with tomcat8 and Postgres/Postgis on Linux server => projet déplacé gitlab in2p3 30/102019

#### Required: ####
  - docker
  - docker-compose

## Installation : ##

1. Clone git repository

`git clone git@github.com:sylviefiat/ODK_deploy.git`

1-bis. Go into repo

`cd ODK_deploy`

2. Run build docker-compose :

`docker-compose -f docker-compose.build.yml up`

This command will download a tomcat8 image and an installation script for ODK Aggreagte, then it will install it in deploy repositories (aggregate_date et aggregatedb_data).
In order to personnalize the installation, MODIFY the variables in docker-compose.build.yml file (user names, servers ip adresses, etc.)

3. Run docker compose in order to start ODK Aggregate:

`docker-compose up`
The first run might end up with an error where tomcat8 cannot find postgres because the latest is still being installing, if it happens stop and restart the docker-compose:

`docker-compose stop`

`docker-compose up`

4. visit http://127.0.0.1:8080/ODKAggregate (username is defined in docker-compose.build - default is admin - and default password is aggregate - beware that you will not be able to change it later)


  
## Installation without the provided build: ##
If you don't want to use the provided build but still use the docker-compose this is how to proceed :
 
1. Clone git repo

`git clone git@github.com:sylviefiat/ODK_deploy.git`

2. Download latest ODK Aggregate version [here](https://opendatakit.org/downloads/download-info/odk-aggregate-linux-x64-installer-run/) and place it in ./ODK_deploy/tmp

3. Run install

`cd ./ODK_deploy/tmp`

`chmod +x ODK\ Aggregate\ v1.4.15\ linux-x64-installer.run`

`./ODK\ Aggregate\ v1.4.15\ linux-x64-installer.run`
 
 - Read and accept the licence, 
 - the installation will ask for parent repository where 'ODk Aggregate' will be deployed, you can place it in tmp as we will move it later on:
 
 `[]:/path/to/ODK_deploy`
 
 - then, choose option **3** in order to select PostgreSQL.
 
 - As docker will automatically install tomcat and Postgres, answer no **n** to the questions asking to install tomcat (2 fois).
 
 - Select or not SSL (depending on your configuration).
 
 - Internet access: ODK offers to configure tomcat access to internet, tomcat install should take care of this so you can answer no.
 
 - `HTTP Port: [8080]:` enter to validate default entry **8080**
 
 - `HTTPS Port: [8443]:` enter to validate default entry or enter HTTPS port (if you selected SSL)
 
 - `DNS name:` valide  if the url is correct
 
 - installer postgres: no
 
 - `database number [5432]:` enter
 
 - `Database server hostname: [127.0.0.1]:` you need to enter **aggregatedb** which will be the docker server name of you postgresql instance (as specified in docker-compose)
 
 - `Database username: [odk_user]:` entrer to use this name or enter another username
 
 - `Database password:` enter password for database
 
 - `Database Name: [odk_prod]:` enter to use default of enter a name for database name
 
 - `Database Schema Name: [odk_prod]:`nter to use default of enter a name for database schema name
 
 - `Please enter the name of your instance: []:` enter the name of your instance that will be visible to users
 
 - `Please enter an ODK Aggregate Username: []:` enter admin username **admin** for example
 
 - `Do you want to continue? [Y/n]:` Y !
 
 - `Show additional deployment and
 configuration steps (5-10 minutes). [Y/n]:` **Y** (dans notre cas il n'y en a pas apparement)

4. cd to "ODK Aggregate" repo and place the generated .war in webapps:

`mv ODKAggregate.war ../aggregate_data/webapps/`

5. move postgres creation script in postgres data repo:

`mv create_db_and_user.sql ../aggregatedb_data/postgresql/`

6. go back to project repo and start docker-compose

`docker-compose up -d`

7. uOnce the containers are started, run the database creation script
  - using pgadmin OR
  - using command line
  
  `cd aggregatedb_data`
  
  `docker exec -it odkdeploy_aggregatedb_1 psql -U postgres -f /etc/postgresql/create_db_and_user.sql`
  
8. restart docker-compose

`docker-compose stop`

`docker-compose up -d`
 
 
 

