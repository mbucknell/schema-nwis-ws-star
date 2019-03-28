# schema\-nwis\-ws\-star

Liquibase scripts for creating the NWIS\_WS\_STAR database schema objects in a Postgres database. They 
are used for both the Water Quality Portal (WQP) and the Internal Water Quality Data Delivery systems.
The repo also includes Docker Compose scripts to setup a continuous integration PostGIS database.

### Docker Network
A named Docker Network is required for local running of the containers. Creating this network allows you to run all of the WQP locally in individual containers without having to maintain a massive Docker Compose script encompassing all of the required pieces. (It is also possible to run portions of the system locally against remote services.) The name of this network is provided by the __LOCAL_NETWORK_NAME__ environment variable. The following is a sample command for creating your own local network. In this example the name is wqp and the ip addresses will be 172.25.0.x

```
docker network create --subnet=172.25.0.0/16 wqp
```

### Environment variables
In order to use the docker compose scripts, you will need to create a .env file in the project directory containing
the following (shown are example values):
```
POSTGRES_PASSWORD=<changeMe>

NWIS_WS_STAR_OWNER=nwis_ws_star_owner
NWIS_WS_STAR_OWNER_PASSWORD=<changeMe>
NWIS_WS_STAR_DATABASE_NAME=nwis_ws_star_db
NWIS_WS_STAR_SCHEMA_NAME=nwis_ws_star

EXTERNAL_OWNER=wqp_core
EXTERNAL_OWNER_PASSWORD=<changeMe>
INTERNAL_OWNER=int_wqp
INTERNAL_OWNER_PASSWORD=<changeMe>

DB_PORT=<5434>
DATABASE_ADDRESS=<name or ip of the database instance>
LIQUIBASE_IPV4=<172.25.0.7. 

```

#### Environment variable definitions

* **POSTGRES_PASSWORD** - Password for the postgres user.
* **DATABASE_ADDRESS** - address of database to run the liquibase scripts against.
* **CONTEXTS** - Which Liquibase contexts to apply. See list below for valid values.
* **NWIS_WS_STAR_DATABASE_NAME** - Name of the PostgreSQL database to create for containing the schema.
* **NWIS_WS_STAR_SCHEMA_NAME** - Name of the schema to create for holding database objects.
* **NWIS_WS_STAR_DATA_OWNER_USERNAME** - Role which will own the database objects.
* **EXTERNAL_OWNER** - External owner role
* **EXTERNAL_OWNER_PASSWORD** - External owner role passowrd
* **INTERNAL_OWNER** - Internal owner role
* **INTERNAL_OWNER_PASSWORD** - External owner role passowrd
* **LOCAL_NETWORK_NAME** - The name of the local Docker Network you have created for using these images/containers.
* **DB_IPV4** - The IP address in your Docker Network you would like assigned to the database container used for testing the Liquibase scripts.
* **DB_PORT** - The localhost port on which to expose the script testing database container.
* **LIQUIBASE_IPV4** - The IP address you would like assigned to the Liquibase runner container.
* **LIQUIBASE_VERSION** - The version of Liquibase to install.
* **JDBC_JAR** - The jdbc driver to install.


To create a postgres database and then run the liquibase scripts:
```
% docker-compose up -d db
% docker-compose up liquibase
```

The PostGIS database will be available on port ${DB_PORT}

Other Helpful commands include:
* __docker-compose up__ to create and start the containers
* __docker-compose ps__ to list the containers
* __docker-compose stop__ or __docker-compose kill__ to stop the containers
* __docker-compose start__ to start the containers
* __docker-compose rm__ to remove all containers
* __docker network inspect pubsdb_default__ to get the ip addresses of the running containers
* __docker-compose ps -q__ to get the Docker Compose container ids
* __docker ps -a__ to list all the Docker containers
* __docker rm <containerId>__ to remove a container
* __docker rmi <imageId>__ to remove an image
* __docker logs <containerID>__ to view the Docker Compose logs in a container
