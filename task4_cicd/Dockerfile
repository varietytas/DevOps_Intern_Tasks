FROM nginx:stable-alpine

ARG STATIC_FILES_PATH=/var/www/html \
    SSL_PATH=/etc/nginx/ssl

# Create dir for the cert;
# Remove default configuration;
# Remove default static assets;
# Create dir for static assets.
RUN mkdir -p ${SSL_PATH}              && \
    rm /etc/nginx/conf.d/default.conf && \
    rm -rf /usr/share/nginx/html/*    && \
    mkdir -p ${STATIC_FILES_PATH}

COPY index.html ${STATIC_FILES_PATH}/

COPY cert.crt cert.key ${SSL_PATH}/

# Set file permissions for the certificate
RUN chmod 444 ${SSL_PATH}/cert.crt && \
    chmod 400 ${SSL_PATH}/cert.key

COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 80 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
