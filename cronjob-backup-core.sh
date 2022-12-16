#!/usr/bin/env bash

# 127.0.0.1,42010
SERVER=
DATABASE=
USERNAME=
PASSWORD=
REGISTRY_URL=
EXPORT_LOG_DIR=/var/log/db_backup/core/`date "+%Y-%m"`
EXPORT_DIR=/backup/core/`date "+%Y-%m"`
EXPORT_OLD_DIR=/backup/core/`date --date='2 month ago' "+%Y-%m"`
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

sudo rm -rf EXPORT_OLD_DIR

sudo mkdir -p /var/log/db_backup
sudo mkdir -p /var/log/db_backup/core
sudo mkdir -p $EXPORT_LOG_DIR

sudo mkdir -p /backup
sudo mkdir -p /backup/core
sudo mkdir -p $EXPORT_DIR


echo '[$TIMESTAMP]--Starting----------------------------' >> $EXPORT_LOG_DIR/db_backup_`date "+%Y%m%d"`.log &&

# backup db
sudo docker run --rm  -v ${EXPORT_LOG_DIR}:/var/log -v ${EXPORT_DIR}:/tmp/export --network host $REGISTRY_URL -S $SERVER -d $DATABASE -U $USERNAME -P $PASSWORD --schema-and-data -f /tmp/export/core-`date "+%Y%m%d"`.sql >> $EXPORT_LOG_DIR/db_backup_`date "+%Y%m%d"`.log &&
# zip file
sudo tar -czvf ${EXPORT_DIR}/core-`date "+%Y%m%d"`.tar.gz ${EXPORT_DIR}/core-`date "+%Y%m%d"`.sql >> $EXPORT_LOG_DIR/db_backup_`date "+%Y%m%d"`.log &&
# remove sql file
sudo rm -rf ${EXPORT_DIR}/core-`date "+%Y%m%d"`.sql >> $EXPORT_LOG_DIR/db_backup_`date "+%Y%m%d"`.log &&

echo '[$TIMESTAMP]--Started-----------------------------' >> $EXPORT_LOG_DIR/db_backup_`date "+%Y%m%d"`.log



