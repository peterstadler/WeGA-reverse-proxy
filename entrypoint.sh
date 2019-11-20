#!/bin/sh

# add our existdb location to the httpd config
cat <<EOF >> /usr/local/apache2/conf/httpd.conf
LoadModule	ldap_module          modules/mod_ldap.so
LoadModule	authnz_ldap_module   modules/mod_authnz_ldap.so
LoadModule  proxy_module         modules/mod_proxy.so
LoadModule  proxy_http_module    modules/mod_proxy_http.so
AllowEncodedSlashes NoDecode
<Location />
    ProxyPass ${EXISTDB}
    ProxyPassReverse ${EXISTDB}
    RequestHeader unset Authorization
    AuthName "WeGA-interne Seite nur für Mitarbeiter: Login mit Nutzernamen und Passwort"
    AuthBasicProvider ldap
    AuthType Basic
    AuthLDAPGroupAttribute member
    AuthLDAPGroupAttributeIsDN on
    AuthLDAPURL ${AuthLDAPURL}
    AuthLDAPBindDN "${AuthLDAPBindDN}" 
    AuthLDAPBindPassword "${AuthLDAPBindPassword}" 
    <RequireAny>
        Require ldap-group CN=wega,CN=Users,DC=muwi,DC=hfm-detmold,DC=de
        Require ldap-group CN=wega-guests,CN=Users,DC=muwi,DC=hfm-detmold,DC=de
    </RequireAny>
</Location>
EOF

# run the command given in the Dockerfile at CMD 
exec "$@"
