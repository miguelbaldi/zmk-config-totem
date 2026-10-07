#!/bin/bash

for d in /sys/class/power_supply/*/ ; do
        # ZMK etc.
        if [ -f "$d/capacity" ] && [ -f "$d/status" ] && [ -f "$d/model_name" ] && [ -f "$d/type" ] ; then
                CAPACITY=`cat "$d/capacity"`
                STATUS=`cat "$d/status"`
                MODEL=`cat "$d/model_name" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                TYPE=`cat "$d/type" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                DIR=`basename "$d" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                echo "battery,name=${MODEL},type=${TYPE},protocol=HID,path=${DIR} capacity=${CAPACITY}i,status=\"${STATUS}\""
        fi

        # Logitech HID++
        if [ -f "$d/capacity_level" ] && [ -f "$d/status" ] && [ -f "$d/manufacturer" ] && [ -f "$d/model_name" ] && [ -f "$d/type" ] && [ -f "$d/serial_number" ] ; then
                LEVEL=`cat "$d/capacity_level"`
                STATUS=`cat "$d/status"`
                MANUFACTURER=`cat "$d/manufacturer" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                MODEL=`cat "$d/model_name" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                TYPE=`cat "$d/type" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                SERIAL=`cat "$d/serial_number" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                DIR=`basename "$d" | sed 's/ /\\\\&/g' | sed 's/,/\\\\&/g' | sed 's/=/\\\\&/g'`
                echo "battery,name=${MANUFACTURER}\ ${MODEL},type=${TYPE},protocol=HID++,path=${DIR},serial=${SERIAL} level=\"${LEVEL}\",status=\"${STATUS}\""
        fi
done

