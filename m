Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84280354926
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhDEXMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhDEXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:12:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5CC06174A;
        Mon,  5 Apr 2021 16:12:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq27so18918624ejc.9;
        Mon, 05 Apr 2021 16:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX+Ijy6//mnPc6r5gggHSthpMfwHGQm/kI6cQy98wi8=;
        b=sNGC4eHfR+gdaN0uRzXf4EFNOb/iNHxKBrh9teGzzxT8GM1hz1HrH7frAM3mxGK7O1
         zQ2s4p+42Z0PPUc/LzAK/XJaWKFS2x3aYA5HUamQfnHsw/ulh2B7KB0IWPpyCRupH7Y+
         jXhh9xa4c3FtLDKf7sZmjF+lF/K9WwLMJYwjJFx8CL89TFgLI17T6B4E/9QhFwFEpAH6
         UKxUvZFcdCnBw+r9ycZSoLi7YcfuweyYnzTbCG2/QzgIR5m+Ts7wHt28zC1G05pqZSX0
         bkxBAQ8FnC28VOMtem7D+aDot5FKlKPW08tELHYwcS0WPQSgoC6jmc4xeatjiinQTbWH
         EiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YX+Ijy6//mnPc6r5gggHSthpMfwHGQm/kI6cQy98wi8=;
        b=qqJj8yFxhegYsKqEUShpNzaTQnVEyND/wWBpFz1HoDxamnvevXU3tgb8TX+clg70N9
         m/x74bmxeHJwWj0VLkwWcrhuZ59IV9aBnUBJKhosAkdpswISy/fPKBeKlmZXr56e27PI
         +X82tnYLNZpFDypuAV5oQrx1KBL2khZn7FDuPMagWPdMVf+fmmzoqWIR333Ri7VFoOFe
         jLJgP8tX3enAWfe94gsHfdHQkV/i4CMrjx1zH8FR39kjEcynUbtDdWslK1oNpAE2I5S4
         slX2ti9+Y3kDJ5A7cxUJsv4pm4qLpKaj1XZIbwTc6Xe+VCfBjHXUteTLkstw7Sclm64d
         ilEw==
X-Gm-Message-State: AOAM530bJWDoPCv6A2oTgesvM28P71DX+gIRR1VQvd/gQNJcn8UilqMX
        D4TyUMn5BRXFwhj4ey5uHsI=
X-Google-Smtp-Source: ABdhPJy8DYKsmt43hVJKXeoaom0FahbWuU4t2csLOtF3Qcox49xjJiwkeAlE/75R1SnZ9NqQ2i9asA==
X-Received: by 2002:a17:906:7d82:: with SMTP id v2mr31114741ejo.524.1617664352598;
        Mon, 05 Apr 2021 16:12:32 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id w6sm9575376eje.107.2021.04.05.16.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:12:32 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator_registry: Give devices time to set up when connecting
Date:   Tue,  6 Apr 2021 01:12:22 +0200
Message-Id: <20210405231222.358113-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, the "base connected" event that we rely on to (re-)attach the
device connected to the base is sent a bit too early. When this happens,
some devices may not be completely ready yet.

Specifically, the battery has been observed to report zero-values for
things like full charge capacity, which, however, is only loaded once
when the driver for that device probes. This can thus result in battery
readings being unavailable.

As we cannot easily and reliably discern between devices that are not
ready yet and devices that are not connected (i.e. will never be ready),
delay adding these devices. This should give them enough time to set up.

The delay is set to 2.5 seconds, which should give us a good safety
margin based on testing and still be fairly responsive for users.

To achieve that delay switch to updating via a delayed work struct,
which means that we can also get rid of some locking.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 98 ++++++++-----------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index eccb9d1007cd..685d37a7add1 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -13,10 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/surface_aggregator/controller.h>
 #include <linux/surface_aggregator/device.h>
@@ -287,6 +287,13 @@ static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *c
 
 /* -- SSAM base-hub driver. ------------------------------------------------- */
 
+/*
+ * Some devices (especially battery) may need a bit of time to be fully usable
+ * after being (re-)connected. This delay has been determined via
+ * experimentation.
+ */
+#define SSAM_BASE_UPDATE_CONNECT_DELAY		msecs_to_jiffies(2500)
+
 enum ssam_base_hub_state {
 	SSAM_BASE_HUB_UNINITIALIZED,
 	SSAM_BASE_HUB_CONNECTED,
@@ -296,8 +303,8 @@ enum ssam_base_hub_state {
 struct ssam_base_hub {
 	struct ssam_device *sdev;
 
-	struct mutex lock;  /* Guards state update checks and transitions. */
 	enum ssam_base_hub_state state;
+	struct delayed_work update_work;
 
 	struct ssam_event_notifier notif;
 };
@@ -335,11 +342,7 @@ static ssize_t ssam_base_hub_state_show(struct device *dev, struct device_attrib
 					char *buf)
 {
 	struct ssam_base_hub *hub = dev_get_drvdata(dev);
-	bool connected;
-
-	mutex_lock(&hub->lock);
-	connected = hub->state == SSAM_BASE_HUB_CONNECTED;
-	mutex_unlock(&hub->lock);
+	bool connected = hub->state == SSAM_BASE_HUB_CONNECTED;
 
 	return sysfs_emit(buf, "%d\n", connected);
 }
@@ -356,16 +359,20 @@ static const struct attribute_group ssam_base_hub_group = {
 	.attrs = ssam_base_hub_attrs,
 };
 
-static int __ssam_base_hub_update(struct ssam_base_hub *hub, enum ssam_base_hub_state new)
+static void ssam_base_hub_update_workfn(struct work_struct *work)
 {
+	struct ssam_base_hub *hub = container_of(work, struct ssam_base_hub, update_work.work);
 	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
+	enum ssam_base_hub_state state;
 	int status = 0;
 
-	lockdep_assert_held(&hub->lock);
+	status = ssam_base_hub_query_state(hub, &state);
+	if (status)
+		return;
 
-	if (hub->state == new)
-		return 0;
-	hub->state = new;
+	if (hub->state == state)
+		return;
+	hub->state = state;
 
 	if (hub->state == SSAM_BASE_HUB_CONNECTED)
 		status = ssam_hub_add_devices(&hub->sdev->dev, hub->sdev->ctrl, node);
@@ -374,51 +381,28 @@ static int __ssam_base_hub_update(struct ssam_base_hub *hub, enum ssam_base_hub_
 
 	if (status)
 		dev_err(&hub->sdev->dev, "failed to update base-hub devices: %d\n", status);
-
-	return status;
-}
-
-static int ssam_base_hub_update(struct ssam_base_hub *hub)
-{
-	enum ssam_base_hub_state state;
-	int status;
-
-	mutex_lock(&hub->lock);
-
-	status = ssam_base_hub_query_state(hub, &state);
-	if (!status)
-		status = __ssam_base_hub_update(hub, state);
-
-	mutex_unlock(&hub->lock);
-	return status;
 }
 
 static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
 {
-	struct ssam_base_hub *hub;
-	struct ssam_device *sdev;
-	enum ssam_base_hub_state new;
-
-	hub = container_of(nf, struct ssam_base_hub, notif);
-	sdev = hub->sdev;
+	struct ssam_base_hub *hub = container_of(nf, struct ssam_base_hub, notif);
+	unsigned long delay;
 
 	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
 		return 0;
 
 	if (event->length < 1) {
-		dev_err(&sdev->dev, "unexpected payload size: %u\n",
-			event->length);
+		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
 		return 0;
 	}
 
-	if (event->data[0])
-		new = SSAM_BASE_HUB_CONNECTED;
-	else
-		new = SSAM_BASE_HUB_DISCONNECTED;
+	/*
+	 * Delay update when the base is being connected to give devices/EC
+	 * some time to set up.
+	 */
+	delay = event->data[0] ? SSAM_BASE_UPDATE_CONNECT_DELAY : 0;
 
-	mutex_lock(&hub->lock);
-	__ssam_base_hub_update(hub, new);
-	mutex_unlock(&hub->lock);
+	schedule_delayed_work(&hub->update_work, delay);
 
 	/*
 	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
@@ -430,7 +414,10 @@ static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam
 
 static int __maybe_unused ssam_base_hub_resume(struct device *dev)
 {
-	return ssam_base_hub_update(dev_get_drvdata(dev));
+	struct ssam_base_hub *hub = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&hub->update_work, 0);
+	return 0;
 }
 static SIMPLE_DEV_PM_OPS(ssam_base_hub_pm_ops, NULL, ssam_base_hub_resume);
 
@@ -443,8 +430,6 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 	if (!hub)
 		return -ENOMEM;
 
-	mutex_init(&hub->lock);
-
 	hub->sdev = sdev;
 	hub->state = SSAM_BASE_HUB_UNINITIALIZED;
 
@@ -456,27 +441,25 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 	hub->notif.event.mask = SSAM_EVENT_MASK_NONE;
 	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
 
+	INIT_DELAYED_WORK(&hub->update_work, ssam_base_hub_update_workfn);
+
 	ssam_device_set_drvdata(sdev, hub);
 
 	status = ssam_notifier_register(sdev->ctrl, &hub->notif);
 	if (status)
-		goto err_register;
-
-	status = ssam_base_hub_update(hub);
-	if (status)
-		goto err_update;
+		return status;
 
 	status = sysfs_create_group(&sdev->dev.kobj, &ssam_base_hub_group);
 	if (status)
-		goto err_update;
+		goto err;
 
+	schedule_delayed_work(&hub->update_work, 0);
 	return 0;
 
-err_update:
+err:
 	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	cancel_delayed_work_sync(&hub->update_work);
 	ssam_hub_remove_devices(&sdev->dev);
-err_register:
-	mutex_destroy(&hub->lock);
 	return status;
 }
 
@@ -487,9 +470,8 @@ static void ssam_base_hub_remove(struct ssam_device *sdev)
 	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
 
 	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	cancel_delayed_work_sync(&hub->update_work);
 	ssam_hub_remove_devices(&sdev->dev);
-
-	mutex_destroy(&hub->lock);
 }
 
 static const struct ssam_device_id ssam_base_hub_match[] = {
-- 
2.31.1

