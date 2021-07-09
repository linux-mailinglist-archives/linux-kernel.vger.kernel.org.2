Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62713C26FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhGIPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:43:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0EC0613E6;
        Fri,  9 Jul 2021 08:40:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso6311570pjb.0;
        Fri, 09 Jul 2021 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42xmxQQv5j3gpKzBiG4S4LnFOaJ5sPb/t9LZ9F41LmU=;
        b=EYlU43Fuvw/pFU05LbRtUa2/y30s4fSy+gesXzBeMOfbnGPxkWmnihj6ZbFri6J3lc
         zZ6bLn7mADZBvG/VjrSVjnb26Bhtp9KDvYZv3hs4K4lUwUrzAP+H0HGNqOak0TfcS9iJ
         J5T7w7r9obAENO1KAwm3qPbdJEyZ7MIGVwNIkqpy6qY5AymvJaowxPqzQpuNLF7W3tdn
         8/Etzedzm8I/2tYe3d14LzfebkL7/nbZmFwAALuGJ/pmo+vIrQGJlYRdPyQvI3wNk/25
         LGTnga2R6TApvkFi+lo7tWSvQ2qCCCvxxGGMZ4Inp5veJgefhMOnYKiMbZi9leni0XGl
         i4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42xmxQQv5j3gpKzBiG4S4LnFOaJ5sPb/t9LZ9F41LmU=;
        b=lK07C5qUf7jJPa41e+8e4pNXHWNfa2Aakld7W+q15CVLEZDjN10gxwAUtWrmazkiUV
         hmz/RlLOFJdADvOpjeYSPtnqkOPeiakNQ7dEkR87qfpDGT4K64S5PdZLz+2EfSdBpxS4
         VNYssWw24C2Oy8GrEcOaVku3HwVBcs8nqVYHkH16ZNpjUt7Z4Y+ZWVB18rtTNGXHhRpx
         1wz3QuFmg8eBei3tWKiEeTS6YTnp/jUz6U62IR1VS2H1HzZlSZemszUAq0DazNjB3C1c
         lG0cIS5htYVTzjUlLPiHVwqWcT7xrFAzYuiX39J8WPwu8/s2RxtkZKDytxaR/nl0Uztk
         XUrQ==
X-Gm-Message-State: AOAM531qrbnDnTNsqtXO9IrBtfrOZ9n8xeJZ7bLv6EbSULXApqw7EHVe
        w5T4c3zPDMql+7axpbk5b58XZ0MzHQIdlA==
X-Google-Smtp-Source: ABdhPJxgGukqYLQi4J1sT+AEeeVK1dFmNOcJ3U+YFzsvbHJ6PkzzL/6Yx6iERR4wdvq538+Gl+3RQg==
X-Received: by 2002:a17:90a:ce8a:: with SMTP id g10mr10972899pju.169.1625845255257;
        Fri, 09 Jul 2021 08:40:55 -0700 (PDT)
Received: from localhost.localdomain (1-171-0-5.dynamic-ip.hinet.net. [1.171.0.5])
        by smtp.gmail.com with ESMTPSA id g11sm8314703pgj.3.2021.07.09.08.40.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 08:40:54 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: rt6752: Add support for Richtek RTQ6752
Date:   Fri,  9 Jul 2021 23:40:36 +0800
Message-Id: <1625845236-30285-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
References: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add suport for Richtek RTQ6752.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig             |   9 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/rtq6752-regulator.c | 285 ++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/regulator/rtq6752-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 24ce9a1..6562d4c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1066,6 +1066,15 @@ config REGULATOR_RTMV20
 	  the Richtek RTMV20. It can support the load current up to 6A and
 	  integrate strobe/vsync/fsin signal to synchronize the IR camera.
 
+config REGULATOR_RTQ6752
+	tristate "Richtek RTQ6752 TFT LCD voltage regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver adds support for Richtek RTQ6752. RTQ6752 includes two
+	  synchronous boost converters for PAVDD, and one synchronous NAVDD
+	  buck-boost. This device is suitable for automotive TFT-LCD panel.
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8c2f822..102b2a0 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT6160)	+= rt6160-regulator.o
 obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
+obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
new file mode 100644
index 00000000..fe31597
--- /dev/null
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+enum {
+	RTQ6752_IDX_PAVDD = 0,
+	RTQ6752_IDX_NAVDD = 1,
+	RTQ6752_IDX_MAX
+};
+
+#define RTQ6752_REG_PAVDD	0x00
+#define RTQ6752_REG_NAVDD	0x01
+#define RTQ6752_REG_PAVDDONDLY	0x07
+#define RTQ6752_REG_PAVDDSSTIME	0x07
+#define RTQ6752_REG_NAVDDONDLY	0x0D
+#define RTQ6752_REG_NAVDDSSTIME	0x0E
+#define RTQ6752_REG_OPTION1	0x12
+#define RTQ6752_REG_CHSWITCH	0x16
+#define RTQ6752_REG_FAULT	0x1D
+
+#define RTQ6752_VOUT_MASK	GENMASK(5, 0)
+#define RTQ6752_NAVDDEN_MASK	BIT(3)
+#define RTQ6752_PAVDDEN_MASK	BIT(0)
+#define RTQ6752_PAVDDAD_MASK	BIT(4)
+#define RTQ6752_NAVDDAD_MASK	BIT(3)
+#define RTQ6752_PAVDDF_MASK	BIT(3)
+#define RTQ6752_NAVDDF_MASK	BIT(0)
+#define RTQ6752_ENABLE_MASK	(BIT(RTQ6752_IDX_MAX) - 1)
+
+#define RTQ6752_VOUT_MINUV	5000000
+#define RTQ6752_VOUT_STEPUV	50000
+#define RTQ6752_VOUT_NUM	47
+#define RTQ6752_I2CRDY_TIMEUS	1000
+#define RTQ6752_MINSS_TIMEUS	5000
+
+struct rtq6752_priv {
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	struct mutex lock;
+	unsigned char enable_flag;
+};
+
+static int rtq6752_set_vdd_enable(struct regulator_dev *rdev)
+{
+	struct rtq6752_priv *priv = rdev_get_drvdata(rdev);
+	int rid = rdev_get_id(rdev), ret;
+
+	mutex_lock(&priv->lock);
+	if (!priv->enable_flag && priv->enable_gpio) {
+		gpiod_set_value(priv->enable_gpio, 1);
+
+		usleep_range(RTQ6752_I2CRDY_TIMEUS,
+			     RTQ6752_I2CRDY_TIMEUS + 100);
+
+		regcache_cache_only(priv->regmap, false);
+		ret = regcache_sync(priv->regmap);
+		if (ret) {
+			mutex_unlock(&priv->lock);
+			return ret;
+		}
+	}
+
+	priv->enable_flag |= BIT(rid);
+	mutex_unlock(&priv->lock);
+
+	return regulator_enable_regmap(rdev);
+}
+
+static int rtq6752_set_vdd_disable(struct regulator_dev *rdev)
+{
+	struct rtq6752_priv *priv = rdev_get_drvdata(rdev);
+	int rid = rdev_get_id(rdev), ret;
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&priv->lock);
+	priv->enable_flag &= ~BIT(rid);
+
+	if (!priv->enable_flag && priv->enable_gpio) {
+		regcache_cache_only(priv->regmap, true);
+		regcache_mark_dirty(priv->regmap);
+
+		gpiod_set_value(priv->enable_gpio, 0);
+	}
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rtq6752_get_error_flags(struct regulator_dev *rdev,
+				   unsigned int *flags)
+{
+	unsigned int val, events = 0;
+	const unsigned int fault_mask[] = {
+		RTQ6752_PAVDDF_MASK, RTQ6752_NAVDDF_MASK };
+	int rid = rdev_get_id(rdev), ret;
+
+	ret = regmap_read(rdev->regmap, RTQ6752_REG_FAULT, &val);
+	if (ret)
+		return ret;
+
+	if (val & fault_mask[rid])
+		events = REGULATOR_ERROR_REGULATION_OUT;
+
+	*flags = events;
+	return 0;
+}
+
+static const struct regulator_ops rtq6752_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = rtq6752_set_vdd_enable,
+	.disable = rtq6752_set_vdd_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_error_flags = rtq6752_get_error_flags,
+};
+
+static const struct regulator_desc rtq6752_regulator_descs[] = {
+	{
+		.name = "rtq6752-pavdd",
+		.of_match = of_match_ptr("pavdd"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RTQ6752_IDX_PAVDD,
+		.n_voltages = RTQ6752_VOUT_NUM,
+		.ops = &rtq6752_regulator_ops,
+		.owner = THIS_MODULE,
+		.min_uV = RTQ6752_VOUT_MINUV,
+		.uV_step = RTQ6752_VOUT_STEPUV,
+		.enable_time = RTQ6752_MINSS_TIMEUS,
+		.vsel_reg = RTQ6752_REG_PAVDD,
+		.vsel_mask = RTQ6752_VOUT_MASK,
+		.enable_reg = RTQ6752_REG_CHSWITCH,
+		.enable_mask = RTQ6752_PAVDDEN_MASK,
+		.active_discharge_reg = RTQ6752_REG_OPTION1,
+		.active_discharge_mask = RTQ6752_PAVDDAD_MASK,
+		.active_discharge_off = RTQ6752_PAVDDAD_MASK,
+	},
+	{
+		.name = "rtq6752-navdd",
+		.of_match = of_match_ptr("navdd"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RTQ6752_IDX_NAVDD,
+		.n_voltages = RTQ6752_VOUT_NUM,
+		.ops = &rtq6752_regulator_ops,
+		.owner = THIS_MODULE,
+		.min_uV = RTQ6752_VOUT_MINUV,
+		.uV_step = RTQ6752_VOUT_STEPUV,
+		.enable_time = RTQ6752_MINSS_TIMEUS,
+		.vsel_reg = RTQ6752_REG_NAVDD,
+		.vsel_mask = RTQ6752_VOUT_MASK,
+		.enable_reg = RTQ6752_REG_CHSWITCH,
+		.enable_mask = RTQ6752_NAVDDEN_MASK,
+		.active_discharge_reg = RTQ6752_REG_OPTION1,
+		.active_discharge_mask = RTQ6752_NAVDDAD_MASK,
+		.active_discharge_off = RTQ6752_NAVDDAD_MASK,
+	}
+};
+
+static int rtq6752_init_device_properties(struct rtq6752_priv *priv)
+{
+	u8 raw_vals[] = { 0, 0 };
+	int ret;
+
+	/* Configure PAVDD on and softstart delay time to the minimum */
+	ret = regmap_raw_write(priv->regmap, RTQ6752_REG_PAVDDONDLY, raw_vals,
+			       ARRAY_SIZE(raw_vals));
+	if (ret)
+		return ret;
+
+	/* Configure NAVDD on and softstart delay time to the minimum */
+	return regmap_raw_write(priv->regmap, RTQ6752_REG_NAVDDONDLY, raw_vals,
+				ARRAY_SIZE(raw_vals));
+}
+
+static bool rtq6752_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == RTQ6752_REG_FAULT)
+		return true;
+	return false;
+}
+
+static const struct reg_default rtq6752_reg_defaults[] = {
+	{ RTQ6752_REG_PAVDD, 0x14 },
+	{ RTQ6752_REG_NAVDD, 0x14 },
+	{ RTQ6752_REG_PAVDDONDLY, 0x01 },
+	{ RTQ6752_REG_PAVDDSSTIME, 0x01 },
+	{ RTQ6752_REG_NAVDDONDLY, 0x01 },
+	{ RTQ6752_REG_NAVDDSSTIME, 0x01 },
+	{ RTQ6752_REG_OPTION1, 0x07 },
+	{ RTQ6752_REG_CHSWITCH, 0x29 },
+};
+
+static const struct regmap_config rtq6752_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = RTQ6752_REG_FAULT,
+	.reg_defaults = rtq6752_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rtq6752_reg_defaults),
+	.volatile_reg = rtq6752_is_volatile_reg,
+};
+
+static int rtq6752_probe(struct i2c_client *i2c)
+{
+	struct rtq6752_priv *priv;
+	struct regulator_config reg_cfg = {};
+	struct regulator_dev *rdev;
+	int i, ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+
+	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio)) {
+		dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
+		return PTR_ERR(priv->enable_gpio);
+	}
+
+	usleep_range(RTQ6752_I2CRDY_TIMEUS, RTQ6752_I2CRDY_TIMEUS + 100);
+	/* Default EN pin to high, PAVDD and NAVDD will be on */
+	priv->enable_flag = RTQ6752_ENABLE_MASK;
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &rtq6752_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&i2c->dev, "Failed to init regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	ret = rtq6752_init_device_properties(priv);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to init device properties\n");
+		return ret;
+	}
+
+	reg_cfg.dev = &i2c->dev;
+	reg_cfg.regmap = priv->regmap;
+	reg_cfg.driver_data = priv;
+
+	for (i = 0; i < ARRAY_SIZE(rtq6752_regulator_descs); i++) {
+		rdev = devm_regulator_register(&i2c->dev,
+					       rtq6752_regulator_descs + i,
+					       &reg_cfg);
+		if (IS_ERR(rdev)) {
+			dev_err(&i2c->dev, "Failed to init %d regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rtq6752_device_table[] = {
+	{ .compatible = "richtek,rtq6752", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq6752_device_table);
+
+static struct i2c_driver rtq6752_driver = {
+	.driver = {
+		.name = "rtq6752",
+		.of_match_table = rtq6752_device_table,
+	},
+	.probe_new = rtq6752_probe,
+};
+module_i2c_driver(rtq6752_driver);
+
+MODULE_AUTHOR("ChiYuan Hwang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ6752 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

