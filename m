Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7861F363DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhDSIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56909 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233403AbhDSIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 395825C00F0;
        Mon, 19 Apr 2021 04:40:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ktS/NNT3m5Mu5
        w/q9/9KYu7yuC8VOkZAl8GQ2tTtOk8=; b=WRbqXWFUxd68KQDnnQRD3oEM2Amny
        lcd3hEmamuY+wP8alXWKaGH9tQaO6Xo05oyD8nHbwXe0t2xzrL+5LJZVvXDjHnOu
        Ewvr5Iu6PeBhxinqK+RzmGc6f0VJHZCfOmzRLE0A40l77OzTR5duvg2bmewhw6W2
        GO+ibCKqCvkqDlmOr9C4vIWVzdyQ5tCK0NW555uxeQYMCLh+9qXUZQgQnP/sHFVM
        ZqVy8hBov0ZG3DNRXL7xpqlbcMlAogCX7D3nwEgry9Gs9NSwBRnNECm5pu8C6ndH
        Swsw6fuqDLEWmJxrs3TLpqNkM5VXBXE9grY5e5ExcptJqufFP27WueITg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ktS/NNT3m5Mu5w/q9/9KYu7yuC8VOkZAl8GQ2tTtOk8=; b=UdzUTy5n
        6e2Wk5zBy7yNFxYC96M+SaIsbM9bRvhP0+c+DTHsc/iwzK7Vf2A6CiEBWYi6vMLa
        2nMkZ7Ow9OPjMwBKQF7W2f9JnlaVpBhTdNh1/3Q7wYnaI9PVVKUFbT0YgKIa897R
        lZracxuthYFcSpxS8X9zYg0vWN+oMVvPXwhXfagR/Dc/RFcPbZVOJy1OQWf1d/x4
        hm7vl8FVXTNnZyncrCLq5OZUvNmyr3goHv+FDbHGrYdXmkoumCiEOYFs5eDJPB5B
        W56xZciAp1cPIdIEgIxX4n4+y4wlV6ktpfzUEIe5haaGoKFsCB/Zd4qlZ3N4yEOS
        7R6FNX97h5XC5Q==
X-ME-Sender: <xms:DEJ9YAfRbwlKraA8s4871MCZHI9UrjI6mkMC9_rjeTh42Ey2NV3YqA>
    <xme:DEJ9YCNm0oYyYlNCSJC73HdGAwjWPyOCKLj9QlOqkVqYqmuufQ-QncDGQIbH2QLVn
    BWlUSanyTSxKZOthbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeekledrgeegrddutddruddvfeenucevlh
    hushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:DEJ9YBhH_ejAKcRmbNo_58yYY64-eGTPhKAg2Hne8GKQyf38TFLIYA>
    <xmx:DEJ9YF9BumAfaQ-Xw08oBi_pe0USSY5a7bLHhJMXRcXPs3wiyyr8gA>
    <xmx:DEJ9YMvz4Gca9NEyVTknWNoqf7yxqWTN0Xgc8x1EvG2ffryhnXu2MQ>
    <xmx:DEJ9YAiGn0fN7Tg0RUYFwLHXOM_ruy3wBWXfEYlLxTUpn4IIKowPBg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2E6E1080057;
        Mon, 19 Apr 2021 04:40:40 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 3/5] regulator: sy7636a: Initial commit
Date:   Mon, 19 Apr 2021 07:02:20 +1000
Message-Id: <20210418210222.2945-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418210222.2945-1-alistair@alistair23.me>
References: <20210418210222.2945-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A-regulator Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v5:
 - Simplify the implementation

 drivers/regulator/Kconfig             |   6 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/sy7636a-regulator.c | 127 ++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h           |   1 +
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/regulator/sy7636a-regulator.c

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
index 000000000000..c384c2b6ac46
--- /dev/null
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -0,0 +1,127 @@
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
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/sy7636a.h>
+
+#define SY7636A_POLL_ENABLED_TIME 500
+
+static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val, val_h;
+
+	ret = regmap_read(rdev->regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, &val_h);
+	if (ret)
+		return ret;
+
+	val |= (val_h << VCOM_ADJUST_CTRL_SHIFT);
+
+	return (val & VCOM_ADJUST_CTRL_MASK) * VCOM_ADJUST_CTRL_SCAL;
+}
+
+static int sy7636a_get_status(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int ret = 0;
+
+	ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
+	if (ret < 0)
+		dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", ret);
+
+	return ret;
+}
+
+static const struct regulator_ops sy7636a_vcom_volt_ops = {
+	.get_voltage = sy7636a_get_vcom_voltage_op,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
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
+	.poll_enabled_time	= SY7636A_POLL_ENABLED_TIME,
+	.regulators_node = of_match_ptr("regulators"),
+	.of_match = of_match_ptr("vcom"),
+};
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
+	ret = regmap_write(sy7636a->regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
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
index 43b0db0f8e6d..8e71a6e21791 100644
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
2.31.1

