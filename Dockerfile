FROM phusion/passenger-customizable:0.9.15

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
RUN /pd_build/utilities.sh
#   Ruby support.
#RUN /pd_build/ruby1.9.sh
#RUN /pd_build/ruby2.0.sh
#RUN /pd_build/ruby2.1.sh
RUN /pd_build/ruby2.2.sh
#RUN /pd_build/jruby1.7.sh
#   Python support.
#RUN /pd_build/python.sh
#   Node.js and Meteor support.
RUN /pd_build/nodejs.sh

# ...put your own build instructions here...
RUN gem install chef

RUN gem install knife-windows

RUN gem install knife-ec2

RUN npm install -g underscore-cli

ADD files/main.sh /main.sh

# Main entrypoint script
RUN chmod 777 main.sh

# Folder for secure files
RUN mkdir /etc/chef

RUN ln -s /etc/chef ~/.chef

RUN ln -s /etc/chef /.chef

WORKDIR /

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/main.sh"]
