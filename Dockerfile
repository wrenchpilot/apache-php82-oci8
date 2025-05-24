FROM php:8.2-apache

# Define Oracle Instant Client version variables
ARG ORACLE_CLIENT_VERSION=19.3.0.0.0
ARG ORACLE_CLIENT_VERSION_SHORT=${ORACLE_CLIENT_VERSION%.*.*.*}

LABEL org.opencontainers.image.description="PHP 8.2 with Apache and Oracle Instant Client (${ORACLE_CLIENT_VERSION}) for OCI8 support"

# Update and install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libaio1 \
    alien \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient${ORACLE_CLIENT_VERSION_SHORT}-basic-${ORACLE_CLIENT_VERSION}-1.x86_64.rpm \
    && alien -i --scripts oracle-instantclient*.rpm \
    && rm -f oracle-instantclient*.rpm \
    && wget http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient${ORACLE_CLIENT_VERSION_SHORT}-devel-${ORACLE_CLIENT_VERSION}-1.x86_64.rpm \
    && alien -i --scripts oracle-instantclient${ORACLE_CLIENT_VERSION_SHORT}-devel-${ORACLE_CLIENT_VERSION}-1.x86_64.rpm \
    && rm -f oracle-instantclient${ORACLE_CLIENT_VERSION_SHORT}-devel-${ORACLE_CLIENT_VERSION}-1.x86_64.rpm \
    && pecl install oci8 \
    && echo "extension=oci8.so" > /usr/local/etc/php/conf.d/oci8.ini \
    && apt-get purge -y alien wget \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && a2enmod rewrite

ENV ORACLE_HOME=/usr/lib/oracle/${ORACLE_CLIENT_VERSION_SHORT}/client64 \
    ORACLE_BASE=/usr/lib/oracle/${ORACLE_CLIENT_VERSION_SHORT} \
    LD_LIBRARY_PATH=/usr/lib/oracle/${ORACLE_CLIENT_VERSION_SHORT}/client64/lib \
    PATH=/usr/lib/oracle/${ORACLE_CLIENT_VERSION_SHORT}/client64/bin:$PATH

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Default command to start Apache in the foreground
CMD ["apache2-foreground"]
