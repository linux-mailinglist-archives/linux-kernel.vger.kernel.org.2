Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018E63887C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhESGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhESGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:45:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A95C061760;
        Tue, 18 May 2021 23:44:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so6022686pgi.6;
        Tue, 18 May 2021 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47NKUzkUn7sG2o34JRLfK9VDmGON44TGQJRbbxFfmZk=;
        b=Iqp1jQrOE6Gi2AM0Ej+G8iUCkn8SlASHhx9TEXM1Xi3iN0X9Y9ssIL5tvxsmzF7AsO
         jjEzwdNnLsV8w/1XdBThdainzd44Les5c9A+odTwPDGtBQI7/t+tk0hcYW1AUTcKTGzg
         0GeZZqpogVpfr51jIT3Yc+FmXL7JqAncSZajmfXhVO3w09fJg3iPDjxTLALkHma26/In
         V6sEdkWGj6dVKi56DLH1k1xFMZ9/0USkZ/kxR3VSD2gQkAQ/m+yoIPfUXWp8X4Wa2uV1
         YoLoVE07R6dGWWsEJBD26cE3ykmFWT+oPwcY3ZPxsZIGt/fb9EV9bPkSVit6vaj6TgEV
         U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47NKUzkUn7sG2o34JRLfK9VDmGON44TGQJRbbxFfmZk=;
        b=svAABVc9bPhl+0QM42JhLhTBKg3sJn0doGhd4baFf2AnByXUCPLJZ2O3JuFtCc1NCN
         Gn5gt7qzG7crbf3trB27nSx6YXYaGoDZZRsqZ7ELYJ5mqdZ63vTFm3f7N2kyziaWf+yf
         00lwaNSiTB3toQEO2ry86WnuMiGoKHEnz1GFOSaOIfCg4AdHBRO3j40ZE34skoJEBcvk
         oaS5cVg7z4lJhxokF4JRzCe/TkEi/J1rRxD8oc9yFHYAdtfycRknzEL/yBhdmfxUhnsn
         ZigPTxC9XHi3JuKL8tM8ewusBrp06fAdBm+3GWdLrfWQAPMx++1T0n28/4Lh5oBd+sGJ
         RX+A==
X-Gm-Message-State: AOAM530waotlzN5b6BWwgxeTblQJaDKGttZAyHVMwLfmZcxbSu9/xctK
        6lsyWmjRcgEkOTfj49YpeYw=
X-Google-Smtp-Source: ABdhPJw/9LtuKExW0BVWOmVo65o1a+vjMHppQIBExMbL0PEPJNOcqpUX7beho/4W9lHniwfGCIAwgw==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr9574334pgl.368.1621406672237;
        Tue, 18 May 2021 23:44:32 -0700 (PDT)
Received: from localhost.localdomain (1-171-11-163.dynamic-ip.hinet.net. [1.171.11.163])
        by smtp.gmail.com with ESMTPSA id m14sm14085447pff.17.2021.05.18.23.44.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 23:44:31 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] regulator: rt6160: Add support for Richtek RT6160
Date:   Wed, 19 May 2021 14:43:59 +0800
Message-Id: <1621406639-29911-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621406639-29911-1-git-send-email-u0084500@gmail.com>
References: <1621406639-29911-1-git-send-email-u0084500@gmail.com>
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
since v3
- Use more header file like as of_regulator.h and property.h.
- Change the parsing string from 'richtek,vsel_active_low' to 'richtek,vsel-active-low'.
- Use of_get_regulator_init_data to get the regulator init_data.

since v2
- Fix W=1 warning for of_device_id.
---
 drivers/regulator/Kconfig            |  11 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt6160-regulator.c | 269 +++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
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
index 00000000..4483c17
--- /dev/null
+++ b/drivers/regulator/rt6160-regulator.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
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
+#define RT6160_RAMPRATE_1VMS	0
+#define RT6160_RAMPRATE_2P5VMS	1
+#define RT6160_RAMPRATE_5VMS	2
+#define RT6160_RAMPRATE_10VMS	3
+#define RT6160_VENDOR_ID	0xA0
+#define RT6160_VOUT_MINUV	2025000
+#define RT6160_VOUT_MAXUV	5200000
+#define RT6160_VOUT_STPUV	25000
+#define RT6160_N_VOUTS		((RT6160_VOUT_MAXUV - RT6160_VOUT_MINUV) / RT6160_VOUT_STPUV + 1)
+
+struct rt6160_priv {
+	struct regulator_desc desc;
+	bool vsel_active_low;
+};
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
+static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int ramp_value = RT6160_RAMPRATE_1VMS;
+
+	switch (ramp_delay) {
+	case 1 ... 1000:
+		ramp_value = RT6160_RAMPRATE_1VMS;
+		break;
+	case 1001 ... 2500:
+		ramp_value = RT6160_RAMPRATE_2P5VMS;
+		break;
+	case 2501 ... 5000:
+		ramp_value = RT6160_RAMPRATE_5VMS;
+		break;
+	case 5001 ... 10000:
+		ramp_value = RT6160_RAMPRATE_10VMS;
+		break;
+	default:
+		dev_warn(&rdev->dev, "ramp_delay %d not supported, setting 1000\n", ramp_delay);
+	}
+
+	return regmap_update_bits(regmap, RT6160_REG_CNTL, RT6160_RAMPRATE_MASK, ramp_value);
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
+	.set_mode = rt6160_set_mode,
+	.get_mode = rt6160_get_mode,
+	.set_suspend_voltage = rt6160_set_suspend_voltage,
+	.set_ramp_delay = rt6160_set_ramp_delay,
+	.get_error_flags = rt6160_get_error_flags,
+};
+
+static unsigned int rt6160_of_map_mode(unsigned int mode)
+{
+	if (mode == RT6160_MODE_FPWM)
+		return REGULATOR_MODE_FAST;
+	else if (mode == RT6160_MODE_AUTO)
+		return REGULATOR_MODE_NORMAL;
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
+static const struct regmap_config rt6160_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT6160_REG_VSELH,
+
+	.writeable_reg = rt6160_is_accessible_reg,
+	.readable_reg = rt6160_is_accessible_reg,
+};
+
+static int rt6160_probe(struct i2c_client *i2c)
+{
+	struct rt6160_priv *priv;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
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
+	enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio)) {
+		dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
+		return PTR_ERR(enable_gpio);
+	}
+
+	regmap = devm_regmap_init_i2c(i2c, &rt6160_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	ret = regmap_read(regmap, RT6160_REG_DEVID, &devid);
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
+	regulator_cfg.regmap = regmap;
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

