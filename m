Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC6B3BF973
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhGHMBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39241 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhGHMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 044F55C01AF;
        Thu,  8 Jul 2021 07:58:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Jul 2021 07:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=mMRofIIaWixit
        VOGeCjP7KV97Cr9IHTUhF1XMo380tI=; b=e2wy2+ps5ozzPyeXVEho4iJl+kKqh
        wb3Xfjpt+hGRpdZGKLS18sQH7AUwoM3KXNicuZoxwoJ1m6JnZ6ceKV5fVBkMMA67
        qqRx1f0w/kMaZj9cD50BpPe7mZQCmAx7L9a9n7nxxsB58FIAKgx8YbSvjpQFh3FT
        2hG3WHmFoARCeZNg+47Nc/i46zxJrZF7e+brAjmS8NQEymbtAiJO11z47CuedaOZ
        kDqwulNjk2UhZO1UtvwhiiDU1Q9WnW2+wW+gr2KQ8PsRvNY4v+C71x/XRzkuHMni
        e8Xq3LCZ65eX0TB7LBPbkBJN1ivQT17wa3rdEdxVhY0MRphxu+WWrL0NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mMRofIIaWixitVOGeCjP7KV97Cr9IHTUhF1XMo380tI=; b=em1aGke9
        HEAn9ajrA1rAg9ewwcXZrZdrICB+vtV/QllfS0jWpwgY/YguS+Eq5crOu6Jxod5h
        nS6LcSu9mgZQ626zTXpte+Ly/0qCMfR/PTXZR+c9ynLVY+A94SSSVpp7QxiGAKv9
        kgtFYiRDUoj60et7NXPeuHIowaGCLzA2Y3usIu/8T1e/JnsAzXiK6SuTLxPgeyR0
        HIJuC6DgCBK1zw56qzYgwU9XzPAe2vngoWUqloWu1KgwNhrE6G2Dc57KoBzrkVLz
        YNR5/aLUPXnPDbvJSCDp1J+VzDln5xIhaVlCE/itM3lczWE3Gq0L1A/ojUt0yhID
        P8/S8d6LNqdIvQ==
X-ME-Sender: <xms:YejmYNGiciEaBwGlyEYuV7zJx0qbW6BFw9wqLR2CeqtELVJJWtoySg>
    <xme:YejmYCU1udoMpD_omYTTjzjuc0XZ1KsLnMkyDxbllwKBnxlQyOxkSzBgYXpf4mWAm
    3X2D-B-2ljHUm67u-A>
X-ME-Received: <xmr:YejmYPI2F5K-kQTyANRZs9KuFbwASjpcemXraC917kQBsaT7sreGD1uJb8DIXbsuwCfIUDETZ-VOG6volh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:YejmYDE9O9faRQVq5lG7rRcFbni5ZQmlJaeRGuOXGu45z9RdI0_RsQ>
    <xmx:YejmYDXYogCSCkwIHE8OB_4sNDzCgUCoEip_erRsOQsTqnNb_5X2bQ>
    <xmx:YejmYONIWFsiWeHb4VlB015N1brHo1Z5U8cZrn9yaqOIvuX3nmT0yQ>
    <xmx:YejmYKFSnuJ5Q2-P4cv_7BjCzXlnhTPRm89JHM0cHG0-5fdIbpT-Qw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:22 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 3/6] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Thu,  8 Jul 2021 21:58:01 +1000
Message-Id: <20210708115804.212-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
References: <20210708115804.212-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig |   1 +
 drivers/hwmon/Kconfig                |  10 +++
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/sy7636a-hwmon.c        | 106 +++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cd80e85d37cf..e9c0be5629c6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -227,6 +227,7 @@ CONFIG_RN5T618_POWER=m
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
index 000000000000..4edbee99b693
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,106 @@
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
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
+struct sy7636a_data {
+	struct sy7636a *sy7636a;
+	struct device *hwmon_dev;
+};
+
+static ssize_t show_temp(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned int reg_val;
+	signed char temp;
+	int ret;
+	struct sy7636a_data *data = dev_get_drvdata(dev);
+
+	ret = regmap_read(data->sy7636a->regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	temp = *((signed char*)&reg_val);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
+}
+
+static SENSOR_DEVICE_ATTR(temp0, S_IRUGO, show_temp, NULL, 0);
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
+	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct sy7636a_data *data;
+	int err;
+
+	if (!sy7636a)
+		return -EPROBE_DEFER;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
+	if (!data) {
+		return -ENOMEM;
+	}
+
+	data->sy7636a = sy7636a;
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+			"sy7636a_temperature", data, sy7636a_groups);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id sy7636a_sensor_id[] = {
+	{ "sy7636a-temperature", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_sensor_id);
+
+static struct platform_driver sy7636a_sensor_driver = {
+	.probe = sy7636a_sensor_probe,
+	.id_table = sy7636a_sensor_id,
+	.driver = {
+		.name = "sy7636a-temperature",
+	},
+};
+module_platform_driver(sy7636a_sensor_driver);
+
+MODULE_DESCRIPTION("SY7636A sensor driver");
+MODULE_LICENSE("GPL");
+
-- 
2.31.1

