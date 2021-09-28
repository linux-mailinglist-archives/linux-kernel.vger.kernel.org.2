Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817F941A9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbhI1HiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbhI1HiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:38:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E8C061575;
        Tue, 28 Sep 2021 00:36:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1084132pjc.3;
        Tue, 28 Sep 2021 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LskSzsSNShbQvAfLh+YBVaY4obg5XfSfewJRktZ7EGc=;
        b=newzelhrlbn2vuTJZOWcpns5Bx7qJThN07wuog904mjVGw5Pqzm3RCSI896h1xNgWP
         5OBWCXZs7Aa4AT/bhNL6chciFJL5CLn5eCdFTemvcMaiC0kTftZIX5kzqvehyxCJcc5u
         whO/ZwnmDzXYmL4qkKkc7ndsDhfBcDiXreilD3LkvmhC1xOgq9Nlsf5WTwoZQ2+Hx6L8
         4jmY/yFlUzjTVTPTduPKOwE5b7Kg2ucbOHDtSx7hW+5TCCslQLYWpRudHw8yhVcYkdB3
         DjGNPZ5Hl7trMvPgZJ3s9reeWDsBTPmP7Fu0zv9sQVLiMwblbaz/h+lwXETDI/6O2LP0
         KPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LskSzsSNShbQvAfLh+YBVaY4obg5XfSfewJRktZ7EGc=;
        b=Se+g3uzlF4cjYcnGhyk2gh05wJJ4jzqIGlGIjsNjjil2FwJw4Um9RWOKJng/SJTpWd
         i89U3ib3NROaa4H5do3LAH48ZhbJR9aCDWIXxgAAAA2XiDeKA5yXlVqj9d8JPNDqJYLn
         E/Rcjr/ySuW5HQag1oQfdwMfMD0l237GqnrQH8dufkrBCqo5bhqb0EF6IzJW7XV/uwUq
         iTIZeoPkNOZCHfMc3iW4dLMAW9U0Hd20ruPB5Ovc5UESJc/bNLyfr9dQSNFb3TcZx2Ft
         CS0pGFdbxLx0v8RjH5pEwPOK6/fG12+j7HKeZI5OUZ4bJH4IBpdYjp7ljaIhOKjF+nAz
         6WxA==
X-Gm-Message-State: AOAM533Qlht1BdZIFe6F1s0q5K4llKghL5LjkazZpgY+Qbg4DHaJsALE
        SpPhf0hRdhdVgpKIfSFZ8Ig=
X-Google-Smtp-Source: ABdhPJy5pQNzbKPrOMjwZUmyJ6iyzUuan5Exa/1klxI9jjOkfbL7xNZi9cDN/kDKQXYt6TZjazr7+w==
X-Received: by 2002:a17:90a:7d0a:: with SMTP id g10mr418266pjl.73.1632814586988;
        Tue, 28 Sep 2021 00:36:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g3sm1495757pjm.22.2021.09.28.00.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:36:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
Date:   Tue, 28 Sep 2021 15:36:08 +0800
Message-Id: <20210928073609.198975-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongfa Wang <zhongfa.wang@unisoc.com>

Add SC2730 regulator driver which is used on Unisoc's UMS512 SoC.

Signed-off-by: Zhongfa Wang <zhongfa.wang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/regulator/Kconfig            |  10 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sc2730-regulator.c | 502 +++++++++++++++++++++++++++
 3 files changed, 513 insertions(+)
 create mode 100644 drivers/regulator/sc2730-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4fd13b06231f..e1ecfc703a07 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1110,6 +1110,16 @@ config REGULATOR_S5M8767
 	 via I2C bus. S5M8767A have 9 Bucks and 28 LDOs output and
 	 supports DVS mode with 8bits of output voltage control.
 
+config REGULATOR_SC2730
+	tristate "Spreadtrum SC2730 power regulator driver"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	help
+	  This driver provides support for the voltage regulators on the
+	  SC2730 PMIC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sc2730-regulator.
+
 config REGULATOR_SC2731
 	tristate "Spreadtrum SC2731 power regulator driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 9e382b50a5ef..22ffdbde88d7 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
+obj-$(CONFIG_REGULATOR_SC2730) += sc2730-regulator.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_SLG51000) += slg51000-regulator.o
diff --git a/drivers/regulator/sc2730-regulator.c b/drivers/regulator/sc2730-regulator.c
new file mode 100644
index 000000000000..32400ab1f616
--- /dev/null
+++ b/drivers/regulator/sc2730-regulator.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2021 Unisoc Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SC2730_REGULATOR_BASE		0x1800
+
+/*
+ * SC2730 regulator lock register
+ */
+#define SC2730_WR_UNLOCK_VALUE		0x6e7f
+#define SC2730_PWR_WR_PROT		(SC2730_REGULATOR_BASE + 0x3d0)
+
+/*
+ * SC2730 enable register
+ */
+#define SC2730_POWER_PD_SW		(SC2730_REGULATOR_BASE + 0x01c)
+#define SC2730_LDO_VDDRF18_PD		(SC2730_REGULATOR_BASE + 0x10c)
+#define SC2730_LDO_VDDCAMIO_PD		(SC2730_REGULATOR_BASE + 0x118)
+#define SC2730_LDO_VDDWCN_PD		(SC2730_REGULATOR_BASE + 0x11c)
+#define SC2730_LDO_VDDCAMD1_PD		(SC2730_REGULATOR_BASE + 0x128)
+#define SC2730_LDO_VDDCAMD0_PD		(SC2730_REGULATOR_BASE + 0x134)
+#define SC2730_LDO_VDDRF1V25_PD		(SC2730_REGULATOR_BASE + 0x140)
+#define SC2730_LDO_AVDD12_PD		(SC2730_REGULATOR_BASE + 0x14c)
+#define SC2730_LDO_VDDCAMA0_PD		(SC2730_REGULATOR_BASE + 0x158)
+#define SC2730_LDO_VDDCAMA1_PD		(SC2730_REGULATOR_BASE + 0x164)
+#define SC2730_LDO_VDDCAMMOT_PD		(SC2730_REGULATOR_BASE + 0x170)
+#define SC2730_LDO_VDDSIM2_PD		(SC2730_REGULATOR_BASE + 0x194)
+#define SC2730_LDO_VDDEMMCCORE_PD	(SC2730_REGULATOR_BASE + 0x1a0)
+#define SC2730_LDO_VDDSDCORE_PD		(SC2730_REGULATOR_BASE + 0x1ac)
+#define SC2730_LDO_VDDSDIO_PD		(SC2730_REGULATOR_BASE + 0x1b8)
+#define SC2730_LDO_VDDWIFIPA_PD		(SC2730_REGULATOR_BASE + 0x1d0)
+#define SC2730_LDO_VDDUSB33_PD		(SC2730_REGULATOR_BASE + 0x1e8)
+#define SC2730_LDO_VDDLDO0_PD		(SC2730_REGULATOR_BASE + 0x1f4)
+#define SC2730_LDO_VDDLDO1_PD		(SC2730_REGULATOR_BASE + 0x200)
+#define SC2730_LDO_VDDLDO2_PD		(SC2730_REGULATOR_BASE + 0x20c)
+#define SC2730_LDO_VDDKPLED_PD		(SC2730_REGULATOR_BASE + 0x38c)
+
+/*
+ * SC2730 enable mask
+ */
+#define SC2730_DCDC_CPU_PD_MASK		BIT(4)
+#define SC2730_DCDC_GPU_PD_MASK		BIT(3)
+#define SC2730_DCDC_CORE_PD_MASK	BIT(5)
+#define SC2730_DCDC_MODEM_PD_MASK	BIT(11)
+#define SC2730_DCDC_MEM_PD_MASK		BIT(6)
+#define SC2730_DCDC_MEMQ_PD_MASK	BIT(12)
+#define SC2730_DCDC_GEN0_PD_MASK	BIT(8)
+#define SC2730_DCDC_GEN1_PD_MASK	BIT(7)
+#define SC2730_DCDC_SRAM_PD_MASK	BIT(13)
+#define SC2730_LDO_AVDD18_PD_MASK	BIT(2)
+#define SC2730_LDO_VDDRF18_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMIO_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDWCN_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMD1_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMD0_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDRF1V25_PD_MASK	BIT(0)
+#define SC2730_LDO_AVDD12_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMA0_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMA1_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDCAMMOT_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDSIM2_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDEMMCCORE_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDSDCORE_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDSDIO_PD_MASK	BIT(0)
+#define SC2730_LDO_VDD28_PD_MASK	BIT(1)
+#define SC2730_LDO_VDDWIFIPA_PD_MASK	BIT(0)
+#define SC2730_LDO_VDD18_DCXO_PD_MASK	BIT(10)
+#define SC2730_LDO_VDDUSB33_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDLDO0_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDLDO1_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDLDO2_PD_MASK	BIT(0)
+#define SC2730_LDO_VDDKPLED_PD_MASK	BIT(15)
+
+/*
+ * SC2730 vsel register
+ */
+#define SC2730_DCDC_CPU_VOL		(SC2730_REGULATOR_BASE + 0x44)
+#define SC2730_DCDC_GPU_VOL		(SC2730_REGULATOR_BASE + 0x54)
+#define SC2730_DCDC_CORE_VOL		(SC2730_REGULATOR_BASE + 0x64)
+#define SC2730_DCDC_MODEM_VOL		(SC2730_REGULATOR_BASE + 0x74)
+#define SC2730_DCDC_MEM_VOL		(SC2730_REGULATOR_BASE + 0x84)
+#define SC2730_DCDC_MEMQ_VOL		(SC2730_REGULATOR_BASE + 0x94)
+#define SC2730_DCDC_GEN0_VOL		(SC2730_REGULATOR_BASE + 0xa4)
+#define SC2730_DCDC_GEN1_VOL		(SC2730_REGULATOR_BASE + 0xb4)
+#define SC2730_DCDC_SRAM_VOL		(SC2730_REGULATOR_BASE + 0xdc)
+#define SC2730_LDO_AVDD18_VOL		(SC2730_REGULATOR_BASE + 0x104)
+#define SC2730_LDO_VDDRF18_VOL		(SC2730_REGULATOR_BASE + 0x110)
+#define SC2730_LDO_VDDCAMIO_VOL		(SC2730_REGULATOR_BASE + 0x28)
+#define SC2730_LDO_VDDWCN_VOL		(SC2730_REGULATOR_BASE + 0x120)
+#define SC2730_LDO_VDDCAMD1_VOL		(SC2730_REGULATOR_BASE + 0x12c)
+#define SC2730_LDO_VDDCAMD0_VOL		(SC2730_REGULATOR_BASE + 0x138)
+#define SC2730_LDO_VDDRF1V25_VOL	(SC2730_REGULATOR_BASE + 0x144)
+#define SC2730_LDO_AVDD12_VOL		(SC2730_REGULATOR_BASE + 0x150)
+#define SC2730_LDO_VDDCAMA0_VOL		(SC2730_REGULATOR_BASE + 0x15c)
+#define SC2730_LDO_VDDCAMA1_VOL		(SC2730_REGULATOR_BASE + 0x168)
+#define SC2730_LDO_VDDCAMMOT_VOL	(SC2730_REGULATOR_BASE + 0x174)
+#define SC2730_LDO_VDDSIM2_VOL		(SC2730_REGULATOR_BASE + 0x198)
+#define SC2730_LDO_VDDEMMCCORE_VOL	(SC2730_REGULATOR_BASE + 0x1a4)
+#define SC2730_LDO_VDDSDCORE_VOL	(SC2730_REGULATOR_BASE + 0x1b0)
+#define SC2730_LDO_VDDSDIO_VOL		(SC2730_REGULATOR_BASE + 0x1bc)
+#define SC2730_LDO_VDD28_VOL		(SC2730_REGULATOR_BASE + 0x1c8)
+#define SC2730_LDO_VDDWIFIPA_VOL	(SC2730_REGULATOR_BASE + 0x1d4)
+#define SC2730_LDO_VDD18_DCXO_VOL	(SC2730_REGULATOR_BASE + 0x1e0)
+#define SC2730_LDO_VDDUSB33_VOL		(SC2730_REGULATOR_BASE + 0x1ec)
+#define SC2730_LDO_VDDLDO0_VOL		(SC2730_REGULATOR_BASE + 0x1f8)
+#define SC2730_LDO_VDDLDO1_VOL		(SC2730_REGULATOR_BASE + 0x204)
+#define SC2730_LDO_VDDLDO2_VOL		(SC2730_REGULATOR_BASE + 0x210)
+#define SC2730_LDO_VDDKPLED_VOL		(SC2730_REGULATOR_BASE + 0x38c)
+
+/*
+ * SC2730 vsel register mask
+ */
+#define SC2730_DCDC_CPU_VOL_MASK	GENMASK(8, 0)
+#define SC2730_DCDC_GPU_VOL_MASK	GENMASK(8, 0)
+#define SC2730_DCDC_CORE_VOL_MASK	GENMASK(8, 0)
+#define SC2730_DCDC_MODEM_VOL_MASK	GENMASK(8, 0)
+#define SC2730_DCDC_MEM_VOL_MASK	GENMASK(7, 0)
+#define SC2730_DCDC_MEMQ_VOL_MASK	GENMASK(8, 0)
+#define SC2730_DCDC_GEN0_VOL_MASK	GENMASK(7, 0)
+#define SC2730_DCDC_GEN1_VOL_MASK	GENMASK(7, 0)
+#define SC2730_DCDC_SRAM_VOL_MASK	GENMASK(8, 0)
+#define SC2730_LDO_AVDD18_VOL_MASK	GENMASK(5, 0)
+#define SC2730_LDO_VDDRF18_VOL_MASK	GENMASK(5, 0)
+#define SC2730_LDO_VDDCAMIO_VOL_MASK	GENMASK(5, 0)
+#define SC2730_LDO_VDDWCN_VOL_MASK	GENMASK(5, 0)
+#define SC2730_LDO_VDDCAMD1_VOL_MASK	GENMASK(4, 0)
+#define SC2730_LDO_VDDCAMD0_VOL_MASK	GENMASK(4, 0)
+#define SC2730_LDO_VDDRF1V25_VOL_MASK	GENMASK(4, 0)
+#define SC2730_LDO_AVDD12_VOL_MASK	GENMASK(4, 0)
+#define SC2730_LDO_VDDCAMA0_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDCAMA1_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDCAMMOT_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDSIM2_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDEMMCCORE_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDSDCORE_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDSDIO_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDD28_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDWIFIPA_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDD18_DCXO_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDUSB33_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDLDO0_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDLDO1_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDLDO2_VOL_MASK	GENMASK(7, 0)
+#define SC2730_LDO_VDDKPLED_VOL_MASK	GENMASK(14, 7)
+
+enum sc2730_regulator_id {
+	SC2730_DCDC_CPU,
+	SC2730_DCDC_GPU,
+	SC2730_DCDC_CORE,
+	SC2730_DCDC_MODEM,
+	SC2730_DCDC_MEM,
+	SC2730_DCDC_MEMQ,
+	SC2730_DCDC_GEN0,
+	SC2730_DCDC_GEN1,
+	SC2730_DCDC_SRAM,
+	SC2730_LDO_AVDD18,
+	SC2730_LDO_VDDRF18,
+	SC2730_LDO_VDDCAMIO,
+	SC2730_LDO_VDDWCN,
+	SC2730_LDO_VDDCAMD1,
+	SC2730_LDO_VDDCAMD0,
+	SC2730_LDO_VDDRF1V25,
+	SC2730_LDO_AVDD12,
+	SC2730_LDO_VDDCAMA0,
+	SC2730_LDO_VDDCAMA1,
+	SC2730_LDO_VDDCAMMOT,
+	SC2730_LDO_VDDSIM0,
+	SC2730_LDO_VDDSIM1,
+	SC2730_LDO_VDDSIM2,
+	SC2730_LDO_VDDEMMCCORE,
+	SC2730_LDO_VDDSDCORE,
+	SC2730_LDO_VDDSDIO,
+	SC2730_LDO_VDD28,
+	SC2730_LDO_VDDWIFIPA,
+	SC2730_LDO_VDD18_DCXO,
+	SC2730_LDO_VDDUSB33,
+	SC2730_LDO_VDDLDO0,
+	SC2730_LDO_VDDLDO1,
+	SC2730_LDO_VDDLDO2,
+	SC2730_LDO_VDDKPLED,
+};
+
+static struct dentry *debugfs_root;
+
+static const struct regulator_ops sc2730_regu_linear_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+#define SC2730_REGU_LINEAR(_id, en_reg, en_mask, vreg, vmask,	\
+			  vstep, vmin, vmax, min_sel) {		\
+	.name			= #_id,				\
+	.of_match		= of_match_ptr(#_id),		\
+	.ops			= &sc2730_regu_linear_ops,	\
+	.type			= REGULATOR_VOLTAGE,		\
+	.id			= SC2730_##_id,			\
+	.owner			= THIS_MODULE,			\
+	.min_uV			= vmin,				\
+	.n_voltages		= ((vmax) - (vmin)) / (vstep) + 1,	\
+	.uV_step		= vstep,			\
+	.enable_is_inverted	= true,				\
+	.enable_val		= 0,				\
+	.enable_reg		= en_reg,			\
+	.enable_mask		= en_mask,			\
+	.vsel_reg		= vreg,				\
+	.vsel_mask		= vmask,			\
+	.linear_min_sel		= min_sel,			\
+}
+
+static struct regulator_desc regulators[] = {
+	SC2730_REGU_LINEAR(DCDC_CPU, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_CPU_PD_MASK, SC2730_DCDC_CPU_VOL,
+			   SC2730_DCDC_CPU_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_GPU, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_GPU_PD_MASK, SC2730_DCDC_GPU_VOL,
+			   SC2730_DCDC_GPU_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_CORE, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_CORE_PD_MASK, SC2730_DCDC_CORE_VOL,
+			   SC2730_DCDC_CORE_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_MODEM, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_MODEM_PD_MASK, SC2730_DCDC_MODEM_VOL,
+			   SC2730_DCDC_MODEM_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_MEM, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_MEM_PD_MASK, SC2730_DCDC_MEM_VOL,
+			   SC2730_DCDC_MEM_VOL_MASK, 6250, 0, 1593750,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_MEMQ, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_MEMQ_PD_MASK, SC2730_DCDC_MEMQ_VOL,
+			   SC2730_DCDC_MEMQ_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_GEN0, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_GEN0_PD_MASK, SC2730_DCDC_GEN0_VOL,
+			   SC2730_DCDC_GEN0_VOL_MASK, 9375, 20000, 2410625,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_GEN1, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_GEN1_PD_MASK, SC2730_DCDC_GEN1_VOL,
+			   SC2730_DCDC_GEN1_VOL_MASK, 6250, 50000, 1643750,
+			   0),
+	SC2730_REGU_LINEAR(DCDC_SRAM, SC2730_POWER_PD_SW,
+			   SC2730_DCDC_SRAM_PD_MASK, SC2730_DCDC_SRAM_VOL,
+			   SC2730_DCDC_SRAM_VOL_MASK, 3125, 0, 1596875,
+			   0),
+	SC2730_REGU_LINEAR(LDO_AVDD18, SC2730_POWER_PD_SW,
+			   SC2730_LDO_AVDD18_PD_MASK, SC2730_LDO_AVDD18_VOL,
+			   SC2730_LDO_AVDD18_VOL_MASK, 10000, 1175000, 1805000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDRF18, SC2730_LDO_VDDRF18_PD,
+			   SC2730_LDO_VDDRF18_PD_MASK, SC2730_LDO_VDDRF18_VOL,
+			   SC2730_LDO_VDDRF18_VOL_MASK, 10000, 1175000, 1805000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMIO, SC2730_LDO_VDDCAMIO_PD,
+			   SC2730_LDO_VDDCAMIO_PD_MASK, SC2730_LDO_VDDCAMIO_VOL,
+			   SC2730_LDO_VDDCAMIO_VOL_MASK, 10000, 1200000,
+			   1830000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDWCN, SC2730_LDO_VDDWCN_PD,
+			   SC2730_LDO_VDDWCN_PD_MASK, SC2730_LDO_VDDWCN_VOL,
+			   SC2730_LDO_VDDWCN_VOL_MASK, 15000, 900000, 1845000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMD1, SC2730_LDO_VDDCAMD1_PD,
+			   SC2730_LDO_VDDCAMD1_PD_MASK, SC2730_LDO_VDDCAMD1_VOL,
+			   SC2730_LDO_VDDCAMD1_VOL_MASK, 15000, 900000,
+			   1365000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMD0, SC2730_LDO_VDDCAMD0_PD,
+			   SC2730_LDO_VDDCAMD0_PD_MASK, SC2730_LDO_VDDCAMD0_VOL,
+			   SC2730_LDO_VDDCAMD0_VOL_MASK, 15000, 900000,
+			   1365000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDRF1V25, SC2730_LDO_VDDRF1V25_PD,
+			   SC2730_LDO_VDDRF1V25_PD_MASK,
+			   SC2730_LDO_VDDRF1V25_VOL,
+			   SC2730_LDO_VDDRF1V25_VOL_MASK, 15000, 900000,
+			   1365000, 0),
+	SC2730_REGU_LINEAR(LDO_AVDD12, SC2730_LDO_AVDD12_PD,
+			   SC2730_LDO_AVDD12_PD_MASK, SC2730_LDO_AVDD12_VOL,
+			   SC2730_LDO_AVDD12_VOL_MASK, 15000, 900000, 1365000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMA0, SC2730_LDO_VDDCAMA0_PD,
+			   SC2730_LDO_VDDCAMA0_PD_MASK, SC2730_LDO_VDDCAMA0_VOL,
+			   SC2730_LDO_VDDCAMA0_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMA1, SC2730_LDO_VDDCAMA1_PD,
+			   SC2730_LDO_VDDCAMA1_PD_MASK, SC2730_LDO_VDDCAMA1_VOL,
+			   SC2730_LDO_VDDCAMA1_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDCAMMOT, SC2730_LDO_VDDCAMMOT_PD,
+			   SC2730_LDO_VDDCAMMOT_PD_MASK,
+			   SC2730_LDO_VDDCAMMOT_VOL,
+			   SC2730_LDO_VDDCAMMOT_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDSIM2, SC2730_LDO_VDDSIM2_PD,
+			   SC2730_LDO_VDDSIM2_PD_MASK, SC2730_LDO_VDDSIM2_VOL,
+			   SC2730_LDO_VDDSIM2_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDEMMCCORE, SC2730_LDO_VDDEMMCCORE_PD,
+			   SC2730_LDO_VDDEMMCCORE_PD_MASK,
+			   SC2730_LDO_VDDEMMCCORE_VOL,
+			   SC2730_LDO_VDDEMMCCORE_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDSDCORE, SC2730_LDO_VDDSDCORE_PD,
+			   SC2730_LDO_VDDSDCORE_PD_MASK,
+			   SC2730_LDO_VDDSDCORE_VOL,
+			   SC2730_LDO_VDDSDCORE_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDSDIO, SC2730_LDO_VDDSDIO_PD,
+			   SC2730_LDO_VDDSDIO_PD_MASK, SC2730_LDO_VDDSDIO_VOL,
+			   SC2730_LDO_VDDSDIO_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDD28, SC2730_POWER_PD_SW,
+			   SC2730_LDO_VDD28_PD_MASK, SC2730_LDO_VDD28_VOL,
+			   SC2730_LDO_VDD28_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDWIFIPA, SC2730_LDO_VDDWIFIPA_PD,
+			   SC2730_LDO_VDDWIFIPA_PD_MASK,
+			   SC2730_LDO_VDDWIFIPA_VOL,
+			   SC2730_LDO_VDDWIFIPA_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDD18_DCXO, SC2730_POWER_PD_SW,
+			   SC2730_LDO_VDD18_DCXO_PD_MASK,
+			   SC2730_LDO_VDD18_DCXO_VOL,
+			   SC2730_LDO_VDD18_DCXO_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDUSB33, SC2730_LDO_VDDUSB33_PD,
+			   SC2730_LDO_VDDUSB33_PD_MASK, SC2730_LDO_VDDUSB33_VOL,
+			   SC2730_LDO_VDDUSB33_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+	SC2730_REGU_LINEAR(LDO_VDDLDO0, SC2730_LDO_VDDLDO0_PD,
+			   SC2730_LDO_VDDLDO0_PD_MASK, SC2730_LDO_VDDLDO0_VOL,
+			   SC2730_LDO_VDDLDO0_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDLDO1, SC2730_LDO_VDDLDO1_PD,
+			   SC2730_LDO_VDDLDO1_PD_MASK, SC2730_LDO_VDDLDO1_VOL,
+			   SC2730_LDO_VDDLDO1_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDLDO2, SC2730_LDO_VDDLDO2_PD,
+			   SC2730_LDO_VDDLDO2_PD_MASK, SC2730_LDO_VDDLDO2_VOL,
+			   SC2730_LDO_VDDLDO2_VOL_MASK, 10000, 1200000, 3750000,
+			   0),
+	SC2730_REGU_LINEAR(LDO_VDDKPLED, SC2730_LDO_VDDKPLED_PD,
+			   SC2730_LDO_VDDKPLED_PD_MASK, SC2730_LDO_VDDKPLED_VOL,
+			   SC2730_LDO_VDDKPLED_VOL_MASK, 10000, 1200000,
+			   3750000, 0),
+};
+
+static int debugfs_enable_get(void *data, u64 *val)
+{
+	struct regulator_dev *rdev = data;
+
+	if (rdev && rdev->desc->ops->is_enabled)
+		*val = rdev->desc->ops->is_enabled(rdev);
+	else
+		*val = ~0ULL;
+	return 0;
+}
+
+static int debugfs_enable_set(void *data, u64 val)
+{
+	struct regulator_dev *rdev = data;
+
+	if (rdev && rdev->desc->ops->enable && rdev->desc->ops->disable) {
+		if (val)
+			rdev->desc->ops->enable(rdev);
+		else
+			rdev->desc->ops->disable(rdev);
+	}
+
+	return 0;
+}
+
+static int debugfs_voltage_get(void *data, u64 *val)
+{
+	int sel, ret;
+	struct regulator_dev *rdev = data;
+
+	sel = rdev->desc->ops->get_voltage_sel(rdev);
+	if (sel < 0)
+		return sel;
+
+	ret = rdev->desc->ops->list_voltage(rdev, sel);
+
+	*val = ret / 1000;
+
+	return 0;
+}
+
+static int debugfs_voltage_set(void *data, u64 val)
+{
+	int selector;
+	struct regulator_dev *rdev = data;
+
+	val = val * 1000;
+	selector = regulator_map_voltage_linear(rdev,
+						val - rdev->desc->uV_step / 2,
+						val + rdev->desc->uV_step / 2);
+
+	return rdev->desc->ops->set_voltage_sel(rdev, selector);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_enable,
+			debugfs_enable_get, debugfs_enable_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(fops_ldo,
+			debugfs_voltage_get, debugfs_voltage_set, "%llu\n");
+
+static void sc2730_regulator_debugfs_init(struct regulator_dev *rdev)
+{
+
+	debugfs_root = debugfs_create_dir(rdev->desc->name, NULL);
+
+	if (IS_ERR_OR_NULL(debugfs_root)) {
+		dev_warn(&rdev->dev, "Failed to create debugfs directory\n");
+		rdev->debugfs = NULL;
+		return;
+	}
+
+	debugfs_create_file("enable", 0644,
+			    debugfs_root, rdev, &fops_enable);
+	debugfs_create_file("voltage", 0644,
+			    debugfs_root, rdev, &fops_ldo);
+}
+
+static int sc2730_regulator_unlock(struct regmap *regmap)
+{
+	return regmap_write(regmap, SC2730_PWR_WR_PROT,
+			    SC2730_WR_UNLOCK_VALUE);
+}
+
+static int sc2730_regulator_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	struct regmap *regmap;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "failed to get regmap.\n");
+		return -ENODEV;
+	}
+
+	ret = sc2730_regulator_unlock(regmap);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to release regulator lock\n");
+		return ret;
+	}
+
+	config.dev = &pdev->dev;
+	config.regmap = regmap;
+
+	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register regulator %s\n",
+				regulators[i].name);
+			return PTR_ERR(rdev);
+		}
+
+		sc2730_regulator_debugfs_init(rdev);
+	}
+
+	return 0;
+}
+
+static int sc2730_regulator_remove(struct platform_device *pdev)
+{
+	debugfs_remove_recursive(debugfs_root);
+	return 0;
+}
+
+static const struct of_device_id sc2730_regulator_match[] = {
+	{ .compatible = "sprd,sc2730-regulator" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sc2730_regulator_match);
+
+static struct platform_driver sc2730_regulator_driver = {
+	.driver = {
+		.name = "sc2730-regulator",
+		.of_match_table = sc2730_regulator_match,
+	},
+	.probe = sc2730_regulator_probe,
+	.remove = sc2730_regulator_remove,
+};
+module_platform_driver(sc2730_regulator_driver);
+
+MODULE_DESCRIPTION("Unisoc SC2730 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

