Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB93926CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhE0FP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhE0FPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:15:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F516C061574;
        Wed, 26 May 2021 22:14:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q67so2751368pfb.4;
        Wed, 26 May 2021 22:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53Eza6IIWvQZ2+MOVEINVFrLGHYsHFKL8NUyL3HUVbo=;
        b=a1GK7LxwlITgdFTSY8jjB4JpIkwn0epjP7gGQsOGvv1Qkw9a4Nsx9P6WTKElNmBgnd
         nAzW9abP1KM+LyD9kwQ2ImHHPYvTb0o8LU/X73nXGb+B14mqVRDDARPd2oXhiRJZxD13
         FrSWp9HvZTKmHT2oJoPFny1x8fMdEmFeTX4PYhcdNkNFxvkZ+Mi7nYMNREcEl4J0Dmrj
         n525r/kUaQyRRfhihbp5Ziy+FzjazxF2C/hm9+yvR12UT3je3q3NlwmKGClpOtFXObEx
         aNwKguYCNv7v0M05IR4YEpY8Hbe+1S2W4No8a2IPjGZULpx3jzL4hlEVXO3jnVu6crSg
         vNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53Eza6IIWvQZ2+MOVEINVFrLGHYsHFKL8NUyL3HUVbo=;
        b=fXqOi6BbVMHqbWO9aWn1rFkGXnaF/tNs9i6D0wnGCc9ocg29nxAYY64vwcl7crGfDK
         sh5HsaTcTcklQu4GhelED3t5/rgydIq0DOVReJ/VQHOXrRvYIbl0PsoFpyz206t4wM3O
         d3k/yziSTQd5w5gibWmRuwqFO0gQ7+PXI2cMwpGcFAJ4uUoefv1gfKR4cDoPNIf9HfEH
         6Ujr5y/KJFiSaoNtIjs1u0QPdyLZ5YIo8RRFew3r9rn9DAwUdJqW2OG0iaP8W+VLJavg
         c/e6k2osvZi/qG1D4p7c4FuHzNRqMmiZTnVHcTkpylamG+wSw2R5pYDMd52v49De5HEY
         RfgQ==
X-Gm-Message-State: AOAM533SvmAMQABjZn/9bb9kgxL9zcM/rRL0i4/rerC9AMtgpTj12mIA
        93UvlJC70G9Afc8CCCpiF6OztjQN3Xs=
X-Google-Smtp-Source: ABdhPJx6DMpJcXYltoQxwwKQb5pMEElNNcPUDRDeRWxnrv/J5Y/CAXDNOyPfyGVBAnzAYnWSoZ7zTQ==
X-Received: by 2002:a65:550e:: with SMTP id f14mr2071408pgr.160.1622092460864;
        Wed, 26 May 2021 22:14:20 -0700 (PDT)
Received: from localhost.localdomain (1-171-23-132.dynamic-ip.hinet.net. [1.171.23.132])
        by smtp.gmail.com with ESMTPSA id cu2sm706424pjb.43.2021.05.26.22.14.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 22:14:20 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: rt6245: Add support for Richtek RT6245
Date:   Thu, 27 May 2021 13:14:09 +0800
Message-Id: <1622092449-21461-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622092449-21461-1-git-send-email-u0084500@gmail.com>
References: <1622092449-21461-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Richtek RT6245 is a high-performance, synchronous step-down converter
that can deliver up to 14A output current with an input supply voltage
range of 4.5V to 17V.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v2
- Use hweight8 to fix x86 __sw_hweight8 undefined.
---
 drivers/regulator/Kconfig            |   9 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt6245-regulator.c | 260 +++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
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
index 00000000..e4032b0
--- /dev/null
+++ b/drivers/regulator/rt6245-regulator.c
@@ -0,0 +1,260 @@
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
+#define RT6245_CHKSUM_MASK	BIT(7)
+#define RT6245_CODE_MASK	GENMASK(6, 0)
+
+/* HW Enable + Soft start time */
+#define RT6245_ENTIME_IN_US	5000
+
+#define RT6245_RAMPT_UNIT_0P1UV	15625
+#define RT6245_RAMPT_MAXUV	12500
+#define RT6245_RAMPT_BASESEL	1
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
+static int rt6245_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct regmap *regmap  = rdev_get_regmap(rdev);
+	unsigned int ramp_time_scale;
+
+	if (ramp_delay == 0 || ramp_delay > RT6245_RAMPT_MAXUV) {
+		dev_warn(&rdev->dev, "Not in ramp time range %d, set to fastest\n", ramp_delay);
+		ramp_delay = RT6245_RAMPT_MAXUV;
+	}
+
+	/* ramp_time = max_ramp_time / ramp_time_scale, scale from 1 to 8 */
+	ramp_delay = max(ramp_delay * 10, RT6245_RAMPT_UNIT_0P1UV);
+	ramp_time_scale = (RT6245_RAMPT_MAXUV * 10) / ramp_delay;
+	ramp_time_scale -= RT6245_RAMPT_BASESEL;
+
+	return regmap_write(regmap, RT6245_VIRT_SLEWRATE, ramp_time_scale);
+}
+
+static int rt6245_enable(struct regulator_dev *rdev)
+{
+	struct rt6245_priv *priv = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+
+	if (!priv->enable_gpio)
+		return 0;
+
+	priv->enable_state = true;
+	gpiod_direction_output(priv->enable_gpio, 1);
+	usleep_range(RT6245_ENTIME_IN_US, RT6245_ENTIME_IN_US + 1000);
+
+	regcache_cache_only(regmap, false);
+	return regcache_sync(regmap);
+}
+
+static int rt6245_disable(struct regulator_dev *rdev)
+{
+	struct rt6245_priv *priv = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
+
+	if (!priv->enable_gpio)
+		return -ENOTSUPP;
+
+	priv->enable_state = false;
+	gpiod_direction_output(priv->enable_gpio, 0);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
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
+	.set_ramp_delay = rt6245_set_ramp_delay,
+	.enable = rt6245_enable,
+	.disable = rt6245_disable,
+	.is_enabled = rt6245_is_enabled,
+};
+
+static const struct regulator_desc rt6245_regulator_desc = {
+	.name = "rt6245-regulator",
+	.ops = &rt6245_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.min_uV = RT6245_VOUT_MINUV,
+	.uV_step = RT6245_VOUT_STEPUV,
+	.n_voltages = RT6245_NUM_VOUT,
+	.owner = THIS_MODULE,
+	.vsel_reg = RT6245_VIRT_VOUT,
+	.vsel_mask = RT6245_VOUT_MASK,
+};
+
+static int rt6245_init_device_properties(struct device *dev)
+{
+	struct {
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
+MODULE_AUTHOR("ChiYuan Hwang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT6245 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

