<h3>Dockerizing a laravel application.</h3>

<h6>Useful notes:</h6>
- Clone the repo into your root of your project.
- Make sure file and folder ownership is set to a user with id and gid of 1000, and if didn't exist create one.
- Make sure `docker/entrypoint.sh` has `755` permission.
- Make sure `.env` file exists with `APP_CONTAINER_NAME` and `DB_CONTAINER_NAME` keys defined as they define the container names, for example first one could be `app` and database could be `app_database`.
- Don't forget to manually run `composer install / update` just in case the default one fails.
- Shell into the docker to run necessary commands such as `php artisan migrate`;
- Command for rebuilding container after changes or pulls, `sudo docker compose build --no-cache && sudo docker compose up --force-recreate -d`.
- Importing data from sql dump in to database container, `sudo docker exec -i container_name mysql -uuser -ppassword database_name < file.sql`.
- Remove `ports` section from docker compose file if you are running your webserver in a container as this helps to prevent ip:port access to your docker containers.
