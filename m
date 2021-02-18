Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20DA31EA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhBRNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:17:09 -0500
Received: from mail.manjaro.org ([176.9.38.148]:54994 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhBRLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:42:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 38D833E600A1;
        Thu, 18 Feb 2021 12:20:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ful2cswKUM3i; Thu, 18 Feb 2021 12:20:32 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Icenowy Zheng <icenowy@aosc.io>, Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 1/1] clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll
Date:   Thu, 18 Feb 2021 12:20:01 +0100
Message-Id: <20210218112001.479018-2-t.schramm@manjaro.org>
In-Reply-To: <20210218112001.479018-1-t.schramm@manjaro.org>
References: <20210218112001.479018-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously it was not possible to achieve clock rates of 24.576MHz and
22.5792MHz, which are commonly required core clocks for the i2s
peripheral of v3s based SoCs.

Add support for those clock rates through the audio pll's sigma-delta
modulator.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 33 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 0e36ca3bf3d5..a774942cb153 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -40,18 +40,29 @@ static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
  * the base (2x, 4x and 8x), and one variable divider (the one true
  * pll audio).
  *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names
+ * With sigma-delta modulation for fractional-N on the audio PLL,
+ * we have to use specific dividers. This means the variable divider
+ * can no longer be used, as the audio codec requests the exact clock
+ * rates we support through this mechanism. So we now hard code the
+ * variable divider to 1. This means the clock rates will no longer
+ * match the clock names.
  */
 #define SUN8I_V3S_PLL_AUDIO_REG	0x008
 
-static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
-				   "osc24M", 0x008,
-				   8, 7,	/* N */
-				   0, 5,	/* M */
-				   BIT(31),	/* gate */
-				   BIT(28),	/* lock */
-				   0);
+static struct ccu_sdm_setting pll_audio_sdm_table[] = {
+	{ .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
+	{ .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
+};
+
+static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
+				       "osc24M", 0x008,
+				       8, 7,	/* N */
+				       0, 5,	/* M */
+				       pll_audio_sdm_table, BIT(24),
+				       0x284, BIT(31),
+				       BIT(31),	/* gate */
+				       BIT(28),	/* lock */
+				       CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
 					"osc24M", 0x0010,
@@ -524,10 +535,10 @@ static struct ccu_common *sun8i_v3_ccu_clks[] = {
 	&mipi_csi_clk.common,
 };
 
-/* We hardcode the divider to 4 for now */
+/* We hardcode the divider to 1 for SDM support */
 static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
 			    clk_parent_pll_audio,
-			    4, 1, CLK_SET_RATE_PARENT);
+			    1, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
 			    clk_parent_pll_audio,
 			    2, 1, CLK_SET_RATE_PARENT);
-- 
2.30.1

