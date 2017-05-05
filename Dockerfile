FROM nginx:1.13.0

LABEL maintainer="Luke Watts @LukeWatts85"
LABEL version="0.0.4"

# IMPORTANT: Set this to the domain or ip address of you host machine
ENV APP_URL=http://localhost/

# Update and Upgrade
RUN apt-get update -y && apt-get upgrade -y

## Install deps
RUN apt-get install -y gnupg2
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y sqlite3
RUN apt-get install -y graphicsmagick

# Get latest packages of node and yarn
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update
RUN apt-get update -y

# Install node 7.9.0
RUN apt-get install -y nodejs

# Install yarn
RUN apt-get install -y yarn

# Get build essential
RUN apt-get install -y build-essential

# Clean out server directory
RUN rm -rf /usr/share/nginx/html/*

# Clone repo
RUN git clone --branch 1.0.0-alpha.3 https://github.com/Postleaf/postleaf.git /usr/share/nginx/html/

# Set permissions
RUN chown -R $USER:www-data /usr/share/nginx/html

# Change Working directory
WORKDIR /usr/share/nginx/html/

# Clone empower theme
RUN git clone https://github.com/Postleaf/empower-theme.git themes/empower-theme

# Setup .env file
RUN cp .env.example .env
RUN sed -i "s|APP_URL=https://example.com/|APP_URL=$APP_URL|" /usr/share/nginx/html/.env
RUN sed -i "s/APP_PORT=3000/APP_PORT=80/" /usr/share/nginx/html/.env
RUN HASH=$(date +%s | sha256sum | base64 | head -c 32) ; sed -i "s/CHANGE_THIS_TO_A_RANDOM_STRING/$HASH/" /usr/share/nginx/html/.env

# Install global npm dependencies
#RUN npm install -g gulp

# Install postleaf npm dependencies
RUN npm install --only=prod

# Build Postleaf
#RUN gulp build

# Create folders for volumes
RUN mkdir cache data uploads

# Copy in base database.sq3 file
COPY html/data/database.sq3 data/database.sq3

# Setup volumes
VOLUME ["cache", "data", "uploads"]

# Set permissions
# @todo Currently has no effect because of Nginx image has control of the www-data user
RUN chown -R $USER:www-data /usr/share/nginx/html/
RUN chmod -R 775 /usr/share/nginx/html/

# Run
CMD node app.js
