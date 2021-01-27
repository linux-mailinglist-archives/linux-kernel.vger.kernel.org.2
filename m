Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12741305430
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhA0HN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232374AbhA0HJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:09:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6A62072C;
        Wed, 27 Jan 2021 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611731310;
        bh=Y4lin5XW4XbmWUCOFnuEYMKBivSBkDGA8LTHpmbqjt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOsLXmfN/8aQA5vyCACsv1TumBxIHBZqBiCWPlzaAH31r128LArLvoBcc8sl+hBqJ
         MYOatMtMP0wRX83FLfxpXLBvGoYB8MIz1Mnsym0ERXABJbB8X+AzrcXiiaHT7/ZMad
         8QkloYe4iYiYnjwJICLCd7hogpxnVgULKGkt/XzdRiRtJJ8qdXonL4bdpbyMvuHZRC
         IlSRqaCx0ArFaVyHMN7W0M5tWfpb74vgvAyri20/Yc33L+7JgA0j0lxsmxNuyg8fFr
         ozh1jjNW4tzQxQLkNw60z3HVoN4TWmBiWKMnm42nwGOpfbExikQW14aV1whXikdwdW
         n7LbCEj/MYQ+g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] clk: qcom: clk-alpha-pll: modularize alpha_pll_trion_set_rate()
Date:   Wed, 27 Jan 2021 12:38:08 +0530
Message-Id: <20210127070811.152690-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127070811.152690-1-vkoul@kernel.org>
References: <20210127070811.152690-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trion 5LPE set rate uses code similar to alpha_pll_trion_set_rate() but
with different registers. Modularize these by moving out latch and latch
ack bits so that we can reuse the function.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index f7721088494c..a30ea7b09224 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1471,8 +1471,8 @@ static int alpha_pll_lucid_prepare(struct clk_hw *hw)
 	return __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
 }
 
-static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long prate)
+static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long prate, u32 latch_bit, u32 latch_ack)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	unsigned long rrate;
@@ -1490,22 +1490,20 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 
 	/* Latch the PLL input */
-	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
-				 PLL_UPDATE, PLL_UPDATE);
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, latch_bit);
 	if (ret)
 		return ret;
 
 	/* Wait for 2 reference cycles before checking the ACK bit. */
 	udelay(1);
 	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
-	if (!(val & ALPHA_PLL_ACK_LATCH)) {
+	if (!(val & latch_ack)) {
 		pr_err("Lucid PLL latch failed. Output may be unstable!\n");
 		return -EINVAL;
 	}
 
 	/* Return the latch input to 0 */
-	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
-				 PLL_UPDATE, 0);
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, 0);
 	if (ret)
 		return ret;
 
@@ -1520,6 +1518,12 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	return __alpha_pll_trion_set_rate(hw, rate, prate, PLL_UPDATE, ALPHA_PLL_ACK_LATCH);
+}
+
 const struct clk_ops clk_alpha_pll_trion_ops = {
 	.prepare = alpha_pll_trion_prepare,
 	.enable = clk_trion_pll_enable,
-- 
2.26.2

