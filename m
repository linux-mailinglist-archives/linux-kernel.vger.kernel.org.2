Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2454363DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhDSIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53437 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238310AbhDSIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6832E5C0065;
        Mon, 19 Apr 2021 04:40:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=tpgYJp9Cj9iAj
        urWKmCYupHLFX3Mk3MR3W6piJJP8w8=; b=TKWul1QoqqhXxLfZ49QpVyzJU+pld
        AoaWSsPlARnWMue6f+7WydyGYOyIFwGtmBgy+3C/u+/74B9nVVCZpvYmk8mpyOPf
        leHKeYPtAnoL7RPqychwRamhf9JmJ96IyPx4S2JyqQlQHc4vPQ1bwwY4O4/xQpr4
        hUnEhcxeBABZPaDqY2nxHraf6/XaaOpiB6jUle6yUp4HR3aLll6BVr6m86LN8gv7
        L++1D1vK/wrCsuK9p5QlSDcISE1VCwPilzunAkMnC1NcXKJFZSKDmHqA0cAJIR4K
        /oysDsqdYFGTraZ8+r5afCmkFdDjYjiSCKvXaBibmu0WR7X7F3gSe1UXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tpgYJp9Cj9iAjurWKmCYupHLFX3Mk3MR3W6piJJP8w8=; b=RqPcEUN9
        oyAYOA3wGE2Yd6YFkiHLXz6j4IV4vgSTJnUZOeOWp7JBmwFJ2XLIcUQ6oCp9QR9j
        o6YnET5a9RxGMR8zEoDcTtiTOd3Nt6DTQSEjddHtMZ898U8E7gSNzedIJHHxZQAC
        izBT2ZrHdDDjPZS7USVJaosZQbxjYYoUHkBOpazdFT9RZurn8I8Cu3+DOg9Fwt9u
        IsNdsHre+AaWPkRULSIws1Af63i6GuoxK+aSa/j0Q4YQD3fUkXfPm3Aars29RuSA
        LHJHuZK7NET3M60hBoocJM+BRa5qcr2ZjX9eykcxP82+DTSG/mLlBVDaD1mRp86/
        44N/nQoFGvg+Sg==
X-ME-Sender: <xms:CEJ9YGgcAC_r_8i5whOghDQGiqtkj-KaQq78_O3qM4HmOvr6p9zoFw>
    <xme:CEJ9YHCkZ8QDvhi_BwrjEFRLxWuQIcWoi3FfbZ29COEj1WXUC_HH99uWogWtgtYwg
    -8Phr9G3DBx3BkGkIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeekledrgeegrddutddruddvfeenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:CEJ9YOH7fWxK4XAr2Zw3fcSrG3x6AcblhJHrQ7JW8fkX4gJbc7Wbcg>
    <xmx:CEJ9YPTQP_jz6TVA6887QfLbc1Ulfilf2V-jnDSJoOn79kYBQKDGgw>
    <xmx:CEJ9YDz0Gn4o-uGcKhTOs-tHh6gba3m3PT06Dlxq6ax6z8Z1A_zAtw>
    <xmx:CEJ9YKlrzXn1grDoXT_HeuZH-IeAjZs2K9mHAhCmexMf4ns9pq1bLg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id B439D108005B;
        Mon, 19 Apr 2021 04:40:36 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 2/5] mfd: sy7636a: Initial commit
Date:   Mon, 19 Apr 2021 07:02:19 +1000
Message-Id: <20210418210222.2945-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418210222.2945-1-alistair@alistair23.me>
References: <20210418210222.2945-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v5:
 - Don't use regmap-irq

 drivers/mfd/Kconfig         |  9 ++++
 drivers/mfd/Makefile        |  1 +
 drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h | 46 +++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b74efa469e90..9516ba932b5e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1351,6 +1351,15 @@ config MFD_SYSCON
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
index 834f5463af28..5bfa0d6e5dc5 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 
+obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
new file mode 100644
index 000000000000..e08f29ea63f8
--- /dev/null
+++ b/drivers/mfd/sy7636a.c
@@ -0,0 +1,82 @@
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
+	ret = devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
+					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
+					NULL, 0, NULL);
+	return 0;
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
index 000000000000..43b0db0f8e6d
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,46 @@
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
+#define VCOM_ADJUST_CTRL_SCAL	10
+
+#define FAULT_FLAG_SHIFT	1
+
+struct sy7636a {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

