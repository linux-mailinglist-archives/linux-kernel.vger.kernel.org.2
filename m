Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67F3E3250
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhHGA2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhHGA2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628296076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn1hyRJM8BURrd6NXAk48E748YVbCwToMWhQgVC9nvY=;
        b=MsQlFqPjEiUEFA4WwaFjeOEP0nJs/kAZC8IVfKoU0bIVP+QylXbcAtPN/DxQxUBtlM/Bl0
        Z/qiOJeFjgbq6jBKYIxEDRLsdGwH73iHNxSpw0mVNwfSsBjvwJ+IxODKP3TbZ6RgToquLz
        GJApo3TqJAUN9ZvSgMmv2q4wvHMlBLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-2JzGYSByMrma0DISvdHSOg-1; Fri, 06 Aug 2021 20:27:55 -0400
X-MC-Unique: 2JzGYSByMrma0DISvdHSOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0101B593A8;
        Sat,  7 Aug 2021 00:27:54 +0000 (UTC)
Received: from jsavitz.bos.com (unknown [10.22.8.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 311E969FAD;
        Sat,  7 Aug 2021 00:27:53 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
Subject: [RFC PATCH 2/3] drivers/mfd: rpisense: Raspberry Pi senseHAT joystick driver
Date:   Fri,  6 Aug 2021 20:27:21 -0400
Message-Id: <20210807002722.2634585-3-jsavitz@redhat.com>
In-Reply-To: <20210807002722.2634585-1-jsavitz@redhat.com>
References: <20210807002722.2634585-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements support for the joystick, including a threaded
IRQ routine.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/rpisense-js.c | 132 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 drivers/mfd/rpisense-js.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 76f9a9221241..71356153ccdc 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_MFD_RPISENSE) 	+= rpisense-core.o
+obj-$(CONFIG_MFD_RPISENSE)	+= rpisense-js.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/rpisense-js.c b/drivers/mfd/rpisense-js.c
new file mode 100644
index 000000000000..c6c97bff118c
--- /dev/null
+++ b/drivers/mfd/rpisense-js.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT joystick driver
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
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/rpisense.h>
+
+static unsigned char keymap[] = {KEY_DOWN, KEY_RIGHT, KEY_UP, KEY_ENTER, KEY_LEFT,};
+
+static irqreturn_t rpisense_js_report(int n, void *cookie)
+{
+	int i;
+	static s32 prev_keys;
+	struct rpisense *rpisense = cookie;
+	struct rpisense_js *rpisense_js = &rpisense->joystick;
+	s32 keys = rpisense_get_joystick_state(rpisense);
+	s32 changes = keys ^ prev_keys;
+
+	prev_keys = keys;
+	for (i = 0; i < ARRAY_SIZE(keymap); ++i) {
+		if (changes & (1<<i)) {
+			input_report_key(rpisense_js->keys_dev,
+					 keymap[i], keys & (1<<i));
+		}
+	}
+	input_sync(rpisense_js->keys_dev);
+	return IRQ_HANDLED;
+}
+
+static int rpisense_js_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct rpisense *rpisense = dev_get_drvdata(&pdev->dev);
+	struct rpisense_js *rpisense_js = &rpisense->joystick;
+
+	rpisense_js->keys_desc = devm_gpiod_get(&rpisense->i2c_client->dev,
+						"keys-int", GPIOD_IN);
+	if (IS_ERR(rpisense_js->keys_desc)) {
+		dev_warn(&pdev->dev, "Failed to get keys-int descriptor.\n");
+		return PTR_ERR(rpisense_js->keys_desc);
+	}
+
+
+	rpisense_js->keys_dev = devm_input_allocate_device(&pdev->dev);
+	if (rpisense_js->keys_dev == NULL) {
+		dev_err(&pdev->dev, "Could not allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keymap); i++) {
+		set_bit(keymap[i],
+			rpisense_js->keys_dev->keybit);
+	}
+
+	rpisense_js->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
+	rpisense_js->keys_dev->phys = "rpi-sense-joy/input0";
+	rpisense_js->keys_dev->id.bustype = BUS_I2C;
+	rpisense_js->keys_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	rpisense_js->keys_dev->keycode = keymap;
+	rpisense_js->keys_dev->keycodesize = sizeof(unsigned char);
+	rpisense_js->keys_dev->keycodemax = ARRAY_SIZE(keymap);
+
+	ret = input_register_device(rpisense_js->keys_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register input device.\n");
+		return ret;
+	}
+
+	ret = gpiod_direction_input(rpisense_js->keys_desc);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not set keys-int direction.\n");
+		return ret;
+	}
+
+	rpisense_js->keys_irq = gpiod_to_irq(rpisense_js->keys_desc);
+	if (rpisense_js->keys_irq < 0) {
+		dev_err(&pdev->dev, "Could not determine keys-int IRQ.\n");
+		return rpisense_js->keys_irq;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, rpisense_js->keys_irq,
+		NULL, rpisense_js_report, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+		"keys", rpisense);
+
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ request failed.\n");
+		return ret;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id rpisense_js_id[] = {
+	{ .compatible = "rpi,rpi-sense-js" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rpisense_js_id);
+#endif
+
+static struct platform_device_id rpisense_js_device_id[] = {
+	{ .name = "rpi-sense-js" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, rpisense_js_device_id);
+
+static struct platform_driver rpisense_js_driver = {
+	.probe = rpisense_js_probe,
+	.driver = {
+		.name = "rpi-sense-js",
+	},
+};
+
+module_platform_driver(rpisense_js_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.27.0

