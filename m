Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185CE319358
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBKTrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhBKTr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:47:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F4C061756;
        Thu, 11 Feb 2021 11:46:47 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f14so11860908ejc.8;
        Thu, 11 Feb 2021 11:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vEcRJnrv+TKW7LPmlY6bd7eiXcKwVZKgdsROy9KLPk=;
        b=YBbXyt1v5AupZxTgvSmLzzEqLUZODKIta/3HGMoR0qEALUG3OZ564SLH61hcAY54s3
         2057huRGS+kgATNiAEq0MSWRwVfiH1kPjc8/did4NaisnJ0IbcHmpNjuuaaOnlIYN+NF
         iApNl+l4y1NQf3Qw/j8unY1y3pLZFDG6/lMYajSWywbHyPFnVXTRMwevQEbQ4COWeT53
         xHYGh9C8lTRjlBIZKRr5RQ5xolkFhnfsG06Je7AenANPJUUCKW53xpzqfX3z0n8SbRFP
         HYuUOZWC6wS9UK0VoIt3juStfdIFLHllRIS+Bmh8bgFS55BVYkW8qK7XqoPB/KzDcbkR
         sf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vEcRJnrv+TKW7LPmlY6bd7eiXcKwVZKgdsROy9KLPk=;
        b=IqjQq9odOPHGJZX+VvTelDUfX3YVV6AtA3uSyasSvSE+yi6R/2m/kxzydUatYWMpgO
         UnqZCyuK0qK3nRDKXVLxD6lvyR5piTpM1jfZKXzY/GebkZrW+reWHPlbUi6LYyPz0DCO
         NvGg9LVZSL8WnKUdTOaDxjLnXeKXQ28U8OHzdsMTBcRyRVvnlbCrO/NNsP1S8UkxuIsR
         Mq7KMjaHpTiP3BZQEOgh+Ht1ezdU0KVNulaTmdKs1be9uYzbsn00LKMv38Qqnqf44B+1
         c5kmKZpnCMrxxzh2joyh2AUsEOFy7AJNcqi7nEoVtCElIRX0kIN9qM5xk/XH7Z+hlSTt
         it1Q==
X-Gm-Message-State: AOAM532d2Xov0OMH1A2YfHT/eJ3Aj2gdn3oDwVI/M2GpjiUnOu0p1KnY
        TzWFnKHfF2KiOjQffgBiTeE=
X-Google-Smtp-Source: ABdhPJwBdCsSE/ULkDZXEuA3vQXlGSwwcwhuh+0bImRaL8uO9oNpj/Kj+rDXCi34xG+1e52lJWx8Zg==
X-Received: by 2002:a17:906:39c6:: with SMTP id i6mr10359575eje.433.1613072806580;
        Thu, 11 Feb 2021 11:46:46 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:46 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] platform/surface: Set up Surface Aggregator device registry
Date:   Thu, 11 Feb 2021 20:46:31 +0100
Message-Id: <20210211194636.568929-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface System Aggregator Module (SSAM) subsystem provides various
functionalities, which are separated by spreading them across multiple
devices and corresponding drivers. Parts of that functionality / some of
those devices, however, can (as far as we currently know) not be
auto-detected by conventional means. While older (specifically 5th- and
6th-)generation models do advertise most of their functionality via
standard platform devices in ACPI, newer generations do not.

As we are currently also not aware of any feasible way to query said
functionalities dynamically, this poses a problem. There is, however, a
device in ACPI that seems to be used by Windows for identifying
different Surface models: The Windows Surface Integration Device (WSID).
This device seems to have a HID corresponding to the overall set of
functionalities SSAM provides for the associated model.

This commit introduces a registry providing non-detectable device
information via software nodes. In addition, a SSAM platform hub driver
is introduced, which takes care of creating and managing the SSAM
devices specified in this registry. This approach allows for a
hierarchical setup akin to ACPI and is easily extendable, e.g. via
firmware node properties.

Note that this commit only provides the basis for the platform hub and
registry, and does not add any content to it. The registry will be
expanded in subsequent commits.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Fix Kconfig dependency

---
 MAINTAINERS                                   |   1 +
 drivers/platform/surface/Kconfig              |  27 ++
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_registry.c     | 284 ++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 drivers/platform/surface/surface_aggregator_registry.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fcf3df517a8..000a82f59c76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11826,6 +11826,7 @@ F:	Documentation/driver-api/surface_aggregator/
 F:	drivers/platform/surface/aggregator/
 F:	drivers/platform/surface/surface_acpi_notify.c
 F:	drivers/platform/surface/surface_aggregator_cdev.c
+F:	drivers/platform/surface/surface_aggregator_registry.c
 F:	include/linux/surface_acpi_notify.h
 F:	include/linux/surface_aggregator/
 F:	include/uapi/linux/surface_aggregator/
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 0847b2dc97bf..179b8c93d7fd 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -77,6 +77,33 @@ config SURFACE_AGGREGATOR_CDEV
 	  The provided interface is intended for debugging and development only,
 	  and should not be used otherwise.
 
+config SURFACE_AGGREGATOR_REGISTRY
+	tristate "Surface System Aggregator Module Device Registry"
+	depends on SURFACE_AGGREGATOR
+	depends on SURFACE_AGGREGATOR_BUS
+	help
+	  Device-registry and device-hubs for Surface System Aggregator Module
+	  (SSAM) devices.
+
+	  Provides a module and driver which act as a device-registry for SSAM
+	  client devices that cannot be detected automatically, e.g. via ACPI.
+	  Such devices are instead provided via this registry and attached via
+	  device hubs, also provided in this module.
+
+	  Devices provided via this registry are:
+	  - Platform profile (performance-/cooling-mode) device (5th- and later
+	    generations).
+	  - Battery/AC devices (7th-generation).
+	  - HID input devices (7th-generation).
+
+	  Select M (recommended) or Y here if you want support for the above
+	  mentioned devices on the corresponding Surface models. Without this
+	  module, the respective devices will not be instantiated and thus any
+	  functionality provided by them will be missing, even when drivers for
+	  these devices are present. In other words, this module only provides
+	  the respective client devices. Drivers for these devices still need to
+	  be selected via the other options.
+
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
 	depends on DMI
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 990424c5f0c9..80035ee540bf 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
+obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
new file mode 100644
index 000000000000..a051d941ad96
--- /dev/null
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface System Aggregator Module (SSAM) client device registry.
+ *
+ * Registry for non-platform/non-ACPI SSAM client devices, i.e. devices that
+ * cannot be auto-detected. Provides device-hubs and performs instantiation
+ * for these devices.
+ *
+ * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
+
+
+/* -- Device registry. ------------------------------------------------------ */
+
+/*
+ * SSAM device names follow the SSAM module alias, meaning they are prefixed
+ * with 'ssam:', followed by domain, category, target ID, instance ID, and
+ * function, each encoded as two-digit hexadecimal, separated by ':'. In other
+ * words, it follows the scheme
+ *
+ *      ssam:dd:cc:tt:ii:ff
+ *
+ * Where, 'dd', 'cc', 'tt', 'ii', and 'ff' are the two-digit hexadecimal
+ * values mentioned above, respectively.
+ */
+
+/* Root node. */
+static const struct software_node ssam_node_root = {
+	.name = "ssam_platform_hub",
+};
+
+/* Devices for Surface Book 2. */
+static const struct software_node *ssam_node_group_sb2[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Book 3. */
+static const struct software_node *ssam_node_group_sb3[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Laptop 1. */
+static const struct software_node *ssam_node_group_sl1[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Laptop 2. */
+static const struct software_node *ssam_node_group_sl2[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Laptop 3. */
+static const struct software_node *ssam_node_group_sl3[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Laptop Go. */
+static const struct software_node *ssam_node_group_slg1[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Pro 5. */
+static const struct software_node *ssam_node_group_sp5[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Pro 6. */
+static const struct software_node *ssam_node_group_sp6[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+/* Devices for Surface Pro 7. */
+static const struct software_node *ssam_node_group_sp7[] = {
+	&ssam_node_root,
+	NULL,
+};
+
+
+/* -- Device registry helper functions. ------------------------------------- */
+
+static int ssam_uid_from_string(const char *str, struct ssam_device_uid *uid)
+{
+	u8 d, tc, tid, iid, fn;
+	int n;
+
+	n = sscanf(str, "ssam:%hhx:%hhx:%hhx:%hhx:%hhx", &d, &tc, &tid, &iid, &fn);
+	if (n != 5)
+		return -EINVAL;
+
+	uid->domain = d;
+	uid->category = tc;
+	uid->target = tid;
+	uid->instance = iid;
+	uid->function = fn;
+
+	return 0;
+}
+
+static int ssam_hub_remove_devices_fn(struct device *dev, void *data)
+{
+	if (!is_ssam_device(dev))
+		return 0;
+
+	ssam_device_remove(to_ssam_device(dev));
+	return 0;
+}
+
+static void ssam_hub_remove_devices(struct device *parent)
+{
+	device_for_each_child_reverse(parent, NULL, ssam_hub_remove_devices_fn);
+}
+
+static int ssam_hub_add_device(struct device *parent, struct ssam_controller *ctrl,
+			       struct fwnode_handle *node)
+{
+	struct ssam_device_uid uid;
+	struct ssam_device *sdev;
+	int status;
+
+	status = ssam_uid_from_string(fwnode_get_name(node), &uid);
+	if (status)
+		return status;
+
+	sdev = ssam_device_alloc(ctrl, uid);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->dev.parent = parent;
+	sdev->dev.fwnode = node;
+
+	status = ssam_device_add(sdev);
+	if (status)
+		ssam_device_put(sdev);
+
+	return status;
+}
+
+static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *ctrl,
+				struct fwnode_handle *node)
+{
+	struct fwnode_handle *child;
+	int status;
+
+	fwnode_for_each_child_node(node, child) {
+		/*
+		 * Try to add the device specified in the firmware node. If
+		 * this fails with -EINVAL, the node does not specify any SSAM
+		 * device, so ignore it and continue with the next one.
+		 */
+
+		status = ssam_hub_add_device(parent, ctrl, child);
+		if (status && status != -EINVAL)
+			goto err;
+	}
+
+	return 0;
+err:
+	ssam_hub_remove_devices(parent);
+	return status;
+}
+
+
+/* -- SSAM platform/meta-hub driver. ---------------------------------------- */
+
+static const struct acpi_device_id ssam_platform_hub_match[] = {
+	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
+	{ "MSHW0081", (unsigned long)ssam_node_group_sp5 },
+
+	/* Surface Pro 6 (OMBR >= 0x10) */
+	{ "MSHW0111", (unsigned long)ssam_node_group_sp6 },
+
+	/* Surface Pro 7 */
+	{ "MSHW0116", (unsigned long)ssam_node_group_sp7 },
+
+	/* Surface Book 2 */
+	{ "MSHW0107", (unsigned long)ssam_node_group_sb2 },
+
+	/* Surface Book 3 */
+	{ "MSHW0117", (unsigned long)ssam_node_group_sb3 },
+
+	/* Surface Laptop 1 */
+	{ "MSHW0086", (unsigned long)ssam_node_group_sl1 },
+
+	/* Surface Laptop 2 */
+	{ "MSHW0112", (unsigned long)ssam_node_group_sl2 },
+
+	/* Surface Laptop 3 (13", Intel) */
+	{ "MSHW0114", (unsigned long)ssam_node_group_sl3 },
+
+	/* Surface Laptop 3 (15", AMD) */
+	{ "MSHW0110", (unsigned long)ssam_node_group_sl3 },
+
+	/* Surface Laptop Go 1 */
+	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);
+
+static int ssam_platform_hub_probe(struct platform_device *pdev)
+{
+	const struct software_node **nodes;
+	struct ssam_controller *ctrl;
+	struct fwnode_handle *root;
+	int status;
+
+	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
+	if (!nodes)
+		return -ENODEV;
+
+	/*
+	 * As we're adding the SSAM client devices as children under this device
+	 * and not the SSAM controller, we need to add a device link to the
+	 * controller to ensure that we remove all of our devices before the
+	 * controller is removed. This also guarantees proper ordering for
+	 * suspend/resume of the devices on this hub.
+	 */
+	ctrl = ssam_client_bind(&pdev->dev);
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl) == -ENODEV ? -EPROBE_DEFER : PTR_ERR(ctrl);
+
+	status = software_node_register_node_group(nodes);
+	if (status)
+		return status;
+
+	root = software_node_fwnode(&ssam_node_root);
+	if (!root) {
+		software_node_unregister_node_group(nodes);
+		return -ENOENT;
+	}
+
+	set_secondary_fwnode(&pdev->dev, root);
+
+	status = ssam_hub_add_devices(&pdev->dev, ctrl, root);
+	if (status) {
+		set_secondary_fwnode(&pdev->dev, NULL);
+		software_node_unregister_node_group(nodes);
+	}
+
+	platform_set_drvdata(pdev, nodes);
+	return status;
+}
+
+static int ssam_platform_hub_remove(struct platform_device *pdev)
+{
+	const struct software_node **nodes = platform_get_drvdata(pdev);
+
+	ssam_hub_remove_devices(&pdev->dev);
+	set_secondary_fwnode(&pdev->dev, NULL);
+	software_node_unregister_node_group(nodes);
+	return 0;
+}
+
+static struct platform_driver ssam_platform_hub_driver = {
+	.probe = ssam_platform_hub_probe,
+	.remove = ssam_platform_hub_remove,
+	.driver = {
+		.name = "surface_aggregator_platform_hub",
+		.acpi_match_table = ssam_platform_hub_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(ssam_platform_hub_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Device-registry for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.30.0

