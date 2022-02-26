# Start from the code-server Debian base image
FROM codercom/code-server:3.10.2

USER coder

# Apply VS Code settings
COPY workspaceFolder/settings.json .local/share/code-server/User/settings.json
COPY workspaceFolder/file.txt .local/share/code-server/User/file.txt

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
#RUN curl https://rclone.org/install.sh | sudo bash

# Copy rclone tasks to /tmp, to potentially be used
#COPY deploy-container/rclone-tasks.json /tmp/rclone-tasks.json

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
#RUN code-server --install-extension dendron.dendron

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make


USER root
RUN chmod a+w ./ -R

RUN sudo dpkg --purge --force-depends ca-certificates-java -y

RUN sudo apt-get install ca-certificates-java -y 

RUN sudo apt install openjdk-11-jdk -y

# Install OpenJDK-8
# RUN sudo apt-get update && \
#     apt-get install -y openjdk-8-jdk && \
#     apt-get install -y ant && \
#     apt-get clean;
    
# # Fix certificate issues
# RUN sudo apt-get update && \
#     apt-get install ca-certificates-java && \
#     apt-get clean && \
#     update-ca-certificates -f;

# RUN sudo apt-get update
# RUN sudo apt install --reinstall software-properties-common -y
# RUN sudo apt-get install software-properties-common -y

# # RUN sudo apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'

# RUN sudo add-apt-repository ppa:webupd8team/java -y
# RUN sudo apt-get update -y 
# RUN sudo apt-get install oracle-java8-installer -y 

# RUN sudo apt-get install openjdk-8-jdk



# Setup JAVA_HOME -- useful for docker commandline
# ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
# RUN export JAVA_HOME



# RUN sudo apt-get update && apt-get install -y software-properties-common gcc && \
#     add-apt-repository -y ppa:deadsnakes/ppa

# RUN sudo apt-get update && apt-get install -y python3.6 python3-pip 

USER coder

# Copy files: 
# COPY deploy-container/myTool /home/coder/myTool

# -----------

# Port
ENV PORT=8080

# Use our custom entrypoint script first
#COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
#ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
