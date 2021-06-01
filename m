Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63437396D60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhFAGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhFAGfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:35:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3EDC061574;
        Mon, 31 May 2021 23:33:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 11so2829121plk.12;
        Mon, 31 May 2021 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWE2hRciUWjd3pFO88mP2PlfmGxlR3eWRLBl22ws0ZY=;
        b=fdpGLwpVfsJFq72v8MYvi57KFh7d+hcYTokn2VxkxKWSLMPW6VY6YeaK9Si+fwqZ8l
         GzyOJxEvHvIhSp4MfZ2XufobhdYblo86elkfFsxziohu3jxCsVlg6nWjTuB4uZQRjyPS
         Vxna8shCwpN/IDmJj61IPojzarDi+SqtotbJzZqtW68HQhbYv0Mo2du2ogOyYLsRdIz5
         NmeR3JujXJ4tBhx7QQ7cOaVVQ4xRrKw6r9Wkfk1AZA+EMeTdGXLK6omhdPEu8zP91HcZ
         Vdylihw/qHt5uiuEuo7FqjhheXUoM2yz0+4X/MzddYKA93412ljCZoNDIfp0Jnzy3oac
         r+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWE2hRciUWjd3pFO88mP2PlfmGxlR3eWRLBl22ws0ZY=;
        b=KwZE59pFZRnnV5/N1BFHvipztBaEGyBXzz8qreUkiguj2MJoTeB8Cc8Rlf3TiPjMey
         KU8/eiSw0Ezh7Ztgk2ljM7OKqj3CwPX86zLk3ymhYNPFjwD3Zdk7uRMa+zc1X5KF+qEN
         b82cPQLZStGK/2QQ9rp7VFlDY/bGUx+z4IcZLGY9JhahGOhe7amKCnU+dc0q34w1TDLH
         E2LChNDxuUnZFBRz05Iiwx65U+9qWKIEU0GHDACFyyq9ix/Q79RWHtO7J4bEez/7Dguc
         lAXISxw+7l7obCOdgSx5fWhufrIHAY+/hetfrebKbLHF8o3DGoGR2n6h7R+YbQfaasqE
         EPHA==
X-Gm-Message-State: AOAM533Ueo6Cw7BwZxOjKsJ/E73/vOXUynpw/K6UDjzQSpFK+ACyKnG2
        //HiIJNicH9RWGiqGSamNEo=
X-Google-Smtp-Source: ABdhPJwJwS8FSzcDTgA1UcdDz5yv67MMyO/0KpK2MEHL6P6qixUuUDqzZDllSRg40HMD4TY5kLGwNw==
X-Received: by 2002:a17:90a:f197:: with SMTP id bv23mr8066287pjb.113.1622529207705;
        Mon, 31 May 2021 23:33:27 -0700 (PDT)
Received: from localhost.localdomain (1-171-14-152.dynamic-ip.hinet.net. [1.171.14.152])
        by smtp.gmail.com with ESMTPSA id x22sm4982747pfn.10.2021.05.31.23.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 May 2021 23:33:27 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] regulator: rt6160: Add support for Richtek RT6160
Date:   Tue,  1 Jun 2021 14:32:47 +0800
Message-Id: <1622529167-25852-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622529167-25852-1-git-send-email-u0084500@gmail.com>
References: <1622529167-25852-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add support for Richtek RT6160 voltage regulator. It can provide up
to 3A output current within the adjustable voltage from 2025mV
to 5200mV. It integrate a buckboost converter to support wide input
voltage range from 2200mV to 5500mV.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v5
- Add 'enable" gpio control into regulator enable/disable.
- Refine regulator ramp delay ops.
- Due to 'enable' gpio H to L cause register reset, use regcache.

since v4
- Add of_node into regulator_config to fix regulator_get by device tree node parsing.

since v3
- Use more header file like as of_regulator.h and property.h.
- Change the parsing string from 'richtek,vsel_active_low' to 'richtek,vsel-active-low'.
- Use of_get_regulator_init_data to get the regulator init_data.

since v2
- Fix W=1 warning for of_device_id.
---
 drivers/regulator/Kconfig            |  11 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt6160-regulator.c | 327 +++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 drivers/regulator/rt6160-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9d84d92..4fe7ddc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1030,6 +1030,17 @@ config REGULATOR_RT5033
 	  RT5033 PMIC. The device supports multiple regulators like
 	  current source, LDO and Buck.
 
+config REGULATOR_RT6160
+	tristate "Richtek RT6160 BuckBoost voltage regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This adds support for voltage regulator in Richtek RT6160.
+	  This device automatically change voltage output mode from
+	  Buck or Boost. The mode transistion depend on the input source voltage.
+	  The wide output range is from 2025mV to 5200mV and can be used on most
+	  common application scenario.
+
 config REGULATOR_RTMV20
 	tristate "RTMV20 Laser Diode Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 580b015..5b2c93e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
 obj-$(CONFIG_REGULATOR_RT4801)	+= rt4801-regulator.o
 obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
+obj-$(CONFIG_REGULATOR_RT6160)	+= rt6160-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
new file mode 100644
index 00000000..3937da1
--- /dev/null
+++ b/drivers/regulator/rt6160-regulator.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define RT6160_MODE_AUTO	0
+#define RT6160_MODE_FPWM	1
+
+#define RT6160_REG_CNTL		0x01
+#define RT6160_REG_STATUS	0x02
+#define RT6160_REG_DEVID	0x03
+#define RT6160_REG_VSELL	0x04
+#define RT6160_REG_VSELH	0x05
+#define RT6160_NUM_REGS		(RT6160_REG_VSELH + 1)
+
+#define RT6160_FPWM_MASK	BIT(3)
+#define RT6160_RAMPRATE_MASK	GENMASK(1, 0)
+#define RT6160_VID_MASK		GENMASK(7, 4)
+#define RT6160_VSEL_MASK	GENMASK(6, 0)
+#define RT6160_HDSTAT_MASK	BIT(4)
+#define RT6160_UVSTAT_MASK	BIT(3)
+#define RT6160_OCSTAT_MASK	BIT(2)
+#define RT6160_TSDSTAT_MASK	BIT(1)
+#define RT6160_PGSTAT_MASK	BIT(0)
+
+#define RT6160_VENDOR_ID	0xA0
+#define RT6160_VOUT_MINUV	2025000
+#define RT6160_VOUT_MAXUV	5200000
+#define RT6160_VOUT_STPUV	25000
+#define RT6160_N_VOUTS		((RT6160_VOUT_MAXUV - RT6160_VOUT_MINUV) / RT6160_VOUT_STPUV + 1)
+
+#define RT6160_I2CRDY_TIMEUS	100
+
+struct rt6160_priv {
+	struct regulator_desc desc;
+	struct gpio_desc *enable_gpio;
+	struct regmap *regmap;
+	bool vsel_active_low;
+	bool enable_state;
+};
+
+static int rt6160_enable(struct regulator_dev *rdev)
+{
+	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
+
+	if (!priv->enable_gpio)
+		return 0;
+
+	gpiod_set_value_cansleep(priv->enable_gpio, 1);
+	priv->enable_state = true;
+
+	usleep_range(RT6160_I2CRDY_TIMEUS, RT6160_I2CRDY_TIMEUS + 100);
+
+	regcache_cache_only(priv->regmap, false);
+	return regcache_sync(priv->regmap);
+}
+
+static int rt6160_disable(struct regulator_dev *rdev)
+{
+	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
+
+	if (!priv->enable_gpio)
+		return -EINVAL;
+
+	/* Mark regcache as dirty and cache only before HW disabled */
+	regcache_cache_only(priv->regmap, true);
+	regcache_mark_dirty(priv->regmap);
+
+	priv->enable_state = false;
+	gpiod_set_value_cansleep(priv->enable_gpio, 0);
+
+	return 0;
+
+}
+
+static int rt6160_is_enabled(struct regulator_dev *rdev)
+{
+	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
+
+	return priv->enable_state ? 1 : 0;
+}
+
+static int rt6160_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int mode_val;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		mode_val = RT6160_FPWM_MASK;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		mode_val = 0;
+		break;
+	default:
+		dev_err(&rdev->dev, "mode not supported\n");
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, RT6160_REG_CNTL, RT6160_FPWM_MASK, mode_val);
+}
+
+static unsigned int rt6160_get_mode(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, RT6160_REG_CNTL, &val);
+	if (ret)
+		return ret;
+
+	if (val & RT6160_FPWM_MASK)
+		return REGULATOR_MODE_FAST;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg = RT6160_REG_VSELH;
+	int vsel;
+
+	vsel = regulator_map_voltage_linear(rdev, uV, uV);
+	if (vsel < 0)
+		return vsel;
+
+	if (priv->vsel_active_low)
+		reg = RT6160_REG_VSELL;
+
+	return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
+}
+
+static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int target)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	const unsigned int ramp_tables[] = { 1000, 2500, 5000, 10000 };
+	unsigned int sel = 0;
+	int i;
+
+	/* Find closest smaller or equal */
+	for (i = 1; i < ARRAY_SIZE(ramp_tables); i++) {
+		if (target < ramp_tables[i])
+			break;
+
+		if (target >= ramp_tables[i])
+			sel++;
+	}
+
+	sel <<= ffs(RT6160_RAMPRATE_MASK) - 1;
+
+	return regmap_update_bits(regmap, RT6160_REG_CNTL, RT6160_RAMPRATE_MASK, sel);
+}
+
+static int rt6160_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int val, events = 0;
+	int ret;
+
+	ret = regmap_read(regmap, RT6160_REG_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (val & (RT6160_HDSTAT_MASK | RT6160_TSDSTAT_MASK))
+		events |= REGULATOR_ERROR_OVER_TEMP;
+
+	if (val & RT6160_UVSTAT_MASK)
+		events |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+	if (val & RT6160_OCSTAT_MASK)
+		events |= REGULATOR_ERROR_OVER_CURRENT;
+
+	if (val & RT6160_PGSTAT_MASK)
+		events |= REGULATOR_ERROR_FAIL;
+
+	*flags = events;
+	return 0;
+}
+
+static const struct regulator_ops rt6160_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+
+	.enable = rt6160_enable,
+	.disable = rt6160_disable,
+	.is_enabled = rt6160_is_enabled,
+
+	.set_mode = rt6160_set_mode,
+	.get_mode = rt6160_get_mode,
+	.set_suspend_voltage = rt6160_set_suspend_voltage,
+	.set_ramp_delay = rt6160_set_ramp_delay,
+	.get_error_flags = rt6160_get_error_flags,
+};
+
+static unsigned int rt6160_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RT6160_MODE_FPWM:
+		return REGULATOR_MODE_FAST;
+	case RT6160_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	}
+
+	return REGULATOR_MODE_INVALID;
+}
+
+static bool rt6160_is_accessible_reg(struct device *dev, unsigned int reg)
+{
+	if (reg >= RT6160_REG_CNTL && reg <= RT6160_REG_VSELH)
+		return true;
+	return false;
+}
+
+static bool rt6160_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == RT6160_REG_STATUS)
+		return true;
+	return false;
+}
+
+static const struct regmap_config rt6160_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT6160_REG_VSELH,
+	.num_reg_defaults_raw = RT6160_NUM_REGS,
+	.cache_type = REGCACHE_FLAT,
+
+	.writeable_reg = rt6160_is_accessible_reg,
+	.readable_reg = rt6160_is_accessible_reg,
+	.volatile_reg = rt6160_is_volatile_reg,
+};
+
+static int rt6160_probe(struct i2c_client *i2c)
+{
+	struct rt6160_priv *priv;
+	struct regulator_config regulator_cfg = {};
+	struct regulator_dev *rdev;
+	unsigned int devid;
+	int ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->vsel_active_low = device_property_present(&i2c->dev, "richtek,vsel-active-low");
+
+	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio)) {
+		dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
+		return PTR_ERR(priv->enable_gpio);
+	}
+	priv->enable_state = true;
+
+	usleep_range(RT6160_I2CRDY_TIMEUS, RT6160_I2CRDY_TIMEUS + 100);
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &rt6160_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&i2c->dev, "Failed to init regmap (%d)\n", PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
+
+	ret = regmap_read(priv->regmap, RT6160_REG_DEVID, &devid);
+	if (ret)
+		return ret;
+
+	if ((devid & RT6160_VID_MASK) != RT6160_VENDOR_ID) {
+		dev_err(&i2c->dev, "VID not correct [0x%02x]\n", devid);
+		return -ENODEV;
+	}
+
+	priv->desc.name = "rt6160-buckboost";
+	priv->desc.type = REGULATOR_VOLTAGE;
+	priv->desc.owner = THIS_MODULE;
+	priv->desc.min_uV = RT6160_VOUT_MINUV;
+	priv->desc.uV_step = RT6160_VOUT_STPUV;
+	priv->desc.vsel_reg = RT6160_REG_VSELH;
+	priv->desc.vsel_mask = RT6160_VSEL_MASK;
+	priv->desc.n_voltages = RT6160_N_VOUTS;
+	priv->desc.of_map_mode = rt6160_of_map_mode;
+	priv->desc.ops = &rt6160_regulator_ops;
+	if (priv->vsel_active_low)
+		priv->desc.vsel_reg = RT6160_REG_VSELL;
+
+	regulator_cfg.dev = &i2c->dev;
+	regulator_cfg.of_node = i2c->dev.of_node;
+	regulator_cfg.regmap = priv->regmap;
+	regulator_cfg.driver_data = priv;
+	regulator_cfg.init_data = of_get_regulator_init_data(&i2c->dev, i2c->dev.of_node,
+							     &priv->desc);
+
+	rdev = devm_regulator_register(&i2c->dev, &priv->desc, &regulator_cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(&i2c->dev, "Failed to register regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rt6160_of_match_table[] = {
+	{ .compatible = "richtek,rt6160", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt6160_of_match_table);
+
+static struct i2c_driver rt6160_driver = {
+	.driver = {
+		.name = "rt6160",
+		.of_match_table = rt6160_of_match_table,
+	},
+	.probe_new = rt6160_probe,
+};
+module_i2c_driver(rt6160_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

