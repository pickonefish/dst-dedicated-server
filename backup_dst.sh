#!/bin/bash

# 設定時間格式 yyyy-MM-dd_HHMM
TIMESTAMP=$(date +"%Y-%m-%d_%H%M")
BACKUP_DIR="/data/backup/Cluster1_$TIMESTAMP"

# 來源存檔目錄
MASTER_SRC="/data/dst-dedicated-server/.klei/DoNotStarveTogether/MyDediServer/Master/save"
CAVES_SRC="/data/dst-dedicated-server/.klei/DoNotStarveTogether/MyDediServer/Caves/save"

# 最多保留 30 份備份
MAX_BACKUPS=30

# 檢查是否有變更
rsync -rc --checksum "$MASTER_SRC" /tmp/last_master_backup > /dev/null
MASTER_CHANGED=$?

rsync -rc --checksum "$CAVES_SRC" /tmp/last_caves_backup > /dev/null
CAVES_CHANGED=$?

if [[ $MASTER_CHANGED -eq 0 && $CAVES_CHANGED -eq 0 ]]; then
    echo "未偵測到存檔變更，跳過備份。"
    exit 0
fi

# 如果有變更，則執行備份
mkdir -p "$BACKUP_DIR"
cp -r "$MASTER_SRC" "$BACKUP_DIR/Master_save"
cp -r "$CAVES_SRC" "$BACKUP_DIR/Caves_save"

# 更新最新的檔案狀態
rsync -rc "$MASTER_SRC" /tmp/last_master_backup
rsync -rc "$CAVES_SRC" /tmp/last_caves_backup

echo "DST 存檔備份完成: $BACKUP_DIR"

# 保留最多 30 份，刪除舊備份
BACKUP_COUNT=$(ls -dt /data/backup/Cluster1_* | wc -l)
if [[ $BACKUP_COUNT -gt $MAX_BACKUPS ]]; then
    ls -dt /data/backup/Cluster1_* | tail -n +$((MAX_BACKUPS+1)) | xargs rm -rf
    echo "已刪除最舊的備份，確保最多保留 $MAX_BACKUPS 份。"
fi
