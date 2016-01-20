# asterisk-zabbix
collection of silly Zabbix configuration files, templates, screens and script for monitoring Asterisk (mainly FreePBX) base systems.  
the whole idea is to have Zabbix screen containing vital Asterisk information.

### Description
```template_app_asterisk_service.xml``` - Template file for Zabbix  
```screen_app_asterisk_service.xml```   - Screen template 
```userparams_app_asterisk_service.conf``` - userparams.conf file, to be included in Zabbix configuration  
```sip_status.sh``` - Bash script to be placed and run periodically on monitored Asterisk server, generates (more or less) pretty report, consistent with zabbix screen

### Usage
* Import ```template_app_asterisk_service.xml``` into zabbix;
* Create new host in zabbix, assign to newly imported template;
* Change ```{HOST.ADDRESS}``` to newly added host ip address, and ```{HOST.NAME}``` to Zabbix host name in ```screen_app_asterisk_service.xml```, import that file in Zabbix;
* Include ```userparams_app_asterisk_service.conf``` in Zabbix configuration;
* Copy ```sip_status.sh``` script to server you want to monitor, make sure it is executed periodically via cron.
