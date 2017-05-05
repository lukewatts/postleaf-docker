# Postleaf Docker Container
Docker container for Postleaf. Currently just for trying out Postleaf.

__IMPORTANT:__ Not recommended for production usage. Postleaf is currently in Alpha testing phase and this Dockerfile is currently not for production. 

## Features
This container has the following services/software build in:

- Nginx 1.13.0
- Node 7.x
- Postleaf 1.0.0-alpha.3

## Usage (with volumes)
1. Once Docker is installed clone this repo: `git clone https://github.com/lukewatts/postleaf-docker.git`
2. Change into `postleaf-docker` directory: `cd postleaf-docker`
3. Ensure docker command has sudo rights: `sudo usermod -aG docker sudo`
4. Build container: `docker build -t postleaf:1.0.0-alpha.3 .`
5. Create necessary volume directories: `mkdir html/data html/cache/ html/uploads`
6. Make sure volumes has correct owner: `sudo chown -R root:root $(pwd)/html`
5. Run the container: `docker run -tid -v $(pwd)/html/data:/usr/share/nginx/html/data -v $(pwd)/html/cache:/usr/share/nginx/html/cache -v $(pwd)/html/uploads:/usr/share/nginx/html/uploads -p 80:80 --name postleaf postleaf:1.0.0-alpha.3`
6. Visit the url (http://127.0.0.1 or http://localhost)

## Usage (for quick testing)
1. Follow steps 1 - 4 above.
2. Run the container so it removes the container when stopped: `docker run -ti --rm -p 80:80 --name postleaf_test postleaf:1.0.0-alpha.3`
3. Visit the url

## Access container while it is running
If you want to look at the code of Postleaf or debug issues etc you will need to use `exec` to access the container while it's running.

`docker exec -it postleaf bash`

__NOTE:__ To make edits you will need to install Vim or Nano yourself.

`apt-get install vim nano`

## If you are not running on localhost
If you are testing Postleaf on a domain, vhost or on a server with a public IP you will notice the styles are not correctly loaded on the login screen. 

To fix this you will need to add the `--env` flag to set the `APP_URL` variable.

Assuming you're domain is `http://postleaf.dev/` you will need to use the following command when running the container:

`docker run -tid -v $(pwd)/html/data:/usr/share/nginx/html/data -v $(pwd)/html/cache:/usr/share/nginx/html/cache -v $(pwd)/html/uploads:/usr/share/nginx/html/uploads -p 80:80 --env APP_URL=http://postleaf.dev/ --name postleaf postleaf:1.0.0-alpha.3`

## Future features
- Allow overriding all ENV variables in .env file. Not just APP_URL
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



