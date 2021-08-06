Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08EF3E26E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbhHFJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42109 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244128AbhHFJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A8C625C00A5;
        Fri,  6 Aug 2021 05:11:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 06 Aug 2021 05:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=fBXKxTdI6gPhS
        j9cGl0EQmbIHIygasR+Oo/pPe/tKuo=; b=gyvbhOLxhR7gbps65/uNWlBCKsqcn
        3W0kaoX8ZUIlceMmfGTs8DU4aZwjcxX5FN8r4kuiLTtYhRlNX6TrmxXpvE+6C1Ks
        wJOQC8/LS5QyNXm3a0OF/M6PYLbxeMCBCqqcrPV/8XlE0PPUKzP1tFb94HwJMy9m
        VnXavM35ueDeQCg3vvHYxHKjmwr8EpfRf8RW2EcSPbQxeGmXYwVpeOY3s3BcML1w
        4kacgyaEYKdfto2EAHcmwW1HJbEscNB0BEeW+tlhsADJSwcYRsu5Q6LVp0fd+Bw+
        YIDFrcCtQ05hdqY/yUMrIv0aMZASsYM6hgREj3VSYt+5dl1VfdHqMUGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fBXKxTdI6gPhSj9cGl0EQmbIHIygasR+Oo/pPe/tKuo=; b=QkpV2Svn
        C/0Vl7KusH2Pl0w86RhcR+BuJLhfVv6f/Ei1TuQJiC6rw9IgRnxmZeahKodFWAOu
        xOnkSBlmDE9pWhI5QWOGS1RnSnD4EQ+jaQiv/JgVNUshSH70Gv9OSYid1Av6XbHF
        WgC6Dllp0U2FaiI1ilVSfT224XP12JP3Co+ZJRYH/V9WYxi4THyKfi/DMmbPN6q+
        1dbXcH9mXpOmlby9ZikjNQyw7//ajUB+twOJ4gseAg+SVa6Cil8fA6UQZ+1tAuDr
        cFhyDb1ehlBpg7f5pXvW86EC6YX9TAAsl5sb1gYormFKk+OB2w+2Jf3mAxPTc1CC
        EcIJKIAPTxGNGA==
X-ME-Sender: <xms:0vwMYbraYxoLKJoAS1D90Ll8vImar9nTGCPjfASKzSstXejPUf7AYg>
    <xme:0vwMYVpZdSpkyPZiw0H_4r1hPGSWhU2Jg357hJExSbzxT2aiz_4LcDuDgkf065QaA
    8Pq8qotE5Kbck2m9n8>
X-ME-Received: <xmr:0vwMYYM_luQ404hsmlx6H0XO15ebqHZjHT0sXCJ3mL8l8SWL7l_R3oSNFtiAzJl_r7i4XStJJJy73X5-lzHqXLq1zgZjI1DAJj3NSJZSjTtZYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:0vwMYe4osLz-9B2T7YbdVhEJgz93a_DIhfwfKN-_9dLtms-o9SfAJw>
    <xmx:0vwMYa4Fc_fawC-z4DdUhJXxnoMQdl9leyQJIIoKYoG_D2zQ32OBTA>
    <xmx:0vwMYWhbYlR2uO1n25qgk0JYGSzQxFPNC76j1AlxS_dwO3lr5JJeIg>
    <xmx:0vwMYRbur-Fgr9-ITM0IuhJjuEwNKCO5bNKSmjMhwOeMVCFUFqtliA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 08/12] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Fri,  6 Aug 2021 19:10:54 +1000
Message-Id: <20210806091058.141-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig |  1 +
 drivers/hwmon/Kconfig                | 10 ++++
 drivers/hwmon/Makefile               |  1 +
 drivers/hwmon/sy7636a-hwmon.c        | 77 ++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 477dac1edc75..ef8c6dca1277 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -229,6 +229,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e3675377bc5d..6cae12de59cd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1631,6 +1631,16 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module. If so, the module
 	  will be called sis5595.
 
+config SENSORS_SY7636A
+	tristate "Silergy SY7636A"
+	depends on I2C
+	help
+	  If you say yes here you get support for the thermistor readout of
+	  the Silergy SY7636A PMIC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sy7636a-hwmon.
+
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
 	depends on I2C && !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d712c61c1f5e..8b2e09e25b24 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -180,6 +180,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
new file mode 100644
index 000000000000..0f4618e24d71
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static ssize_t show_temp(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned int reg_val;
+	int ret;
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", reg_val);
+}
+
+static SENSOR_DEVICE_ATTR(temp0, 0444, show_temp, NULL, 0);
+
+static struct attribute *sy7636a_attrs[] = {
+	&sensor_dev_attr_temp0.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(sy7636a);
+
+static int sy7636a_sensor_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+			"sy7636a_temperature", regmap, sy7636a_groups);
+
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sy7636a_sensor_driver = {
+	.probe = sy7636a_sensor_probe,
+	.driver = {
+		.name = "sy7636a-temperature",
+	},
+};
+module_platform_driver(sy7636a_sensor_driver);
+
+MODULE_DESCRIPTION("SY7636A sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

