Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAB37F8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEMNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:31:23 -0400
Received: from mail.manjaro.org ([176.9.38.148]:57534 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233682AbhEMNbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:31:17 -0400
X-Greylist: delayed 1081 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 09:31:16 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 03107220FF6;
        Thu, 13 May 2021 15:12:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uvKiGvuW2myG; Thu, 13 May 2021 15:12:01 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] clk: sunxi-ng: v3s: fix incorrect postdivider on pll-audio
Date:   Thu, 13 May 2021 15:13:15 +0200
Message-Id: <20210513131315.2059451-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 46060be6d840 ("clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll")
changed the audio pll on the Allwinner V3s and V3 SoCs to use
sigma-delta modulation. In the process the declaration of fixed postdivider
providing "pll-audio" was adjusted to provide the desired clock rates from
the now sigma-delta modulated pll.
However, while the divider used for calculations by the clock framework
was adjusted the actual divider programmed into the hardware in
sun8i_v3_v3s_ccu_init was left at "divide by four". This broke the
"pll-audio" clock, now only providing quater the expected clock rate.
It would in general be desirable to program the postdivider for
"pll-audio" to four, such that a broader range of frequencies were
available on the pll outputs. But the clock for the integrated codec
"ac-dig" does not feature a mux that allows to select from all pll outputs
as it is just a simple clock gate connected to "pll-audio". Thus we need
to set the postdivider to one to be able to provide the 22.5792MHz and
24.576MHz rates required by the internal sun4i codec.

This patches fixes the incorrect clock rate by forcing the postdivider to
one in sun8i_v3_v3s_ccu_init.

Fixes: 46060be6d840 ("clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll")
Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index a774942cb153..f49724a22540 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -817,10 +817,10 @@ static void __init sun8i_v3_v3s_ccu_init(struct device_node *node,
 		return;
 	}
 
-	/* Force the PLL-Audio-1x divider to 4 */
+	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN8I_V3S_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
-	writel(val | (3 << 16), reg + SUN8I_V3S_PLL_AUDIO_REG);
+	writel(val, reg + SUN8I_V3S_PLL_AUDIO_REG);
 
 	sunxi_ccu_probe(node, reg, ccu_desc);
 }
-- 
2.30.1

