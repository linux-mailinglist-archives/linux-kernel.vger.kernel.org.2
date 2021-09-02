Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B889F3FEB4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbhIBJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:30:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12638 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbhIBJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630574969; x=1662110969;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AEbKHg6JDQjcbF/xthWkf1TuEVFenWhe8v7YJbIM9oQ=;
  b=yTZ8y1G9UQCedzgRG6Er7xjYcfyFEgEbv8wbH2XWPweOVkMuNuogEn3o
   F/j6zQNfLNZwHJO+hLIlDOJpVUyP3uk1UllqWznBymCE+PBhywielR/3N
   ZwGTJj3I+ZDfuB0o2aL0dGVy4z6r1+muWS0u59SX31nEktgwWW3TMYK0B
   SCYW/SSaSl+H/VyybnTdR8idnJuteIuomRAzYYfia8eHcQro6g+q3x8DB
   pOUZwkTgAgM5smn6ngbnRno2OwJpOJGWqbDiho0MCs4Pd//Xfu0cgKQeJ
   /Idx4Iw6s87is12sASOhLDzN7mH9BjRAPj1DcjfII+LoDpl3DKl/b+N5t
   A==;
IronPort-SDR: SzzivUux2kdB9QTnBTUjdec+GSek7I3Kb4iMVJhYQqXTnZ5LhPmm9xFzaTH0rkFcii1PryVk3G
 F19z3ezIZDq+8WIvbBt6gDvIcgjwl9KlswTkXnXr4zot0JDd+LPSCQ8LxDlvK4RZaTO11UMNGJ
 a/5kb5tTFMlLisAs/3Kt30FOjO8Ajp5XElB9FJsEEJxutTWT+5v4Ur91wew0kpyiYVpHSvV9XS
 QbvnGVNij8GYVFrlCLmvuBD6Ji5Wuok1sPosETzjTH/kJ1/9VfpY52zOjNt77rtnP33gPUQzIq
 bb3n/aUKI2mTpl48oi3/fr3S
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="127995093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 02:29:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 02:29:29 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Sep 2021 02:29:25 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 2/3] clk: lan966x: Add lan966x SoC clock driver
Date:   Thu, 2 Sep 2021 14:59:23 +0530
Message-ID: <20210902092923.28313-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

This adds Generic Clock Controller driver for lan966x SoC.

Lan966x clock controller contains 3 PLLs - cpu_clk, ddr_clk
and sys_clk. It generates and supplies clock to various
peripherals within SoC.
Register settings required to provide GCK clocking to a
peripheral is as below:
GCK_SRC_SEL     = Select clock source.
GCK_PRESCALER   = Set divider value.
GCK_ENA         = 1 - Enable GCK clock.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Co-developed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/clk/clk-lan966x.c | 235 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 drivers/clk/clk-lan966x.c

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
new file mode 100644
index 000000000000..4492be90cecf
--- /dev/null
+++ b/drivers/clk/clk-lan966x.c
@@ -0,0 +1,235 @@
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
+static struct clk_init_data init;
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
+	const char *parent_names[3];
+	int i, ret;
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
+	init.num_parents = 3;
+
+	for (i = 0; i < init.num_parents; ++i) {
+		parent_names[i] = of_clk_get_parent_name(pdev->dev.of_node, i);
+		if (!parent_names[i])
+			return -EINVAL;
+	}
+
+	init.parent_names = parent_names;
+	hw_data->num = N_CLOCKS;
+
+	for (i = 0; i < N_CLOCKS; i++) {
+		init.name = clk_names[i];
+		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
+		if (IS_ERR(hw_data->hws[i])) {
+			dev_err(dev, "failed to register %s clock\n",
+				init.name);
+			return ret;
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

