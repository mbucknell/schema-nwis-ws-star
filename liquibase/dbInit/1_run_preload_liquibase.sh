#!/bin/bash

# postgres to postgres db scripts
${LIQUIBASE_HOME}/liquibase \
	--classpath=${LIQUIBASE_HOME}/lib/${JDBC_JAR} \
	--changeLogFile=${LIQUIBASE_WORKSPACE}/postgres/postgres/changeLog.yml \
	--driver=org.postgresql.Driver \
	--url=jdbc:postgresql://${DATABASE_ADDRESS}:5432/postgres \
	--username=postgres \
	--password=${POSTGRES_PASSWORD} \
	--logLevel=debug \
	update \
	-DPOSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
	-DNWIS_WS_STAR_DATABASE_NAME=${NWIS_WS_STAR_DATABASE_NAME} \
	-DNWIS_WS_STAR_OWNER=${NWIS_WS_STAR_OWNER} \
	-DNWIS_WS_STAR_OWNER_PASSWORD=${NWIS_WS_STAR_OWNER_PASSWORD} \
	-DEXTERNAL_OWNER=${EXTERNAL_OWNER} \
	-DEXTERNAL_OWNER_PASSWORD=${EXTERNAL_OWNER_PASSWORD} \
	-DINTERNAL_OWNER=${INTERNAL_OWNER} \
	-DINTERNAL_OWNER_PASSOWRD=${INTERNAL_OWNER_PASSWORD} \
	 > $LIQUIBASE_HOME/logs/liquibasePostgres.log

# postgres to pubs db scripts
${LIQUIBASE_HOME}/liquibase \
	--classpath=${LIQUIBASE_HOME}/lib/${JDBC_JAR} \
	--changeLogFile=${LIQUIBASE_WORKSPACE}/postgres/wqp/changeLog.yml \
	--driver=org.postgresql.Driver \
	--url=jdbc:postgresql://${DATABASE_ADDRESS}:5432/${NWIS_WS_STAR_DATABASE_NAME} \
	--username=postgres \
	--password=${POSTGRES_PASSWORD} \
	--logLevel=debug \
	update \
	-DPOSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
	-DNWIS_WS_STAR_OWNER=${NWIS_WS_STAR_OWNER} \
	-DNWIS_WS_STAR_SCHEMA_NAME=${NWIS_WS_STAR_SCHEMA_NAME} \
	 > $LIQUIBASE_HOME/logs/liquibaseWQP.log

# remaining preload scripts
${LIQUIBASE_HOME}/liquibase \
	--classpath=${LIQUIBASE_HOME}/lib/${JDBC_JAR} \
	--changeLogFile=${LIQUIBASE_WORKSPACE}/wqp/preload/changeLog.yml \
	--driver=org.postgresql.Driver \
	--url=jdbc:postgresql://$DATABASE_ADDRESS:5432/${NWIS_WS_STAR_DATABASE_NAME} \
	--username=${NWIS_WS_STAR_OWNER} \
	--password=${NWIS_WS_STAR_OWNER_PASSWORD} \
	--logLevel=debug \
	update \
	-DNWIS_WS_STAR_OWNER=${NWIS_WS_STAR_OWNER} \
	-DNWIS_WS_STAR_SCHEMA_NAME=${NWIS_WS_STAR_SCHEMA_NAME} \
	-DEXTERNAL_OWNER=${EXTERNAL_OWNER} \
	-DINTERNAL_OWNER=${INTERNAL_OWNER} \
	> $LIQUIBASE_HOME/logs/liquibasePreload.log
