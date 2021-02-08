Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDE31412C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhBHVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbhBHTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:50:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED19BC06178C;
        Mon,  8 Feb 2021 11:49:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y18so20208351edw.13;
        Mon, 08 Feb 2021 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCY7iWXGVoWG8lMWKwFW8Wg242yDvtfAK+mK2aTNK2k=;
        b=PpnvzQKHyyizQ+ANx8wYeDBYkLbmUYJro/+/zgfDQIth7KfLO9sjOfeHadbYhLAn+g
         ME1fnX8Un2no7iK7gruxZZ4OUe/HfYNx9U2CnDruvKnF27egFVqLO7hA06+bIMzd5Iq6
         f3brksBXuRyijQEpkM3quX3ftfLYIE2cNGy3i/V7FcsxCLweMN9mAgPU8PjyGnALB53M
         /lnMtjUDs1uFNY4KpzSCYUAdPTnU4vQC+E0Gp6QXppbqMOWgDmakzo87ZNFJB0iYi/SN
         x6sODnLoHAMo31G2JYGbFwb5BfrMeLapipj69lx/E4v8pApBAech6bE9hUBcMSkv/x7R
         Tidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCY7iWXGVoWG8lMWKwFW8Wg242yDvtfAK+mK2aTNK2k=;
        b=RXQrhYfDGyM1+FMEUhAxK8U6Impei8xGBHMHXTTu5cQXkMZPCu1bQ5fzTCp+hizSem
         HFTF47tF1/y/11Dbl/m7rByH7JJ/MxirAWKylyohLwp0OyMqy12Mb0tIqKcTQPis0Bxt
         lnMzGAgHAekQ2anGdPOS4cbaDIWSoefGXA5zMBi+2JFgC7kwA6fZONmHImKa0ltM9f1z
         v/7YbbtLjha7rwpC75CfFBdAAlp6RlCHMw2vD7PNbHRiTP6YpfDNAk9n+Sza7gJrFSRu
         lFLBrOAjZzGfzC+UTMOX8k2Ok9MU6IlC+wAA2TC0SJOXwFYtZsbsS6hmk9Cugw1PeDkl
         bBbw==
X-Gm-Message-State: AOAM531D18r1I5HtdzXecd6mFBGe4PHSMhBfsyJtHHN1u6oyiRGv1p9B
        5hGUyp6ZA4OJT5uVEc+NZlbzzbD1jk6yFQ==
X-Google-Smtp-Source: ABdhPJwKeviFI8mQ4InPvdWoPpEdfy+gxarjdNRlKKAv5vihSWcUJRnU+NIxMGhmBm4KbuOgnbAh1Q==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr18861503edw.314.1612813759599;
        Mon, 08 Feb 2021 11:49:19 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id hb24sm7940866ejb.16.2021.02.08.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:49:18 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: Add platform profile driver
Date:   Mon,  8 Feb 2021 20:49:03 +0100
Message-Id: <20210208194903.3039142-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to provide platform profile support on 5th- and later
generation Microsoft Surface devices with a Surface System Aggregator
Module. On those devices, the platform profile can be used to influence
cooling behavior and power consumption.

For example, the default 'quiet' profile limits fan noise and in turn
sacrifices performance of the discrete GPU found on Surface Books. Its
full performance can only be unlocked on the 'performance' profile.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Note: This patch builds ontop of the

    platform/surface: Add Surface Aggregator device registry

series. While that series is not strictly required for building this
driver, it provides the device against which it loads. So (at the moment
at least) this patch is essentially useless without that series.

---
 MAINTAINERS                                   |   6 +
 drivers/platform/surface/Kconfig              |  27 +++
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/platform/surface/surface_platform_profile.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 000a82f59c76..a08d65f8f0df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11811,6 +11811,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/surface/surface_hotplug.c
 
+MICROSOFT SURFACE PLATFORM PROFILE DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_platform_profile.c
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 1cd37c041710..e12c65909bcc 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -131,6 +131,33 @@ config SURFACE_HOTPLUG
 	  Select M or Y here, if you want to (fully) support hot-plugging of
 	  dGPU devices on the Surface Book 2 and/or 3 during D3cold.
 
+config SURFACE_PLATFORM_PROFILE
+	tristate "Surface Platform Profile Driver"
+	depends on SURFACE_AGGREGATOR_BUS
+	depends on ACPI_PLATFORM_PROFILE
+	help
+	  Provides support for the ACPI platform profile on 5th- and later
+	  generation Microsoft Surface devices.
+
+	  More specifically, this driver provides ACPI platform profile support
+	  on Microsoft Surface devices with a Surface System Aggregator Module
+	  (SSAM) connected via the Surface Serial Hub (SSH / SAM-over-SSH). In
+	  other words, this driver provides platform profile support on the
+	  Surface Pro 5, Surface Book 2, Surface Laptop, Surface Laptop Go and
+	  later. On those devices, the platform profile can significantly
+	  influence cooling behavior, e.g. setting it to 'quiet' (default) or
+	  'low-power' can significantly limit performance of the discrete GPU on
+	  Surface Books, while in turn leading to lower power consumption and/or
+	  less fan noise.
+
+	  Note that this driver currently relies on the Surface Aggregator
+	  registry (CONFIG_SURFACE_AGGREGATOR_REGISTRY) to provide the device it
+	  loads against. Thus, without that registry, this module is essentially
+	  of no use.
+
+	  Select M or Y here, if you want to include ACPI platform profile
+	  support on the above mentioned devices.
+
 config SURFACE_PRO3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
 	depends on INPUT
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 80035ee540bf..99372c427b73 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
+obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
new file mode 100644
index 000000000000..548ad8af9cf1
--- /dev/null
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface Platform Profile / Performance Mode driver for Surface System
+ * Aggregator Module (thermal subsystem).
+ *
+ * Copyright (C) 2021 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_profile.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/device.h>
+
+enum ssam_tmp_profile {
+	SSAM_TMP_PROFILE_NORMAL             = 1,
+	SSAM_TMP_PROFILE_BATTERY_SAVER      = 2,
+	SSAM_TMP_PROFILE_BETTER_PERFORMANCE = 3,
+	SSAM_TMP_PROFILE_BEST_PERFORMANCE   = 4,
+};
+
+struct ssam_tmp_profile_info {
+	__le32 profile;
+	__le16 unknown1;
+	__le16 unknown2;
+} __packed;
+
+struct ssam_tmp_profile_device {
+	struct ssam_device *sdev;
+	struct platform_profile_handler handler;
+};
+
+static SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x02,
+});
+
+static SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x03,
+});
+
+static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
+{
+	struct ssam_tmp_profile_info info;
+	int status;
+
+	status = ssam_retry(__ssam_tmp_profile_get, sdev, &info);
+	if (status < 0)
+		return status;
+
+	*p = le32_to_cpu(info.profile);
+	return 0;
+}
+
+static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile p)
+{
+	__le32 profile_le = cpu_to_le32(p);
+
+	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
+}
+
+static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
+{
+	switch (p) {
+	case SSAM_TMP_PROFILE_NORMAL:
+		return PLATFORM_PROFILE_QUIET;
+
+	case SSAM_TMP_PROFILE_BATTERY_SAVER:
+		return PLATFORM_PROFILE_LOW_POWER;
+
+	case SSAM_TMP_PROFILE_BETTER_PERFORMANCE:
+		return PLATFORM_PROFILE_BALANCED;
+
+	case SSAM_TMP_PROFILE_BEST_PERFORMANCE:
+		return PLATFORM_PROFILE_PERFORMANCE;
+
+	default:
+		dev_err(&sdev->dev, "invalid performance profile: %d", p);
+		return -EINVAL;
+	}
+}
+
+static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profile_option p)
+{
+	switch (p) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		return SSAM_TMP_PROFILE_BATTERY_SAVER;
+
+	case PLATFORM_PROFILE_QUIET:
+		return SSAM_TMP_PROFILE_NORMAL;
+
+	case PLATFORM_PROFILE_BALANCED:
+		return SSAM_TMP_PROFILE_BETTER_PERFORMANCE;
+
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return SSAM_TMP_PROFILE_BEST_PERFORMANCE;
+
+	default:
+		/* This should have already been caught by platform_profile_store(). */
+		WARN(true, "unsupported platform profile");
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
+				     enum platform_profile_option *profile)
+{
+	struct ssam_tmp_profile_device *tpd;
+	enum ssam_tmp_profile tp;
+	int status;
+
+	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
+
+	status = ssam_tmp_profile_get(tpd->sdev, &tp);
+	if (status)
+		return status;
+
+	status = convert_ssam_to_profile(tpd->sdev, tp);
+	if (status < 0)
+		return status;
+
+	*profile = status;
+	return 0;
+}
+
+static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	struct ssam_tmp_profile_device *tpd;
+	int tp;
+
+	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
+
+	tp = convert_profile_to_ssam(tpd->sdev, profile);
+	if (tp < 0)
+		return tp;
+
+	return ssam_tmp_profile_set(tpd->sdev, tp);
+}
+
+static int surface_platform_profile_probe(struct ssam_device *sdev)
+{
+	struct ssam_tmp_profile_device *tpd;
+
+	tpd = devm_kzalloc(&sdev->dev, sizeof(*tpd), GFP_KERNEL);
+	if (!tpd)
+		return -ENOMEM;
+
+	tpd->sdev = sdev;
+
+	tpd->handler.profile_get = ssam_platform_profile_get;
+	tpd->handler.profile_set = ssam_platform_profile_set;
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
+	set_bit(PLATFORM_PROFILE_QUIET, tpd->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
+
+	platform_profile_register(&tpd->handler);
+	return 0;
+}
+
+static void surface_platform_profile_remove(struct ssam_device *sdev)
+{
+	platform_profile_remove();
+}
+
+static const struct ssam_device_id ssam_platform_profile_match[] = {
+	{ SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
+
+static struct ssam_device_driver surface_platform_profile = {
+	.probe = surface_platform_profile_probe,
+	.remove = surface_platform_profile_remove,
+	.match_table = ssam_platform_profile_match,
+	.driver = {
+		.name = "surface_platform_profile",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(surface_platform_profile);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Platform Profile Support for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.30.0

