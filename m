Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415D3A7C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFOKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:36:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55675 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231766AbhFOKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 44A685C0116;
        Tue, 15 Jun 2021 06:34:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 15 Jun 2021 06:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=yKGaVzsaPWa0k
        OpHRXY5NUqTSi5jxQ0vLAr+VFLu1Xs=; b=CLsuttwYXhXPU9MQxTdB1AHrXCv3L
        DG+/QygRo0hhVhLFcF7OfLGv/YDsoIjqB2i82YLH0pTkNYri3oJuxD0lPYMtsRey
        hSAvhSj4I9JIuSw7i/VZfhGpvlDnoLYzg3cZscRaeT85+UX26NgR9avg9YLABtwS
        bzQAfnBE2G/mKNV6uVFRaNNxhHPO3nK3M62XMMm3hd7DmQtqxNMpcUcc8aqHrUrA
        YaX1SarL3dFlg2I+/UqXWeaeoDCeu7AnrzrKxpkDNh7BLbglth6GVl0u69wNu9yu
        h34d0hchsu8SF853Zjk7mE0Ya/b6hTUHwzjds2sL3v9JKsCSHa1/kFLtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yKGaVzsaPWa0kOpHRXY5NUqTSi5jxQ0vLAr+VFLu1Xs=; b=PxWy89yh
        iixT/JRhovJzWYHb0+czdk6PtbVwAWJycN/Z5mZHy2H7nnv9uTdzIpFxyUocwhik
        DkxYdwDNmV2HBDxGs5t73lkWCi6TL17as6GkYTKXm98Z9YQxrGHWapCCqLcRA5la
        /thBMGpD64Y6ytnfY2DZaHI2zzqUas/CcTxI/KnERbqu93Hhl2IkKcox44xoeTtn
        yxAAQGmo5nDkOK+h24o2RQOp9ZsD8aR3889xO2c3hp1D/gIKgDH6Pj3mto13feKN
        YxwLB1qv4UNPFj0+x2X2HHcEKdPNFSGEgTRknVPCFln/UiO6WgTXguIBkWGU+c1f
        yzPEggaY54KQXA==
X-ME-Sender: <xms:N4LIYFIs9jYzZ9TaRcbqU4BlLXR9ykvWgqCxswnkgoyNa8SyupK-Qw>
    <xme:N4LIYBKnMNKLFgi1MyWMh7ZPfFlw_E_GbZgmWPeghrIuOdXZydSMGN-zTiLQsWjRx
    PDGc5Flwi36Wxc6WOU>
X-ME-Received: <xmr:N4LIYNumycyMgmc-etn6jBhEcBfjHXhhKZHpzBsJM_S9iDRNT6hMiYMELgr9pGiWHLKA3wiRUOcBD6pv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:N4LIYGY5jF6-9CS8kOgLWLy4oftU9Bk9YJP3ZjjY9L4VOpDP4IWXLg>
    <xmx:N4LIYMbYkdclHJAGeUGcXgHPTOChSVgVcku2w7_odSWe9DjqWmAdKg>
    <xmx:N4LIYKDMSd3CzZ43eTmMxxj6l1FLZJvsM_Ppqi0hvRZjqTqohQTt3w>
    <xmx:N4LIYM4ZOiZzaajG5qbHoG4Kp37YiAq7AK2V5Gqk5I7GNes5pl4_-w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 06:34:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 3/5] regulator: sy7636a: Initial commit
Date:   Tue, 15 Jun 2021 20:33:58 +1000
Message-Id: <20210615103400.946-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615103400.946-1-alistair@alistair23.me>
References: <20210615103400.946-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A-regulator Power Management chip.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             |   6 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/sy7636a-regulator.c | 127 ++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/regulator/sy7636a-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3e7a38525cb3..ebb968e8b2b0 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1150,6 +1150,12 @@ config REGULATOR_STW481X_VMMC
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
index 580b015296ea..b17c24d93f3b 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
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
-- 
2.31.1

