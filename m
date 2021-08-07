Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24BE3E3251
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhHGA2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhHGA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628296078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxTdbfP18mZ+72k7qOK7K5cmpLWIlVSm0Jiwe3SqOfs=;
        b=Gao+LDgXSk5EgkM+CYpKAdZOiU3upcRUjr7nrT+jt9XleVM/Tk3XqZZR8hR+aMoSYL3KrS
        qk2vOloTiy7rK0zdIPpOJ8ZzW/z3aOo5hZayhR+Oni2v5JrEVaysDxpQPaqZqs9GtIiSJw
        3kXKxzPoxN4O9VLSGc3iDsFwk7gvPh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-RA8it8U4PpGh98hUTxmVKg-1; Fri, 06 Aug 2021 20:27:51 -0400
X-MC-Unique: RA8it8U4PpGh98hUTxmVKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CE5107ACF5;
        Sat,  7 Aug 2021 00:27:50 +0000 (UTC)
Received: from jsavitz.bos.com (unknown [10.22.8.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E741519C87;
        Sat,  7 Aug 2021 00:27:49 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
Subject: [RFC PATCH 1/3] drivers/mfd: rpisense: Raspberry Pi senseHAT core driver
Date:   Fri,  6 Aug 2021 20:27:20 -0400
Message-Id: <20210807002722.2634585-2-jsavitz@redhat.com>
In-Reply-To: <20210807002722.2634585-1-jsavitz@redhat.com>
References: <20210807002722.2634585-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core driver file, containing methods to communicate
with the board over I2C. We also add the header file shared by all
three drivers, containing common data and definitions. In addition, we
add a config option to toggle compilation of the driver.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/mfd/Kconfig          |  10 +++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/rpisense-core.c  | 170 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/rpisense.h |  55 ++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 drivers/mfd/rpisense-core.c
 create mode 100644 include/linux/mfd/rpisense.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..614de080dee6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -11,6 +11,16 @@ config MFD_CORE
 	select IRQ_DOMAIN
 	default n
 
+config MFD_RPISENSE
+	tristate "Raspberry Pi Sense HAT driver"
+	depends on I2C && GPIOLIB
+	select MFD_CORE
+	help
+	  This is the driver for the Raspberry Pi Sense HAT. This provides
+	  the necessary functions to communicate with the hardware as well
+	  as a joystick and display interface. Linux communicates with the
+	  hardwire using the GPIO pins via the I2C protocol.
+
 config MFD_CS5535
 	tristate "AMD CS5535 and CS5536 southbridge core functions"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8116c19d5fd4..76f9a9221241 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_RPISENSE) 	+= rpisense-core.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/rpisense-core.c b/drivers/mfd/rpisense-core.c
new file mode 100644
index 000000000000..69e3051a4be0
--- /dev/null
+++ b/drivers/mfd/rpisense-core.c
@@ -0,0 +1,170 @@
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
+#include <linux/mfd/rpisense.h>
+
+#define RPISENSE_DISPLAY		0x00
+#define RPISENSE_WAI			0xF0
+#define RPISENSE_VER			0xF1
+#define RPISENSE_KEYS			0xF2
+#define RPISENSE_EE_WP			0xF3
+
+#define RPISENSE_ID			's'
+
+static struct platform_device *
+rpisense_client_dev_register(struct rpisense *rpisense, const char *name);
+
+static int rpisense_probe(struct i2c_client *i2c,
+			       const struct i2c_device_id *id)
+{
+	int ret;
+
+	struct rpisense *rpisense = devm_kzalloc(&i2c->dev, sizeof(*rpisense), GFP_KERNEL);
+
+	if (rpisense == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rpisense);
+	rpisense->dev = &i2c->dev;
+	rpisense->i2c_client = i2c;
+
+
+	ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_WAI);
+	if (ret < 0)
+		return ret;
+
+	if (ret != RPISENSE_ID)
+		return -EINVAL;
+
+	ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_VER);
+	if (ret < 0)
+		return ret;
+
+	dev_info(rpisense->dev,
+		 "Raspberry Pi Sense HAT firmware version %i\n", ret);
+
+	rpisense->joystick.pdev = rpisense_client_dev_register(rpisense,
+							       "rpi-sense-js");
+
+	if (IS_ERR(rpisense->joystick.pdev)) {
+		dev_err(rpisense->dev, "failed to register rpisense-js");
+		return PTR_ERR(rpisense->joystick.pdev);
+	}
+
+	rpisense->display.pdev = rpisense_client_dev_register(rpisense,
+								  "rpi-sense-fb");
+
+	if (IS_ERR(rpisense->display.pdev)) {
+		dev_err(rpisense->dev, "failed to register rpisense-fb");
+		return PTR_ERR(rpisense->display.pdev);
+	}
+
+	return 0;
+}
+
+static struct platform_device *
+rpisense_client_dev_register(struct rpisense *rpisense, const char *name)
+{
+	long ret = -ENOMEM;
+	struct platform_device *pdev = platform_device_alloc(name, -1);
+
+	if (pdev == NULL)
+		goto alloc_fail;
+
+	pdev->dev.parent = rpisense->dev;
+	platform_set_drvdata(pdev, rpisense);
+
+	ret = platform_device_add(pdev);
+	if (ret != 0)
+		goto add_fail;
+
+	ret = devm_add_action_or_reset(rpisense->dev,
+		(void *)platform_device_unregister, pdev);
+	if (ret != 0)
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
+int rpisense_get_joystick_state(struct rpisense *rpisense)
+{
+	int ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_KEYS);
+
+	return ret < 0 ? ret : ret & 0x1f;
+}
+EXPORT_SYMBOL_GPL(rpisense_get_joystick_state);
+
+int rpisense_update_display(struct rpisense *rpisense)
+{
+	int i, j, ret;
+	struct rpisense_display *display = &rpisense->display;
+	struct {u8 reg, pixel_data[8][3][8]; } msg;
+
+	msg.reg = RPISENSE_DISPLAY;
+	for (i = 0; i < 8; ++i) {
+		for (j = 0; j < 8; ++j) {
+			msg.pixel_data[i][0][j] = display->gamma[display->vmem[i][j].r];
+			msg.pixel_data[i][1][j] = display->gamma[display->vmem[i][j].g];
+			msg.pixel_data[i][2][j] = display->gamma[display->vmem[i][j].b];
+		}
+	}
+
+	ret = i2c_master_send(rpisense->i2c_client, (u8 *)&msg, sizeof(msg));
+	if (ret < 0)
+		dev_err(rpisense->dev, "Update to 8x8 LED matrix display failed");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rpisense_update_display);
+
+static const struct i2c_device_id rpisense_i2c_id[] = {
+	{ "rpi-sense", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rpisense_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id rpisense_core_id[] = {
+	{ .compatible = "rpi,rpi-sense" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rpisense_core_id);
+#endif
+
+
+static struct i2c_driver rpisense_driver = {
+	.driver = {
+		   .name = "rpi-sense",
+	},
+	.probe = rpisense_probe,
+	.id_table = rpisense_i2c_id,
+};
+
+module_i2c_driver(rpisense_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT core driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rpisense.h b/include/linux/mfd/rpisense.h
new file mode 100644
index 000000000000..c2690ab9f820
--- /dev/null
+++ b/include/linux/mfd/rpisense.h
@@ -0,0 +1,55 @@
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
+#ifndef __LINUX_MFD_RPISENSE_H_
+#define __LINUX_MFD_RPISENSE_H_
+#include <linux/miscdevice.h>
+
+#define SENSEDISP_IOC_MAGIC 0xF1
+
+#define SENSEDISP_IOGET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 0)
+#define SENSEDISP_IOSET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 1)
+#define SENSEDISP_IORESET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 2)
+
+struct rpisense {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+
+	/* Client devices */
+	struct rpisense_js {
+		struct platform_device *pdev;
+		struct input_dev *keys_dev;
+		struct gpio_desc *keys_desc;
+		int keys_irq;
+	} joystick;
+
+	struct rpisense_display {
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
+int rpisense_get_joystick_state(struct rpisense *rpisense);
+int rpisense_update_display(struct rpisense *rpisense);
+
+#endif
-- 
2.27.0

