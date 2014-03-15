# DOCKER-VERSION 0.8.0

FROM ubuntu:12.10

MAINTAINER Justin Riggio <nicemindz@gmail.com>

# Update
RUN apt-get update

# Install Node.js and npm
RUN apt-get install -y python-software-properties python g++ make curl git
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

# Install Meteor and meteorite (mrt)
RUN curl https://install.meteor.com/ | sh
RUN npm install -g meteorite

# install mongodb
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install -y --force-yes mongodb-10gen
RUN service mongodb start

# Clone the app
RUN git clone https://github.com/justinriggio/meteor-base-platform.git

# Symbolic link to mongodb
#WORKDIR /meteor-base-platform/baseplatform/.meteor/local
#ADD /baseplatform/.meteor /.meteor

# Bundle the app
#RUN cd /meteor-base-platform/baseplatform && meteor bundle ../bundle.tgz

# Deploying bundled app
#RUN cd /meteor-base-platform && tar -xzf bundle.tgz

#ADD /meteor-base-platform/baseplatform .

# Start the Meteor app in Dev Mode

EXPOSE 3000
ENV MONGO_URL mongodb://localhost:27017/meteor
WORKDIR /meteor-base-platform/baseplatform
CMD ["meteor"]
