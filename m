Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B83F32CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhHTSJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhHTSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629482903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+1ga8RnLPOJBGffNXOE61OYpVAHkveZy0tmtQr8ecM=;
        b=Rv2da68yqXs+4glNoMgBJZsckUK+nVj1FdUKfHhhaDGDPJrd7UHe+29W3nRatVw1WR8fpl
        KPuDw6ps3fftJvdKIWSML5QGtQ2PqsN4utKG5tkM0RrVcCAHL41UPxOp2CcTEJxDS/W0w5
        YOGxZ0G0bDq0jWMpB79WyaS1NY0YlQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ESqQje94Op2oXWUMBWaHEg-1; Fri, 20 Aug 2021 14:08:22 -0400
X-MC-Unique: ESqQje94Op2oXWUMBWaHEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C77760C0;
        Fri, 20 Aug 2021 18:08:20 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC3665D9D5;
        Fri, 20 Aug 2021 18:08:19 +0000 (UTC)
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
Subject: [RFC PATCH v2 1/4] drivers/mfd: sensehat: Raspberry Pi Sense HAT core driver
Date:   Fri, 20 Aug 2021 14:07:58 -0400
Message-Id: <20210820180801.561119-2-cmirabil@redhat.com>
In-Reply-To: <20210820180801.561119-1-cmirabil@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 drivers/mfd/Kconfig          |   8 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/sensehat-core.c  | 168 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/sensehat.h |  55 ++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 drivers/mfd/sensehat-core.c
 create mode 100644 include/linux/mfd/sensehat.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..569972f0738f 100644
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
index 8116c19d5fd4..d23262dc6a27 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_SENSEHAT_CORE) += sensehat-core.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/sensehat-core.c b/drivers/mfd/sensehat-core.c
new file mode 100644
index 000000000000..295b0abe2375
--- /dev/null
+++ b/drivers/mfd/sensehat-core.c
@@ -0,0 +1,168 @@
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
+
+#include <linux/mfd/sensehat.h>
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
+sensehat_client_dev_register(struct sensehat *sensehat, const char *name);
+
+static int sensehat_probe(struct i2c_client *i2c,
+			       const struct i2c_device_id *id)
+{
+	int ret;
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
+
+	ret = i2c_smbus_read_byte_data(sensehat->i2c_client, RPISENSE_WAI);
+	if (ret < 0) {
+		dev_err(sensehat->dev, "failed to read from device");
+		return ret;
+	}
+
+	if (ret != RPISENSE_ID) {
+		dev_err(sensehat->dev, "expected device ID %i, got %i",
+			RPISENSE_ID, ret);
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_read_byte_data(sensehat->i2c_client, RPISENSE_VER);
+	if (ret < 0)
+		return ret;
+
+	dev_info(sensehat->dev,
+		 "Raspberry Pi Sense HAT firmware version %i\n", ret);
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
+int sensehat_get_joystick_state(struct sensehat *sensehat)
+{
+	int ret = i2c_smbus_read_byte_data(sensehat->i2c_client, RPISENSE_KEYS);
+
+	return ret < 0 ? ret : ret & 0x1f;
+}
+EXPORT_SYMBOL_GPL(sensehat_get_joystick_state);
+
+int sensehat_update_display(struct sensehat *sensehat)
+{
+	int i, j, ret;
+	struct sensehat_display *display = &sensehat->display;
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
+	ret = i2c_master_send(sensehat->i2c_client, (u8 *)&msg, sizeof(msg));
+	if (ret < 0)
+		dev_err(sensehat->dev, "Update to 8x8 LED matrix display failed");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensehat_update_display);
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
index 000000000000..2701c3ff25bc
--- /dev/null
+++ b/include/linux/mfd/sensehat.h
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
+struct sensehat {
+	struct device *dev;
+	struct i2c_client *i2c_client;
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
+int sensehat_get_joystick_state(struct sensehat *sensehat);
+int sensehat_update_display(struct sensehat *sensehat);
+
+#endif
-- 
2.27.0

