Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E75314C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhBIJ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhBIJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:54:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CCC061225
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:53:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y9so30199267ejp.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6McvaymhglpJsw5cFqu8G0AvV7wzVMGX2JtuLfyQvE=;
        b=QWCLLvI+tNV6X5F6ZqgMQRyLnZdhzEPovZRp83/KNkzxUZ9/ITTEBJxAuhlkVQ0CPb
         BVUsI9fsUjGmDdn7K2v9fDj20axZ+Y6iHLD4eMD5BTKkbSKQKFCTqvL8ErLuMGo0xvf0
         +smK57GbogO7H3Byokw5zuL0DNW7r9Umajzd+RKjC1vYVL4pWRB/S+zazPp4z/GFveBc
         z4OW5OepIvQ4Gu7T/CmnEBqtu+SLJBHbMLNDZbGM93gIYNgGz58oYdBsIxR64D0DfpUU
         E9S5ez1u7hFF/jg8y6T2stSplrHuL6bRvEwp9TLKrKLjrecBXayaOrGEXeoqGXPpA6O4
         PJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l6McvaymhglpJsw5cFqu8G0AvV7wzVMGX2JtuLfyQvE=;
        b=a6s5BJ/joMqab0bZoRbTNwZcYJ4x1GqUU1pYql+jEQJ75FcKWNMLlWF8MJh3VM5xxd
         Kt3GjIXeiynYTdnBvMNX1lI/YdyGrJ8BNEctx1Glq4DigZcnQ7ruraGSPaQKQ0P5oByM
         QFvNeHumyVitRJe9aWDO0142il7UY2le0II0toUXPGRREe56g/PUBnAmxBD29GUVgsW+
         XHLEDoJCgr3NkID+PPxSvU25qYZUVZ4MnAWcu5lrtd/AhODHOQ3HM4BLly295xro6TuC
         hzqIeFE6jM1f6GsdXFTuW0+0eRO7kxf/XaL+sCMeG3uNCRcOPj94AVn0Ix2G+V2ViIEq
         KxHg==
X-Gm-Message-State: AOAM532Ag37Kk2a4G8qeho+95xcn1VxHw3rqEfLIXTcz62pPfvwLw83K
        W82+lWBiWUFhFttBrDF4shsZaNzytGUY0A==
X-Google-Smtp-Source: ABdhPJxiRvcNejewspSY8w7zq0dyXQJIDHDWET7hs+GP+g66T0jmvNHtYJeUVaqC8kV6+sTAr20kXw==
X-Received: by 2002:a17:906:80b:: with SMTP id e11mr21316977ejd.269.1612864408059;
        Tue, 09 Feb 2021 01:53:28 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a1sm8308589edj.6.2021.02.09.01.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 01:53:27 -0800 (PST)
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
Subject: [PATCH 2/2] usb: misc: usb5744: Add support for USB hub controller
Date:   Tue,  9 Feb 2021 10:53:20 +0100
Message-Id: <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1612864393.git.michal.simek@xilinx.com>
References: <cover.1612864393.git.michal.simek@xilinx.com>
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
index 8f1144359012..30335b5c4f88 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -242,6 +242,15 @@ config USB_HUB_USB251XB
 	  parameters may be set in devicetree or platform data.
 	  Say Y or M here if you need to configure such a device via SMBus.
 
+config USB_USB5744
+	tristate "Microchip USB5744 Hub driver"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  This option enables support for Microchip USB5744 Hub. This driver
+	  optionally reset the hub using gpio pin and configure hub via i2c if
+	  connected.
+
 config USB_HSIC_USB3503
 	tristate "USB3503 HSIC to USB20 Driver"
 	depends on I2C
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598573ab..5920146a506a 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_USB_USS720)		+= uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+= yurex.o
 obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
+obj-$(CONFIG_USB_USB5744)		+= usb5744.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
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

