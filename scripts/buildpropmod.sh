#!/sbin/sh

bp="/system/build.prop"

busybox mount /system
busybox mount /data

if [ -f /system/build.prop.bak ]; 
  then
    rm -rf $bp
    cp $bp.bak $bp
  else
    cp $bp $bp.bak
fi

echo " " >> $bp
echo "# original build.prop" >> $bp
echo " " >> $bp

for mod in tweaks;
  do
    for prop in `cat /tmp/$mod`;do
      export newprop=$(echo ${prop} | cut -d '=' -f1)
      sed -i "/${newprop}/d" /system/build.prop
      echo $prop >> /system/build.prop 
    done
done