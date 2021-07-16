Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775ED3CB3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhGPIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbhGPIHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:07:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD971C06175F;
        Fri, 16 Jul 2021 01:04:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c15so4918636pls.13;
        Fri, 16 Jul 2021 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5RZ70CNQStjRkV3x4TnENlwPYVoT/RmUOwQEN2/wRmA=;
        b=Ft6m9ft+WkE3/vFIuuLhPeDdHC1hqz7fb5SYTg21O/Ji5u84ENhFUXcqQ9uypOohkR
         smVrjDfQ/c9gmOk+E7SVwU4eZqdX0s3l9skQ7Fb6FZ2Nm7JPZLpLyiiM5EnvOOj5yV8J
         V7ahL42fwB9dbOUesKog94APGez6gR/rkarJrLM4SFCfmKWmg86HEp+fjo4IgMRPOxKu
         RtcBCv7yMN0auXVcoyB2W5XfejrIYJE9oD2ePShYLdY58Aqi1NGiwnWRgC2KrvNT5hJW
         5kiBk6jRTwW2iQ0SL7q0yyQnJ2rTbS9cWBdmX9oetyVT8xlGSnDMhWL/1mcADKOnv55H
         o+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5RZ70CNQStjRkV3x4TnENlwPYVoT/RmUOwQEN2/wRmA=;
        b=VCHwn4Tw+ZFTwg6uFONjeCzHPe0sH5RDanSSRGo3GR7KY+z61fq2AWRPiTy3KkqZgm
         JeGCoqlfcQkwEencVvjGrGtDt9I1Lm14quLFxB0/S5aAMqqze+WoS+y91bRQ1piRmjwS
         VyPPG1QL9pQVuUTqdeNz58WIgKpsOjqDVdzWDTzyi1pdiCtUh+w7ODov0Dq8vrWlw6+m
         u1BFWIPJd9xNgxFFdzLTrzfnO23vDdwuJWgXCLA4YsnGWfRo3GS1dc4tuYOALQDJXFQf
         H5UGdU0wwffOQbTtnw5fvhjurPlsPjcjJOu1IoaMG3rrTLtbFmjQcsfNfnps35E4qALk
         td9w==
X-Gm-Message-State: AOAM5303FdCbSjhVah/B1hsLn5qde0bUFA46MyOpvYcI26gR+M2RrSrZ
        7uJNibbemqnmeRbuP0NrX/M=
X-Google-Smtp-Source: ABdhPJzbcYLecEPul5kPAtRkTWgoS4gBUUpklIsyV9HAMgzoAnglEhKoxJs0yN03R5MVV5QQNWlDtQ==
X-Received: by 2002:a17:90a:3b42:: with SMTP id t2mr14850552pjf.193.1626422645397;
        Fri, 16 Jul 2021 01:04:05 -0700 (PDT)
Received: from localhost.localdomain (1-171-2-23.dynamic-ip.hinet.net. [1.171.2.23])
        by smtp.gmail.com with ESMTPSA id t17sm9292636pfg.93.2021.07.16.01.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 01:04:04 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: rtq2134: Add support for Richtek RTQ2134 SubPMIC
Date:   Fri, 16 Jul 2021 16:03:56 +0800
Message-Id: <1626422636-29458-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626422636-29458-1-git-send-email-u0084500@gmail.com>
References: <1626422636-29458-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This adds support for Richtek RTQ2134 SubPMIC.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig             |  11 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/rtq2134-regulator.c | 373 ++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 drivers/regulator/rtq2134-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6562d4c..7bd99d7 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1057,6 +1057,17 @@ config REGULATOR_RT6245
 	  It can support up to 14A output current and adjustable output voltage
 	  from 0.4375V to 1.3875V, per step 12.5mV.
 
+config REGULATOR_RTQ2134
+	tristate "Richtek RTQ2134 SubPMIC Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver adds support for RTQ2134 SubPMIC regulators.
+	  The RTQ2134 is a multi-phase, programmable power management IC that
+	  integrate with four high efficient, synchronous step-down converter
+	  cores. It features wide output voltage range and the capability to
+	  configure the corresponding power stages.
+
 config REGULATOR_RTMV20
 	tristate "Richtek RTMV20 Laser Diode Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 102b2a0..9e382b5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT6160)	+= rt6160-regulator.o
 obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
+obj-$(CONFIG_REGULATOR_RTQ2134) += rtq2134-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
diff --git a/drivers/regulator/rtq2134-regulator.c b/drivers/regulator/rtq2134-regulator.c
new file mode 100644
index 00000000..e09419c
--- /dev/null
+++ b/drivers/regulator/rtq2134-regulator.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+enum {
+	RTQ2134_IDX_BUCK1 = 0,
+	RTQ2134_IDX_BUCK2,
+	RTQ2134_IDX_BUCK3,
+	RTQ2134_IDX_MAX
+};
+
+#define RTQ2134_AUTO_MODE		0
+#define RTQ2134_FCCM_MODE		1
+
+#define RTQ2134_BUCK_DVS0_CTRL		0
+#define RTQ2134_BUCK_VSEL_CTRL		2
+
+#define RTQ2134_REG_IO_CHIPNAME		0x01
+#define RTQ2134_REG_FLT_RECORDTEMP	0x13
+#define RTQ2134_REG_FLT_RECORDBUCK(_id)	(0x14 + (_id))
+#define RTQ2134_REG_FLT_BUCKCTRL(_id)	(0x37 + (_id))
+#define RTQ2134_REG_BUCK1_CFG0		0x42
+#define RTQ2134_REG_BUCK1_DVS0CFG1	0x48
+#define RTQ2134_REG_BUCK1_DVS0CFG0	0x49
+#define RTQ2134_REG_BUCK1_DVS1CFG1	0x4A
+#define RTQ2134_REG_BUCK1_DVS1CFG0	0x4B
+#define RTQ2134_REG_BUCK1_DVSCFG	0x52
+#define RTQ2134_REG_BUCK1_RSPCFG	0x54
+#define RTQ2134_REG_BUCK2_CFG0		0x5F
+#define RTQ2134_REG_BUCK2_DVS0CFG1	0x62
+#define RTQ2134_REG_BUCK2_DVS0CFG0	0x63
+#define RTQ2134_REG_BUCK2_DVS1CFG1	0x64
+#define RTQ2134_REG_BUCK2_DVS1CFG0	0x65
+#define RTQ2134_REG_BUCK2_DVSCFG	0x6C
+#define RTQ2134_REG_BUCK2_RSPCFG	0x6E
+#define RTQ2134_REG_BUCK3_CFG0		0x79
+#define RTQ2134_REG_BUCK3_DVS0CFG1	0x7C
+#define RTQ2134_REG_BUCK3_DVS0CFG0	0x7D
+#define RTQ2134_REG_BUCK3_DVS1CFG1	0x7E
+#define RTQ2134_REG_BUCK3_DVS1CFG0	0x7F
+#define RTQ2134_REG_BUCK3_DVSCFG	0x86
+#define RTQ2134_REG_BUCK3_RSPCFG	0x88
+#define RTQ2134_REG_BUCK3_SLEWCTRL	0x89
+
+#define RTQ2134_VOUT_MAXNUM		256
+#define RTQ2134_VOUT_MASK		0xFF
+#define RTQ2134_VOUTEN_MASK		BIT(0)
+#define RTQ2134_ACTDISCHG_MASK		BIT(0)
+#define RTQ2134_RSPUP_MASK		GENMASK(6, 4)
+#define RTQ2134_FCCM_MASK		BIT(5)
+#define RTQ2134_UVHICCUP_MASK		BIT(3)
+#define RTQ2134_BUCKDVS_CTRL_MASK	GENMASK(1, 0)
+#define RTQ2134_CHIPOT_MASK		BIT(2)
+#define RTQ2134_BUCKOV_MASK		BIT(5)
+#define RTQ2134_BUCKUV_MASK		BIT(4)
+
+struct rtq2134_regulator_desc {
+	struct regulator_desc desc;
+	/* Extension for proprietary register and mask */
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+	unsigned int suspend_enable_reg;
+	unsigned int suspend_enable_mask;
+	unsigned int suspend_vsel_reg;
+	unsigned int suspend_vsel_mask;
+	unsigned int suspend_mode_reg;
+	unsigned int suspend_mode_mask;
+	unsigned int dvs_ctrl_reg;
+};
+
+static int rtq2134_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+	unsigned int val;
+
+	if (mode == REGULATOR_MODE_NORMAL)
+		val = RTQ2134_AUTO_MODE;
+	else if (mode == REGULATOR_MODE_FAST)
+		val = RTQ2134_FCCM_MODE;
+	else
+		return -EINVAL;
+
+	val <<= ffs(desc->mode_mask) - 1;
+	return regmap_update_bits(rdev->regmap, desc->mode_reg, desc->mode_mask,
+				  val);
+}
+
+static unsigned int rtq2134_buck_get_mode(struct regulator_dev *rdev)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+	unsigned int mode;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, desc->mode_reg, &mode);
+	if (ret)
+		return ret;
+
+	if (mode & desc->mode_mask)
+		return REGULATOR_MODE_FAST;
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int rtq2134_buck_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+	int sel;
+
+	sel = regulator_map_voltage_linear_range(rdev, uV, uV);
+	if (sel < 0)
+		return sel;
+
+	sel <<= ffs(desc->suspend_vsel_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, desc->suspend_vsel_reg,
+				  desc->suspend_vsel_mask, sel);
+}
+
+static int rtq2134_buck_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+	unsigned int val = desc->suspend_enable_mask;
+
+	return regmap_update_bits(rdev->regmap, desc->suspend_enable_reg,
+				  desc->suspend_enable_mask, val);
+}
+
+static int rtq2134_buck_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+
+	return regmap_update_bits(rdev->regmap, desc->suspend_enable_reg,
+				  desc->suspend_enable_mask, 0);
+}
+
+static int rtq2134_buck_set_suspend_mode(struct regulator_dev *rdev,
+					 unsigned int mode)
+{
+	struct rtq2134_regulator_desc *desc =
+		(struct rtq2134_regulator_desc *)rdev->desc;
+	unsigned int val;
+
+	if (mode == REGULATOR_MODE_NORMAL)
+		val = RTQ2134_AUTO_MODE;
+	else if (mode == REGULATOR_MODE_FAST)
+		val = RTQ2134_FCCM_MODE;
+	else
+		return -EINVAL;
+
+	val <<= ffs(desc->suspend_mode_mask) - 1;
+	return regmap_update_bits(rdev->regmap, desc->suspend_mode_reg,
+				  desc->suspend_mode_mask, val);
+}
+
+static int rtq2134_buck_get_error_flags(struct regulator_dev *rdev,
+					unsigned int *flags)
+{
+	int rid = rdev_get_id(rdev);
+	unsigned int chip_error, buck_error, events = 0;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, RTQ2134_REG_FLT_RECORDTEMP,
+			  &chip_error);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get chip error flag\n");
+		return ret;
+	}
+
+	ret = regmap_read(rdev->regmap, RTQ2134_REG_FLT_RECORDBUCK(rid),
+			  &buck_error);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get buck error flag\n");
+		return ret;
+	}
+
+	if (chip_error & RTQ2134_CHIPOT_MASK)
+		events |= REGULATOR_ERROR_OVER_TEMP;
+
+	if (buck_error & RTQ2134_BUCKUV_MASK)
+		events |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+	if (buck_error & RTQ2134_BUCKOV_MASK)
+		events |= REGULATOR_ERROR_REGULATION_OUT;
+
+	*flags = events;
+	return 0;
+}
+
+static const struct regulator_ops rtq2134_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+	.set_mode = rtq2134_buck_set_mode,
+	.get_mode = rtq2134_buck_get_mode,
+	.set_suspend_voltage = rtq2134_buck_set_suspend_voltage,
+	.set_suspend_enable = rtq2134_buck_set_suspend_enable,
+	.set_suspend_disable = rtq2134_buck_set_suspend_disable,
+	.set_suspend_mode = rtq2134_buck_set_suspend_mode,
+	.get_error_flags = rtq2134_buck_get_error_flags,
+};
+
+static const struct linear_range rtq2134_buck_vout_ranges[] = {
+	REGULATOR_LINEAR_RANGE(300000, 0, 200, 5000),
+	REGULATOR_LINEAR_RANGE(1310000, 201, 255, 10000)
+};
+
+static unsigned int rtq2134_buck_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RTQ2134_AUTO_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case RTQ2134_FCCM_MODE:
+		return REGULATOR_MODE_FAST;
+	}
+
+	return REGULATOR_MODE_INVALID;
+}
+
+static int rtq2134_buck_of_parse_cb(struct device_node *np,
+				    const struct regulator_desc *desc,
+				    struct regulator_config *cfg)
+{
+	struct rtq2134_regulator_desc *rdesc =
+		(struct rtq2134_regulator_desc *)desc;
+	int rid = desc->id;
+	bool uv_shutdown, vsel_dvs;
+	unsigned int val;
+	int ret;
+
+	vsel_dvs = of_property_read_bool(np, "richtek,use-vsel-dvs");
+	if (vsel_dvs)
+		val = RTQ2134_BUCK_VSEL_CTRL;
+	else
+		val = RTQ2134_BUCK_DVS0_CTRL;
+
+	ret = regmap_update_bits(cfg->regmap, rdesc->dvs_ctrl_reg,
+				 RTQ2134_BUCKDVS_CTRL_MASK, val);
+	if (ret)
+		return ret;
+
+	uv_shutdown = of_property_read_bool(np, "richtek,uv-shutdown");
+	if (uv_shutdown)
+		val = 0;
+	else
+		val = RTQ2134_UVHICCUP_MASK;
+
+	return regmap_update_bits(cfg->regmap, RTQ2134_REG_FLT_BUCKCTRL(rid),
+				  RTQ2134_UVHICCUP_MASK, val);
+}
+
+static const unsigned int rtq2134_buck_ramp_delay_table[] = {
+	0, 16000, 0, 8000, 4000, 2000, 1000, 500
+};
+
+#define RTQ2134_BUCK_DESC(_id) { \
+	.desc = { \
+		.name = "rtq2134_buck" #_id, \
+		.of_match = of_match_ptr("buck" #_id), \
+		.regulators_node = of_match_ptr("regulators"), \
+		.id = RTQ2134_IDX_BUCK##_id, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		.ops = &rtq2134_buck_ops, \
+		.n_voltages = RTQ2134_VOUT_MAXNUM, \
+		.linear_ranges = rtq2134_buck_vout_ranges, \
+		.n_linear_ranges = ARRAY_SIZE(rtq2134_buck_vout_ranges), \
+		.vsel_reg = RTQ2134_REG_BUCK##_id##_DVS0CFG1, \
+		.vsel_mask = RTQ2134_VOUT_MASK, \
+		.enable_reg = RTQ2134_REG_BUCK##_id##_DVS0CFG0, \
+		.enable_mask = RTQ2134_VOUTEN_MASK, \
+		.active_discharge_reg = RTQ2134_REG_BUCK##_id##_CFG0, \
+		.active_discharge_mask = RTQ2134_ACTDISCHG_MASK, \
+		.ramp_reg = RTQ2134_REG_BUCK##_id##_RSPCFG, \
+		.ramp_mask = RTQ2134_RSPUP_MASK, \
+		.ramp_delay_table = rtq2134_buck_ramp_delay_table, \
+		.n_ramp_values = ARRAY_SIZE(rtq2134_buck_ramp_delay_table), \
+		.of_map_mode = rtq2134_buck_of_map_mode, \
+		.of_parse_cb = rtq2134_buck_of_parse_cb, \
+	}, \
+	.mode_reg = RTQ2134_REG_BUCK##_id##_DVS0CFG0, \
+	.mode_mask = RTQ2134_FCCM_MASK, \
+	.suspend_mode_reg = RTQ2134_REG_BUCK##_id##_DVS1CFG0, \
+	.suspend_mode_mask = RTQ2134_FCCM_MASK, \
+	.suspend_enable_reg = RTQ2134_REG_BUCK##_id##_DVS1CFG0, \
+	.suspend_enable_mask = RTQ2134_VOUTEN_MASK, \
+	.suspend_vsel_reg = RTQ2134_REG_BUCK##_id##_DVS1CFG1, \
+	.suspend_vsel_mask = RTQ2134_VOUT_MASK, \
+	.dvs_ctrl_reg = RTQ2134_REG_BUCK##_id##_DVSCFG, \
+}
+
+static const struct rtq2134_regulator_desc rtq2134_regulator_descs[] = {
+	RTQ2134_BUCK_DESC(1),
+	RTQ2134_BUCK_DESC(2),
+	RTQ2134_BUCK_DESC(3)
+};
+
+static bool rtq2134_is_accissible_reg(struct device *dev, unsigned int reg)
+{
+	if (RTQ2134_REG_IO_CHIPNAME <= reg && reg <= RTQ2134_REG_BUCK3_SLEWCTRL)
+		return true;
+	return false;
+}
+
+static const struct regmap_config rtq2134_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RTQ2134_REG_BUCK3_SLEWCTRL,
+
+	.readable_reg = rtq2134_is_accissible_reg,
+	.writeable_reg = rtq2134_is_accissible_reg,
+};
+
+static int rtq2134_probe(struct i2c_client *i2c)
+{
+	struct regmap *regmap;
+	struct regulator_dev *rdev;
+	struct regulator_config regulator_cfg= {};
+	int i;
+
+	regmap = devm_regmap_init_i2c(i2c, &rtq2134_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to allocate regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	regulator_cfg.dev = &i2c->dev;
+	regulator_cfg.regmap = regmap;
+	for (i = 0; i < ARRAY_SIZE(rtq2134_regulator_descs); i++) {
+		rdev = devm_regulator_register(&i2c->dev,
+					       &rtq2134_regulator_descs[i].desc,
+					       &regulator_cfg);
+		if (IS_ERR(rdev)) {
+			dev_err(&i2c->dev, "Failed to init %d regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rtq2134_device_tables[] = {
+	{ .compatible = "richtek,rtq2134", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtq2134_device_tables);
+
+static struct i2c_driver rtq2134_driver = {
+	.driver = {
+		.name = "rtq2134",
+		.of_match_table = rtq2134_device_tables,
+	},
+	.probe_new = rtq2134_probe,
+};
+module_i2c_driver(rtq2134_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTQ2134 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

