#!/bin/bash
# -*- ENCODING: UTF-8 -*-
polymer build
cd build
cordova create cordova com.nbormi.tupeso "Tu peso"
cd cordova && rm www/* -r
cp ../polymer/* www/ -r
cd www/ 
sed -i "s%<base href=\"/\">%<base href=\"file:///android_asset/www/\">%g" "index.html" 
cd .. 
cordova platforms add android
cordova plugin add cordova-plugin-statusbar 
cordova plugin add cordova-plugin-splashscreen 
cordova plugin add cordova-plugin-headercolor 
sed -i "s%version=\"1.0.0\"%version=\"1.0.0\" xmlns:android=\"http://schemas.android.com/apk/res/android\"%g" "config.xml"
sed -i "s%name=\"android\">%name=\"android\"><edit-config file=\"AndroidManifest.xml\" mode=\"merge\" target=\"/manifest/application/activity[@android:label='@string/activity_name']\"><activity android:theme=\"@android:style/Theme.Black.NoTitleBar\" /></edit-config><icon src=\"../../images/manifest/icon-48x48.png\" density=\"ldpi\" /><icon src=\"../../images/manifest/icon-72x72.png\" density=\"mdpi\" /><icon src=\"../../images/manifest/icon-96x96.png\" density=\"hdpi\" /><icon src=\"../../images/manifest/icon-144x144.png\" density=\"xhdpi\" /><icon src=\"../../images/manifest/icon-192x192.png\" density=\"xxhdpi\" /><icon src=\"../../images/manifest/icon-512x512.png\" density=\"xxxhdpi\" /><splash density=\"land-ldpi\" src=\"../../images/cordova/res/screens/android/drawable-land-ldpi-screen.png\" /><splash density=\"land-mdpi\" src=\"../../images/cordova/res/screens/android/drawable-land-mdpi-screen.png\" /><splash density=\"land-hdpi\" src=\"../../images/cordova/res/screens/android/drawable-land-hdpi-screen.png\" /><splash density=\"land-xhdpi\" src=\"../../images/cordova/res/screens/android/drawable-land-xhdpi-screen.png\" /><splash density=\"land-xxhdpi\" src=\"../../images/cordova/res/screens/android/drawable-land-xxhdpi-screen.png\" /><splash density=\"land-xxxhdpi\" src=\"../../images/cordova/res/screens/android/drawable-land-xxxhdpi-screen.png\" /><splash density=\"port-ldpi\" src=\"../../images/cordova/res/screens/android/drawable-port-ldpi-screen.png\" /><splash density=\"port-mdpi\" src=\"../../images/cordova/res/screens/android/drawable-port-mdpi-screen.png\" /><splash density=\"port-hdpi\" src=\"../../images/cordova/res/screens/android/drawable-port-hdpi-screen.png\" /><splash density=\"port-xhdpi\" src=\"../../images/cordova/res/screens/android/drawable-port-xhdpi-screen.png\" /><splash density=\"port-xxhdpi\" src=\"../../images/cordova/res/screens/android/drawable-port-xxhdpi-screen.png\" /><splash density=\"port-xxxhdpi\" src=\"../../images/cordova/res/screens/android/drawable-port-xxxhdpi-screen.png\" />%g" "config.xml" 
cordova run android
if [[ $1 = "-f" ]]; then
    cd ../..
    firebase login
    firebase deploy
fi
exit