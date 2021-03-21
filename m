Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396963432F2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 15:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCUOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 10:14:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40367 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhCUONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 10:13:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 587B25C00FF;
        Sun, 21 Mar 2021 10:13:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 21 Mar 2021 10:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=iGk0piulugY6B
        ExjFZGZkpnHDkjsk6l8KXQTXtt1piw=; b=ZPYSvvcHnP2Fz+/u7fF1AJzw+AxvB
        bF/8gUBSpn0p9bXVlAnqFenfuV30N8m/jI8Pzzq6/pasu7QsL8AR9UsRbzSqxkoA
        YzU7xsLJ4bYnLSh0/3YGfFezwBX8SwQ6T9yG4aCBc3rbn+jXvXw3XLb5xOxA55OC
        gBVPOB2nnlycYzMqe5BlbJEfmqDn9p8lN8AHd74uCADbpmaziSuW/th48CuCqP2b
        jh0GkQcdyKqU5ilowe0ETwhBHwWYNgm7r60WhODKhKmFstxHbhPAA15/aG9EDfpU
        +oFKEz8NWQV7lXUYS3SdfUFX1WHmKwIs7dX6qL06Y00uyx0+apIkSyVsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=iGk0piulugY6BExjFZGZkpnHDkjsk6l8KXQTXtt1piw=; b=UM61BPn/
        2wGOfAZbYU/dZfcMjiXtqkFkstVAlNXyT3CwaSXG4U2ghglj44LZXlwCfV2bFJ/H
        T6iYV/9w54q5Jmeolp5vR7Vy2rzKr9FzzpfxKtORe7zSFIuJ6Gs+EWVO95RfXuja
        k/VoNLN5oaV3MapQvdD03AxcJ8cPBNXpSSo+Pkjf/Cykv3cuB/qx3ocjZ8o7KrWe
        TTwcbuIV6N3CIeAa76+72rUdFcea00SAxt5AqlyMVYzJ0fCKN6FLG6ZxmE/tbNkn
        pY3hflRuUVhBMYGRf50z/qsWOncyCzxaCfGat30P7DCmWGjjVXWHP8Q8m1aICh13
        sCOnpMxZjLmkKg==
X-ME-Sender: <xms:jVRXYLdfQ_bc76sSZZYe7ZIM4J7m09w53V_sOt11JToUw24yexrhqQ>
    <xme:jVRXYFgW-u5PuXlBakNuaEVpT7YyqY6lc6B_UxNZ2KcqNbmhy5QrVEENXO7FMJXMo
    ov4HwsLdC3KdE0f7do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeduleefrddvjedrudefrddvfeehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:jVRXYDpGQzXY70BSrduLYFM6q2bEo7ehfLm-gI6G0vjDxQdA7EuNiw>
    <xmx:jVRXYFH6BtqqUSdGypFKGzE775NPakOB8nfKkzpjACy3qlOfW2ZaTA>
    <xmx:jVRXYNliB08wcByhV5if5IFP97vIGfGsrxxcsq6zgZbrtDI44XKDhw>
    <xmx:jVRXYDMae46AY8iWPQbKdkAyKcWWPq7Cc7hKlPUCpdE7rtnstijXxg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31848240194;
        Sun, 21 Mar 2021 10:13:32 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 2/2] mfd: sy7636a: Initial commit
Date:   Sun, 21 Mar 2021 10:13:22 -0400
Message-Id: <20210321141322.298-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210321141322.298-1-alistair@alistair23.me>
References: <20210321141322.298-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v3:
 - Address comments in V2
 - Drop regulator patches

 drivers/mfd/Kconfig         |  10 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/sy7636a.c       | 246 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h |  46 +++++++
 4 files changed, 303 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b74efa469e90..a285d11d5be3 100644
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
+	depends on I2C=y
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
index 000000000000..ecb7c58eb5f4
--- /dev/null
+++ b/drivers/mfd/sy7636a.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// MFD parent driver for SY7636A chip
+//
+// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
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
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
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
+static const char * const states[] = {
+	"no fault event",
+	"UVP at VP rail",
+	"UVP at VN rail",
+	"UVP at VPOS rail",
+	"UVP at VNEG rail",
+	"UVP at VDDH rail",
+	"UVP at VEE rail",
+	"SCP at VP rail",
+	"SCP at VN rail",
+	"SCP at VPOS rail",
+	"SCP at VNEG rail",
+	"SCP at VDDH rail",
+	"SCP at VEE rail",
+	"SCP at V COM rail",
+	"UVLO",
+	"Thermal shutdown",
+};
+
+static int sy7636a_get_vcom_voltage_mv(struct regmap *regmap)
+{
+	int ret;
+	unsigned int val, val_h;
+
+	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, &val_h);
+	if (ret)
+		return ret;
+
+	val |= (val_h << VCOM_ADJUST_CTRL_SHIFT);
+
+	return (val & VCOM_ADJUST_CTRL_MASK) * VCOM_ADJUST_CTRL_SCAL;
+}
+
+static int sy7636a_set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom)
+{
+	int ret;
+	unsigned int val;
+
+	if (vcom < VCOM_MIN || vcom > VCOM_MAX)
+		return -EINVAL;
+
+	val = (unsigned int)(vcom / VCOM_ADJUST_CTRL_SCAL) & VCOM_ADJUST_CTRL_MASK;
+
+	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, val >> VCOM_ADJUST_CTRL_SHIFT);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	int ret;
+	unsigned int val;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to read from device\n");
+		return ret;
+	}
+
+	val = val >> FAULT_FLAG_SHIFT;
+
+	if (val >= ARRAY_SIZE(states)) {
+		dev_err(sy7636a->dev, "Unexpected value read from device: %u\n", val);
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", states[val]);
+}
+static DEVICE_ATTR(state, 0444, state_show, NULL);
+
+static ssize_t power_good_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	unsigned int val;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to read from device\n");
+		return ret;
+	}
+
+	val &= (1 << FAULT_FLAG_SHIFT) - 1;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", val ? "ON" : "OFF");
+}
+static DEVICE_ATTR(power_good, 0444, power_good_show, NULL);
+
+static ssize_t vcom_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	int ret;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = sy7636a_get_vcom_voltage_mv(sy7636a->regmap);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", -ret);
+}
+static ssize_t vcom_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int ret;
+	int vcom;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = kstrtoint(buf, 0, &vcom);
+	if (ret)
+		return ret;
+
+	if (vcom > 0 || vcom < -5000)
+		return -EINVAL;
+
+	ret = sy7636a_set_vcom_voltage_mv(sy7636a->regmap, (unsigned int)(-vcom));
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR(vcom, 0644, vcom_show, vcom_store);
+
+static struct attribute *sy7636a_sysfs_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_power_good.attr,
+	&dev_attr_vcom.attr,
+	NULL,
+};
+
+static const struct attribute_group sy7636a_sysfs_attr_group = {
+	.attrs = sy7636a_sysfs_attrs,
+};
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
+	ret = sysfs_create_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to create sysfs attributes\n");
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
+					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
+					NULL, 0, NULL);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to add child devices\n");
+		sysfs_remove_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
+		return ret;
+	}
+
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
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
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
2.30.1

