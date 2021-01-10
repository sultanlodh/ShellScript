#!/bin/bash
## track_lockwait.sh
## Print out the blocking statements that causing InnoDB lock wait
 
INTERVAL=5
DIR=/root/lockwait/
 
[ -d $dir ] || mkdir -p $dir
 
while true; do
  check_query=$(mysql -A -Bse 'SELECT THREAD_ID,EVENT_ID,EVENT_NAME,CURRENT_SCHEMA,SQL_TEXT FROM events_statements_history_long WHERE THREAD_ID IN (SELECT BLOCKING_THREAD_ID FROM data_lock_waits) ORDER BY EVENT_ID')
 
  # if $check_query is not empty
  if [[ ! -z $check_query ]]; then
    timestamp=$(date +%s)
    echo $check_query > $DIR/innodb_lockwait_report_${timestamp}
  fi
 
  sleep $INTERVAL
done
Apply execu
