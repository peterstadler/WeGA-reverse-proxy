FROM httpd:2.4
LABEL maintainer="Peter Stadler for the WeGA"

# For information about these parameters see 
# https://httpd.apache.org/docs/2.4/mod/mod_authnz_ldap.html
ARG AuthLDAPURL
ARG AuthLDAPBindDN
ARG AuthLDAPBindPassword

COPY entrypoint.sh /my-docker-entrypoint.sh
RUN chmod 755 /my-docker-entrypoint.sh

ENTRYPOINT ["/my-docker-entrypoint.sh"]
CMD ["httpd-foreground"]
