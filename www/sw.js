self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", e => e.waitUntil(self.clients.claim()));

// عند الضغط على الإشعار: افتح التطبيق وشغّل النطق والرنّة
self.addEventListener("notificationclick", event => {
  event.notification.close();
  const task = (event.notification.data && event.notification.data.task) || "";
  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then(list => {
      if (list.length) {
        const client = list[0];
        client.postMessage({ type: "reminder-click", task });
        return client.focus();
      }
      return self.clients.openWindow("/?reminder=" + encodeURIComponent(task));
    })
  );
});

// جاهز لـ Web Push مستقبلًا
self.addEventListener("push", event => {
  let data = {};
  try { data = event.data ? event.data.json() : {}; } catch (e) {}
  const task = data.task || "عندك تذكير";
  event.waitUntil(
    self.registration.showNotification("🔔 تذكير من المساعد الذكي", {
      body: task,
      tag: "alz-push-" + Date.now(),
      requireInteraction: true,
      vibrate: [500, 200, 500, 200, 500],
      data: { task }
    })
  );
});
