#!/bin/bash
DB_HOST="127.0.0.1"
DB_USER="pgweb"
DB_PASSWORD="pgweb"
DB_NAME="task"
DB_PORT="8000"
CONTAINER_NAME="postgres"
CREAT_DB="CREATE DATABASE Task;"
CREAT_SCHEMA="CREATE SCHEMA test;"
CREAT_TABLE="CREATE TABLE IF NOT EXISTS test.project_statistics (
    project_name varchar PRIMARY KEY,
    oldest_date timestamp,
    newest_date timestamp,
    largest_version integer,
    project_count integer
);"

read -p "Do you want to modify /etc/hosts? (yes/no) its needed for nginx: " user_input
user_input_lower=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
if [ "$user_input_lower" == "yes" ]; then
	    echo "Modifying /etc/hosts..."
        echo "127.0.0.1    pg.net" | sudo tee -a /etc/hosts
        echo "Done"

else
	    echo "Invalid input. Please enter 'yes' or 'no'."
fi
export PGPASSWORD=$DB_PASSWORD

docker compose up -d
SLEEP_DURATION=5
while [ ! "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; do
	    echo "Container is not running. Sleeping for $SLEEP_DURATION seconds..."
	        sleep $SLEEP_DURATION
	done
echo "waiting for postgres be ready ... "
sleep 30
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "$CREAT_DB"
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "$CREAT_SCHEMA"
psql -h $DB_HOST -p $DB_PORT  -U $DB_USER -d $DB_NAME -f populate.sql
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "UPDATE test.test_project  SET branch = INITCAP(TRIM(BOTH ' ' FROM branch));"
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "UPDATE test.test_project  SET project_name = INITCAP(TRIM(BOTH ' ' FROM project_name));"
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "$CREAT_TABLE"
