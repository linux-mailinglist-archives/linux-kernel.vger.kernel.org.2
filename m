Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A23DE8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhHCIqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60155 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234656AbhHCIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 72D1E5C00CF;
        Tue,  3 Aug 2021 04:46:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Aug 2021 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=24W58pwLC8JPC
        lSnlXShder4NRAbcQwJUTo8WYRwEGI=; b=NxCGNlEklPwbvbP9/+UimID+G+84G
        nStUWjWYlExqkzOOjuPerFKfbB2POaeb02SzaQ5tXIAPrtvKSzBFD1PCrmvRR1+z
        ofyJ0ZpW+JSF4ae04LXMZK3SSm8WAfMKLoPmYFOjksUHYVlXi4Pe6CvSb7KopdNK
        mF33rJTkEUO3d5EnHeK3TRIZKg4T1MZ+L449SwKckcOlweAcSoo+6q7lEYbMdFHk
        wdtj/5EFF0K4JtuQRWmrUn1gZvNlfZWtUJkktv0tTmx6+Wev3yUwAvZ7vBnoTOr6
        nDk8Auw2z3S0+fxSMYm0SHRWetj47f99PlchRqnROsx0n0JIxdMSziEQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=24W58pwLC8JPClSnlXShder4NRAbcQwJUTo8WYRwEGI=; b=BwGXBmgf
        sVBZCLlmnPWEaMsfGQJuo93yaLedPmFq5a4WySz4oKcUX6HxMTVddQg/PB5dF18X
        s+G13QKqO5LqYH36LdYr2AZQ8wiRWIve9ntFX7VyIbaCQyBEjQWyUI8N23zURfeV
        Aog3f3yRZA0l0wOuoYLsO9H9ZBiA9y0sJ5MbC59BzCzRIeRIkzet5cTJA9oRd03j
        JWWmqeJ057njGK8DNzFutbLcnnm58/akztuJ5ZX8EuLSDHYm6mPzyrhB57+TFh3p
        rGkp+0tqi3Xile2cZrzSiTZYFTtSqk+kSLD7zwKs217w1DTC96/nCn8M98NODo11
        IdSsSZZgpEHTKQ==
X-ME-Sender: <xms:TAIJYeLo7HJk62kKS8OYugrP9pKhroqzJnPJSbmTdjDfoI8RTBMxtQ>
    <xme:TAIJYWJQaLyqwtbt9yaF7rgPqMDB0tp0PabNyGhJ-nF9gK-1UBpZWgbrQ8aNoITZG
    mdiz1ED5tRpVSWuRjo>
X-ME-Received: <xmr:TAIJYeudWv6rgJ-BgMoesSFC8LMuATq0qoi0F6BDm__zlptAVKy2O6lAXTdvjoxgaz3UPqzIMVYnV9TnuCKyVlH2Sir-GOrxM7BKe8rZyWO_Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:TAIJYTbL_Vk5W2XSmzPeI2_J7EvJNhG5LcsFF6pJsBPXTMOuu-1btg>
    <xmx:TAIJYVbOrbs1LokdVJ5IT5nQhANEMiv9QF-UtqXBmsS4YBnV7wcOIg>
    <xmx:TAIJYfC6kFxqz3_BWDrAVNBOv6q9cvSr1xH7jnQKcGQUWEPX20nEVA>
    <xmx:TAIJYR637sVFDCNpB1JBBy3MdUpxQRbPCV2dJLKeaq94HZc0vXxdjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:00 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 04/11] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Tue,  3 Aug 2021 18:44:51 +1000
Message-Id: <20210803084456.198-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
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
index 000000000000..f5c6b5dca81b
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
+	struct sy7636a *data = dev_get_drvdata(dev);
+
+	ret = regmap_read(data->regmap,
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
+	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct device *hwmon_dev;
+	int err;
+
+	if (!sy7636a)
+		return -EPROBE_DEFER;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+			"sy7636a_temperature", sy7636a, sy7636a_groups);
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

