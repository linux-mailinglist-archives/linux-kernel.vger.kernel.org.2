Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA13E3252
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhHGA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhHGA2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628296083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9K7aJtrIO9zZpqSbpBJnMpCH0dOxJgsY9S8re4/WLQ=;
        b=hYCm1p5ZJC3OScY06aDCUq08Amq9U4fYgXMWWR1ve6PbpNmOMAwoCV7YJPI74HAEnMmrEA
        4z4VR1J66txzM7LclwrdxmSfKYod8z4CEvY4u4siv2/ZOA6dO4cq2t/iBNVZJQ3UD4Zhz9
        jeBaosxU1120umPO3MW3WAnHZJdbmbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-zOZvbhQfPnq9sM7xjKR6Xw-1; Fri, 06 Aug 2021 20:27:59 -0400
X-MC-Unique: zOZvbhQfPnq9sM7xjKR6Xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82E971853028;
        Sat,  7 Aug 2021 00:27:58 +0000 (UTC)
Received: from jsavitz.bos.com (unknown [10.22.8.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B403319811;
        Sat,  7 Aug 2021 00:27:57 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
Subject: [RFC PATCH 3/3] drivers/mfd: rpisense: Raspberry Pi senseHAT 8x8 LED matrix display driver
Date:   Fri,  6 Aug 2021 20:27:22 -0400
Message-Id: <20210807002722.2634585-4-jsavitz@redhat.com>
In-Reply-To: <20210807002722.2634585-1-jsavitz@redhat.com>
References: <20210807002722.2634585-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements control of the 8x8 RGB LED matrix display.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/mfd/Makefile           |   1 +
 drivers/mfd/rpisense-display.c | 242 +++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 drivers/mfd/rpisense-display.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 71356153ccdc..974518d9801b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_MFD_RPISENSE) 	+= rpisense-core.o
 obj-$(CONFIG_MFD_RPISENSE)	+= rpisense-js.o
+obj-$(CONFIG_MFD_RPISENSE)	+= rpisense-display.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/rpisense-display.c b/drivers/mfd/rpisense-display.c
new file mode 100644
index 000000000000..10a34fa0eece
--- /dev/null
+++ b/drivers/mfd/rpisense-display.c
@@ -0,0 +1,242 @@
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
+
+#include <linux/mfd/rpisense.h>
+
+#define GAMMA_SIZE sizeof_field(struct rpisense_display, gamma)
+#define VMEM_SIZE sizeof_field(struct rpisense_display, vmem)
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
+static const struct file_operations rpisense_display_fops;
+
+static int rpisense_display_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	struct rpisense *rpisense = dev_get_drvdata(&pdev->dev);
+	struct rpisense_display *rpisense_display = &rpisense->display;
+
+	memcpy(rpisense_display->gamma, gamma_presets[lowlight], GAMMA_SIZE);
+
+	memset(rpisense_display->vmem, 0, VMEM_SIZE);
+
+	mutex_init(&rpisense_display->rw_mtx);
+
+	rpisense_display->mdev = (struct miscdevice) {
+		.minor	= MISC_DYNAMIC_MINOR,
+		.name	= "sense-hat",
+		.mode	= 0666,
+		.fops	= &rpisense_display_fops,
+	};
+
+	ret = misc_register(&rpisense_display->mdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register 8x8 LED matrix display.\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "8x8 LED matrix display registered with minor number %i",
+		rpisense_display->mdev.minor);
+
+	rpisense_update_display(rpisense);
+	return 0;
+}
+
+static int rpisense_display_remove(struct platform_device *pdev)
+{
+	struct rpisense *rpisense = dev_get_drvdata(&pdev->dev);
+	struct rpisense_display *rpisense_display = &rpisense->display;
+
+	misc_deregister(&rpisense_display->mdev);
+	return 0;
+}
+
+static loff_t rpisense_display_llseek(struct file *filp, loff_t pos, int whence)
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
+rpisense_display_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct rpisense *rpisense = container_of(filp->private_data, struct rpisense, display.mdev);
+	struct rpisense_display *rpisense_display = &rpisense->display;
+	ssize_t retval = -EFAULT;
+
+	if (*f_pos >= VMEM_SIZE)
+		return 0;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (mutex_lock_interruptible(&rpisense_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_to_user(buf, rpisense_display->vmem + *f_pos, count))
+		goto out;
+	*f_pos += count;
+	retval = count;
+out:
+	mutex_unlock(&rpisense_display->rw_mtx);
+	return retval;
+}
+
+static ssize_t
+rpisense_display_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct rpisense *rpisense = container_of(filp->private_data, struct rpisense, display.mdev);
+	struct rpisense_display *rpisense_display = &rpisense->display;
+	u8 temp[VMEM_SIZE];
+
+	if (*f_pos >= VMEM_SIZE)
+		return -EFBIG;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (copy_from_user(temp, buf, count))
+		return -EFAULT;
+	if (mutex_lock_interruptible(&rpisense_display->rw_mtx))
+		return -ERESTARTSYS;
+	memcpy(rpisense_display->vmem + *f_pos, temp, count);
+	rpisense_update_display(rpisense);
+	*f_pos += count;
+	mutex_unlock(&rpisense_display->rw_mtx);
+	return count;
+}
+
+static long rpisense_display_ioctl(struct file *filp, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct rpisense *rpisense = container_of(filp->private_data, struct rpisense, display.mdev);
+	struct rpisense_display *rpisense_display = &rpisense->display;
+	void __user *user_ptr = (void __user *)arg;
+	u8 temp[GAMMA_SIZE];
+	int ret;
+
+	if (mutex_lock_interruptible(&rpisense_display->rw_mtx))
+		return -ERESTARTSYS;
+	switch (cmd) {
+	case SENSEDISP_IOGET_GAMMA:
+		if (copy_to_user(user_ptr, rpisense_display->gamma, GAMMA_SIZE)) {
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
+	memcpy(rpisense_display->gamma, temp, GAMMA_SIZE);
+	rpisense_update_display(rpisense);
+out_unlock:
+	mutex_unlock(&rpisense_display->rw_mtx);
+	return ret;
+}
+
+static const struct file_operations rpisense_display_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= rpisense_display_llseek,
+	.read		= rpisense_display_read,
+	.write		= rpisense_display_write,
+	.unlocked_ioctl	= rpisense_display_ioctl,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id rpisense_display_id[] = {
+	{ .compatible = "rpi,rpi-sense-fb" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rpisense_display_id);
+#endif
+
+static struct platform_device_id rpisense_display_device_id[] = {
+	{ .name = "rpi-sense-fb" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, rpisense_display_device_id);
+
+static struct platform_driver rpisense_display_driver = {
+	.probe = rpisense_display_probe,
+	.remove = rpisense_display_remove,
+	.driver = {
+		.name = "rpi-sense-fb",
+	},
+};
+
+module_platform_driver(rpisense_display_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT 8x8 LED matrix display driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
+
-- 
2.27.0

