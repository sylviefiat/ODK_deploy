# Projet Docker permettant de déployer une instance de ODK COLLECT avec tomcat8 et Postgres/Postgis sur Linux

#### Requis: ####
  - docker
  - docker-compose

## Procédure d'installation : ##

1. Cloner le répertoire git

`git clone git@github.com:sylviefiat/ODK_deploy.git`

2. Lancer le docker compose avec le fichier build:

`docker-compose -f docker-compose.build.yml up`

Cette commande va télécharger une image tomcat 8 et le script d'installation d'ODK Aggregate puis l'installer dans les répertoires de déploiement (aggregate_date et aggregatedb_data).
Pour personnaliser l'installation, modifier les variables dans le fichier docker-compose.build.yml (noms utilisateurs, ip serveur, etc.)

3. Lancer le docker compose up pour démarrer ODK Aggregate:

`docker-compose up`
Il y a des chances pour que la première fois le container tomcat ne trouve pas la connexion à la base de données car celle ci est entrain de s'installer, si c'est le cas arrêter et relancer un docker-compose:

`docker-compose stop`

`docker-compose up`

4. visiter la page http://127.0.0.1:8080/ODKAggregate (le usernam est défini dans le docker-compose.build - admin par défaut - et mot de passe par défaut est aggregate)


  
## Procédure d'installation sans utiliser le build fourni: ##
Si vous ne souhaitez pas utiliser le docker-compose.build, voici la procédure pour installer ODK Aggregate
 
1. Cloner le répertoire git 

`git clone git@github.com:sylviefiat/ODK_deploy.git`

2. Télécharger la dernière version d'ODK Aggregate [ici](https://opendatakit.org/downloads/download-info/odk-aggregate-linux-x64-installer-run/) et le placer dans le répertoire ./ODK_deploy/tmp

3. Exécuter l'installateur

`cd ./ODK_deploy/tmp`

`chmod +x ODK\ Aggregate\ v1.4.15\ linux-x64-installer.run`

`./ODK\ Aggregate\ v1.4.15\ linux-x64-installer.run`
 
 - Lire et accepter la licence, ensuite l'installation va demander de sélectionner le répertoire parent sous lequel 'ODk Aggregate' sera installé, comme on déplacera les fichiers généré, on peut le mettre dans un répertoire de tmp:
 
 `[]:/path/to/ODK_deploy`
 
 - Ensuite, choisir l'option **3** pour sélectionner PostgreSQL.
 
 - Comme docker installera tomcat et Postgres, répondre non **n** aux demandes de téléchargement et installation de tomcat (2 fois).
 
 - Selon votre cas, sélectionner ou non le SSL (Non dans mon cas).
 
 - Accès à internet: ODK propose de configurer tomcat pour l'accès à internet, normalement l'installation de tomcat prend en charge donc répondre non.
 
 - `HTTP Port: [8080]:` taper entrée pour valider le port **8080**
 
 - `HTTPS Port: [8443]:` taper entrée pour valider le port ou saisir votre port HTTPS (si vous avez sélectionné le SSL)
 
 - `DNS name:` valider si l'url est bien celle de votre serveur sinon la saisir
 
 - installer postgres: mettre non
 
 - `database number [5432]:` taper entrée
 
 - `Database server hostname: [127.0.0.1]:` là il faut mettre le nom réseau du container de la base postgres, visible dans le docker-compose: **aggregatedb**
 
 - `Database username: [odk_user]:` taper entrée pour utiliser ce nom ou saisir un autre nom
 
 - `Database password:` saisir un mot de passe pour la bdd
 
 - `Database Name: [odk_prod]:` taper entrée pour utiliser ce nom ou saisir un autre nom
 
 - `Database Schema Name: [odk_prod]:`taper entrée pour utiliser ce nom ou saisir un autre nom
 
 - `Please enter the name of your instance: []:` saisir le nom de votre projet ou groupe ce nom sera visible par les utilisateurs
 
 - `Please enter an ODK Aggregate Username: []:` saisir un nom d'utilisateur **admin** par exemple
 
 - `Do you want to continue? [Y/n]:` Y !
 
 - `Show additional deployment and
 configuration steps (5-10 minutes). [Y/n]:` **Y** (dans notre cas il n'y en a pas apparement)

4. Aller dans le répertoire créé "ODK Aggregate" et déplacer le .war vers webapps:

`mv ODKAggregate.war ../aggregate_data/webapps/`

5. déplacer le script de création postgres dans le répertoire de données postgres:

`mv create_db_and_user.sql ../aggregatedb_data/postgresql/`

6. retourner dans le répertoire du projet et démarrer docker-compose

`docker-compose up -d`

7. une fois les containers démarrés, faire tourner le script d'installation de la base de données
  - soit en utilisant pgadmin
  - sinon utiliser la commande
  
  `cd aggregatedb_data`
  
  `docker exec -it odkdeploy_aggregatedb_1 psql -U postgres -f /etc/postgresql/create_db_and_user.sql`
  
8. redémarrer docker-compose

`docker-compose stop`

`docker-compose up -d`
 
 
 

