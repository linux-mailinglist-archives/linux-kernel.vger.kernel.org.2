Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A041DB09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbhI3Na2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:30:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17460 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351292AbhI3NaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633008516; x=1664544516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Eu2hSiAI8L6vu5nvHEvLYO50NCTXA67MnLtHKRAjzVo=;
  b=wZ2LoaSgrqZdtSxLucjcmHvKhasbclaYPzs15bwoTrLhSuEuHI6Qz4Kn
   yDlG085GPoj7oh7CK1LDFQocBuwtVmY3REU6outtsMths57ASMRb0TRmx
   CIH7lYWkMJShLG2TCuCut0hBN43BooE564QqcILxTYBkQ9lrTAXzozwyh
   96/2Namo6i8+G1WwPeW0JZ6286O2UglJkewpE7nXbmaeeW5htyGR2lO9O
   Nk5/FayGhGfhRZOzHjjoDNb46Lw4kteS/CpfQWNb8ef3Hp4cqkXSM9NUb
   myLMYkmwF+ud/9v1WKDKzFoz40rDEyT2WiNy+fsjH19tTs6P04noMMBeo
   A==;
IronPort-SDR: jYAbQcu2L3MVzf4aJD7AtpqDwOJrlwi1fxaRRo597IbDiwO9zzIx0fjifkN7uLZcwGQ8cTq62l
 YxBV/qnvMJKHIgHv4vmMFocEJTagFs0pI+xocUsOX68K9rF/3fr1s+jiYp1yVWqrXVL3C1IFVI
 feEIo6XNQZIld3jajLlcGRkZfitm/xlWNH8xDoFxMP3xF0LjkYBuLtObjTl8nvrCqvk9oYAN0z
 /3Ao4FCJwYykBpwrO+tBL0Y9ZGYWOWQMNoTyJ1I3/1YoOdlJBog08fOkt1JGWG823/UOKF8Y+u
 K+jWu/5FRdaCbJPp4YNc7bz2
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="131255677"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 06:28:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 06:28:35 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 06:28:32 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v7 3/3] clk: lan966x: Add lan966x SoC clock driver
Date:   Thu, 30 Sep 2021 18:58:15 +0530
Message-ID: <20210930132815.15353-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
References: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Generic Clock Controller driver for lan966x SoC.

Lan966x clock controller contains 3 PLLs - cpu_clk, ddr_clk
and sys_clk. It generates and supplies clock to various
peripherals within SoC.
Register settings required to provide GCK clocking to a
peripheral is as below:
GCK_SRC_SEL     = Select clock source.
GCK_PRESCALER   = Set divider value.
GCK_ENA         = 1 - Enable GCK clock.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Co-developed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v6 -> v7:
- Added Kconfig and Makefile entires for lan966x clock driver.

v5 -> v6:
- No changes.

v4 -> v5:
- Returning proper error - PTR_ERR.
- Removed unused variable "ret" in probe function.

v3 -> v4:
- Used clk_parent_data instead of of_clk_get_parent_name().

v2 -> v3:
- No changes.

v1 -> v2:
- No changes.

 drivers/clk/Kconfig       |   7 ++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-lan966x.c | 236 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/clk/clk-lan966x.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c5b3dc97396a..1b992a554ff8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -221,6 +221,13 @@ config COMMON_CLK_GEMINI
 	  This driver supports the SoC clocks on the Cortina Systems Gemini
 	  platform, also known as SL3516 or CS3516.
 
+config COMMON_CLK_LAN966X
+	bool "Generic Clock Controller driver for LAN966X SoC"
+	help
+	  This driver provides support for Generic Clock Controller(GCK) on
+	  LAN966X SoC. GCK generates and supplies clock to various peripherals
+	  within the SoC.
+
 config COMMON_CLK_ASPEED
 	bool "Clock driver for Aspeed BMC SoCs"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e42312121e51..d8565ef01b34 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
 obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
 obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
+obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
 obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX9485)	+= clk-max9485.o
diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
new file mode 100644
index 000000000000..0f24b95fd78f
--- /dev/null
+++ b/drivers/clk/clk-lan966x.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Microchip LAN966x SoC Clock driver.
+ *
+ * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/microchip,lan966x.h>
+
+#define GCK_ENA         BIT(0)
+#define GCK_SRC_SEL     GENMASK(9, 8)
+#define GCK_PRESCALER   GENMASK(23, 16)
+
+static const char *clk_names[N_CLOCKS] = {
+	"qspi0", "qspi1", "qspi2", "sdmmc0",
+	"pi", "mcan0", "mcan1", "flexcom0",
+	"flexcom1", "flexcom2", "flexcom3",
+	"flexcom4", "timer", "usb_refclk",
+};
+
+struct lan966x_gck {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+#define to_lan966x_gck(hw) container_of(hw, struct lan966x_gck, hw)
+
+static const struct clk_parent_data lan966x_gck_pdata[] = {
+	{ .fw_name = "cpu_clk", .name = "cpu_clk" },
+	{ .fw_name = "ddr_clk", .name = "ddr_clk" },
+	{ .fw_name = "sys_clk", .name = "sys_clk" },
+};
+
+static struct clk_init_data init = {
+	.parent_data = lan966x_gck_pdata,
+	.num_parents = ARRAY_SIZE(lan966x_gck_pdata),
+};
+
+static void __iomem *base;
+
+static int lan966x_gck_enable(struct clk_hw *hw)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 val = readl(gck->reg);
+
+	val |= GCK_ENA;
+	writel(val, gck->reg);
+
+	return 0;
+}
+
+static void lan966x_gck_disable(struct clk_hw *hw)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 val = readl(gck->reg);
+
+	val &= ~GCK_ENA;
+	writel(val, gck->reg);
+}
+
+static int lan966x_gck_set_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 div, val = readl(gck->reg);
+
+	if (rate == 0 || parent_rate == 0)
+		return -EINVAL;
+
+	/* Set Prescalar */
+	div = parent_rate / rate;
+	val &= ~GCK_PRESCALER;
+	val |= FIELD_PREP(GCK_PRESCALER, (div - 1));
+	writel(val, gck->reg);
+
+	return 0;
+}
+
+static long lan966x_gck_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	unsigned int div;
+
+	if (rate == 0 || *parent_rate == 0)
+		return -EINVAL;
+
+	if (rate >= *parent_rate)
+		return *parent_rate;
+
+	div = DIV_ROUND_CLOSEST(*parent_rate, rate);
+
+	return *parent_rate / div;
+}
+
+static unsigned long lan966x_gck_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 div, val = readl(gck->reg);
+
+	div = FIELD_GET(GCK_PRESCALER, val);
+
+	return parent_rate / (div + 1);
+}
+
+static int lan966x_gck_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_hw *parent;
+	int i;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); ++i) {
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		if (clk_hw_get_rate(parent) / req->rate < 254) {
+			req->best_parent_hw = parent;
+			req->best_parent_rate = clk_hw_get_rate(parent);
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static u8 lan966x_gck_get_parent(struct clk_hw *hw)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 val = readl(gck->reg);
+
+	return FIELD_GET(GCK_SRC_SEL, val);
+}
+
+static int lan966x_gck_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct lan966x_gck *gck = to_lan966x_gck(hw);
+	u32 val = readl(gck->reg);
+
+	val &= ~GCK_SRC_SEL;
+	val |= FIELD_PREP(GCK_SRC_SEL, index);
+	writel(val, gck->reg);
+
+	return 0;
+}
+
+static const struct clk_ops lan966x_gck_ops = {
+	.enable         = lan966x_gck_enable,
+	.disable        = lan966x_gck_disable,
+	.set_rate       = lan966x_gck_set_rate,
+	.round_rate     = lan966x_gck_round_rate,
+	.recalc_rate    = lan966x_gck_recalc_rate,
+	.determine_rate = lan966x_gck_determine_rate,
+	.set_parent     = lan966x_gck_set_parent,
+	.get_parent     = lan966x_gck_get_parent,
+};
+
+static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
+{
+	struct lan966x_gck *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->reg = base + (i * 4);
+	priv->hw.init = &init;
+	ret = devm_clk_hw_register(dev, &priv->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &priv->hw;
+};
+
+static int lan966x_clk_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *hw_data;
+	struct device *dev = &pdev->dev;
+	int i;
+
+	hw_data = devm_kzalloc(dev, sizeof(*hw_data), GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	init.ops = &lan966x_gck_ops;
+
+	hw_data->num = N_CLOCKS;
+
+	for (i = 0; i < N_CLOCKS; i++) {
+		init.name = clk_names[i];
+		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
+		if (IS_ERR(hw_data->hws[i])) {
+			dev_err(dev, "failed to register %s clock\n",
+				init.name);
+			return PTR_ERR(hw_data->hws[i]);
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
+}
+
+static const struct of_device_id lan966x_clk_dt_ids[] = {
+	{ .compatible = "microchip,lan966x-gck", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lan966x_clk_dt_ids);
+
+static struct platform_driver lan966x_clk_driver = {
+	.probe  = lan966x_clk_probe,
+	.driver = {
+		.name = "lan966x-clk",
+		.of_match_table = lan966x_clk_dt_ids,
+	},
+};
+builtin_platform_driver(lan966x_clk_driver);
+
+MODULE_AUTHOR("Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>");
+MODULE_DESCRIPTION("LAN966X clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

