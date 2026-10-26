#!/usr/bin/env bash
set -e
npm install
[ -d android ] || npx cap add android

# رنّة الإشعار (لازم تكون داخل res/raw)
mkdir -p android/app/src/main/res/raw
cp resources/reminder_sound.wav android/app/src/main/res/raw/reminder_sound.wav

# صلاحيات المنبّه والإشعارات في AndroidManifest
python3 - <<'PY'
p = "android/app/src/main/AndroidManifest.xml"
s = open(p, encoding="utf-8").read()
perms = [
 "android.permission.POST_NOTIFICATIONS",
 "android.permission.VIBRATE",
 "android.permission.WAKE_LOCK",
 "android.permission.RECEIVE_BOOT_COMPLETED",
 "android.permission.SCHEDULE_EXACT_ALARM",
 "android.permission.USE_EXACT_ALARM",
]
add = ""
for x in perms:
    if x not in s:
        add += '    <uses-permission android:name="%s" />\n' % x
if add:
    s = s.replace("<application", add + "\n    <application", 1)
    open(p, "w", encoding="utf-8").write(s)
print("manifest ok")
PY

npx cap sync android
echo "✅ تم. لبناء الـ APK:  npm run apk   (أو: npx cap open android)"
