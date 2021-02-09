Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA20314D95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBIKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhBIKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:48:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F35C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:48:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so22836413edi.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7zgHA0yWG/zOGIQXOsMzCh7zWsu/9Pw2PZf498lKCU=;
        b=ZO6cmxiGQwUsYyuV+tGsUpkOXsuXQbzgeqV6DS8ojlPQEB6SPdcOTWKZEwG9h0vMKx
         //ycz1QHRqKAVOQz+s8vuRcgnwe+oTElxSl95XKRyFMbhUcSwnQLRksWFQgpETYQKnyq
         RFHkIhKZ3UTmTy0jqPWMFJ6XAA1Zq1uGUKSuNAZJmCXnj8QygIueeDG9tult4GjMHjyl
         w1gDvmhzp4LmLD0Syjdd1e5XGkB4dkMSyLmYGhZ4VYgL9NVVE17NVeOBbT4Qi1n7vhK8
         JfjtDzqkTnbMzvKDL1jx4CXnpnA+n9xOnP0huI2tlWNA8hgXTi8GW3yErHkCSeIUYTWb
         G7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t7zgHA0yWG/zOGIQXOsMzCh7zWsu/9Pw2PZf498lKCU=;
        b=LfcIy6RfFjR0jrPp9FJfh2uA7ltAcnnmxdpapRj8S4Ng2Yt07hi4i+U3o4CYDQZj5/
         hkMqvGfk0DGJp8UJVE8p5AzKLUgm7pv7cJdtEY4ap81JXV5zBeEAiJzTlf0Zfq8KcsOh
         rgH8OHru5BbBfXaE0gUoPtlJINNpUnxTkrs/relX7dAcnRt4BpVso2O5nlpfrckoXRuB
         iUOyhb+aXCmNqPu9gk3fRJmsyda5FChyTJk0Rv8M+vK1FXuVEyYZrdt9w0Iajt1AX1jR
         5vS+3KXAAK1uo/xgrbMq3NUrevjki81HI9eNQ82t2zCg1EzDPR6X+KoPH01LCVXBUlJk
         N2HQ==
X-Gm-Message-State: AOAM532QY/uPg1QLuxvu9xJq1NXCrbgPSA+7e4l73Fd4J+YB2QwpTOv8
        QwiddB4ieRgHRulSTxs6MHeCuZlnW/KnEg==
X-Google-Smtp-Source: ABdhPJylIwDSHVfFo7SvceeTerSpNKHQyMZ8dMDgMnoTJRG2/bupOzgwtk54nFPXRze2lmIQH7Ey2g==
X-Received: by 2002:a05:6402:b8c:: with SMTP id cf12mr21850207edb.320.1612867694348;
        Tue, 09 Feb 2021 02:48:14 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d3sm3677300edk.82.2021.02.09.02.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 02:48:14 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Piyush Mehta <piyush.mehta@xilinx.com>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] usb: misc: usb5744: Add support for USB hub controller
Date:   Tue,  9 Feb 2021 11:48:10 +0100
Message-Id: <d6accf76bb5d060a13067816f23008e93264f317.1612867682.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1612867682.git.michal.simek@xilinx.com>
References: <cover.1612867682.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

This patch adds a USB GPIO based hub reset for USB5744 hub. This usb5744
driver trigger hub reset signal after soft reset or core Reset. The HUB
needs to be resetted after completion of phy initialization. After the
toggling of gpio, hub configure using i2c usb attached command.

USB5744 hub can be used without any I2C connection, is handled by a
simple platform device driver.

As part of the reset, sets the direction of the pin to output before
toggling the pin. Delay of millisecond is added in between low and
high to meet the setup and hold time requirement of the reset.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- s/USB_USB5744/USB_HUB_USB5744/g
- Fix order in Makefile and Kconfig

 MAINTAINERS                |   1 +
 drivers/usb/misc/Kconfig   |   9 +++
 drivers/usb/misc/Makefile  |   1 +
 drivers/usb/misc/usb5744.c | 115 +++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 drivers/usb/misc/usb5744.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7439471b5d37..56d1fcdd24f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2706,6 +2706,7 @@ F:	drivers/edac/synopsys_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
+F:	drivers/usb/misc/usb5744.c
 N:	zynq
 N:	xilinx
 
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f1144359012..9995a5701fd9 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -255,6 +255,15 @@ config USB_HSIC_USB4604
 	help
 	  This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
 
+config USB_HUB_USB5744
+	tristate "Microchip USB5744 Hub driver"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  This option enables support for Microchip USB5744 Hub. This driver
+	  optionally reset the hub using gpio pin and configure hub via i2c if
+	  connected.
+
 config USB_LINK_LAYER_TEST
 	tristate "USB Link Layer Test driver"
 	help
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598573ab..fbb9adf08f8c 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_USB_YUREX)			+= yurex.o
 obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
+obj-$(CONFIG_USB_HUB_USB5744)		+= usb5744.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
diff --git a/drivers/usb/misc/usb5744.c b/drivers/usb/misc/usb5744.c
new file mode 100644
index 000000000000..729b76345c69
--- /dev/null
+++ b/drivers/usb/misc/usb5744.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip USB5744 4-port hub.
+ *
+ * Copyright (c) 2021 Xilinx, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+
+static int usb5744_init_hw(struct device *dev)
+{
+	struct gpio_desc *reset_gpio;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(dev, "Failed to bind reset gpio");
+		return -ENODEV;
+	}
+
+	if (reset_gpio) {
+		/* Toggle RESET_N to reset the hub. */
+		gpiod_set_value(reset_gpio, 0);
+		usleep_range(5, 20); /* trstia */
+		gpiod_set_value(reset_gpio, 1);
+		usleep_range(5000, 10000); /* tcsh */
+	}
+
+	return 0;
+}
+
+static int usb5744_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	/* Trigger gpio reset to the hub. */
+	ret = usb5744_init_hw(dev);
+	if (ret)
+		return ret;
+
+	/* Send SMBus command to boot hub. */
+	ret = i2c_smbus_write_word_data(client, 0xAA, swab16(0x5600));
+	if (ret < 0)
+		dev_err(dev, "Sending boot command failed");
+
+	return ret;
+}
+
+static int usb5744_platform_probe(struct platform_device *pdev)
+{
+	/* Trigger gpio reset to the hub. */
+	return usb5744_init_hw(&pdev->dev);
+}
+
+static const struct i2c_device_id usb5744_id[] = {
+	{ "usb5744", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, usb5744_id);
+
+static struct i2c_driver usb5744_i2c_driver = {
+	.driver = {
+		.name = "usb5744",
+	},
+	.probe = usb5744_i2c_probe,
+	.id_table = usb5744_id,
+};
+
+static const struct of_device_id usb5744_platform_id[] = {
+	{ .compatible = "microchip,usb5744", },
+	{ }
+};
+
+static struct platform_driver usb5744_platform_driver = {
+	.driver = {
+		.name = "microchip,usb5744",
+		.of_match_table = usb5744_platform_id,
+	},
+	.probe = usb5744_platform_probe,
+};
+
+static int __init usb5744_init(void)
+{
+	int err;
+
+	err = i2c_add_driver(&usb5744_i2c_driver);
+	if (err != 0)
+		pr_err("usb5744: Failed to register I2C driver: %d\n", err);
+
+	err = platform_driver_register(&usb5744_platform_driver);
+	if (err != 0)
+		pr_err("usb5744: Failed to register platform driver: %d\n",
+		       err);
+	return 0;
+}
+module_init(usb5744_init);
+
+static void __exit usb5744_exit(void)
+{
+	platform_driver_unregister(&usb5744_platform_driver);
+	i2c_del_driver(&usb5744_i2c_driver);
+}
+module_exit(usb5744_exit);
+
+MODULE_AUTHOR("Piyush Mehta <piyush.mehta@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
+MODULE_DESCRIPTION("USB5744 Hub");
+MODULE_LICENSE("GPL v2");
-- 
2.30.0

