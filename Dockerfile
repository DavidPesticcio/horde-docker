FROM php:apache

RUN ["/usr/local/bin/pear", "channel-discover", "pear.horde.org"]
RUN ["/usr/local/bin/pear", "channel-discover", "pear.nrk.io"]
RUN ["/usr/local/bin/pear", "update-channels"]
RUN ["/usr/local/bin/pear", "upgrade"]
# install packages where the stable channel is not available
RUN ["/usr/local/bin/pear", "install", "--alldeps", "pear/Console_Color2-alpha", "pear/Image_Text-beta", "pear/Numbers_Words-beta", "pear/SOAP-beta", "pear/XML_Serializer-beta"]
# /pecl/APC-* fails to build on debian
RUN ["/usr/local/bin/pecl", "install", "--alldeps", "--nobuild", "APC", "idn-beta", "sasl-alpha"]
# first, install Horde_Role, than configure it, than install everything else
RUN ["/usr/local/bin/pear", "install", "--alldeps", "horde/Horde_Role"]
RUN ["/usr/local/bin/pear", "config-set", "-c", "horde", "horde_dir", "/usr/local/lib/php/www/horde"]
RUN ["/usr/local/bin/pear", "install", "--alldeps", "--nobuild", "horde/Horde_Backup-beta"]
RUN ["/usr/local/bin/pear", "install", "--alldeps", "horde/Horde_Argv", "horde/Horde_Cache", "horde/Horde_Cli", "horde/horde_Cli_Modular", "horde/Horde_Exception", "horde/Horde_Http", "horde/Horde_Pear-alpha", "horde/Horde_Translation", "horde/Horde_Yaml"]
RUN ["/usr/local/bin/pear", "install", "--alldeps", "--nobuild", "horde/horde"]
RUN ["/bin/ln", "-s", "/usr/local/lib/php/www/horde", "/var/www/horde"]
