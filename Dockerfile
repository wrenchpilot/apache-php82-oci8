# Use an official PHP 8.2 image with Apache for x86_64
FROM --platform=linux/amd64 php:8.2-apache

# Update and install required dependencies
RUN apt-get update && apt-get install -y \
    libaio1 \
    alien \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Convert Oracle RPM to DEB package using alien
RUN wget http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.20-basic-19.20.0.0.0-1.x86_64.rpm
RUN alien -i --scripts oracle-instantclient*.rpm
RUN rm -f oracle-instantclient*.rpm

# Optionally install SQLPlus
RUN wget http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.20-sqlplus-19.20.0.0.0-1.x86_64.rpm
RUN alien -i --scripts oracle-instantclient*.rpm
RUN rm -f oracle-instantclient*.rpm

# Install Oracle Instant Client SDK (devel package)
RUN wget http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.20-devel-19.20.0.0.0-1.x86_64.rpm \
    && alien -i --scripts oracle-instantclient19.20-devel-19.20.0.0.0-1.x86_64.rpm \
    && rm -f oracle-instantclient19.20-devel-19.20.0.0.0-1.x86_64.rpm

# Install PECL and OCI8 extension via PECL
RUN pecl install oci8 \
    && echo "extension=oci8.so" > /usr/local/etc/php/conf.d/oci8.ini

# Set Oracle environment variables in /etc/profile
RUN echo "export ORACLE_HOME=/usr/lib/oracle/19.20/client64" >> /etc/profile \
    && echo "export ORACLE_BASE=/usr/lib/oracle/19.20" >> /etc/profile \
    && echo "export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$LD_LIBRARY_PATH" >> /etc/profile \
    && echo "export PATH=\$ORACLE_HOME/bin:\$PATH" >> /etc/profile

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Copy application files
# COPY . /var/www/html/

# Default command to start Apache in the foreground
CMD ["apache2-foreground"]
