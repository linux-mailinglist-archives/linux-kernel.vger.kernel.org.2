Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28A3E34EC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhHGKks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49663 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232178AbhHGKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CF3E65C00E9;
        Sat,  7 Aug 2021 06:40:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 07 Aug 2021 06:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=j2qB+BfCroHm8
        5dLaWC9AKvrZqzhF/dayLXgdrQMfi0=; b=GwrXT7lWj1C1HK0pMYa/nUxoovR0X
        9U+N9Gsg7NfLpSBQK2SbT9cmEI42m/0B2tUnXAooqPfPj+cpkwClK5hiWPH6JZz/
        6h1g/7QrGZjd2IktF4G8/PreaSUfRCZ2I+B906WA6wq2Yr+h+3aQKhO0yg8Bny0C
        fn2Clvx0lU4Wv+6zeufg15g4FcCG1RqsgDnVaVotjkw+57qb5ADt8aX0gS0h+7tc
        pZ5FmwIu5YII9daAThjZGDzRji3K33f8JAIwK03LtmJgeCTb65CqwpFcYOf/ljIW
        LrAmCzxoDavuAqOa+ZLqS8ntr+9icl6/bPLB/evxxCrnp7/zOWWlTNBYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=j2qB+BfCroHm85dLaWC9AKvrZqzhF/dayLXgdrQMfi0=; b=tUt2js0j
        ExXTEeyb6pXqHwAaRmwbIxnC1rtpQRGEf56f9f55oGYkrwKLejAQ0Z62cHIDrUB9
        2+4kpM6zCHOycAY2ivEuDVMRMxIVAysaenC0YE2fgb/lmX9bdCJzbcgeelcVWRlA
        ITxxaWwZkemgEJBtNhtHrgyIdx9J3cXrIyTs4RSoyA2o4j6WYslQzoLalcvtxA6H
        fUW/TCfZernJGO08mGBDzLZ5+n3gvY6WOwg//tJ6QbSRcGzy+a4zlvHfl4X8SA9Z
        7iOpWG0BpgaWXPvLycpKRypT2eBmVxwgBmjKoFj/EqsUuzW+vfHE5rN7tLf6dWan
        /kjZkJU1A0E58Q==
X-ME-Sender: <xms:FmMOYZqNWGGy0UKFjbxacjW9UbQZHARsfa2SlrvjDmgrVowb6-ocTQ>
    <xme:FmMOYbrC2l9lhUtho-ZHwN1AwTOd24IltVSh4L_kzhxa4GodphR-3ZyGSoSQ0EEU0
    hmLSziFPycg-w_tAaQ>
X-ME-Received: <xmr:FmMOYWNd8CEqiRpomdOOfuQxQKSOo-0ZOZy2plOsOM7R8zTEvTu6ESXudmba5yd1d3QxuRPGVZCQHGvXQQA9Yp3FI-NPUHtFQyuslLrgYMeEw4spaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:FmMOYU4hZp2JrDxXGte2f91_hBiKx8I9UlXyOO0iJ7RyQNokOKGOvg>
    <xmx:FmMOYY4GlFowbeFb0q_6eC7U8bK7HZlKdvM23fDYAPpYlBkQvfFFLg>
    <xmx:FmMOYcj6uD5WJSRc3LJVMqdg_99U4M4UWaNTr6ls_fAJD0fBv6mEoA>
    <xmx:FmMOYXZvwvrHwsxVIamYK_KDLuajX3wjXwXqqVZzbjUkQ6BZy04kjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:19 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 07/11] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Sat,  7 Aug 2021 20:39:36 +1000
Message-Id: <20210807103940.152-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
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
index 000000000000..2aec0875b031
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
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	int ret;
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
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
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

