# المساعد الذكي — نسخة أندرويد (Capacitor)

المطلوب: Node 18+ ، JDK 17 ، Android SDK (أو Android Studio).

1. انسخ ملفاتك (manifest.json, background.png, icon-192.png ...) داخل مجلد www
2. bash setup.sh
3. npm run apk        -> android/app/build/outputs/apk/debug/app-debug.apk
   (أو: npx cap open android ثم Run)

لتغيير رنّة التنبيه: استبدل resources/reminder_sound.wav بملفك (wav/mp3، 15-30 ثانية)
وغيّر NATIVE_SOUND و NATIVE_CHANNEL في www/index.html، ثم bash setup.sh
