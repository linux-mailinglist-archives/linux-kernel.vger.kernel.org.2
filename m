Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA593FD2B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbhIAFGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34713 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241932AbhIAFGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A2D045C01DB;
        Wed,  1 Sep 2021 01:05:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 01:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WNxuoMCYDmq5i
        viwux3z95XOQBk0bM34zKf5K/8nI6A=; b=jene/l8V/0ZhdTTOBcrNiwxcnb3U3
        ZBnBbufsOkoxf+4yQ6lJJF9FoMkiwSrlSo+BoyJc4zu0LgQppYZn7OfSX/KF3lCV
        v1jQSukG/ORkThF/1/vOmPZG1tm8f0ZX2JYDdwM3IO/6Ut9bnmTVGXoZ5q/qzpkS
        5yO6fKfVBcLjh0FQDQWAMEPpvNHCACnv6Wa9ZpBF759SEt8rWBVPBvK9MnlD/3yk
        XxiIyC02LAC3zMgxIAevA6F7gZC4/fUBUzDCvpHbx519Tsfovh0PbgP5/NX3n7sR
        nQ9OxjvWKRSkAZxjXtEjble4UypRRDxzzHLwI5kTtX19JGQ8qI/QoYY5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WNxuoMCYDmq5iviwux3z95XOQBk0bM34zKf5K/8nI6A=; b=J76t+Nci
        p7QvezC0iVBxk5XZop9fwne2v8TJt/oX4EBT0jZiZwsbTo/awE/URYBf/s45ekUU
        Zd3mHP8Dzuuz5T3gQ4rgb71zRjqOJzblQWqCSQpHSXpTHYQAGsEb5nQJv4K9lpHC
        7xPzj3Wp8ZGhWHrAbH7kPYAQ9IZvn+Uu1wFDFcZ53DQ0eYT3e2AWzu556pSep6by
        +83/SvzfAIMuIZjlgF1FsWTGrBdEKig/KOA42+qz8tbk5X/p0FclIV1DP3AzePnT
        LBk0G2oBIhUh61ES173oKcvGVuCFRRmKZE6jMNb86NqzOHvYiKOytUhItcZXIHOs
        7kWrYxwVzoLkOQ==
X-ME-Sender: <xms:IAovYYAwsdTejeTwfnLN1Z-64ds_WoNz0sBojhI_CW3rLmVLlzJXiA>
    <xme:IAovYajC-r5SNae8cRnl96zqgmjifD4ZgKs2LH-PbfXBgHi9H8pTwZ4_dRQNK23Mv
    353CRJRfpmN9TrX4g>
X-ME-Received: <xmr:IAovYbkp6LWOaQMrcJQmdAk324TWdCsOdKmPQNPSsTh8PBrvZglLPb6q5F5uPNPJsAdHh-kvvIqDTE9-7V3o3_lV6LP9tn7oi78BGd5sGqjjoJsf2r5IHHE1FCdSVqugrLQmsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:IAovYexlxTJBxv7yKnIRxIns5GppaGIztpNbyPQ2OKpVKbV66kSpLw>
    <xmx:IAovYdQxctHEHufCMzdYjjmEL09WcoodlsQEQxKkyZSUi0HDkPNqGQ>
    <xmx:IAovYZZLug7y16aIDuv2-JR88WOZhZ17zSS66QFsSLeDEpm0q5Rvpw>
    <xmx:IAovYYHyyH8gEGV0HO21kOLSyOVAmlWiUlu5ibdqNa6DM0og2s6t_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/8] clk: sunxi-ng: Convert early providers to platform drivers
Date:   Wed,  1 Sep 2021 00:05:25 -0500
Message-Id: <20210901050526.45673-8-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRCM CCU drivers depend on clocks provided by other CCU drivers. For
example, the sun8i-r-ccu driver uses the "pll-periph" clock provided by
the SoC's main CCU.

However, sun8i-r-ccu is an early OF clock provider, and many of the
main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means that
the consumer clocks will be orphaned until the supplier driver is bound.
This can be avoided by converting the remaining CCUs to use platform
drivers. Then fw_devlink will ensure the drivers are bound in the
optimal order.

The sun5i CCU is the only one which actually needs to be an early clock
provider, because it provides the clock for the system timer. That one
is left alone.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/Kconfig             | 20 ++++----
 drivers/clk/sunxi-ng/sun4i-a10-ccu.c     | 57 +++++++++++++--------
 drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c   | 55 ++++++++++++--------
 drivers/clk/sunxi-ng/sun50i-h616-ccu.c   | 32 ++++++++----
 drivers/clk/sunxi-ng/sun6i-a31-ccu.c     | 39 +++++++++++----
 drivers/clk/sunxi-ng/sun8i-a23-ccu.c     | 34 +++++++++----
 drivers/clk/sunxi-ng/sun8i-a33-ccu.c     | 39 +++++++++++----
 drivers/clk/sunxi-ng/sun8i-h3-ccu.c      | 61 ++++++++++++++--------
 drivers/clk/sunxi-ng/sun8i-r-ccu.c       | 64 ++++++++++++++----------
 drivers/clk/sunxi-ng/sun8i-v3s-ccu.c     | 56 +++++++++++++--------
 drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c | 37 ++++++++++----
 11 files changed, 322 insertions(+), 172 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 7cfdf21717f7..cbae3612a9ef 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -8,7 +8,7 @@ config SUNXI_CCU
 if SUNXI_CCU
 
 config SUNIV_F1C100S_CCU
-	bool "Support for the Allwinner newer F1C100s CCU"
+	tristate "Support for the Allwinner newer F1C100s CCU"
 	default MACH_SUNIV
 	depends on MACH_SUNIV || COMPILE_TEST
 
@@ -33,17 +33,17 @@ config SUN50I_H6_CCU
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_H616_CCU
-	bool "Support for the Allwinner H616 CCU"
+	tristate "Support for the Allwinner H616 CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN50I_H6_R_CCU
-	bool "Support for the Allwinner H6 and H616 PRCM CCU"
+	tristate "Support for the Allwinner H6 and H616 PRCM CCU"
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN4I_A10_CCU
-	bool "Support for the Allwinner A10/A20 CCU"
+	tristate "Support for the Allwinner A10/A20 CCU"
 	default MACH_SUN4I
 	default MACH_SUN7I
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
@@ -54,17 +54,17 @@ config SUN5I_CCU
 	depends on MACH_SUN5I || COMPILE_TEST
 
 config SUN6I_A31_CCU
-	bool "Support for the Allwinner A31/A31s CCU"
+	tristate "Support for the Allwinner A31/A31s CCU"
 	default MACH_SUN6I
 	depends on MACH_SUN6I || COMPILE_TEST
 
 config SUN8I_A23_CCU
-	bool "Support for the Allwinner A23 CCU"
+	tristate "Support for the Allwinner A23 CCU"
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A33_CCU
-	bool "Support for the Allwinner A33 CCU"
+	tristate "Support for the Allwinner A33 CCU"
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
@@ -73,12 +73,12 @@ config SUN8I_A83T_CCU
 	default MACH_SUN8I
 
 config SUN8I_H3_CCU
-	bool "Support for the Allwinner H3 CCU"
+	tristate "Support for the Allwinner H3 CCU"
 	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN8I_V3S_CCU
-	bool "Support for the Allwinner V3s CCU"
+	tristate "Support for the Allwinner V3s CCU"
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
@@ -97,7 +97,7 @@ config SUN9I_A80_CCU
 	depends on MACH_SUN9I || COMPILE_TEST
 
 config SUN8I_R_CCU
-	bool "Support for Allwinner SoCs' PRCM CCUs"
+	tristate "Support for Allwinner SoCs' PRCM CCUs"
 	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
 
 endif
diff --git a/drivers/clk/sunxi-ng/sun4i-a10-ccu.c b/drivers/clk/sunxi-ng/sun4i-a10-ccu.c
index 5d67f5666943..027b9667f472 100644
--- a/drivers/clk/sunxi-ng/sun4i-a10-ccu.c
+++ b/drivers/clk/sunxi-ng/sun4i-a10-ccu.c
@@ -7,7 +7,9 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1425,18 +1427,19 @@ static const struct sunxi_ccu_desc sun7i_a20_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sunxi_a10_a20_ccu_resets),
 };
 
-static void __init sun4i_ccu_init(struct device_node *node,
-				  const struct sunxi_ccu_desc *desc)
+static int sun4i_a10_ccu_probe(struct platform_device *pdev)
 {
+	const struct sunxi_ccu_desc *desc;
 	void __iomem *reg;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%s: Could not map the clock registers\n",
-		       of_node_full_name(node));
-		return;
-	}
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	val = readl(reg + SUN4I_PLL_AUDIO_REG);
 
@@ -1464,19 +1467,29 @@ static void __init sun4i_ccu_init(struct device_node *node,
 	val &= ~GENMASK(7, 6);
 	writel(val | (2 << 6), reg + SUN4I_AHB_REG);
 
-	of_sunxi_ccu_probe(node, reg, desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
 }
 
-static void __init sun4i_a10_ccu_setup(struct device_node *node)
-{
-	sun4i_ccu_init(node, &sun4i_a10_ccu_desc);
-}
-CLK_OF_DECLARE(sun4i_a10_ccu, "allwinner,sun4i-a10-ccu",
-	       sun4i_a10_ccu_setup);
+static const struct of_device_id sun4i_a10_ccu_ids[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-ccu",
+		.data = &sun4i_a10_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-ccu",
+		.data = &sun7i_a20_ccu_desc,
+	},
+	{ }
+};
 
-static void __init sun7i_a20_ccu_setup(struct device_node *node)
-{
-	sun4i_ccu_init(node, &sun7i_a20_ccu_desc);
-}
-CLK_OF_DECLARE(sun7i_a20_ccu, "allwinner,sun7i-a20-ccu",
-	       sun7i_a20_ccu_setup);
+static struct platform_driver sun4i_a10_ccu_driver = {
+	.probe	= sun4i_a10_ccu_probe,
+	.driver	= {
+		.name			= "sun4i-a10-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun4i_a10_ccu_ids,
+	},
+};
+module_platform_driver(sun4i_a10_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c b/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
index bb7f9ed78c4c..2b2f809fd090 100644
--- a/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
@@ -4,7 +4,8 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -221,30 +222,42 @@ static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
 };
 
-static void __init sunxi_r_ccu_init(struct device_node *node,
-				    const struct sunxi_ccu_desc *desc)
+static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
 {
+	const struct sunxi_ccu_desc *desc;
 	void __iomem *reg;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
 
-	of_sunxi_ccu_probe(node, reg, desc);
-}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
-static void __init sun50i_h6_r_ccu_setup(struct device_node *node)
-{
-	sunxi_r_ccu_init(node, &sun50i_h6_r_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
 }
-CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
-	       sun50i_h6_r_ccu_setup);
 
-static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
-{
-	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
-}
-CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
-	       sun50i_h616_r_ccu_setup);
+static const struct of_device_id sun50i_h6_r_ccu_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h6-r-ccu",
+		.data = &sun50i_h6_r_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun50i-h616-r-ccu",
+		.data = &sun50i_h616_r_ccu_desc,
+	},
+	{ }
+};
+
+static struct platform_driver sun50i_h6_r_ccu_driver = {
+	.probe	= sun50i_h6_r_ccu_probe,
+	.driver	= {
+		.name			= "sun50i-h6-r-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun50i_h6_r_ccu_ids,
+	},
+};
+module_platform_driver(sun50i_h6_r_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun50i-h616-ccu.c b/drivers/clk/sunxi-ng/sun50i-h616-ccu.c
index 71d75833253f..4f6eb5474d4b 100644
--- a/drivers/clk/sunxi-ng/sun50i-h616-ccu.c
+++ b/drivers/clk/sunxi-ng/sun50i-h616-ccu.c
@@ -7,7 +7,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -1082,17 +1082,15 @@ static const u32 usb2_clk_regs[] = {
 	SUN50I_H616_USB3_CLK_REG,
 };
 
-static void __init sun50i_h616_ccu_setup(struct device_node *node)
+static int sun50i_h616_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
 	u32 val;
 	int i;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map clock registers\n", node);
-		return;
-	}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Enable the lock bits and the output enable bits on all PLLs */
 	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
@@ -1141,8 +1139,22 @@ static void __init sun50i_h616_ccu_setup(struct device_node *node)
 	val |= BIT(24);
 	writel(val, reg + SUN50I_H616_HDMI_CEC_CLK_REG);
 
-	of_sunxi_ccu_probe(node, reg, &sun50i_h616_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h616_ccu_desc);
 }
 
-CLK_OF_DECLARE(sun50i_h616_ccu, "allwinner,sun50i-h616-ccu",
-	       sun50i_h616_ccu_setup);
+static const struct of_device_id sun50i_h616_ccu_ids[] = {
+	{ .compatible = "allwinner,sun50i-h616-ccu" },
+	{ }
+};
+
+static struct platform_driver sun50i_h616_ccu_driver = {
+	.probe	= sun50i_h616_ccu_probe,
+	.driver	= {
+		.name			= "sun50i-h616-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun50i_h616_ccu_ids,
+	},
+};
+module_platform_driver(sun50i_h616_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun6i-a31-ccu.c b/drivers/clk/sunxi-ng/sun6i-a31-ccu.c
index b05c06a428ad..36597a5262e1 100644
--- a/drivers/clk/sunxi-ng/sun6i-a31-ccu.c
+++ b/drivers/clk/sunxi-ng/sun6i-a31-ccu.c
@@ -9,7 +9,8 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1226,16 +1227,15 @@ static struct ccu_mux_nb sun6i_a31_cpu_nb = {
 	.bypass_index	= 1, /* index of 24 MHz oscillator */
 };
 
-static void __init sun6i_a31_ccu_setup(struct device_node *node)
+static int sun6i_a31_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
+	int ret;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN6I_A31_PLL_AUDIO_REG);
@@ -1257,10 +1257,29 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
 	val |= 0x3 << 12;
 	writel(val, reg + SUN6I_A31_AHB1_REG);
 
-	of_sunxi_ccu_probe(node, reg, &sun6i_a31_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun6i_a31_ccu_desc);
+	if (ret)
+		return ret;
 
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
 				  &sun6i_a31_cpu_nb);
+
+	return 0;
 }
-CLK_OF_DECLARE(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
-	       sun6i_a31_ccu_setup);
+
+static const struct of_device_id sun6i_a31_ccu_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-ccu" },
+	{ }
+};
+
+static struct platform_driver sun6i_a31_ccu_driver = {
+	.probe	= sun6i_a31_ccu_probe,
+	.driver	= {
+		.name			= "sun6i-a31-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun6i_a31_ccu_ids,
+	},
+};
+module_platform_driver(sun6i_a31_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-a23-ccu.c b/drivers/clk/sunxi-ng/sun8i-a23-ccu.c
index 5bbc66a762db..6c469fdcdab3 100644
--- a/drivers/clk/sunxi-ng/sun8i-a23-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-a23-ccu.c
@@ -5,7 +5,8 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -724,16 +725,14 @@ static const struct sunxi_ccu_desc sun8i_a23_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun8i_a23_ccu_resets),
 };
 
-static void __init sun8i_a23_ccu_setup(struct device_node *node)
+static int sun8i_a23_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN8I_A23_PLL_AUDIO_REG);
@@ -745,7 +744,22 @@ static void __init sun8i_a23_ccu_setup(struct device_node *node)
 	val &= ~BIT(16);
 	writel(val, reg + SUN8I_A23_PLL_MIPI_REG);
 
-	of_sunxi_ccu_probe(node, reg, &sun8i_a23_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_a23_ccu_desc);
 }
-CLK_OF_DECLARE(sun8i_a23_ccu, "allwinner,sun8i-a23-ccu",
-	       sun8i_a23_ccu_setup);
+
+static const struct of_device_id sun8i_a23_ccu_ids[] = {
+	{ .compatible = "allwinner,sun8i-a23-ccu" },
+	{ }
+};
+
+static struct platform_driver sun8i_a23_ccu_driver = {
+	.probe	= sun8i_a23_ccu_probe,
+	.driver	= {
+		.name			= "sun8i-a23-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun8i_a23_ccu_ids,
+	},
+};
+module_platform_driver(sun8i_a23_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-a33-ccu.c b/drivers/clk/sunxi-ng/sun8i-a33-ccu.c
index 6cd214b444d1..ac493198ea14 100644
--- a/drivers/clk/sunxi-ng/sun8i-a33-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-a33-ccu.c
@@ -5,7 +5,8 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -784,16 +785,15 @@ static struct ccu_mux_nb sun8i_a33_cpu_nb = {
 	.bypass_index	= 1, /* index of 24 MHz oscillator */
 };
 
-static void __init sun8i_a33_ccu_setup(struct device_node *node)
+static int sun8i_a33_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
+	int ret;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN8I_A33_PLL_AUDIO_REG);
@@ -805,7 +805,9 @@ static void __init sun8i_a33_ccu_setup(struct device_node *node)
 	val &= ~BIT(16);
 	writel(val, reg + SUN8I_A33_PLL_MIPI_REG);
 
-	of_sunxi_ccu_probe(node, reg, &sun8i_a33_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_a33_ccu_desc);
+	if (ret)
+		return ret;
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&sun8i_a33_pll_cpu_nb);
@@ -813,6 +815,23 @@ static void __init sun8i_a33_ccu_setup(struct device_node *node)
 	/* Reparent CPU during PLL CPU rate changes */
 	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
 				  &sun8i_a33_cpu_nb);
+
+	return 0;
 }
-CLK_OF_DECLARE(sun8i_a33_ccu, "allwinner,sun8i-a33-ccu",
-	       sun8i_a33_ccu_setup);
+
+static const struct of_device_id sun8i_a33_ccu_ids[] = {
+	{ .compatible = "allwinner,sun8i-a33-ccu" },
+	{ }
+};
+
+static struct platform_driver sun8i_a33_ccu_driver = {
+	.probe	= sun8i_a33_ccu_probe,
+	.driver	= {
+		.name			= "sun8i-a33-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun8i_a33_ccu_ids,
+	},
+};
+module_platform_driver(sun8i_a33_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-h3-ccu.c b/drivers/clk/sunxi-ng/sun8i-h3-ccu.c
index c566cc1aa168..a93f48535f44 100644
--- a/drivers/clk/sunxi-ng/sun8i-h3-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-h3-ccu.c
@@ -5,7 +5,9 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1137,24 +1139,29 @@ static struct ccu_mux_nb sun8i_h3_cpu_nb = {
 	.bypass_index	= 1, /* index of 24 MHz oscillator */
 };
 
-static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
-					const struct sunxi_ccu_desc *desc)
+static int sun8i_h3_ccu_probe(struct platform_device *pdev)
 {
+	const struct sunxi_ccu_desc *desc;
 	void __iomem *reg;
+	int ret;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
 	writel(val | (0 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
 
-	of_sunxi_ccu_probe(node, reg, desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
+	if (ret)
+		return ret;
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&sun8i_h3_pll_cpu_nb);
@@ -1162,18 +1169,30 @@ static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
 	/* Reparent CPU during PLL CPU rate changes */
 	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
 				  &sun8i_h3_cpu_nb);
-}
 
-static void __init sun8i_h3_ccu_setup(struct device_node *node)
-{
-	sunxi_h3_h5_ccu_init(node, &sun8i_h3_ccu_desc);
+	return 0;
 }
-CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
-	       sun8i_h3_ccu_setup);
 
-static void __init sun50i_h5_ccu_setup(struct device_node *node)
-{
-	sunxi_h3_h5_ccu_init(node, &sun50i_h5_ccu_desc);
-}
-CLK_OF_DECLARE(sun50i_h5_ccu, "allwinner,sun50i-h5-ccu",
-	       sun50i_h5_ccu_setup);
+static const struct of_device_id sun8i_h3_ccu_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-h3-ccu",
+		.data = &sun8i_h3_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun50i-h5-ccu",
+		.data = &sun50i_h5_ccu_desc,
+	},
+	{ }
+};
+
+static struct platform_driver sun8i_h3_ccu_driver = {
+	.probe	= sun8i_h3_ccu_probe,
+	.driver	= {
+		.name			= "sun8i-h3-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun8i_h3_ccu_ids,
+	},
+};
+module_platform_driver(sun8i_h3_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-r-ccu.c b/drivers/clk/sunxi-ng/sun8i-r-ccu.c
index eb623b01df58..56c242e71127 100644
--- a/drivers/clk/sunxi-ng/sun8i-r-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-r-ccu.c
@@ -4,7 +4,8 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include "ccu_common.h"
@@ -254,37 +255,46 @@ static const struct sunxi_ccu_desc sun50i_a64_r_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_a64_r_ccu_resets),
 };
 
-static void __init sunxi_r_ccu_init(struct device_node *node,
-				    const struct sunxi_ccu_desc *desc)
+static int sun8i_r_ccu_probe(struct platform_device *pdev)
 {
+	const struct sunxi_ccu_desc *desc;
 	void __iomem *reg;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
 
-	of_sunxi_ccu_probe(node, reg, desc);
-}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
-static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
-{
-	sunxi_r_ccu_init(node, &sun8i_a83t_r_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
 }
-CLK_OF_DECLARE(sun8i_a83t_r_ccu, "allwinner,sun8i-a83t-r-ccu",
-	       sun8i_a83t_r_ccu_setup);
 
-static void __init sun8i_h3_r_ccu_setup(struct device_node *node)
-{
-	sunxi_r_ccu_init(node, &sun8i_h3_r_ccu_desc);
-}
-CLK_OF_DECLARE(sun8i_h3_r_ccu, "allwinner,sun8i-h3-r-ccu",
-	       sun8i_h3_r_ccu_setup);
+static const struct of_device_id sun8i_r_ccu_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-a83t-r-ccu",
+		.data = &sun8i_a83t_r_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun8i-h3-r-ccu",
+		.data = &sun8i_h3_r_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-r-ccu",
+		.data = &sun50i_a64_r_ccu_desc,
+	},
+	{ }
+};
 
-static void __init sun50i_a64_r_ccu_setup(struct device_node *node)
-{
-	sunxi_r_ccu_init(node, &sun50i_a64_r_ccu_desc);
-}
-CLK_OF_DECLARE(sun50i_a64_r_ccu, "allwinner,sun50i-a64-r-ccu",
-	       sun50i_a64_r_ccu_setup);
+static struct platform_driver sun8i_r_ccu_driver = {
+	.probe	= sun8i_r_ccu_probe,
+	.driver	= {
+		.name			= "sun8i-r-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun8i_r_ccu_ids,
+	},
+};
+module_platform_driver(sun8i_r_ccu_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c b/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
index 58b123ad1212..5ce0fe0e3358 100644
--- a/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
+++ b/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
@@ -8,7 +8,9 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -805,38 +807,48 @@ static const struct sunxi_ccu_desc sun8i_v3_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun8i_v3_ccu_resets),
 };
 
-static void __init sun8i_v3_v3s_ccu_init(struct device_node *node,
-					 const struct sunxi_ccu_desc *ccu_desc)
+static int sun8i_v3s_ccu_probe(struct platform_device *pdev)
 {
+	const struct sunxi_ccu_desc *desc;
 	void __iomem *reg;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN8I_V3S_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
 	writel(val, reg + SUN8I_V3S_PLL_AUDIO_REG);
 
-	of_sunxi_ccu_probe(node, reg, ccu_desc);
-}
-
-static void __init sun8i_v3s_ccu_setup(struct device_node *node)
-{
-	sun8i_v3_v3s_ccu_init(node, &sun8i_v3s_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
 }
 
-static void __init sun8i_v3_ccu_setup(struct device_node *node)
-{
-	sun8i_v3_v3s_ccu_init(node, &sun8i_v3_ccu_desc);
-}
+static const struct of_device_id sun8i_v3s_ccu_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-v3-ccu",
+		.data = &sun8i_v3_ccu_desc,
+	},
+	{
+		.compatible = "allwinner,sun8i-v3s-ccu",
+		.data = &sun8i_v3s_ccu_desc,
+	},
+	{ }
+};
 
-CLK_OF_DECLARE(sun8i_v3s_ccu, "allwinner,sun8i-v3s-ccu",
-	       sun8i_v3s_ccu_setup);
+static struct platform_driver sun8i_v3s_ccu_driver = {
+	.probe	= sun8i_v3s_ccu_probe,
+	.driver	= {
+		.name			= "sun8i-v3s-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun8i_v3s_ccu_ids,
+	},
+};
+module_platform_driver(sun8i_v3s_ccu_driver);
 
-CLK_OF_DECLARE(sun8i_v3_ccu, "allwinner,sun8i-v3-ccu",
-	       sun8i_v3_ccu_setup);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c b/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
index 850ab8af2471..de602340f460 100644
--- a/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
+++ b/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
@@ -6,7 +6,8 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -525,20 +526,21 @@ static struct ccu_mux_nb suniv_cpu_nb = {
 static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
 {
 	void __iomem *reg;
+	int ret;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%pOF: Could not map the clock registers\n", node);
-		return;
-	}
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	/* Force the PLL-Audio-1x divider to 4 */
 	val = readl(reg + SUNIV_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
 	writel(val | (3 << 16), reg + SUNIV_PLL_AUDIO_REG);
 
-	of_sunxi_ccu_probe(node, reg, &suniv_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &suniv_ccu_desc);
+	if (ret)
+		return ret;
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&suniv_pll_cpu_nb);
@@ -546,6 +548,23 @@ static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
 	/* Reparent CPU during PLL CPU rate changes */
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
 				  &suniv_cpu_nb);
+
+	return 0;
 }
-CLK_OF_DECLARE(suniv_f1c100s_ccu, "allwinner,suniv-f1c100s-ccu",
-	       suniv_f1c100s_ccu_setup);
+
+static const struct of_device_id suniv_f1c100s_ccu_ids[] = {
+	{ .compatible = "allwinner,suniv-f1c100s-ccu" },
+	{ }
+};
+
+static struct platform_driver suniv_f1c100s_ccu_driver = {
+	.probe	= suniv_f1c100s_ccu_probe,
+	.driver	= {
+		.name			= "suniv-f1c100s-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= suniv_f1c100s_ccu_ids,
+	},
+};
+module_platform_driver(suniv_f1c100s_ccu_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.31.1

