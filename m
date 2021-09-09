Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB2404674
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352764AbhIIHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1044 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352727AbhIIHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631173216; x=1662709216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pXQ+1kH3Nj3W10QLxAYlywu4tFXYqhf4Ir1l3JGyc+A=;
  b=YF7FAa9J+Qj0bxaWHbX7RJrPsMNxF7404kOdgbScKWZcravWRsU/CtDV
   PQgRFghtwsR7yPccB6cetX+8qKCNU5YiFXHUq3PhH8HxGAjdSWA/vXBJ1
   VpsucGfe1xaI/lOQiC+HIvoOD6XCoCBSOfbw7WEsFS6wVMMPed+1bkrtL
   j4XexOcn46+h38K7MbtIvn+fGQK4lKb/kMQA5RY2quYNnB2bhCohURK+o
   IREuCyVJX0AREZyE57grzceUHG2FwO+82wlgD7tFKpWsR09skWgUmkwQ9
   NHO/2kg99DW2a6DtTKpnCfvOt6n0LMFUIHM+iwqANBqnh0RUgfr90M5XS
   A==;
IronPort-SDR: Tr2/HUAyFHOx5EioK24aaYowd40bI5Qc0JdRHV8+1Y466J0N+YDt3vzytMasRaah9g4GVx3SJa
 ARQk6taAJ6qmhYOihGDNglYI0v6gJEO5E/cVjySWz2HauDEnMuNVosNG3nc1GY7ZmRjdIdzN7o
 KRWtf7NaPCFl5+oSWS4vYXUX7wB6Oj+AfLTTBaOcTpJH1syKRX55nngB6hTZWozFCNxmzvMZdI
 ooYn/97MPq9e7DagQ1imG+C1MW9ecDmHeRbVGF7zJqwEAqaHFLIm1LjKivycVZSfRm2P5xC/+I
 TK9SZGk89GfPhxE9Z1Oyp/uP
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="135905491"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 00:40:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 00:40:15 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 00:40:11 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v3 2/3] clk: lan966x: Add lan966x SoC clock driver
Date:   Thu, 9 Sep 2021 13:09:46 +0530
Message-ID: <20210909073947.17438-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
References: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
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
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Co-developed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v2 -> v3:
- No changes.

v1 -> v2:
- No changes.

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

