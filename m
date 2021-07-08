Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839E33BF96E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhGHMBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60095 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhGHMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:00:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CE215C0041;
        Thu,  8 Jul 2021 07:58:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Jul 2021 07:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=pRIPB83la3iKOmVVHMgSN8VS8y
        +Ff25CtnJH129lD38=; b=XHdw/n2X0QPHhk5Rk29wFDa/p/xkS59o/mc2SeDavS
        3HukKqfZkR7YE/KafMUaT7+v431Tf9/nfa7M+xgzu1jYE3f3sdnPVfbiJAj7Ow8W
        gk86tgDL8W9Bdo5eI1y2tM0KivP9sAWh9mORZkD0VAk7IAT9RiIRUtoSZFtTXI3r
        0MJQv0fJd5i01ZlqGbbeYHVBXHM5gV4ojFXvXMG+BpUoZAc90bfYLT1un9TpDm9z
        JhId10gbVqt5CVRwBn0XjXuSN2BbrOTu7PPWd/+qGhluzBsf1OSFqfu7EdHPqfHy
        nncPVm89f+m+v47eAy8SmD8EmU+wDVmCKbjCM7PpylAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pRIPB83la3iKOmVVH
        MgSN8VS8y+Ff25CtnJH129lD38=; b=s/iUt8VeVjzPozum6CJNWV6Xn3GrOETvg
        DshS8wObJ82OBV8qXoTx2S2ALniOjn4WccVTD/xksmrsxsOuXbbZFhJvSJ6F4kFV
        9wlZ86/MycnGXIHawyrhd/SRArdHbym9O+pIeVs0wQg8v2VLrMDPUj+qwA1bI2vf
        fy5OknMGFe5jkOSaKO4wrdrp6/RvUefmp58utwYo3974tPNMXCkvPkXxefcKetNf
        VPrNPTF99cCxB7lkKlCNYa7Uwjky3jiNDTM4rJC9Qbkm3jAwW2NUpm4JS9As9YOI
        GCOZDTwV3nUaykgTqBsYy8qHOKzXF4ItNdURLG6tW2P208GQLz/DA==
X-ME-Sender: <xms:WOjmYG3OItMVLig85IbwcM9d6MdyJghGDuL-OXNAWJSiNjBGggXDwQ>
    <xme:WOjmYJHuuUXxRjLdeEBXhKWkt0hIe-9uYdnw7t_sj6ddBlj6KHsDO95HO7acGMBlE
    xBhstK6mlz56-QbW8E>
X-ME-Received: <xmr:WOjmYO4xjV94oMWQz9x0xnC70MFa4Z1SVgVupJeqRhbdVUjutP5uNlk32sxxWzKzw4_doPjH-w5hB6VniLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepkeduveffffefffefve
    fhudejfeefiedugfeltdegueehhfejkedvudeltdeihedtnecuffhomhgrihhnpehrvghm
    rghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:WOjmYH2CRToLzSgpwgTadkKWR2Kn5R81cg8D5745Ua9A1lcVTKcRdg>
    <xmx:WOjmYJGhVDBtpRDjpfqTIAIO7H4HcoQANpYVy-dm9f1UHXKEjNcCtg>
    <xmx:WOjmYA-tw82DfCW0tXCA9veYJ8muoZBYaTl9flw4-5mcYBkOI-EiOA>
    <xmx:WejmYA0_MJS4lGi3rgrvbJra59FV3Qd9btLYNPKg_27PvO9ZrDF9VA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:13 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Date:   Thu,  8 Jul 2021 21:57:59 +1000
Message-Id: <20210708115804.212-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/Kconfig         |  9 +++++
 drivers/mfd/Makefile        |  1 +
 drivers/mfd/sy7636a.c       | 81 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..7b59aa0fd3f2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1352,6 +1352,15 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SY7636A
+	tristate "Silergy SY7636A Power Management chip"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Select this option to enable support for the Silergy SY7636A
+	  Power Management chip.
+
 config MFD_DAVINCI_VOICECODEC
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8116c19d5fd4..cbe581e87fa9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
+obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
new file mode 100644
index 000000000000..345892e11221
--- /dev/null
+++ b/drivers/mfd/sy7636a.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// MFD parent driver for SY7636A chip
+//
+// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+//
+// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+//          Alistair Francis <alistair@alistair23.me>
+//
+// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
+
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static const struct regmap_config sy7636a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
+	{ .name = "sy7636a-thermal", },
+};
+
+static const struct of_device_id of_sy7636a_match_table[] = {
+	{ .compatible = "silergy,sy7636a", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
+
+static int sy7636a_probe(struct i2c_client *client,
+			 const struct i2c_device_id *ids)
+{
+	struct sy7636a *sy7636a;
+	int ret;
+
+	sy7636a = devm_kzalloc(&client->dev, sizeof(*sy7636a), GFP_KERNEL);
+	if (!sy7636a)
+		return -ENOMEM;
+
+	sy7636a->dev = &client->dev;
+
+	sy7636a->regmap = devm_regmap_init_i2c(client, &sy7636a_regmap_config);
+	if (IS_ERR(sy7636a->regmap)) {
+		ret = PTR_ERR(sy7636a->regmap);
+		dev_err(sy7636a->dev,
+			"Failed to initialize register map: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, sy7636a);
+
+	return devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
+					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
+					NULL, 0, NULL);
+}
+
+static const struct i2c_device_id sy7636a_id_table[] = {
+	{ "sy7636a", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);
+
+static struct i2c_driver sy7636a_driver = {
+	.driver	= {
+		.name	= "sy7636a",
+		.of_match_table = of_sy7636a_match_table,
+	},
+	.probe = sy7636a_probe,
+	.id_table = sy7636a_id_table,
+};
+module_i2c_driver(sy7636a_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("Silergy SY7636A Multi-Function Device Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..b6845a3572b8
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Functions to access SY3686A power management chip.
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ */
+
+#ifndef __MFD_SY7636A_H
+#define __MFD_SY7636A_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define SY7636A_REG_OPERATION_MODE_CRL		0x00
+#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
+#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
+#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
+#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
+#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
+#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
+#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
+#define SY7636A_REG_FAULT_FLAG			0x07
+#define SY7636A_FAULT_FLAG_PG			BIT(0)
+#define SY7636A_REG_TERMISTOR_READOUT		0x08
+
+#define SY7636A_REG_MAX				0x08
+
+#define VCOM_MIN		0
+#define VCOM_MAX		5000
+
+#define VCOM_ADJUST_CTRL_MASK	0x1ff
+// Used to shift the high byte
+#define VCOM_ADJUST_CTRL_SHIFT	8
+// Used to scale from VCOM_ADJUST_CTRL to mv
+#define VCOM_ADJUST_CTRL_SCAL	10000
+
+#define FAULT_FLAG_SHIFT	1
+
+struct sy7636a {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *pgood_gpio;
+};
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

