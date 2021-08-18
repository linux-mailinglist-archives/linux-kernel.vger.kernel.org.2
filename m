Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231A3F17D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhHSLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60373 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238586AbhHSLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DA345C0115;
        Thu, 19 Aug 2021 07:16:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=s+ynalgx4AfI6
        lhKtqWRsNO/wGBu9KnuiZQIKAZ6TcM=; b=RzI6thyq+g2cNAT8gW5hnmbkiz8XM
        Z7VHnMLL8AlBU5m7OSaP0YfukRU3HI4XQpG+tkRL9dhyWYSeuZVcDeHKQTCMUXMO
        XofJAOuVPNk+7iYtlBwpxUeaI5kIHf1Z2O9MX7VwJTXm/aY88mq7gTG+1MXs3yk0
        IpFaENbC7wQUbHLnxI2WpTM5XGYue7FR7jbT6RaMN83y+3kQ6xztwoNnSSdlofUC
        e+dX9pfKOzmQGF8VXjOQyj5+/BuSjr8y1RXcjMH55TYzXmz/FnZF4Hvhw13dWbkq
        sQYIPmU5DtS8DOwr8rE1fjPMT4nqY93jEdzhQsCoOfqdpgZxzpesf/fmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=s+ynalgx4AfI6lhKtqWRsNO/wGBu9KnuiZQIKAZ6TcM=; b=SbHgLpzG
        TTGIVJnMqQOkbkeTTDUW+tk96ckk6f91RpKl3Ww3mDL3CW9CLHdyNwzEKdX5Ez/Z
        zuYkjacM3840w7hInjHQIbsBKknsLS7C+INAg2cjKfr3aNRRl9i+Stm2gz89efE8
        tI6XagQfk4LCZUfSiw5/CQTwbp9K995X1vDlC892gtgOvOV4XUnB4Hqtgnk2DvYd
        WiC5pleWREl2caT7rlyLUmOarW6zGoQxxERT812sDkm3U4dOdrZfu3WprlH/H9wD
        rWzoNQzEGep4yH40/f5lNXpxTGk9lMblbi4nZ3DvCywgGnH2uBxErdCUaqvCdS+S
        PaTIRC6rkcyRlg==
X-ME-Sender: <xms:fD0eYU4fao3N4nrnnaixgPu1OoEH9_O3UXiUu9e-8CLLXD4peqATTA>
    <xme:fD0eYV6ELVauYqvErx4REpnNsjOZSwIz9rL_GI86jU0cZCkVNvhHVWMDamE6QZZRx
    WkkgdYbFJpA2Wo19-U>
X-ME-Received: <xmr:fD0eYTcoVhiLp1LUmd_AIit5egNkUq70Dwi-k8RjEvXYfI1PVSg3c8gqbpn1GSsJTfAgJnoQ_cVhlwZmoRF6IZUBjHVIrrf-T52yIdd94I6tPh8z-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:fD0eYZL1Z86K3bZO8CW-D6_y1ZvMIhOINGLMiUs9MAFjiY3m_nckUA>
    <xmx:fD0eYYJ_wIMuMCK63rnD4X7Jf7ijNQz_P1K4QfND_lmYp6JtSq32Pw>
    <xmx:fD0eYayyQ9RhJPRjQt1RYrkRnL5NH1SwMuo9HQ0rZ35Qb42eA1T13w>
    <xmx:fD0eYRrimGkyuuDKIsMiR7ZRIHoHUkthyZmW1-w-7eeeXwsQOSX31w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:09 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 06/10] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Thu, 19 Aug 2021 01:44:45 +1000
Message-Id: <20210818154449.1037-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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
index 000000000000..e0204278339b
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
+	struct regmap *regmap = dev_get_drvdata(dev);
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

