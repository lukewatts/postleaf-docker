# Postleaf Docker Container
Docker container for Postleaf. Currently just for trying out Postleaf.

__IMPORTANT:__ Version 0.0.1 is currently just for exploring the postleaf interface. __Changes made in Postleaf will be lost when you stop the container!__. This includes images and saved posts and data.

## Features
This container has the following services/software build in:

- Nginx 1.13.0
- Node 7.9.0
- Postleaf 1.0.0-alpha.2

## Current Known Issues
### 1.Error while building container
While building the container you will see this error:

```
Error: Postleaf failed to start.

SequelizeUniqueConstraintError: Validation error
```

This is expected while building the image. The final container will work as expected after this error.

This is because for some reason the process needs to run and fail once before permissions on the postleaf directory can properly be set. I'm hoping to have this sorted in later releases.

## Usage
1. Once Docker is installed clone this repo: `git clone https://github.com/lukewatts/postleaf-docker.git`
2. Change into `postleaf-docker` directory: `cd postleaf-docker`
3. Ensure docker command has sudo rights: `sudo usermod -aG docker sudo`
4. Build container: `docker build -t postleaf .`
5. Run the container: `docker run -tid -v /some/local/path:/usr/share/nginx/html -p 80:80 --name postleaf_dev postleaf`
6. Visit the url (http://127.0.0.1 or http://localhost)

## Usage (for quick testing)
1. Follow steps 1 - 4 above.
2. Run the container so it removes the container when stopped: `docker run -ti --rm -p 80:80 --name postleaf_test postleaf`
3. Visit the url

## Access container while it is running
If you want to look at the code of Postleaf or debug issues etc you will need to use `exec` to access the container while it's running.

`docker exec -it postleaf_dev bash`

__NOTE:__ To make edits you will need to install Vim or Nano yourself.

`apt-get install vim nano`

## If you are not running on localhost
If you are testing Postleaf on a domain, vhost or on a server with a public IP you will notice the styles are not correctly loaded on the login screen. 

To fix this you will need to add the `--env` flag to set the `APP_URL` variable.

Assuming you're domain is `http://postleaf.dev/` you will need to use the following command when running the container:

`docker run -tid -p 80:80 --env APP_URL=http://postleaf.dev/ --name postleaf_dev postleaf`

## Future features
- Allow overriding all ENV variables in .env file. Not just APP_URL
- Fix weird permissions bugs
- Add to Docker Hub

## Issues
For issues with this Docker file, such as build or runtime issues create a new issues here: [Postleaf Docker Issues](https://github.com/lukewatts/postleaf-docker/issues) 

For help with Postleaf go here: [Posteaf Support Forum](https://community.postleaf.org/)

For bugs with Postleaf itself submit issues here: [Postleaf Issues](https://github.com/Postleaf/postleaf/issues)

## Reasources
 - [Postleaf Website](https://postleaf.org/)
 - [Docker Documentation](https://docs.docker.com/)

## Licence
MIT



