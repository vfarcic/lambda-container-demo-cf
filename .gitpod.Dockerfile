FROM gitpod/workspace-full

# Codefresh CLI
RUN mkdir -p /home/gitpod/codefresh/bin
RUN curl -L -o codefresh.tar.gz https://github.com/codefresh-io/cli/releases/download/v0.73.22/codefresh-v0.73.22-linux-x64.tar.gz
RUN tar -xvzf codefresh.tar.gz -C /home/gitpod/codefresh/bin
RUN chmod +x /home/gitpod/codefresh/bin/codefresh
RUN rm codefresh.tar.gz
ENV PATH $PATH:/home/gitpod/codefresh/bin

# AWS CLI
RUN curl -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscliv2.zip
RUN mkdir -p /home/gitpod/aws/bin
RUN ./aws/install --install-dir /home/gitpod/aws --bin-dir /home/gitpod/aws/bin
RUN rm -rf awscliv2.zip
ENV PATH $PATH:/home/gitpod/aws/bin
