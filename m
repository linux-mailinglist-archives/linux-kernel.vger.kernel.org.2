Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892B319359
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBKTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhBKTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:47:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15AC0613D6;
        Thu, 11 Feb 2021 11:46:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so8185833edw.8;
        Thu, 11 Feb 2021 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKTjcZrKPElcKyPJ5qAyLAr8f1S682D7/6q/UuWh6ys=;
        b=a4FeE3NkKr+xZKgtpumNziDe6HIkB3C8Ara44KfHwoMMcA0h4qZaxxUMDClIw2CkU8
         yDO1bMhvgbruHL42lh00wlB9/mE4KaY54X0YNX0X4ixjp5GRWAv5DAPHP+rROZeA8mTd
         Yr2bpG+QL0oJ0DKA2nEFGxPKrVU7cy4IXuXcPLyzZpv5YDbNaQ7jw7mILPvgO5FjHGD+
         sx88N79CedtHE0aZzeWFgGRIQvHf1E38gn1x+UEdMCRjaixEpiVo6GuHi/x+JK7neJRs
         B79tr4NKMHwMvPqfNL4FaJjxbon62lWVyaAW6d1oyupTNLsKMytXITLZpwcFu2VXmWBm
         Lkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKTjcZrKPElcKyPJ5qAyLAr8f1S682D7/6q/UuWh6ys=;
        b=mIJEuM1wzHrUhmE4XqbjIFDb8++hNu9rjIHrBrP/C1xu0sN9WSMZKnwuDbdVAa0iku
         dDU/cCZORHYY/ItL3/PEA163Ea58QqrOHpUIO06L5WxnFACjybOhTDjMWbTiqUrTFD7b
         HnwQwDKyB0WVkjvm6NhoS3ijDBun7Ci0+9G0z6GpWQoaBVbRSHmuaetVSWdi6EN9PykL
         n3LQSGp+psLd/JNXAx08sjXr6BqN5AIxQxKiXpXfEG6rJ6dY6AlH+1LGdTY46fgg2mjW
         zhmDFxPioYOg3fYcmDUEekZpywnaV+mbEUtDpOTaTfJr+8W3HNhbFwwJFk0tKlVSu+5q
         yoQg==
X-Gm-Message-State: AOAM533+eaIGjj5gtFGkYIYIEpQqxeU4sL4ytrvA+uEmCKrrn2EOPAuv
        m4TxapAKNcLBo0cZOEH6lQFMmtThK3FEAg==
X-Google-Smtp-Source: ABdhPJyLF/Z4WiestAaXTUm3oiY+jPC7oQGcdQ2l7cdT8FkqKqnRPbjuNa5UCht/qzxGfNI/qLpw0A==
X-Received: by 2002:aa7:ce18:: with SMTP id d24mr10132128edv.376.1613072807982;
        Thu, 11 Feb 2021 11:46:47 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:47 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] platform/surface: aggregator_registry: Add base device hub
Date:   Thu, 11 Feb 2021 20:46:32 +0100
Message-Id: <20210211194636.568929-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface Book 3 has a detachable base part. While the top part
(so-called clipboard) contains the CPU, touchscreen, and primary
battery, the base contains, among other things, a keyboard, touchpad,
and secondary battery.

Those devices do not react well to being accessed when the base part is
detached and should thus be removed and added in sync with the base. To
facilitate this, we introduce a virtual base device hub, which
automatically removes or adds the devices registered under it.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 261 +++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index a051d941ad96..0d802804594c 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -11,9 +11,12 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
 #include <linux/surface_aggregator/controller.h>
 #include <linux/surface_aggregator/device.h>
@@ -38,6 +41,12 @@ static const struct software_node ssam_node_root = {
 	.name = "ssam_platform_hub",
 };
 
+/* Base device hub (devices attached to Surface Book 3 base). */
+static const struct software_node ssam_node_hub_base = {
+	.name = "ssam:00:00:02:00:00",
+	.parent = &ssam_node_root,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -47,6 +56,7 @@ static const struct software_node *ssam_node_group_sb2[] = {
 /* Devices for Surface Book 3. */
 static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_root,
+	&ssam_node_hub_base,
 	NULL,
 };
 
@@ -177,6 +187,230 @@ static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *c
 }
 
 
+/* -- SSAM base-hub driver. ------------------------------------------------- */
+
+enum ssam_base_hub_state {
+	SSAM_BASE_HUB_UNINITIALIZED,
+	SSAM_BASE_HUB_CONNECTED,
+	SSAM_BASE_HUB_DISCONNECTED,
+};
+
+struct ssam_base_hub {
+	struct ssam_device *sdev;
+
+	struct mutex lock;  /* Guards state update checks and transitions. */
+	enum ssam_base_hub_state state;
+
+	struct ssam_event_notifier notif;
+};
+
+static SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
+	.target_category = SSAM_SSH_TC_BAS,
+	.target_id       = 0x01,
+	.command_id      = 0x0d,
+	.instance_id     = 0x00,
+});
+
+#define SSAM_BAS_OPMODE_TABLET		0x00
+#define SSAM_EVENT_BAS_CID_CONNECTION	0x0c
+
+static int ssam_base_hub_query_state(struct ssam_base_hub *hub, enum ssam_base_hub_state *state)
+{
+	u8 opmode;
+	int status;
+
+	status = ssam_retry(ssam_bas_query_opmode, hub->sdev->ctrl, &opmode);
+	if (status < 0) {
+		dev_err(&hub->sdev->dev, "failed to query base state: %d\n", status);
+		return status;
+	}
+
+	if (opmode != SSAM_BAS_OPMODE_TABLET)
+		*state = SSAM_BASE_HUB_CONNECTED;
+	else
+		*state = SSAM_BASE_HUB_DISCONNECTED;
+
+	return 0;
+}
+
+static ssize_t ssam_base_hub_state_show(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct ssam_base_hub *hub = dev_get_drvdata(dev);
+	bool connected;
+
+	mutex_lock(&hub->lock);
+	connected = hub->state == SSAM_BASE_HUB_CONNECTED;
+	mutex_unlock(&hub->lock);
+
+	return sysfs_emit(buf, "%d\n", connected);
+}
+
+static struct device_attribute ssam_base_hub_attr_state =
+	__ATTR(state, 0444, ssam_base_hub_state_show, NULL);
+
+static struct attribute *ssam_base_hub_attrs[] = {
+	&ssam_base_hub_attr_state.attr,
+	NULL,
+};
+
+const struct attribute_group ssam_base_hub_group = {
+	.attrs = ssam_base_hub_attrs,
+};
+
+static int __ssam_base_hub_update(struct ssam_base_hub *hub, enum ssam_base_hub_state new)
+{
+	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
+	int status = 0;
+
+	lockdep_assert_held(hub->lock);
+
+	if (hub->state == new)
+		return 0;
+	hub->state = new;
+
+	if (hub->state == SSAM_BASE_HUB_CONNECTED)
+		status = ssam_hub_add_devices(&hub->sdev->dev, hub->sdev->ctrl, node);
+	else
+		ssam_hub_remove_devices(&hub->sdev->dev);
+
+	if (status)
+		dev_err(&hub->sdev->dev, "failed to update base-hub devices: %d\n", status);
+
+	return status;
+}
+
+static int ssam_base_hub_update(struct ssam_base_hub *hub)
+{
+	enum ssam_base_hub_state state;
+	int status;
+
+	mutex_lock(&hub->lock);
+
+	status = ssam_base_hub_query_state(hub, &state);
+	if (!status)
+		status = __ssam_base_hub_update(hub, state);
+
+	mutex_unlock(&hub->lock);
+	return status;
+}
+
+static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct ssam_base_hub *hub;
+	struct ssam_device *sdev;
+	enum ssam_base_hub_state new;
+
+	hub = container_of(nf, struct ssam_base_hub, notif);
+	sdev = hub->sdev;
+
+	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
+		return 0;
+
+	if (event->length < 1) {
+		dev_err(&sdev->dev, "unexpected payload size: %u\n",
+			event->length);
+		return 0;
+	}
+
+	if (event->data[0])
+		new = SSAM_BASE_HUB_CONNECTED;
+	else
+		new = SSAM_BASE_HUB_DISCONNECTED;
+
+	mutex_lock(&hub->lock);
+	__ssam_base_hub_update(hub, new);
+	mutex_unlock(&hub->lock);
+
+	/*
+	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
+	 * consumed by the detachment system driver. We're just a (more or less)
+	 * silent observer.
+	 */
+	return 0;
+}
+
+static int __maybe_unused ssam_base_hub_resume(struct device *dev)
+{
+	return ssam_base_hub_update(dev_get_drvdata(dev));
+}
+static SIMPLE_DEV_PM_OPS(ssam_base_hub_pm_ops, NULL, ssam_base_hub_resume);
+
+static int ssam_base_hub_probe(struct ssam_device *sdev)
+{
+	struct ssam_base_hub *hub;
+	int status;
+
+	hub = devm_kzalloc(&sdev->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	mutex_init(&hub->lock);
+
+	hub->sdev = sdev;
+	hub->state = SSAM_BASE_HUB_UNINITIALIZED;
+
+	hub->notif.base.priority = INT_MAX;  /* This notifier should run first. */
+	hub->notif.base.fn = ssam_base_hub_notif;
+	hub->notif.event.reg = SSAM_EVENT_REGISTRY_SAM;
+	hub->notif.event.id.target_category = SSAM_SSH_TC_BAS,
+	hub->notif.event.id.instance = 0,
+	hub->notif.event.mask = SSAM_EVENT_MASK_NONE;
+	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	ssam_device_set_drvdata(sdev, hub);
+
+	status = ssam_notifier_register(sdev->ctrl, &hub->notif);
+	if (status)
+		goto err_register;
+
+	status = ssam_base_hub_update(hub);
+	if (status)
+		goto err_update;
+
+	status = sysfs_create_group(&sdev->dev.kobj, &ssam_base_hub_group);
+	if (status)
+		goto err_update;
+
+	return 0;
+
+err_update:
+	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_hub_remove_devices(&sdev->dev);
+err_register:
+	mutex_destroy(&hub->lock);
+	return status;
+}
+
+static void ssam_base_hub_remove(struct ssam_device *sdev)
+{
+	struct ssam_base_hub *hub = ssam_device_get_drvdata(sdev);
+
+	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
+
+	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_hub_remove_devices(&sdev->dev);
+
+	mutex_destroy(&hub->lock);
+}
+
+static const struct ssam_device_id ssam_base_hub_match[] = {
+	{ SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
+	{ },
+};
+
+static struct ssam_device_driver ssam_base_hub_driver = {
+	.probe = ssam_base_hub_probe,
+	.remove = ssam_base_hub_remove,
+	.match_table = ssam_base_hub_match,
+	.driver = {
+		.name = "surface_aggregator_base_hub",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &ssam_base_hub_pm_ops,
+	},
+};
+
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_match[] = {
@@ -277,7 +511,32 @@ static struct platform_driver ssam_platform_hub_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-module_platform_driver(ssam_platform_hub_driver);
+
+
+/* -- Module initialization. ------------------------------------------------ */
+
+static int __init ssam_device_hub_init(void)
+{
+	int status;
+
+	status = platform_driver_register(&ssam_platform_hub_driver);
+	if (status)
+		return status;
+
+	status = ssam_device_driver_register(&ssam_base_hub_driver);
+	if (status)
+		platform_driver_unregister(&ssam_platform_hub_driver);
+
+	return status;
+}
+module_init(ssam_device_hub_init);
+
+static void __exit ssam_device_hub_exit(void)
+{
+	ssam_device_driver_unregister(&ssam_base_hub_driver);
+	platform_driver_unregister(&ssam_platform_hub_driver);
+}
+module_exit(ssam_device_hub_exit);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Device-registry for Surface System Aggregator Module");
-- 
2.30.0

