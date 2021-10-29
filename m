Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A68440528
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJ2V5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhJ2V47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635544467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kThBFWAb67KSqBF7XoYTknpXUcUZelNElU/E06MVtM=;
        b=ZCF5iiCKUCAy8905smg2zGWbeElDKlbQMtf6sYnsNdQeVmisq+3TB/eEWbaKPSVJwCLlMm
        U0aKnzgNJpvsBwyXvBdpowH/heqwuFaYBUaYwefyHsa3dY1ayFRKrw/31fUiWjtIS6wsR2
        P6Y1ekv6UHDvMSduD/qS7u2tp6nSbds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-olVdcj4XNwaNKcUDLLrGgQ-1; Fri, 29 Oct 2021 17:54:26 -0400
X-MC-Unique: olVdcj4XNwaNKcUDLLrGgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1C610A8E02;
        Fri, 29 Oct 2021 21:54:25 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52C5D5DF56;
        Fri, 29 Oct 2021 21:54:23 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 1/5] drivers/mfd: sensehat: Raspberry Pi Sense HAT core driver
Date:   Fri, 29 Oct 2021 17:55:12 -0400
Message-Id: <20211029215516.801593-2-cmirabil@redhat.com>
In-Reply-To: <20211029215516.801593-1-cmirabil@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core driver file, containing the regmap configuration
needed to communicate with the board over I2C. We also add the header
file shared by all three drivers, containing common data and definitions.
In addition, we add a config option to toggle compilation of the driver.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/mfd/Kconfig          |   8 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/sensehat-core.c  | 164 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/sensehat.h |  64 ++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 drivers/mfd/sensehat-core.c
 create mode 100644 include/linux/mfd/sensehat.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..297ab2143ced 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -11,6 +11,14 @@ config MFD_CORE
 	select IRQ_DOMAIN
 	default n
 
+config MFD_SENSEHAT_CORE
+	tristate "Raspberry Pi Sense HAT core functions"
+	depends on I2C
+	select MFD_CORE
+	help
+	  This is the core driver for the Raspberry Pi Sense HAT. This provides
+	  the necessary functions to communicate with the hardware.
+
 config MFD_CS5535
 	tristate "AMD CS5535 and CS5536 southbridge core functions"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2ba6646e874c..7347a040a4ac 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_SENSEHAT_CORE) += sensehat-core.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/sensehat-core.c b/drivers/mfd/sensehat-core.c
new file mode 100644
index 000000000000..fb6c89510ec0
--- /dev/null
+++ b/drivers/mfd/sensehat-core.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT core driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * This driver is based on wm8350 implementation and was refactored to use the
+ * misc device subsystem rather than the deprecated framebuffer subsystem.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include "sensehat.h"
+
+static struct platform_device *
+sensehat_client_dev_register(struct sensehat *sensehat, const char *name);
+
+static struct regmap_config sensehat_config;
+
+static int sensehat_probe(struct i2c_client *i2c,
+			       const struct i2c_device_id *id)
+{
+	int ret;
+	unsigned int reg;
+
+	struct sensehat *sensehat = devm_kzalloc(&i2c->dev, sizeof(*sensehat), GFP_KERNEL);
+
+	if (!sensehat)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, sensehat);
+	sensehat->dev = &i2c->dev;
+	sensehat->i2c_client = i2c;
+
+	sensehat->regmap = devm_regmap_init_i2c(sensehat->i2c_client, &sensehat_config);
+
+	if (IS_ERR(sensehat->regmap)) {
+		dev_err(sensehat->dev, "Failed to initialize sensehat regmap");
+		return PTR_ERR(sensehat->regmap);
+	}
+
+
+	ret = regmap_read(sensehat->regmap, SENSEHAT_WAI, &reg);
+	if (ret < 0) {
+		dev_err(sensehat->dev, "failed to read from device");
+		return ret;
+	}
+
+	if (reg != SENSEHAT_ID) {
+		dev_err(sensehat->dev, "expected device ID %i, got %i",
+			SENSEHAT_ID, ret);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(sensehat->regmap, SENSEHAT_VER, &reg);
+	if (ret < 0) {
+		dev_err(sensehat->dev, "Unable to get sensehat firmware version");
+		return ret;
+	}
+
+	dev_info(sensehat->dev,
+		 "Raspberry Pi Sense HAT firmware version %i\n", reg);
+
+	sensehat->joystick.pdev = sensehat_client_dev_register(sensehat,
+							       "sensehat-joystick");
+
+	if (IS_ERR(sensehat->joystick.pdev)) {
+		dev_err(sensehat->dev, "failed to register sensehat-joystick");
+		return PTR_ERR(sensehat->joystick.pdev);
+	}
+
+	sensehat->display.pdev = sensehat_client_dev_register(sensehat,
+								  "sensehat-display");
+
+	if (IS_ERR(sensehat->display.pdev)) {
+		dev_err(sensehat->dev, "failed to register sensehat-display");
+		return PTR_ERR(sensehat->display.pdev);
+	}
+
+	return 0;
+}
+
+static struct platform_device *
+sensehat_client_dev_register(struct sensehat *sensehat, const char *name)
+{
+	long ret = -ENOMEM;
+	struct platform_device *pdev = platform_device_alloc(name, -1);
+
+	if (!pdev)
+		goto alloc_fail;
+
+	pdev->dev.parent = sensehat->dev;
+	platform_set_drvdata(pdev, sensehat);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto add_fail;
+
+	ret = devm_add_action_or_reset(sensehat->dev,
+		(void *)platform_device_unregister, pdev);
+	if (ret)
+		goto alloc_fail;
+
+	return pdev;
+
+add_fail:
+	platform_device_put(pdev);
+alloc_fail:
+	return ERR_PTR(ret);
+}
+
+static bool sensehat_writeable_register(struct device *dev, unsigned int reg)
+{
+	return (reg >= SENSEHAT_DISPLAY &&
+		reg < SENSEHAT_DISPLAY + sizeof(sensehat_fb_t))
+		|| reg == SENSEHAT_EE_WP;
+}
+static bool sensehat_readable_register(struct device *dev, unsigned int reg)
+{
+	return (reg >= SENSEHAT_DISPLAY &&
+		reg < SENSEHAT_DISPLAY + sizeof(sensehat_fb_t))
+		|| reg == SENSEHAT_WAI || reg == SENSEHAT_VER
+		|| reg == SENSEHAT_KEYS || reg == SENSEHAT_EE_WP;
+}
+
+static struct regmap_config sensehat_config = {
+	.name = "sensehat",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = sensehat_writeable_register,
+	.readable_reg = sensehat_readable_register,
+};
+
+static const struct i2c_device_id sensehat_i2c_id[] = {
+	{ "sensehat", 0 },
+	{ "rpi-sense", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sensehat_i2c_id);
+
+static struct i2c_driver sensehat_driver = {
+	.driver = {
+		   .name = "sensehat",
+	},
+	.probe = sensehat_probe,
+	.id_table = sensehat_i2c_id,
+};
+
+module_i2c_driver(sensehat_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT core driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/sensehat.h b/include/linux/mfd/sensehat.h
new file mode 100644
index 000000000000..7e2e97a43f90
--- /dev/null
+++ b/include/linux/mfd/sensehat.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Raspberry Pi Sense HAT core driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#ifndef __LINUX_MFD_SENSEHAT_H_
+#define __LINUX_MFD_SENSEHAT_H_
+#include <linux/miscdevice.h>
+
+//8x8 display with 3 color channels
+typedef u8 sensehat_fb_t[8][3][8];
+
+#define SENSEHAT_DISPLAY		0x00
+#define SENSEHAT_WAI			0xF0
+#define SENSEHAT_VER			0xF1
+#define SENSEHAT_KEYS			0xF2
+#define SENSEHAT_EE_WP			0xF3
+
+#define SENSEHAT_ID			's'
+
+#define SENSEDISP_IOC_MAGIC 0xF1
+
+#define SENSEDISP_IOGET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 0)
+#define SENSEDISP_IOSET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 1)
+#define SENSEDISP_IORESET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 2)
+
+struct sensehat {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+	struct regmap *regmap;
+
+	/* Client devices */
+	struct sensehat_joystick {
+		struct platform_device *pdev;
+		struct input_dev *keys_dev;
+		struct gpio_desc *keys_desc;
+		int keys_irq;
+	} joystick;
+
+	struct sensehat_display {
+		struct platform_device *pdev;
+		struct miscdevice mdev;
+		struct mutex rw_mtx;
+		u8 gamma[32];
+		struct {
+			u16 b:5, u:1, g:5, r:5;
+		} vmem[8][8];
+	} display;
+};
+
+enum gamma_preset {
+	GAMMA_DEFAULT = 0,
+	GAMMA_LOWLIGHT,
+	GAMMA_PRESET_COUNT,
+};
+
+#endif
-- 
2.31.1

