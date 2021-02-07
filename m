Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A883121F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 07:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBGGQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 01:16:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51241 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229651AbhBGGPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 01:15:31 -0500
X-UUID: cd89827a97444605b8197eca5f9fc392-20210207
X-UUID: cd89827a97444605b8197eca5f9fc392-20210207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 985089914; Sun, 07 Feb 2021 14:14:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 14:14:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 14:14:19 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 2/3] regulator: mt6315: Add support for MT6315 regulator
Date:   Sun, 7 Feb 2021 14:14:16 +0800
Message-ID: <1612678457-11548-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6315 is a regulator found on boards based on MediaTek MT8192 and
probably other SoCs. It connects as a slave to SoC using SPMI.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v3:
- refine the mt6315 regulator for better code quality.
- remove unused registers.
---
 drivers/regulator/Kconfig                  |  10 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6315-regulator.c       | 299 +++++++++++++++++++++
 include/linux/regulator/mt6315-regulator.h |  44 +++
 4 files changed, 354 insertions(+)
 create mode 100644 drivers/regulator/mt6315-regulator.c
 create mode 100644 include/linux/regulator/mt6315-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 53fa84f4d1e1..0787a5cd64e2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -732,6 +732,16 @@ config REGULATOR_MT6311
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6315
+	tristate "MediaTek MT6315 PMIC"
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6315 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6323
 	tristate "MediaTek MT6323 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 680e539f6579..c50797e5f1f8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_REGULATOR_MP8859) += mp8859.o
 obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
+obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
new file mode 100644
index 000000000000..d49a1534d8e9
--- /dev/null
+++ b/drivers/regulator/mt6315-regulator.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2021 MediaTek Inc.
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6315-regulator.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/spmi.h>
+
+#define MT6315_BUCK_MODE_AUTO		0
+#define MT6315_BUCK_MODE_FORCE_PWM	1
+#define MT6315_BUCK_MODE_LP		2
+
+struct mt6315_regulator_info {
+	struct regulator_desc desc;
+	u32 status_reg;
+	u32 lp_mode_mask;
+	u32 lp_mode_shift;
+};
+
+struct mt_regulator_init_data {
+	u32 modeset_mask[MT6315_VBUCK_MAX];
+};
+
+struct mt6315_chip {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#define MT_BUCK(_name, _bid, _vsel)				\
+[_bid] = {							\
+	.desc = {						\
+		.name = _name,					\
+		.of_match = of_match_ptr(_name),		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6315_volt_range_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = _bid,					\
+		.owner = THIS_MODULE,				\
+		.n_voltages = 0xbf,				\
+		.linear_ranges = mt_volt_range1,		\
+		.n_linear_ranges = ARRAY_SIZE(mt_volt_range1),	\
+		.vsel_reg = _vsel,				\
+		.vsel_mask = 0xff,				\
+		.enable_reg = MT6315_BUCK_TOP_CON0,		\
+		.enable_mask = BIT(_bid),			\
+		.of_map_mode = mt6315_map_mode,			\
+	},							\
+	.status_reg = _bid##_DBG4,				\
+	.lp_mode_mask = BIT(_bid),				\
+	.lp_mode_shift = _bid,					\
+}
+
+static const struct linear_range mt_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 0xbf, 6250),
+};
+
+static unsigned int mt6315_map_mode(u32 mode)
+{
+	switch (mode) {
+	case MT6315_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	case MT6315_BUCK_MODE_FORCE_PWM:
+		return REGULATOR_MODE_FAST;
+	case MT6315_BUCK_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int mt6315_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt_regulator_init_data *init = rdev_get_drvdata(rdev);
+	const struct mt6315_regulator_info *info;
+	int ret, regval;
+	u32 modeset_mask;
+
+	info = container_of(rdev->desc, struct mt6315_regulator_info, desc);
+	modeset_mask = init->modeset_mask[rdev_get_id(rdev)];
+	ret = regmap_read(rdev->regmap, MT6315_BUCK_TOP_4PHASE_ANA_CON42, &regval);
+	if (ret != 0) {
+		dev_notice(&rdev->dev, "Failed to get mode: %d\n", ret);
+		return ret;
+	}
+
+	if ((regval & modeset_mask) == modeset_mask)
+		return REGULATOR_MODE_FAST;
+
+	ret = regmap_read(rdev->regmap, MT6315_BUCK_TOP_CON1, &regval);
+	if (ret != 0) {
+		dev_notice(&rdev->dev, "Failed to get lp mode: %d\n", ret);
+		return ret;
+	}
+
+	if (regval & info->lp_mode_mask)
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mt6315_regulator_set_mode(struct regulator_dev *rdev,
+				     u32 mode)
+{
+	struct mt_regulator_init_data *init = rdev_get_drvdata(rdev);
+	const struct mt6315_regulator_info *info;
+	int ret, val, curr_mode;
+	u32 modeset_mask;
+
+	info = container_of(rdev->desc, struct mt6315_regulator_info, desc);
+	modeset_mask = init->modeset_mask[rdev_get_id(rdev)];
+	curr_mode = mt6315_regulator_get_mode(rdev);
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = regmap_update_bits(rdev->regmap,
+					 MT6315_BUCK_TOP_4PHASE_ANA_CON42,
+					 modeset_mask,
+					 modeset_mask);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (curr_mode == REGULATOR_MODE_FAST) {
+			ret = regmap_update_bits(rdev->regmap,
+						 MT6315_BUCK_TOP_4PHASE_ANA_CON42,
+						 modeset_mask,
+						 0);
+		} else if (curr_mode == REGULATOR_MODE_IDLE) {
+			ret = regmap_update_bits(rdev->regmap,
+						 MT6315_BUCK_TOP_CON1,
+						 info->lp_mode_mask,
+						 0);
+			usleep_range(100, 110);
+		} else {
+			ret = -EINVAL;
+		}
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = MT6315_BUCK_MODE_LP >> 1;
+		val <<= info->lp_mode_shift;
+		ret = regmap_update_bits(rdev->regmap,
+					 MT6315_BUCK_TOP_CON1,
+					 info->lp_mode_mask,
+					 val);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_notice(&rdev->dev, "Unsupported mode: %d\n", mode);
+		break;
+	}
+
+	if (ret != 0) {
+		dev_notice(&rdev->dev, "Failed to set mode: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt6315_get_status(struct regulator_dev *rdev)
+{
+	const struct mt6315_regulator_info *info;
+	int ret;
+	u32 regval;
+
+	info = container_of(rdev->desc, struct mt6315_regulator_info, desc);
+	ret = regmap_read(rdev->regmap, info->status_reg, &regval);
+	if (ret < 0) {
+		dev_notice(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		return ret;
+	}
+
+	return (regval & BIT(0)) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
+}
+
+static const struct regulator_ops mt6315_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6315_get_status,
+	.set_mode = mt6315_regulator_set_mode,
+	.get_mode = mt6315_regulator_get_mode,
+};
+
+static const struct mt6315_regulator_info mt6315_regulators[MT6315_VBUCK_MAX] = {
+	MT_BUCK("vbuck1", MT6315_VBUCK1, MT6315_BUCK_TOP_ELR0),
+	MT_BUCK("vbuck2", MT6315_VBUCK2, MT6315_BUCK_TOP_ELR2),
+	MT_BUCK("vbuck3", MT6315_VBUCK3, MT6315_BUCK_TOP_ELR4),
+	MT_BUCK("vbuck4", MT6315_VBUCK4, MT6315_BUCK_TOP_ELR6),
+};
+
+static const struct regmap_config mt6315_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0x16d0,
+	.fast_io	= true,
+};
+
+static const struct of_device_id mt6315_of_match[] = {
+	{
+		.compatible = "mediatek,mt6315-regulator",
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, mt6315_of_match);
+
+static int mt6315_regulator_probe(struct spmi_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct mt6315_chip *chip;
+	struct mt_regulator_init_data *init_data;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	regmap = devm_regmap_init_spmi_ext(pdev, &mt6315_regmap_config);
+	if (!regmap)
+		return -ENODEV;
+
+	chip = devm_kzalloc(dev, sizeof(struct mt6315_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	init_data = devm_kzalloc(dev, sizeof(struct mt_regulator_init_data), GFP_KERNEL);
+	if (!init_data)
+		return -ENOMEM;
+
+	switch (pdev->usid) {
+	case MT6315_PP:
+		init_data->modeset_mask[MT6315_VBUCK1] = BIT(MT6315_VBUCK1) | BIT(MT6315_VBUCK2) |
+							 BIT(MT6315_VBUCK4);
+		break;
+	case MT6315_SP:
+	case MT6315_RP:
+		init_data->modeset_mask[MT6315_VBUCK1] = BIT(MT6315_VBUCK1) | BIT(MT6315_VBUCK2);
+		break;
+	default:
+		init_data->modeset_mask[MT6315_VBUCK1] = BIT(MT6315_VBUCK1);
+		break;
+	}
+	for (i = MT6315_VBUCK2; i < MT6315_VBUCK_MAX; i++)
+		init_data->modeset_mask[i] = BIT(i);
+
+	chip->dev = dev;
+	chip->regmap = regmap;
+	dev_set_drvdata(dev, chip);
+
+	config.dev = dev;
+	config.regmap = regmap;
+	for (i = MT6315_VBUCK1; i < MT6315_VBUCK_MAX; i++) {
+		config.driver_data = init_data;
+		rdev = devm_regulator_register(dev, &mt6315_regulators[i].desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_notice(dev, "Failed to register %s\n", mt6315_regulators[i].desc.name);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static void mt6315_regulator_shutdown(struct spmi_device *pdev)
+{
+	struct mt6315_chip *chip = dev_get_drvdata(&pdev->dev);
+	int ret = 0;
+
+	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY_H, PROTECTION_KEY_H);
+	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY, PROTECTION_KEY);
+	ret |= regmap_update_bits(chip->regmap, MT6315_TOP2_ELR7, 1, 1);
+	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY, 0);
+	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY_H, 0);
+	if (ret < 0)
+		dev_notice(&pdev->dev, "[%#x] Failed to enable power off sequence. %d\n",
+			   pdev->usid, ret);
+}
+
+static struct spmi_driver mt6315_regulator_driver = {
+	.driver		= {
+		.name	= "mt6315-regulator",
+		.of_match_table = mt6315_of_match,
+	},
+	.probe = mt6315_regulator_probe,
+	.shutdown = mt6315_regulator_shutdown,
+};
+
+module_spmi_driver(mt6315_regulator_driver);
+
+MODULE_AUTHOR("Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6315 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6315-regulator.h b/include/linux/regulator/mt6315-regulator.h
new file mode 100644
index 000000000000..3b80d3f3910c
--- /dev/null
+++ b/include/linux/regulator/mt6315-regulator.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6315_H
+#define __LINUX_REGULATOR_MT6315_H
+
+#define MT6315_RP	3
+#define MT6315_PP	6
+#define MT6315_SP	7
+
+enum {
+	MT6315_VBUCK1 = 0,
+	MT6315_VBUCK2,
+	MT6315_VBUCK3,
+	MT6315_VBUCK4,
+	MT6315_VBUCK_MAX,
+};
+
+/* Register */
+#define MT6315_TOP2_ELR7			0x139
+#define MT6315_TOP_TMA_KEY			0x39F
+#define MT6315_TOP_TMA_KEY_H			0x3A0
+#define MT6315_BUCK_TOP_CON0			0x1440
+#define MT6315_BUCK_TOP_CON1			0x1443
+#define MT6315_BUCK_TOP_ELR0			0x1449
+#define MT6315_BUCK_TOP_ELR2			0x144B
+#define MT6315_BUCK_TOP_ELR4			0x144D
+#define MT6315_BUCK_TOP_ELR6			0x144F
+#define MT6315_VBUCK1_DBG0			0x1499
+#define MT6315_VBUCK1_DBG4			0x149D
+#define MT6315_VBUCK2_DBG0			0x1519
+#define MT6315_VBUCK2_DBG4			0x151D
+#define MT6315_VBUCK3_DBG0			0x1599
+#define MT6315_VBUCK3_DBG4			0x159D
+#define MT6315_VBUCK4_DBG0			0x1619
+#define MT6315_VBUCK4_DBG4			0x161D
+#define MT6315_BUCK_TOP_4PHASE_ANA_CON42	0x16B1
+
+#define PROTECTION_KEY_H			0x9C
+#define PROTECTION_KEY				0xEA
+
+#endif /* __LINUX_REGULATOR_MT6315_H */
-- 
2.18.0

