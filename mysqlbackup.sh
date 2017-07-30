#!/bin/bash

OUTDIR="/tmp/mysqlbackup"
TIMESTR=`date +"%y%m%d"`
NAME=`hostname`

mydumper -c --regex '^(?!(mysql))' -o $OUTDIR
aws s3 cp $OUTDIR s3://cloudhipsters.backup/${NAME}_mysql_${TIMESTR} --only-show-errors --recursive
rm -rf "$OUTDIR/*"
