# NSO base image
FROM ubuntu:latest

ARG NSOVER

# Copy local files
COPY nso-$NSOVER.linux.x86_64.installer.bin /tmp/nso
COPY run-nso.sh /root/.

# Install bases packages, Install NSO, and cleanup
RUN apt-get update;\ 
    apt-get install -y openssh-client default-jre-headless ant make; \
    /tmp/nso /root/nso; \
    echo '. ~/nso/ncsrc' >> /root/.bashrc; \
    apt-get -y clean autoclean;\
    apt-get -y autoremove;\
    rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}/

#  create base nso-project with Cisoc IOS, IOSXR and NXOS neds
RUN mkdir ~/nso-project; \
    /bin/bash -c "source ~/nso/ncsrc; ncs-setup --dest ~/nso-project"; \
    chmod 755 /root/run-nso.sh;\
    cp -r /root/nso/packages/neds/cisco-ios-cli-3.8 /root/nso-project/packages;\
    cp -r /root/nso/packages/neds/cisco-iosxr-cli-3.5 /root/nso-project/packages;\
    cp -r /root/nso/packages/neds/cisco-nx-cli-3.0 /root/nso-project/packages

# Set Working Directory
WORKDIR /root/nso-project

# Expose ports
EXPOSE 2022 2024 8080

# Automatically start NSO
ENTRYPOINT ["/root/run-nso.sh"]