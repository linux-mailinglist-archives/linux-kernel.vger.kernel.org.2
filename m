Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8D31A08F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBLOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:21:19 -0500
Received: from mail.manjaro.org ([176.9.38.148]:46288 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbhBLOVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:21:02 -0500
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 09:20:59 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 4B55C182DEA;
        Fri, 12 Feb 2021 14:57:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WqVgog2iWyQB; Fri, 12 Feb 2021 14:57:53 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio pll output
Date:   Fri, 12 Feb 2021 14:57:25 +0100
Message-Id: <20210212135725.283877-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the variable rate audio pll output was fixed to a divider of
four. This is unfortunately incompatible with generating commonly used
I2S core clock rates like 24.576MHz from the 24MHz parent clock.
This commit adds support for arbitrary audio pll output dividers to fix
that.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 0e36ca3bf3d5..c6cf590b235a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -36,12 +36,9 @@ static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
 				     0);
 
 /*
- * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
- * the base (2x, 4x and 8x), and one variable divider (the one true
- * pll audio).
- *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names
+ * The Audio PLL has 4 outputs: 3 fixed factors from the base (2x, 4x and 8x),
+ * and one variable divider (the one true pll audio).
+ * The variable rate output is supported via a a separate divider below.
  */
 #define SUN8I_V3S_PLL_AUDIO_REG	0x008
 
@@ -53,6 +50,11 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   BIT(28),	/* lock */
 				   0);
 
+static SUNXI_CCU_M(pll_audio_clk, "pll-audio",
+		   "pll-audio-base", 0x008,
+		   16, 4, /* P from audio pll */
+		   CLK_SET_RATE_PARENT);
+
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
 					"osc24M", 0x0010,
 					8, 7,		/* N */
@@ -377,6 +379,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mipi_csi_clk, "mipi-csi", mipi_csi_parents,
 static struct ccu_common *sun8i_v3s_ccu_clks[] = {
 	&pll_cpu_clk.common,
 	&pll_audio_base_clk.common,
+	&pll_audio_clk.common,
 	&pll_video_clk.common,
 	&pll_ve_clk.common,
 	&pll_ddr0_clk.common,
@@ -453,6 +456,7 @@ static const struct clk_hw *clk_parent_pll_audio[] = {
 static struct ccu_common *sun8i_v3_ccu_clks[] = {
 	&pll_cpu_clk.common,
 	&pll_audio_base_clk.common,
+	&pll_audio_clk.common,
 	&pll_video_clk.common,
 	&pll_ve_clk.common,
 	&pll_ddr0_clk.common,
@@ -524,10 +528,6 @@ static struct ccu_common *sun8i_v3_ccu_clks[] = {
 	&mipi_csi_clk.common,
 };
 
-/* We hardcode the divider to 4 for now */
-static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
-			    clk_parent_pll_audio,
-			    4, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
 			    clk_parent_pll_audio,
 			    2, 1, CLK_SET_RATE_PARENT);
@@ -545,7 +545,7 @@ static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
 	.hws	= {
 		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
 		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
-		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.common.hw,
 		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
 		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
 		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
@@ -625,7 +625,7 @@ static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
 	.hws	= {
 		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
 		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
-		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.common.hw,
 		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
 		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
 		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
-- 
2.30.0

