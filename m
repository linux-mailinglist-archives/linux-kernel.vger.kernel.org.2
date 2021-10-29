Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11F444052B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJ2V5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhJ2V5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635544487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAtPdADOTwTTB0C5Tq56kybjiHg3X+3Mky2YtAM1qpo=;
        b=f3O3MjdOS7jJTMgwRKGcjnpMq9zmlmlqbaeoT91CmOGx3JHednalJn43U5RZ3iZ3j3g+69
        ZzJwzMkM7T6AxHDPaDxuJGOSYnLd/YMRoqC93t0D4H63oIOAWaNGm6uhPKxyICrrGz+JCX
        ARubc7PDH0t3u2K/9XilopLmyAPIWZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-j_qmrdqBMUyi_fA-3_Q8mA-1; Fri, 29 Oct 2021 17:54:43 -0400
X-MC-Unique: j_qmrdqBMUyi_fA-3_Q8mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A99E1006AA2;
        Fri, 29 Oct 2021 21:54:42 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85685DF56;
        Fri, 29 Oct 2021 21:54:39 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 3/5] drivers/auxdisplay: senshat: Raspberry Pi Sense HAT display driver
Date:   Fri, 29 Oct 2021 17:55:14 -0400
Message-Id: <20211029215516.801593-4-cmirabil@redhat.com>
In-Reply-To: <20211029215516.801593-1-cmirabil@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements control of the 8x8 RGB LED matrix display.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/auxdisplay/Kconfig            |   7 +
 drivers/auxdisplay/Makefile           |   1 +
 drivers/auxdisplay/sensehat-display.c | 258 ++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/auxdisplay/sensehat-display.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 1509cb74705a..24f5d68cfbff 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -193,6 +193,13 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
+config SENSEHAT_DISPLAY
+	tristate "Raspberry pi Sense HAT display driver"
+	select MFD_SENSEHAT_CORE
+	help
+	 This is a driver for the Raspberry Pi Sensehat 8x8 RBG-LED matrix
+	 you can access it as a misc device at /dev/sense-hat
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 307771027c89..7e9aa479586a 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_HD44780)		+= hd44780.o
 obj-$(CONFIG_HT16K33)		+= ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
 obj-$(CONFIG_LCD2S)		+= lcd2s.o
+obj-$(CONFIG_SENSEHAT_DISPLAY)	+= sensehat-display.o
diff --git a/drivers/auxdisplay/sensehat-display.c b/drivers/auxdisplay/sensehat-display.c
new file mode 100644
index 000000000000..5980ad23fd4f
--- /dev/null
+++ b/drivers/auxdisplay/sensehat-display.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT 8x8 LED matrix display driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "sensehat.h"
+
+#define GAMMA_SIZE sizeof_field(struct sensehat_display, gamma)
+#define VMEM_SIZE sizeof_field(struct sensehat_display, vmem)
+
+static int sensehat_update_display(struct sensehat *sensehat);
+
+static bool lowlight;
+module_param(lowlight, bool, 0);
+MODULE_PARM_DESC(lowlight, "Reduce LED matrix brightness to one third");
+
+static const u8 gamma_presets[][GAMMA_SIZE] = {
+	[GAMMA_DEFAULT] = {
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01,
+		0x02, 0x02, 0x03, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0E, 0x0F, 0x11,
+		0x12, 0x14, 0x15, 0x17, 0x19, 0x1B, 0x1D, 0x1F,
+	},
+	[GAMMA_LOWLIGHT] = {
+		0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+		0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02,
+		0x03, 0x03, 0x03, 0x04, 0x04, 0x05, 0x05, 0x06,
+		0x06, 0x07, 0x07, 0x08, 0x08, 0x09, 0x0A, 0x0A,
+	},
+};
+
+static const struct file_operations sensehat_display_fops;
+
+static int sensehat_display_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	struct sensehat *sensehat = dev_get_drvdata(&pdev->dev);
+	struct sensehat_display *sensehat_display = &sensehat->display;
+
+	memcpy(sensehat_display->gamma, gamma_presets[lowlight], GAMMA_SIZE);
+
+	memset(sensehat_display->vmem, 0, VMEM_SIZE);
+
+	mutex_init(&sensehat_display->rw_mtx);
+
+	sensehat_display->mdev = (struct miscdevice) {
+		.minor	= MISC_DYNAMIC_MINOR,
+		.name	= "sense-hat",
+		.mode	= 0666,
+		.fops	= &sensehat_display_fops,
+	};
+
+	ret = misc_register(&sensehat_display->mdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register 8x8 LED matrix display.\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "8x8 LED matrix display registered with minor number %i",
+		sensehat_display->mdev.minor);
+
+	sensehat_update_display(sensehat);
+	return 0;
+}
+
+static int sensehat_display_remove(struct platform_device *pdev)
+{
+	struct sensehat *sensehat = dev_get_drvdata(&pdev->dev);
+	struct sensehat_display *sensehat_display = &sensehat->display;
+
+	misc_deregister(&sensehat_display->mdev);
+	return 0;
+}
+
+static loff_t sensehat_display_llseek(struct file *filp, loff_t pos, int whence)
+{
+	loff_t base;
+
+	switch (whence) {
+	case SEEK_SET:
+		base = 0;
+		break;
+	case SEEK_CUR:
+		base = filp->f_pos;
+		break;
+	case SEEK_END:
+		base = VMEM_SIZE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	base += pos;
+	if (base < 0 || base >= VMEM_SIZE)
+		return -EINVAL;
+	filp->f_pos = base;
+	return base;
+}
+
+static ssize_t
+sensehat_display_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
+	struct sensehat_display *sensehat_display = &sensehat->display;
+	ssize_t retval = -EFAULT;
+
+	if (*f_pos >= VMEM_SIZE)
+		return 0;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_to_user(buf, sensehat_display->vmem + *f_pos, count))
+		goto out;
+	*f_pos += count;
+	retval = count;
+out:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return retval;
+}
+
+static ssize_t
+sensehat_display_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
+	struct sensehat_display *sensehat_display = &sensehat->display;
+	u8 temp[VMEM_SIZE];
+
+	if (*f_pos >= VMEM_SIZE)
+		return -EFBIG;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (copy_from_user(temp, buf, count))
+		return -EFAULT;
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	memcpy(sensehat_display->vmem + *f_pos, temp, count);
+	sensehat_update_display(sensehat);
+	*f_pos += count;
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return count;
+}
+
+static long sensehat_display_ioctl(struct file *filp, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
+	struct sensehat_display *sensehat_display = &sensehat->display;
+	void __user *user_ptr = (void __user *)arg;
+	u8 temp[GAMMA_SIZE];
+	int ret;
+
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	switch (cmd) {
+	case SENSEDISP_IOGET_GAMMA:
+		if (copy_to_user(user_ptr, sensehat_display->gamma, GAMMA_SIZE)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		ret = 0;
+		goto out_unlock;
+	case SENSEDISP_IOSET_GAMMA:
+		if (copy_from_user(temp, user_ptr, GAMMA_SIZE)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		ret = 0;
+		goto out_update;
+	case SENSEDISP_IORESET_GAMMA:
+		if (arg < GAMMA_DEFAULT || arg >= GAMMA_PRESET_COUNT) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		memcpy(temp, gamma_presets[arg], GAMMA_SIZE);
+		ret = 0;
+		goto out_update;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+out_update:
+	memcpy(sensehat_display->gamma, temp, GAMMA_SIZE);
+	sensehat_update_display(sensehat);
+out_unlock:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return ret;
+}
+
+int sensehat_update_display(struct sensehat *sensehat)
+{
+	int i, j, ret;
+	struct sensehat_display *display = &sensehat->display;
+	sensehat_fb_t pixel_data;
+
+	for (i = 0; i < 8; ++i) {
+		for (j = 0; j < 8; ++j) {
+			pixel_data[i][0][j] = display->gamma[display->vmem[i][j].r];
+			pixel_data[i][1][j] = display->gamma[display->vmem[i][j].g];
+			pixel_data[i][2][j] = display->gamma[display->vmem[i][j].b];
+		}
+	}
+
+	ret = regmap_bulk_write(sensehat->regmap, SENSEHAT_DISPLAY,
+				pixel_data, sizeof(pixel_data));
+	if (ret < 0)
+		dev_err(sensehat->dev, "Update to 8x8 LED matrix display failed");
+	return ret;
+}
+
+static const struct file_operations sensehat_display_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= sensehat_display_llseek,
+	.read		= sensehat_display_read,
+	.write		= sensehat_display_write,
+	.unlocked_ioctl	= sensehat_display_ioctl,
+};
+
+static struct platform_device_id sensehat_display_device_id[] = {
+	{ .name = "sensehat-display" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sensehat_display_device_id);
+
+static struct platform_driver sensehat_display_driver = {
+	.probe = sensehat_display_probe,
+	.remove = sensehat_display_remove,
+	.driver = {
+		.name = "sensehat-display",
+	},
+};
+
+module_platform_driver(sensehat_display_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT 8x8 LED matrix display driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

