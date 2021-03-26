Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF65D349F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhCZBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:55:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46563 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhCZBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:55:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C71B5C007B;
        Thu, 25 Mar 2021 21:55:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Mar 2021 21:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=5X3RoLErh6pcv
        7yslv6+nBvy59eRz01ZtrPqSXE8fBc=; b=Mw3/Jis23ZzWkS4hsuLoQwA8NhaZs
        tjAtq7pUYObk0jbzV9xawoJ3cS6rg2kANKMSnc8MxX5Z2zopsj/kDt1HeN964tdM
        KXVnFsh2NXwS4V75/L+A1GSe1BASM5EEKB1VhQobBgzb60NbNF+x15Ha6fc+cprX
        mbC3PTHVy5oMIZvkQW0cz2c4GPec0W0CWFfw9qY6dWPsM+8vfOBtqSENv9HSz4BS
        JRYwXyt14aV5L+O72R09ApZEXlnuTJcTqXMMogDUiIe6RQ8LYEJxGVl0GDFtUam0
        kvSaEhElt+BIDw6SrwUpqbZAQmT/BhCDjD3A+3l0dFsRXPuz0cKT+XsHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5X3RoLErh6pcv7yslv6+nBvy59eRz01ZtrPqSXE8fBc=; b=imqIuVkk
        lPl9lIpOUPxhUIh0Gr1hVi8zqxOHSAswOPtlUIBoaS1BPLveh0NFhm6vj3KwYbKu
        TEUPiYhd8bgCD/jSxmbjrvMa/1aRJrJS0puNwil2q3Uvkw9c5NYJVDvyJXHO7VUq
        Q8sMxniVM2EltahURyiZJeu93XmliXkFTwr0SDX0By0DuTgzOdnSfDk83GRsqy4l
        VQUqiZhAQQfECotY34JzhCOSiFDkkOJX+F2bneFuxDf6hWp63oSap5vHjl0nzoXd
        bpJl9z0Dzs0/YhIK/+We3Z+3sMWk7qxamgY3A2GSSVOB01zXIWrJLFeGFJByM3bt
        86vsg4q+Ckpl9w==
X-ME-Sender: <xms:Dj9dYISGM1jr-_BbilFyClmgWZhjI9Fcp8RAka0nA7-pQHDZ-RTY_A>
    <xme:Dj9dYJDm-Ib-KfP7k5SvkiHeFo3xW9Rl2piWnqaEPwAhZ4WPN3Ca4RXLXF2aPhbnH
    P09jjp22_bixedirlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeduleefrddvjedrudefrddvfeehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:Dj9dYPQOqmzs6xFNugQQ7BXbzq_620Wdx6OvKuHFlvYtfaGD9jQN0A>
    <xmx:Dj9dYHoRKdlSFlzndCqeQYv23pxyjfXGwmF00IagV1eBD8RArcvZ_g>
    <xmx:Dj9dYByOOU-wV7e_BqdSC6k2LIjkOwr20FfV1lQf5S5M14Kf4y54LQ>
    <xmx:Dj9dYGvR2c6tfdoAEbx9VjslbDsdp4XfseKauf_vh7AV6Djrrz73AQ>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F5F81080063;
        Thu, 25 Mar 2021 21:55:25 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 2/5] mfd: sy7636a: Initial commit
Date:   Thu, 25 Mar 2021 21:55:08 -0400
Message-Id: <20210326015511.218-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326015511.218-1-alistair@alistair23.me>
References: <20210326015511.218-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v3:
 - Update copyright year
 - Move power parts to regulator
 - Change Kconfig depends to be tristate
v2:
 - Address comments from review

 drivers/mfd/Kconfig         | 10 +++++
 drivers/mfd/Makefile        |  1 +
 drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h | 46 +++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b74efa469e90..ac09b40e1724 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1351,6 +1351,16 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SY7636A
+	tristate "Silergy SY7636A Power Management chip"
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
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
index 000000000000..a5ec5d911b3a
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
2.31.0

