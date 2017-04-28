#!/bin/bash
# v1.0
# author: Jopn Wu
# create date: 2017/04/28

#startDateString="${1}"
#endDateString="${2}"


startDate=$(date -d "${1}")
endDate=$(date -d "${2}")

#nextDate=$(date -d "$startDate 1 days")
nextDate=$startDate

nextDateString=$(date -d "$nextDate" +%Y%m%d)
endDateString=$(date -d "$endDate" +%Y%m%d)

while [ $endDateString -ge $nextDateString ]; do
  echo "========== start query $nextDateString ============="
  # create parameter for pig
  YY=${nextDateString:0:4}
  MM=${nextDateString:4:2}
  DD=${nextDateString:6:2}
  pig -f attacker_device_query.pig -param YY=$YY -param MM=$MM -param DD=$DD
  echo "=========== end query $nextDateString =============="
  nextDate=$(date -d "$nextDateString 1 days")
  nextDateString=$(date -d "$nextDate" +%Y%m%d)
done

exit 0
