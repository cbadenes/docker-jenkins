FROM jenkins:1.609.1

COPY plugins.txt /usr/share/jenkins/ref/
#COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt