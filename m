Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578CA3FD319
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhIAFlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:04 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35741 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242079AbhIAFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3B126580582;
        Wed,  1 Sep 2021 01:39:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 01:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=NExN06f+MjRdK
        iJwnr6TNu5wki9iHPSdPEsxuMQ297I=; b=s/8vF3hCw4Wrx/QgdW0yp/pLUTKu/
        eqbinfPlw1AidhNlxfLfIP/OybQ40902+mn8mP5VwjAcKHq22BT1hUdMLEg8N0bd
        rcFTEHDmwnH5jNhTSel524rNz+p67hnAjx0uiKDFre+Ona4dC+Y7SIleB135NY8c
        40oDo/sp5lOmaUv4J/1YWgxU7BdqWVLmEhz1aEuUbyNuqxrCl6txcclGyn1G1Dcu
        vvwhvrN8OZVz6AP8DpH3em8E6RhwK50StREAgbKFNfUAS1zoYTYiLEr837jnr4Qo
        fQmkJ5awTXV6veWlMppnRCW+cFhK6xYegieasiI8kf0SdY7cFIpX++X2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NExN06f+MjRdKiJwnr6TNu5wki9iHPSdPEsxuMQ297I=; b=v+f2cHcU
        Pu/cPFvmqOV9TU25aR8PlEMqHqajQihWkvBCzguWpxxn/nQqBpCkR9PeBFVCA/Ye
        z/5TqiKQ68T5GdLYv/Cs7OhoisuirwiQw082hMriKo00RipIbEQm9STFZssPUVFu
        cYEaRh6RhBETxEk07IMo4IbRT4BD5TIebei2AFNk0vPrnA1v7XXNAUziF0Le6pmr
        ZaV2S56kK9F916tHz/E6d/Yp+CPEKohsMOQQzuFiv3ugZ2DjEqfIi+R2L7rsBLYQ
        LcE8dXNfMvXXw7eElQsxSNBqa5fvsFNebQ1YpZ4e+mqzYAD8gm/3+LpeL6CT4Hgi
        hcBV3akRSVYLFw==
X-ME-Sender: <xms:LxIvYZ1ZwSaIhjFEmKKsb2Mr6x7dhRyKw6hY_UYBOGtZzPGRJ7RzYw>
    <xme:LxIvYQFSiEGGAYFVO0-bDGlBRLHPqVTdqWzNj4l7v0IFU9ok_mWHI8yCUcKnzCJ6a
    d90IA2Cqwu2O326fA>
X-ME-Received: <xmr:LxIvYZ4oBM91YdxxiWsHZ5bM_A8o-P-BMAlBtRXmhp9aEYu_09ttZ0NMaIXirj2ZatKv0-gHM3J_e2Ck4zqMYCk_YU_0oBVh7UGtOvBKyHNGBWncuDlV61dNdz2XuUGMG_8wRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LxIvYW2rzpssIzfy-f2pdrvar1qSuJzvJ1WO5XPcB2JKwG0W9sgEAA>
    <xmx:LxIvYcGvws-Aryt4IsCs54kwzgdLqGeVXqj3-y5ngtc2OOea83F6yg>
    <xmx:LxIvYX_XnkRIbihDghtF0U09_IM39LGv_OH31Ny6zf50S1JiZiVNdw>
    <xmx:LxIvYU-0qNkKjlnbbXTHPGbSvLn2-4hbRiYf3jGx4PyMFGdV_wT0sQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 5/7] clk: sunxi-ng: Add support for the sun50i RTC clocks
Date:   Wed,  1 Sep 2021 00:39:49 -0500
Message-Id: <20210901053951.60952-6-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC power domain in sun50i SoCs manages the 16 MHz RC oscillator
(called "IOSC" or "osc16M") and the optional 32 kHz crystal oscillator
(called "LOSC" or "osc32k"). Starting with the H6, this power domain
handles the 24 MHz DCXO (called "HOSC", "dcxo24M", or "osc24M") as well.
The H6 also introduces a calibration circuit for IOSC.

Later SoCs introduce further variations on the design:
 - H616 adds an additional mux for the 32 kHz fanout source.
 - R329 adds an additional mux for the RTC timekeeping clock, a clock
   for the SPI bus between power domains inside the RTC, and removes the
   IOSC calibration functionality.

Take advantage of the CCU framework to handle this increased complexity.
The CCU framework provides pre-made widgets for the mux/gate/divider
combinations. And it allows plugging in different clocks for the same
specifiers based on the compatible string.

This driver is intended to be a drop-in replacement for the existing RTC
clock driver. So some runtime adjustment of the clock parents is needed,
both to handle hardware differences, and to support the old binding
which omitted some of the input clocks.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/Kconfig          |   6 +
 drivers/clk/sunxi-ng/Makefile         |   1 +
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c | 344 ++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.h |  15 ++
 4 files changed, 366 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
 create mode 100644 drivers/clk/sunxi-ng/sun50i-rtc-ccu.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index ee383658ff4d..8d9d486c4673 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -42,6 +42,12 @@ config SUN50I_H6_R_CCU
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
+config SUN50I_RTC_CCU
+	bool "Support for the Allwinner H6/H616/R329 RTC CCU"
+	default ARM64 && ARCH_SUNXI
+	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	depends on SUNXI_CCU=y
+
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
 	default MACH_SUN4I
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 6e9eb004fca0..99554b13d150 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+= sun50i-a100-r-ccu.o
 obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
 obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
 obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
+obj-$(CONFIG_SUN50I_RTC_CCU)	+= sun50i-rtc-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
new file mode 100644
index 000000000000..1dfa05c2f0e9
--- /dev/null
+++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+
+#include "ccu_common.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mux.h"
+
+#include "sun50i-rtc-ccu.h"
+
+#define IOSC_ACCURACY			300000000 /* 30% */
+#define IOSC_RATE			16000000
+
+#define LOSC_RATE			32768
+#define LOSC_RATE_SHIFT			15
+
+#define LOSC_CTRL_KEY			0x16aa0000
+
+#define IOSC_32K_CLK_DIV_REG		0x8
+#define IOSC_32K_CLK_DIV		GENMASK(4, 0)
+#define IOSC_32K_PRE_DIV		32
+
+#define IOSC_CLK_CALI_REG		0xc
+#define IOSC_CLK_CALI_DIV_ONES		22
+#define IOSC_CLK_CALI_EN		BIT(1)
+#define IOSC_CLK_CALI_SRC_SEL		BIT(0)
+
+#define DCXO_CTRL_REG			0x160
+#define DCXO_CTRL_CLK16M_RC_EN		BIT(0)
+
+static bool have_iosc_calib;
+
+static int ccu_iosc_enable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_enable(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static void ccu_iosc_disable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_disable(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static int ccu_iosc_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	return ccu_gate_helper_is_enabled(cm, DCXO_CTRL_CLK16M_RC_EN);
+}
+
+static unsigned long ccu_iosc_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	if (have_iosc_calib) {
+		u32 reg = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/*
+		 * Recover the IOSC frequency by shifting the ones place of
+		 * (fixed-point divider * 32768) into bit zero.
+		 */
+		if (reg & IOSC_CLK_CALI_EN)
+			return reg >> (IOSC_CLK_CALI_DIV_ONES - LOSC_RATE_SHIFT);
+	}
+
+	return IOSC_RATE;
+}
+
+static unsigned long ccu_iosc_recalc_accuracy(struct clk_hw *hw,
+					      unsigned long parent_accuracy)
+{
+	return IOSC_ACCURACY;
+}
+
+static const struct clk_ops ccu_iosc_ops = {
+	.enable			= ccu_iosc_enable,
+	.disable		= ccu_iosc_disable,
+	.is_enabled		= ccu_iosc_is_enabled,
+	.recalc_rate		= ccu_iosc_recalc_rate,
+	.recalc_accuracy	= ccu_iosc_recalc_accuracy,
+};
+
+static struct ccu_common iosc_clk = {
+	.reg		= DCXO_CTRL_REG,
+	.hw.init	= CLK_HW_INIT_NO_PARENT("iosc", &ccu_iosc_ops,
+						CLK_GET_RATE_NOCACHE),
+};
+
+static int ccu_iosc_32k_enable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	unsigned long flags;
+	u32 reg;
+
+	if (!have_iosc_calib)
+		return 0;
+
+	spin_lock_irqsave(cm->lock, flags);
+
+	reg = readl(cm->base + IOSC_CLK_CALI_REG);
+	writel(reg | IOSC_CLK_CALI_EN | IOSC_CLK_CALI_SRC_SEL,
+	       cm->base + IOSC_CLK_CALI_REG);
+
+	spin_unlock_irqrestore(cm->lock, flags);
+
+	return 0;
+}
+
+static void ccu_iosc_32k_disable(struct clk_hw *hw)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	unsigned long flags;
+	u32 reg;
+
+	if (!have_iosc_calib)
+		return;
+
+	spin_lock_irqsave(cm->lock, flags);
+
+	reg = readl(cm->base + IOSC_CLK_CALI_REG);
+	writel(reg & ~(IOSC_CLK_CALI_EN | IOSC_CLK_CALI_SRC_SEL),
+	       cm->base + IOSC_CLK_CALI_REG);
+
+	spin_unlock_irqrestore(cm->lock, flags);
+}
+
+static unsigned long ccu_iosc_32k_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 reg;
+
+	if (have_iosc_calib) {
+		reg = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/* Assume the calibrated 32k clock is accurate. */
+		if (reg & IOSC_CLK_CALI_SRC_SEL)
+			return LOSC_RATE;
+	}
+
+	reg = readl(cm->base + IOSC_32K_CLK_DIV_REG) & IOSC_32K_CLK_DIV;
+
+	return parent_rate / IOSC_32K_PRE_DIV / (reg + 1);
+}
+
+static unsigned long ccu_iosc_32k_recalc_accuracy(struct clk_hw *hw,
+						  unsigned long parent_accuracy)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 reg;
+
+	if (have_iosc_calib) {
+		reg = readl(cm->base + IOSC_CLK_CALI_REG);
+
+		/* Assume the calibrated 32k clock is accurate. */
+		if (reg & IOSC_CLK_CALI_SRC_SEL)
+			return 0;
+	}
+
+	return parent_accuracy;
+}
+
+static const struct clk_ops ccu_iosc_32k_ops = {
+	.enable			= ccu_iosc_32k_enable,
+	.disable		= ccu_iosc_32k_disable,
+	.recalc_rate		= ccu_iosc_32k_recalc_rate,
+	.recalc_accuracy	= ccu_iosc_32k_recalc_accuracy,
+};
+
+static struct ccu_common iosc_32k_clk = {
+	.hw.init	= CLK_HW_INIT_HW("iosc-32k", &iosc_clk.hw,
+					 &ccu_iosc_32k_ops, 0),
+};
+
+/* The old binding did not use clock-names, so fw_name may get cleared out. */
+static struct clk_parent_data ext_osc32k[] = {
+	{ .fw_name = "ext-osc32k", .index = 0 }
+};
+static SUNXI_CCU_GATE_DATA(ext_osc32k_gate_clk, "ext-osc32k-gate",
+			   ext_osc32k, 0x0, BIT(4), 0);
+
+static const struct clk_hw *osc32k_parents[] = { &iosc_32k_clk.hw,
+						 &ext_osc32k_gate_clk.common.hw };
+static SUNXI_CCU_MUX_HW_WITH_KEY(osc32k_clk, "osc32k", osc32k_parents,
+				 0x0, 0, 1, 0);
+
+/* Fall back to the global name for RTC nodes without an osc24M reference. */
+static struct clk_parent_data osc24M[] = {
+	{ .fw_name = "hosc", .name = "osc24M" }
+};
+static struct ccu_gate osc24M_32k_clk = {
+	.enable	= BIT(16),
+	.common	= {
+		.reg		= 0x60,
+		.prediv		= 750,
+		.features	= CCU_FEATURE_ALL_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc24M-32k", osc24M,
+							   &ccu_gate_ops, 0),
+	},
+};
+
+static CLK_FIXED_FACTOR_HW(rtc_32k_fixed_clk, "rtc-32k",
+			   &osc32k_clk.common.hw, 1, 1, 0);
+
+static const struct clk_hw *rtc_32k_parents[] = { &osc32k_clk.common.hw,
+						  &osc24M_32k_clk.common.hw };
+static SUNXI_CCU_MUX_HW_WITH_KEY(rtc_32k_mux_clk, "rtc-32k", rtc_32k_parents,
+				 0x0, 1, 1, 0);
+
+static struct clk_parent_data osc32k_fanout_parents[] = {
+	{ .hw = &osc32k_clk.common.hw },
+	/* Parent is modified depending on the hardware variant. */
+	{ .fw_name = "pll-32k" },
+	{ .hw = &osc24M_32k_clk.common.hw },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(osc32k_fanout_clk, "rtc-32k-fanout",
+				    osc32k_fanout_parents,
+				    0x60, 1, 2, BIT(0), 0);
+
+static SUNXI_CCU_M_FW_WITH_GATE(rtc_spi_clk, "rtc-spi", "ahb",
+				0x310, 0, 5, BIT(31), 0);
+
+static struct ccu_common *sun50i_h616_rtc_ccu_clks[] = {
+	&iosc_clk,
+	&iosc_32k_clk,
+	&osc32k_clk.common,
+	&osc24M_32k_clk.common,
+	&osc32k_fanout_clk.common,
+};
+
+static struct ccu_common *sun50i_r329_rtc_ccu_clks[] = {
+	&iosc_clk,
+	&iosc_32k_clk,
+	&ext_osc32k_gate_clk.common,
+	&osc32k_clk.common,
+	&osc24M_32k_clk.common,
+	&rtc_32k_mux_clk.common,
+	&osc32k_fanout_clk.common,
+	&rtc_spi_clk.common,
+};
+
+static struct clk_hw_onecell_data sun50i_h616_rtc_ccu_hw_clks = {
+	.num = CLK_NUMBER,
+	.hws = {
+		[CLK_OSC32K]		= &osc32k_clk.common.hw,
+		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
+		[CLK_IOSC]		= &iosc_clk.hw,
+
+		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
+		[CLK_EXT_OSC32K_GATE]	= NULL,
+		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
+		[CLK_RTC_32K]		= &rtc_32k_fixed_clk.hw,
+		[CLK_RTC_SPI]		= NULL,
+	},
+};
+
+static struct clk_hw_onecell_data sun50i_r329_rtc_ccu_hw_clks = {
+	.num = CLK_NUMBER,
+	.hws = {
+		[CLK_OSC32K]		= &osc32k_clk.common.hw,
+		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
+		[CLK_IOSC]		= &iosc_clk.hw,
+
+		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
+		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
+		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
+		[CLK_RTC_32K]		= &rtc_32k_mux_clk.common.hw,
+		[CLK_RTC_SPI]		= &rtc_spi_clk.common.hw,
+	},
+};
+
+static const struct sunxi_ccu_desc sun50i_h616_rtc_ccu_desc = {
+	.ccu_clks	= sun50i_h616_rtc_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_rtc_ccu_clks),
+
+	.hw_clks	= &sun50i_h616_rtc_ccu_hw_clks,
+};
+
+static const struct sunxi_ccu_desc sun50i_r329_rtc_ccu_desc = {
+	.ccu_clks	= sun50i_r329_rtc_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_r329_rtc_ccu_clks),
+
+	.hw_clks	= &sun50i_r329_rtc_ccu_hw_clks,
+};
+
+static void __init sunxi_rtc_ccu_init(struct device_node *node,
+				      const struct sunxi_ccu_desc *desc)
+{
+	void __iomem *reg;
+	int i;
+
+	reg = of_iomap(node, 0);
+	if (IS_ERR(reg)) {
+		pr_err("%pOF: Failed to map registers\n", node);
+		return;
+	}
+
+	/* ext-osc32k was the only input clock in the old binding. */
+	if (!of_property_read_bool(node, "clock-names"))
+		ext_osc32k[0].fw_name = NULL;
+
+	/* Rename the first 3 clocks to respect clock-output-names. */
+	for (i = 0; i < 3; ++i) {
+		struct clk_init_data *init = (struct clk_init_data *)
+			desc->hw_clks->hws[i]->init;
+
+		of_property_read_string_index(node, "clock-output-names", i,
+					      &init->name);
+	}
+
+	of_sunxi_ccu_probe(node, reg, desc);
+}
+
+static void __init sun50i_h616_rtc_ccu_setup(struct device_node *node)
+{
+	have_iosc_calib = 1;
+
+	/* Remove the second parent as external osc32k is not supported. */
+	osc32k_parents[1] = &iosc_32k_clk.hw;
+
+	sunxi_rtc_ccu_init(node, &sun50i_h616_rtc_ccu_desc);
+}
+CLK_OF_DECLARE_DRIVER(sun50i_h616_rtc_ccu, "allwinner,sun50i-h616-rtc",
+		      sun50i_h616_rtc_ccu_setup);
+
+static void __init sun50i_r329_rtc_ccu_setup(struct device_node *node)
+{
+	have_iosc_calib = 0;
+
+	osc32k_fanout_parents[1] = (struct clk_parent_data) {
+		.hw = &ext_osc32k_gate_clk.common.hw
+	};
+
+	sunxi_rtc_ccu_init(node, &sun50i_r329_rtc_ccu_desc);
+}
+CLK_OF_DECLARE_DRIVER(sun50i_r329_rtc_ccu, "allwinner,sun50i-r329-rtc",
+		      sun50i_r329_rtc_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.h b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.h
new file mode 100644
index 000000000000..7bd4d8700612
--- /dev/null
+++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _CCU_SUN50I_RTC_H
+#define _CCU_SUN50I_RTC_H
+
+#include <dt-bindings/clock/sun50i-rtc.h>
+
+#define CLK_IOSC_32K		4
+#define CLK_EXT_OSC32K_GATE	5
+#define CLK_OSC24M_32K		6
+#define CLK_RTC_32K		7
+
+#define CLK_NUMBER		(CLK_RTC_SPI + 1)
+
+#endif /* _CCU_SUN50I_RTC_H */
-- 
2.31.1

