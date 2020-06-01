# phpBB 3.2 Dockerfile

This Docker file configures a local development environment in phpBB3


### 0) Install Docker
https://docs.docker.com/desktop/

### 1) Setup docker-compose.yml & install-config.yml
1) Set the `PHPBB_INSTALLED` environment variable to `false` so that it downloads phpBB the first time:
  ```sh
     PHPBB_INSTALLED: 'false'
  ```
2) Check install-config.yml to fit your phpBB setup

### 2) run composer to build and start the MySQL and phpBB containers:
```sh
docker-compose up -d
```
then, stop your container. 
change the value of PHPBB_INSTALLED to false
then, restart your container. 

### 3) phpBB
Open a browser with the server URL:

```sh
open "http://localhost:8082/phpBB3"
```


## License
Released under the [MIT license](https://opensource.org/licenses/MIT).
