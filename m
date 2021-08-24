Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670493F6C11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhHXXHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhHXXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:07:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA5C061757;
        Tue, 24 Aug 2021 16:06:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so3376089wro.7;
        Tue, 24 Aug 2021 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu/ag5GKGBWwht6VOzxJtXe0HGbioRW+arz4tUnbIYc=;
        b=LkW75YZSVVPiT/65SEiDzspNP9FZxl2SU4G/PXTkJdntISBsCc2FPrja2aWbKvsNfF
         3/v6z/0IBmBWO4lHItKIj4YEQCG2IcT9O0O6DU+tHTGWOM/FsbBy4uvZiwEMH+qto8RW
         sZMB4zzUI8SuHpgloJiBV8SQVB7/Xws+53MJcLXj0kPjEdN64WZevyWQfB6T3MLTjp9H
         YLDOl9MK+3c6qk1Xw/vrJobLrzHlLBGSqC1EHIpY+Hmrm4V5FUL2DhoItnpSerhkaz2N
         aceikHlNweQYywRt2CL2hZbGe0MI8mk5l/UusCO4haMJV4G212daRacfgfXpVMATPvS1
         3xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu/ag5GKGBWwht6VOzxJtXe0HGbioRW+arz4tUnbIYc=;
        b=UgCkAz++TEdD6UHsKumB3EvXNktBvdiqiUnDlxnggjmfiiixIMwqOXAXHREx2+Tjj8
         v1iIlmwGTpyKcLrBnVP92zBT7yqs1hD3O1uGbbw5JNns4JylWkjJjgWUBWl4/2+BqLLG
         UwvjGnjjcm+cQpkfvZS4wrhezuvQVYnzQsqsttQQlinhoKwVYDw+9ysaqaxwPUMSehBg
         kQXW7Z8WrZEM1jUriqtx7Qvrb3dGbLIujXnCQBcErzqlAUJAmBjBneSRxSZXAfI4dRPO
         hgW8EOt29trDRQQDGKwr5nhUrCkJQOrVk1caRg+CB/B7XphhUXmTi3SHU9xSrAry6DQ3
         vK5A==
X-Gm-Message-State: AOAM532wRV2CynyH4f/cJErDDOTSpscMd3hEj0R5saU9z/dWtC+jvVIA
        a/94oDeaos0JYqI5zZtxo1yJxzx0MnM=
X-Google-Smtp-Source: ABdhPJz9aSFUhjHO9rdvkv/AwEQ8ILRGQfgxClpFlpzsJOn7iGzHHxFubEpRwL8DpodssWAVyZtx+w==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr21470327wrz.380.1629846402807;
        Tue, 24 Aug 2021 16:06:42 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q10sm3477868wmq.12.2021.08.24.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 16:06:42 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH v2 3/3] platform/surface: Add Surface Go 2 board file
Date:   Wed, 25 Aug 2021 00:06:20 +0100
Message-Id: <20210824230620.1003828-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824230620.1003828-1-djrscally@gmail.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSDT tables on the Surface Go 2 contain no power control methods for
the world facing camera, so the regulator, gpio and clk frameworks have no
way to discover the appropriate connections and settings.

To compensate for the shortcomings, define the connections and other
parameters in a board file for this device.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:
	- Re-written to use regulator_add_lookup() instead of the software
	node api from v1.
	- Added a dmi check to prevent the lookups from being added where the
	platform running the code is not a Microsoft Surface Go 2 (Laurent)

 MAINTAINERS                             |  6 ++
 drivers/platform/surface/Kconfig        | 10 +++
 drivers/platform/surface/Makefile       |  1 +
 drivers/platform/surface/surface_go_2.c | 97 +++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 drivers/platform/surface/surface_go_2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc24e97d5386..891189cecd51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12329,6 +12329,12 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
 F:	drivers/platform/surface/surface_dtx.c
 F:	include/uapi/linux/surface_aggregator/dtx.h
 
+MICROSOFT SURFACE GO 2 SUPPORT
+M:	Daniel Scally <djrscally@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_go_2.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 3105f651614f..0c55bd531592 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -124,6 +124,16 @@ config SURFACE_DTX
 	  Aggregator Bus (i.e. CONFIG_SURFACE_AGGREGATOR_BUS=n). In that case,
 	  some devices, specifically the Surface Book 3, will not be supported.
 
+config SURFACE_GO_2
+	bool "Surface Go 2 Specific Driver"
+	help
+	  This board file performs some platform specific configuration to help
+	  the regulator, gpio and clk frameworks link those resources to the
+	  consuming devices - specifically the world facing camera.
+
+	  Select Y here if your device is a Microsoft Surface Go 2, otherwise
+	  select N.
+
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
 	depends on DMI
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 32889482de55..9f858d2a3d77 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
 obj-$(CONFIG_SURFACE_DTX)		+= surface_dtx.o
+obj-$(CONFIG_SURFACE_GO_2)		+= surface_go_2.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
 obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
diff --git a/drivers/platform/surface/surface_go_2.c b/drivers/platform/surface/surface_go_2.c
new file mode 100644
index 000000000000..31fd6a3ca4aa
--- /dev/null
+++ b/drivers/platform/surface/surface_go_2.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dan Scally <djrscally@gmail.com> */
+
+#include <linux/dmi.h>
+#include <linux/gpio/machine.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/regulator/machine.h>
+
+static const struct dmi_system_id surface_go_2_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 2"),
+		},
+	},
+	{ }
+};
+
+static struct regulator_consumer_supply ana_consumer_supplies[] = {
+	REGULATOR_SUPPLY("avdd", "i2c-INT347A:00"),
+};
+
+static struct regulator_lookup ana_lookup = {
+	.device_name = "i2c-INT3472:05",
+	.regulator_name = "ANA",
+	.init_data = {
+		.constraints = {
+			.min_uV = 2815200,
+			.max_uV = 2815200,
+			.apply_uV = 1,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(ana_consumer_supplies),
+		.consumer_supplies = ana_consumer_supplies,
+	},
+};
+
+static struct regulator_consumer_supply vsio_consumer_supplies[] = {
+	REGULATOR_SUPPLY("dovdd", "i2c-INT347A:00"),
+};
+
+static struct regulator_lookup vsio_lookup = {
+	.device_name = "i2c-INT3472:05",
+	.regulator_name = "VSIO",
+	.init_data = {
+		.constraints = {
+			.min_uV = 1800600,
+			.max_uV = 1800600,
+			.apply_uV = 1,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(vsio_consumer_supplies),
+		.consumer_supplies = vsio_consumer_supplies,
+	},
+};
+
+static struct regulator_consumer_supply core_consumer_supplies[] = {
+	REGULATOR_SUPPLY("dvdd", "i2c-INT347A:00"),
+};
+
+static struct regulator_lookup core_lookup = {
+	.device_name = "i2c-INT3472:05",
+	.regulator_name = "CORE",
+	.init_data = {
+		.constraints = {
+			.min_uV = 1200000,
+			.max_uV = 1200000,
+			.apply_uV = 1,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(core_consumer_supplies),
+		.consumer_supplies = core_consumer_supplies,
+	},
+};
+
+static struct gpiod_lookup_table surface_go_2_gpios = {
+	.dev_id = "i2c-INT347A:00",
+	.table = {
+		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW)
+	}
+};
+
+static int __init surface_go_2_init(void)
+{
+	if (!dmi_check_system(surface_go_2_dmi_table))
+		return -EINVAL;
+
+	regulator_add_lookup(&ana_lookup);
+	regulator_add_lookup(&vsio_lookup);
+	regulator_add_lookup(&core_lookup);
+	gpiod_add_lookup_table(&surface_go_2_gpios);
+
+	return 0;
+}
+device_initcall(surface_go_2_init);
-- 
2.25.1

