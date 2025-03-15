FROM steamcmd/steamcmd:rocky-8
RUN ln -s /usr/lib64/libcurl.so.4 /usr/lib64/libcurl-gnutls.so.4

COPY run_dedicated_server.sh /opt/run_dedicated_server.sh

