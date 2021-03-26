Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16207349F38
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhCZBz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:55:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46967 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230338AbhCZBz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:55:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 90C555C00C3;
        Thu, 25 Mar 2021 21:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Mar 2021 21:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=U42XMEltCqNfz
        khiNByetXmRC9NvjCoD0DXkeqTHQmg=; b=mJsjjyZQ0fzxuUEwZctyW/3m5zzGq
        OUyAwmxihnh1R39S7Ju5RJD6/S5RIIhU85PqjLGHTHmrzWIpMP8IE4kD8J9OJSzQ
        HhiqhOkJjWybFB34gL1kGtTVYW8Rtc8/xY/hRRoWEYUfX3O3c4nI1O8CNREYMj9f
        7C0Wfz/vuY2NK9Yp5LVv8wq2GWkT+FTRP/h1STUeCdlveh0+BfbQqWW67rCxuTjB
        OWKJFKDTQYJjSWd0TXmV72sED/4AqrYgI5OsGgcBU5RRBc20DbIfOPUAYA0K7Ggp
        7dLl0OZelzVtnU/7XspkonSmyf5BBUgEqVi4FWnqtO2sfxRtJOHqxo11Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=U42XMEltCqNfzkhiNByetXmRC9NvjCoD0DXkeqTHQmg=; b=fsi1rjpd
        ltJrid0w1cyqoCkAfkwa0klpZ+HhWHDfic3oPevkegKOEmF+PZjjYYi7ABvQGA6X
        WY/V201Mr5Io73FwIwCUamW5OLQcH+wyxILXXo1lvMj28AHlyRPVYTf8E0chQUlZ
        t97YPbJJ+KVWXZ6LdHS+SrZG/NeVh+omb2COn5DO6JEfUNfVkf5cvAVGuEh6F51F
        WDJzvq/DXnazrzzyI4AeKMnRHMt46zmIra8A6sfp2xWY5YuJFwbFWGlQxiFBeAaP
        6mzCDJr1TgA4f16d438zXHFKdJ6pkCrPOQ5SGIOEFnzqMfQGiH0BMUaa5D62kaGy
        POcZyfsLUgX0oQ==
X-ME-Sender: <xms:Dz9dYJaUwfOWcfiJW3Uu2hRTfoMpQNEplxxyn5RU5mzACznf06spxg>
    <xme:Dz9dYEFJpLr_7NkSpo-VTEbMHgtkMohZW0vHlHF2Ixwqrhxo_hjR8KyLjfQvpF9XK
    lojYaTxgbobYKRvg3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeduleefrddvjedrudefrddvfeehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:Dz9dYFzxckA7podInh1_NGDUH4u-eq6hEK8BaAWB5wgb1Zgs_W1IrA>
    <xmx:Dz9dYOnbhuIFUUTNHGGsBl01w9GQBw02ulAK1CIfwHZMml4RTzcKdw>
    <xmx:Dz9dYGnHQMzBa5tKhDODqPG_Vv0kAdRjwGBwTQk4AMg9nssFNYahQA>
    <xmx:Dz9dYIk5pIe-mc01ylIeh_rI4qNKENM58s5v1hK3iG3g_5s_s3c4uw>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BB1B1080054;
        Thu, 25 Mar 2021 21:55:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 3/5] regulator: sy7636a: Initial commit
Date:   Thu, 25 Mar 2021 21:55:09 -0400
Message-Id: <20210326015511.218-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326015511.218-1-alistair@alistair23.me>
References: <20210326015511.218-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A-regulator Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v3:
 - Move sysfs power from mfd to regulaator
 - Add ABI documentation
v2:
 - N/A
 .../testing/sysfs-driver-sy7636a-regulator    |  21 ++
 drivers/regulator/Kconfig                     |   6 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sy7636a-regulator.c         | 354 ++++++++++++++++++
 include/linux/mfd/sy7636a.h                   |   1 +
 5 files changed, 383 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-sy7636a-regulator
 create mode 100644 drivers/regulator/sy7636a-regulator.c

diff --git a/Documentation/ABI/testing/sysfs-driver-sy7636a-regulator b/Documentation/ABI/testing/sysfs-driver-sy7636a-regulator
new file mode 100644
index 000000000000..ab534a8ea21a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-sy7636a-regulator
@@ -0,0 +1,21 @@
+What:		/sys/bus/regulator/drivers/sy7636a-regulator/state
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	alistair@alistair23.me
+Description:
+		This file allows you to see the current power rail state.
+
+What:		/sys/bus/regulator/drivers/sy7636a-regulator/power_good
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	alistair@alistair23.me
+Description:
+		This file allows you to see the current state of the regulator
+		as either ON or OFF.
+
+What:		/sys/bus/regulator/drivers/sy7636a-regulator/vcom
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	alistair@alistair23.me
+Description:
+		This file allows you to see and set the current voltage in mV.
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 77c43134bc9e..6d501ce921a8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1130,6 +1130,12 @@ config REGULATOR_STW481X_VMMC
 	  This driver supports the internal VMMC regulator in the STw481x
 	  PMIC chips.
 
+config REGULATOR_SY7636A
+	tristate "Silergy SY7636A voltage regulator"
+	depends on MFD_SY7636A
+	help
+	  This driver supports Silergy SY3686A voltage regulator.
+
 config REGULATOR_SY8106A
 	tristate "Silergy SY8106A regulator"
 	depends on I2C && (OF || COMPILE_TEST)
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 44d2f8bf4b74..5a981036a9f0 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
 obj-$(CONFIG_REGULATOR_SY8827N) += sy8827n.o
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
new file mode 100644
index 000000000000..0ec6f852cb3d
--- /dev/null
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Functions to access SY3686A power management chip voltages
+//
+// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+//
+// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+//          Alistair Francis <alistair@alistair23.me>
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/sy7636a.h>
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
+static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
+{
+	return sy7636a_get_vcom_voltage_mv(rdev->regmap);
+}
+
+static int sy7636a_disable_regulator(struct regulator_dev *rdev)
+{
+	int ret = 0;
+
+	ret = regulator_disable_regmap(rdev);
+	// Delay for ~35ms after disabling the regulator, to allow power ramp
+	// down to go undisturbed
+	usleep_range(30000, 35000);
+
+	return ret;
+}
+
+static int sy7636a_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	return regulator_is_enabled_regmap(rdev);
+}
+
+static int sy7636a_get_status(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int pwr_good = 0;
+	const unsigned int wait_time = 500;
+	unsigned int wait_cnt;
+	int ret = 0;
+
+	for (wait_cnt = 0; wait_cnt < wait_time; wait_cnt++) {
+		pwr_good = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
+		if (pwr_good < 0) {
+			dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", pwr_good);
+			ret = pwr_good;
+			return ret;
+		} else if (pwr_good)
+			break;
+
+		usleep_range(1000, 1500);
+	}
+
+	return ret;
+}
+
+static int sy7636a_enable_regulator_pgood(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int pwr_good = 0;
+	int ret = 0;
+	unsigned long t0, t1;
+	const unsigned int wait_time = 500;
+	unsigned int wait_cnt;
+
+	t0 = jiffies;
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret)
+		goto finish;
+
+	for (wait_cnt = 0; wait_cnt < wait_time; wait_cnt++) {
+		pwr_good = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
+		if (pwr_good < 0) {
+			dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", pwr_good);
+			ret = pwr_good;
+			goto finish;
+		} else if (pwr_good)
+			break;
+
+		usleep_range(1000, 1500);
+	}
+
+	t1 = jiffies;
+
+	if (!pwr_good) {
+		dev_err(&rdev->dev, "Power good signal timeout after %u ms\n",
+				jiffies_to_msecs(t1 - t0));
+		ret = -ETIME;
+		sy7636a_disable_regulator(rdev);
+		goto finish;
+	}
+
+	ret = sysfs_create_group(&rdev->dev.kobj, &sy7636a_sysfs_attr_group);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to create sysfs attributes\n");
+		return ret;
+	}
+
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to add child devices\n");
+		sysfs_remove_group(&rdev->dev.kobj, &sy7636a_sysfs_attr_group);
+		return ret;
+	}
+
+	dev_dbg(&rdev->dev, "Power good OK (took %u ms, %u waits)\n",
+		jiffies_to_msecs(t1 - t0),
+		wait_cnt);
+
+finish:
+	return ret;
+}
+
+static const struct regulator_ops sy7636a_vcom_volt_ops = {
+	.get_voltage = sy7636a_get_vcom_voltage_op,
+	.enable = sy7636a_enable_regulator_pgood,
+	.disable = sy7636a_disable_regulator,
+	.is_enabled = sy7636a_regulator_is_enabled,
+	.get_status = sy7636a_get_status,
+};
+
+struct regulator_desc desc = {
+	.name = "vcom",
+	.id = 0,
+	.ops = &sy7636a_vcom_volt_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
+	.enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
+	.regulators_node = of_match_ptr("regulators"),
+	.of_match = of_match_ptr("vcom"),
+};
+
+static int sy7636a_regulator_init(struct sy7636a *sy7636a)
+{
+	return regmap_write(sy7636a->regmap,
+				SY7636A_REG_POWER_ON_DELAY_TIME,
+				0x0);
+}
+
+static int sy7636a_regulator_probe(struct platform_device *pdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct gpio_desc *gdp;
+	int ret;
+
+	if (!sy7636a)
+		return -EPROBE_DEFER;
+
+	platform_set_drvdata(pdev, sy7636a);
+
+	gdp = devm_gpiod_get(sy7636a->dev, "epd-pwr-good", GPIOD_IN);
+	if (IS_ERR(gdp)) {
+		dev_err(sy7636a->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
+		return PTR_ERR(gdp);
+	}
+
+	sy7636a->pgood_gpio = gdp;
+
+	ret = sy7636a_regulator_init(sy7636a);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to initialize regulator: %d\n", ret);
+		return ret;
+	}
+
+	config.dev = &pdev->dev;
+	config.dev->of_node = sy7636a->dev->of_node;
+	config.driver_data = sy7636a;
+	config.regmap = sy7636a->regmap;
+
+	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(sy7636a->dev, "Failed to register %s regulator\n",
+			pdev->name);
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id sy7636a_regulator_id_table[] = {
+	{ "sy7636a-regulator", },
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
+
+static struct platform_driver sy7636a_regulator_driver = {
+	.driver = {
+		.name = "sy7636a-regulator",
+	},
+	.probe = sy7636a_regulator_probe,
+	.id_table = sy7636a_regulator_id_table,
+};
+module_platform_driver(sy7636a_regulator_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("SY7636A voltage regulator driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
index a5ec5d911b3a..1f8d7507a700 100644
--- a/include/linux/mfd/sy7636a.h
+++ b/include/linux/mfd/sy7636a.h
@@ -41,6 +41,7 @@
 struct sy7636a {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *pgood_gpio;
 };
 
 #endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.0

