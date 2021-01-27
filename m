Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04F63061F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbhA0R1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:27:14 -0500
Received: from foss.arm.com ([217.140.110.172]:56420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235239AbhA0R0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:26:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964041042;
        Wed, 27 Jan 2021 09:25:52 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AA783F66E;
        Wed, 27 Jan 2021 09:25:50 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 02/20] clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
Date:   Wed, 27 Jan 2021 17:24:42 +0000
Message-Id: <20210127172500.13356-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks itself are identical to the H6 R-CCU, it's just that the H616
has not all of them implemented (or connected).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/clk/sunxi-ng/Kconfig           |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 48 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index ce5f5847d5d3..feeb8d2074ee 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -33,7 +33,7 @@ config SUN50I_H6_CCU
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_H6_R_CCU
-	bool "Support for the Allwinner H6 PRCM CCU"
+	bool "Support for the Allwinner H6 and H616 PRCM CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 56e351b513f3..f8909a7ed553 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -139,6 +139,16 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
 	&w1_clk.common,
 };
 
+static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
+	&r_apb1_clk.common,
+	&r_apb2_clk.common,
+	&r_apb1_twd_clk.common,
+	&r_apb2_i2c_clk.common,
+	&r_apb2_rsb_clk.common,
+	&r_apb1_ir_clk.common,
+	&ir_clk.common,
+};
+
 static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
 	.hws	= {
 		[CLK_AR100]		= &ar100_clk.common.hw,
@@ -159,6 +169,20 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
+static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
+	.hws	= {
+		[CLK_R_AHB]		= &r_ahb_clk.hw,
+		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
+		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
+		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,
+		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
+		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
+		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
+		[CLK_IR]		= &ir_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
 static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
 	[RST_R_APB1_TIMER]	=  { 0x11c, BIT(16) },
 	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
@@ -170,6 +194,13 @@ static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
 	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
 };
 
+static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
+	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
+	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
+	[RST_R_APB2_RSB]	=  { 0x1bc, BIT(16) },
+	[RST_R_APB1_IR]		=  { 0x1cc, BIT(16) },
+};
+
 static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
 	.ccu_clks	= sun50i_h6_r_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
@@ -180,6 +211,16 @@ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_h6_r_ccu_resets),
 };
 
+static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
+	.ccu_clks	= sun50i_h616_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
+
+	.hw_clks	= &sun50i_h616_r_hw_clks,
+
+	.resets		= sun50i_h616_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
+};
+
 static void __init sunxi_r_ccu_init(struct device_node *node,
 				    const struct sunxi_ccu_desc *desc)
 {
@@ -200,3 +241,10 @@ static void __init sun50i_h6_r_ccu_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
 	       sun50i_h6_r_ccu_setup);
+
+static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
+{
+	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
+}
+CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
+	       sun50i_h616_r_ccu_setup);
-- 
2.17.5

