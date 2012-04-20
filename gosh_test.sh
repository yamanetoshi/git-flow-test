#!/bin/bash

TEST_RECORD=xxx

GAUCHE_TEST_RECORD_FILE=$TEST_RECORD gosh $1
VAL=`cat $TEST_RECORD`
rm $TEST_RECORD
test "0" == $(echo $VAL|awk '{print $6;}')
