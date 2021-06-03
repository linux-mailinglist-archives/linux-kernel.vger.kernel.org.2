Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD48E399A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCF7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFCF7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:59:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7210C06174A;
        Wed,  2 Jun 2021 22:57:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x73so4075980pfc.8;
        Wed, 02 Jun 2021 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsjbJHgxF3sb2azUBfi+FhOLbgx/b++81QxuHtxpj5E=;
        b=Mk+vwlwW6Mn0keFRShJWUc7HjmqrzPwIDPeV05NrAataaj+uh6SfB2TTCtaL4R6ryg
         KZbhPZ7KzEwdFmolIM8546q2j7cBx5Qo4dniq2+2y5MX3a7GigS7zdf/k+cGKeMC0FZk
         teNb2diIztA59eGSDru9KuZ3hSIDL7d6oKllZqTT4GZ/SCQDnlBxRvZHjh0ecxDZqzqC
         fod+jRbJtj2WKeaTy1J3NSTOZinDWckhurGaYWfhw1A0WRtBhoWfv54OPG1RHtCKIYxq
         HKDAeye/awcB+cZ7eKREzAeU+wuBv7VvBmr8GfDX8onMDDKcmhKvwu7b4JhuR7tG6D4O
         b/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NsjbJHgxF3sb2azUBfi+FhOLbgx/b++81QxuHtxpj5E=;
        b=EX/urgRfWRy2udexL6Kr385P0ANW8t8xrIRLzDPnItLxVxuLTj0mUkdredkW8Yunl3
         n8QR+pILSkxF5yj4mCGHEUttLI+Wcab4MtVLTKR7ftYGcbanMTaF+TjCNvev4aj1MM5X
         3+OkX8mrR4N0z4l3OzjtPPWZu4+ZUD547vi400o5/zfQy3qeA/NhHn3ON4G8N+Fnnpto
         tKwreiRscFRr1M8ME+5A5OK+y+lawypfB0c5KQ3MW1MCwxce8WBqrvASgqAgztGTjTZW
         +dtD0fxUoQ+lTZxI17F8ZwTk4AFi4/z0Hh0//dUhIGmZuXdz7sSJvyKd/4frtSUuqw+q
         rKHQ==
X-Gm-Message-State: AOAM532V/QL/mWKcm20U45rUcsKso/H/8zDJhUcxrcn7arHBjP4/qyjK
        y4tzPuqZJauz2sTu2WKPmIc=
X-Google-Smtp-Source: ABdhPJyMrl00vAp62MDwV5k5ztPCtt1Lyv42M/LIywbCTts0+8faLNCOM1ju2KId+yDH+/g8HmEDMw==
X-Received: by 2002:a63:4760:: with SMTP id w32mr37794731pgk.383.1622699858159;
        Wed, 02 Jun 2021 22:57:38 -0700 (PDT)
Received: from localhost.localdomain (1-171-7-242.dynamic-ip.hinet.net. [1.171.7.242])
        by smtp.gmail.com with ESMTPSA id v6sm1207267pfi.46.2021.06.02.22.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 22:57:37 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] regulator: rt6245: Add support for Richtek RT6245
Date:   Thu,  3 Jun 2021 13:57:24 +0800
Message-Id: <1622699844-19203-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622699844-19203-1-git-send-email-u0084500@gmail.com>
References: <1622699844-19203-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Richtek RT6245 is a high-performance, synchronous step-down converter
that can deliver up to 14A output current with an input supply voltage
range of 4.5V to 17V.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v3
- Use new regulator_set_ramp_delay_regmap helper function to simplify
  set_ramp_delay callback.
- Refine enable/disbale callback function. Only when all gpio/regcache
  operations is finished, then to config enable_state variable.
- Fix last name typo for module author information.
- declared as const for struct array in init_device_properties function.

since v2
- Use hweight8 to fix x86 __sw_hweight8 undefined.
---
 drivers/regulator/Kconfig            |   9 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt6245-regulator.c | 254 +++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 drivers/regulator/rt6245-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9d84d92..cdec434 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1030,6 +1030,15 @@ config REGULATOR_RT5033
 	  RT5033 PMIC. The device supports multiple regulators like
 	  current source, LDO and Buck.
 
+config REGULATOR_RT6245
+	tristate "Richtek RT6245 voltage regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This adds supprot for Richtek RT6245 voltage regulator.
+	  It can support up to 14A output current and adjustable output voltage
+	  from 0.4375V to 1.3875V, per step 12.5mV.
+
 config REGULATOR_RTMV20
 	tristate "RTMV20 Laser Diode Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 580b015..69668bf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
 obj-$(CONFIG_REGULATOR_RT4801)	+= rt4801-regulator.o
 obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
+obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
diff --git a/drivers/regulator/rt6245-regulator.c b/drivers/regulator/rt6245-regulator.c
new file mode 100644
index 00000000..d3299a7
--- /dev/null
+++ b/drivers/regulator/rt6245-regulator.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define RT6245_VIRT_OCLIMIT	0x00
+#define RT6245_VIRT_OTLEVEL	0x01
+#define RT6245_VIRT_PGDLYTIME	0x02
+#define RT6245_VIRT_SLEWRATE	0x03
+#define RT6245_VIRT_SWFREQ	0x04
+#define RT6245_VIRT_VOUT	0x05
+
+#define RT6245_VOUT_MASK	GENMASK(6, 0)
+#define RT6245_SLEW_MASK	GENMASK(2, 0)
+#define RT6245_CHKSUM_MASK	BIT(7)
+#define RT6245_CODE_MASK	GENMASK(6, 0)
+
+/* HW Enable + Soft start time */
+#define RT6245_ENTIME_IN_US	5000
+
+#define RT6245_VOUT_MINUV	437500
+#define RT6245_VOUT_MAXUV	1387500
+#define RT6245_VOUT_STEPUV	12500
+#define RT6245_NUM_VOUT		((RT6245_VOUT_MAXUV - RT6245_VOUT_MINUV) / RT6245_VOUT_STEPUV + 1)
+
+struct rt6245_priv {
+	struct gpio_desc *enable_gpio;
+	bool enable_state;
+};
+
+static int rt6245_enable(struct regulator_dev *rdev)
+{
+	struct rt6245_priv *priv = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int ret;
+
+	if (!priv->enable_gpio)
+		return 0;
+
+	gpiod_direction_output(priv->enable_gpio, 1);
+	usleep_range(RT6245_ENTIME_IN_US, RT6245_ENTIME_IN_US + 1000);
+
+	regcache_cache_only(regmap, false);
+	ret = regcache_sync(regmap);
+	if (ret)
+		return ret;
+
+	priv->enable_state = true;
+	return 0;
+}
+
+static int rt6245_disable(struct regulator_dev *rdev)
+{
+	struct rt6245_priv *priv = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+
+	if (!priv->enable_gpio)
+		return -EINVAL;
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	gpiod_direction_output(priv->enable_gpio, 0);
+
+	priv->enable_state = false;
+	return 0;
+}
+
+static int rt6245_is_enabled(struct regulator_dev *rdev)
+{
+	struct rt6245_priv *priv = rdev_get_drvdata(rdev);
+
+	return priv->enable_state ? 1 : 0;
+}
+
+static const struct regulator_ops rt6245_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+	.enable = rt6245_enable,
+	.disable = rt6245_disable,
+	.is_enabled = rt6245_is_enabled,
+};
+
+/* ramp delay dividend is 12500 uV/uS, and divisor from 1 to 8 */
+static const unsigned int rt6245_ramp_delay_table[] = {
+	12500, 6250, 4167, 3125, 2500, 2083, 1786, 1562
+};
+
+static const struct regulator_desc rt6245_regulator_desc = {
+	.name = "rt6245-regulator",
+	.ops = &rt6245_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.min_uV = RT6245_VOUT_MINUV,
+	.uV_step = RT6245_VOUT_STEPUV,
+	.n_voltages = RT6245_NUM_VOUT,
+	.ramp_delay_table = rt6245_ramp_delay_table,
+	.n_ramp_values = ARRAY_SIZE(rt6245_ramp_delay_table),
+	.owner = THIS_MODULE,
+	.vsel_reg = RT6245_VIRT_VOUT,
+	.vsel_mask = RT6245_VOUT_MASK,
+	.ramp_reg = RT6245_VIRT_SLEWRATE,
+	.ramp_mask = RT6245_SLEW_MASK,
+};
+
+static int rt6245_init_device_properties(struct device *dev)
+{
+	const struct {
+		const char *name;
+		unsigned int reg;
+	} rt6245_props[] = {
+		{ "richtek,oc-level-select",  RT6245_VIRT_OCLIMIT },
+		{ "richtek,ot-level-select", RT6245_VIRT_OTLEVEL },
+		{ "richtek,pgdly-time-select", RT6245_VIRT_PGDLYTIME },
+		{ "richtek,switch-freq-select", RT6245_VIRT_SWFREQ }
+	};
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	u8 propval;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(rt6245_props); i++) {
+		ret = device_property_read_u8(dev, rt6245_props[i].name, &propval);
+		if (ret)
+			continue;
+
+		ret = regmap_write(regmap, rt6245_props[i].reg, propval);
+		if (ret) {
+			dev_err(dev, "Fail to apply [%s:%d]\n", rt6245_props[i].name, propval);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int rt6245_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *i2c = context;
+	const u8 func_base[] = { 0x6F, 0x73, 0x78, 0x61, 0x7C, 0 };
+	unsigned int code, bit_count;
+
+	code = func_base[reg];
+	code += val;
+
+	/* xor checksum for bit 6 to 0 */
+	bit_count = hweight8(code & RT6245_CODE_MASK);
+	if (bit_count % 2)
+		code |= RT6245_CHKSUM_MASK;
+	else
+		code &= ~RT6245_CHKSUM_MASK;
+
+	return i2c_smbus_write_byte(i2c, code);
+}
+
+static const struct reg_default rt6245_reg_defaults[] = {
+	/* Default over current 14A */
+	{ RT6245_VIRT_OCLIMIT, 2 },
+	/* Default over temperature 150'c */
+	{ RT6245_VIRT_OTLEVEL, 0 },
+	/* Default power good delay time 10us */
+	{ RT6245_VIRT_PGDLYTIME, 1 },
+	/* Default slewrate 12.5mV/uS */
+	{ RT6245_VIRT_SLEWRATE, 0 },
+	/* Default switch frequency 800KHz */
+	{ RT6245_VIRT_SWFREQ, 1 },
+	/* Default voltage 750mV */
+	{ RT6245_VIRT_VOUT, 0x19 }
+};
+
+static const struct regmap_config rt6245_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT6245_VIRT_VOUT,
+	.cache_type = REGCACHE_FLAT,
+	.reg_defaults = rt6245_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rt6245_reg_defaults),
+	.reg_write = rt6245_reg_write,
+};
+
+static int rt6245_probe(struct i2c_client *i2c)
+{
+	struct rt6245_priv *priv;
+	struct regmap *regmap;
+	struct regulator_config regulator_cfg = {};
+	struct regulator_dev *rdev;
+	int ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->enable_state = true;
+
+	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio)) {
+		dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
+		return PTR_ERR(priv->enable_gpio);
+	}
+
+	usleep_range(RT6245_ENTIME_IN_US, RT6245_ENTIME_IN_US + 1000);
+
+	regmap = devm_regmap_init(&i2c->dev, NULL, i2c, &rt6245_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to initialize the regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	ret = rt6245_init_device_properties(&i2c->dev);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to initialize device properties\n");
+		return ret;
+	}
+
+	regulator_cfg.dev = &i2c->dev;
+	regulator_cfg.of_node = i2c->dev.of_node;
+	regulator_cfg.regmap = regmap;
+	regulator_cfg.driver_data = priv;
+	regulator_cfg.init_data = of_get_regulator_init_data(&i2c->dev, i2c->dev.of_node,
+							     &rt6245_regulator_desc);
+	rdev = devm_regulator_register(&i2c->dev, &rt6245_regulator_desc, &regulator_cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(&i2c->dev, "Failed to register regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rt6245_of_match_table[] = {
+	{ .compatible = "richtek,rt6245", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt6245_of_match_table);
+
+static struct i2c_driver rt6245_driver = {
+	.driver = {
+		.name = "rt6245",
+		.of_match_table = rt6245_of_match_table,
+	},
+	.probe_new = rt6245_probe,
+};
+module_i2c_driver(rt6245_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT6245 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

