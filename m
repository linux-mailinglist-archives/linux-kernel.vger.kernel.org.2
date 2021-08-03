Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42193DE8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhHCIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38237 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234573AbhHCIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 982B55C00C4;
        Tue,  3 Aug 2021 04:45:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Aug 2021 04:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+N7DD/QqxQViw
        OVX7AaMbzgltloMStlyOZLI4dXbkHw=; b=LmPaRwkcUqbHoE8QNWLm+JiLmh3gI
        qa07LYBgDw/5geoCIsqHJhBsY5YMRAir0YXBH4HmmxofURDbuouFCKxbUpLR30fo
        tJ5VTXU0R0sV/vTiMVIen1qxzkoz0MYNHM9U+wDc3co/gcP5YWoPKzVi2Hbbi6f/
        SLULmid0WXJbLZY7G59NEj1dw5K1dDTfTKYcvt4CIEucp1V8IEsMWHofvF9RLk3a
        5IxwA1QG9JLy5WtR34syTiQcVHGlJruWoTs8lw5moA0iqgcsuVbHolPOx34LLT4m
        D80xhR8qgMRSinfE6twn02jFD4hFK/tzbpudpft1pBlAa1hKatZsjvsYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+N7DD/QqxQViwOVX7AaMbzgltloMStlyOZLI4dXbkHw=; b=V8hODupP
        CnS8Ru0TGIkJpQDDw61itsoBuBBu3D9eNJJXo8nyrKroosTpFtz1zIQscT0mZVCL
        0xuGNYPcoU8QD149+dTFBSb6FKYaxwQgxPAu45rG8GPBFAmz3lzQffXbghxOZse9
        SsNk6YE1PwOjTdUQutruGL/amHc2T5+IrM+woYCBRje8feZ4yyLPHBcTo678UgTV
        Pv1yrezWZnar2G78SR4rZilkcNBWSz5957AVxLgr+jF9za/6XEAy9EcNt9MW7b11
        XjydL/7hfPzq0pg2wq0ao/Ep6Hq0rDE1ZDr4uPVc+GhZiCyA3mLWV1ZEciBQG0RI
        2YUV3BGX6Teu3A==
X-ME-Sender: <xms:QgIJYRTjz3dBRAJBT0hyzI3QuqZv29WwVLTcznGQxKYORUmDQszvOQ>
    <xme:QgIJYazD7b-BNs-gStaDRp_6lwDK7udcBfCm7wlWvOFLGemluX56aZL0VD4CQP0JW
    hIT93W75nU9t-91CsI>
X-ME-Received: <xmr:QgIJYW0w-df9KzeiCWqhd0hf6LEEwAK1LxQ4oe-9cpS48cUKykPb8Kch5P8j7z04wZVlQgdy3w_WaqiVFRA5OEIP1nD50Gs0Y5cXH0zDaDyDZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:QgIJYZD4-kUP-o2BOEqqWL9-9B6kO9NKSpkjTc3JqI9HVafoideKBg>
    <xmx:QgIJYaj5MIjx7pWQtJIfI9LXmqNioHvqyEo1IeHqf-HP-FmonJGofg>
    <xmx:QgIJYdrY7VSLA6d2CSWApi9KVZsVVGCF1GaTmmwSsgSHXrsQHgoZCg>
    <xmx:QwIJYeiQP7OhcGrugmlLf_Z8oAJ5x3KgJXJCBxk5IdhoN7iL5B_8lw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:45:50 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 02/11] mfd: sy7636a: Initial commit
Date:   Tue,  3 Aug 2021 18:44:49 +1000
Message-Id: <20210803084456.198-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
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
 drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..b82208f0c79c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1352,6 +1352,15 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SY7636A
+	tristate "Silergy SY7636A Power Management IC"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Select this option to enable support for the Silergy SY7636A
+	  Power Management IC.
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
index 000000000000..f3ff93c7395d
--- /dev/null
+++ b/drivers/mfd/sy7636a.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD parent driver for SY7636A chip
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ *
+ * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
+ */
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
+static int sy7636a_probe(struct i2c_client *client)
+{
+	struct sy7636a *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->regmap = devm_regmap_init_i2c(client, &sy7636a_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		ret = PTR_ERR(ddata->regmap);
+		dev_err(&client->dev,
+			"Failed to initialize register map: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, ddata);
+
+	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				    sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
+				    NULL, 0, NULL);
+}
+
+static const struct of_device_id of_sy7636a_match_table[] = {
+	{ .compatible = "silergy,sy7636a", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
+
+static struct i2c_driver sy7636a_driver = {
+	.driver	= {
+		.name	= "sy7636a",
+		.of_match_table = of_sy7636a_match_table,
+	},
+	.probe_new = sy7636a_probe,
+};
+module_i2c_driver(sy7636a_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("Silergy SY7636A Multi-Function Device Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..5e9c537fee45
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,45 @@
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
+	struct regmap *regmap;
+};
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

