Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952CD30542F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhA0HNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhA0HJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:09:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51BF320731;
        Wed, 27 Jan 2021 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611731305;
        bh=qAqOPaONho9bc4dKl6lVor9L4nS0gWxyc03jsWmOUss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyumfzEEhM6ONoGXD2CMSV0LoAYyZ0FDwZmplvWue5WwS9kHnsOBi+5UgFRwii1BO
         v2Rgv5GXXlpqs/95Ndk5YMxGSH41PTVtuuqk4dcex1D6PpYWezVevxkHJvgfRXT/GT
         aHDsw9UWRAiTyhxemg3gQu/ohPz9drl9vG7Lu/81KSqRApULUhg9hFqaQh7+xqvtNt
         2z+g9jaPSSlCxO2QNw/qP9TZatb3QqgTvRBqfWAAHeEAzu7kSesbI2Mn9gPZMwbAhN
         wp6GY6Z4IZU4J9n5YcLu3H6oFwU3WWS0eFGrrpnTLoJqeSH7yoDbWjE22K9md5oiap
         cVThXlGtuRDtA==
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
Subject: [PATCH v5 1/5] clk: qcom: clk-alpha-pll: replace regval with val
Date:   Wed, 27 Jan 2021 12:38:07 +0530
Message-Id: <20210127070811.152690-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127070811.152690-1-vkoul@kernel.org>
References: <20210127070811.152690-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver uses regval variable for holding register values, replace with a
shorter one val

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 21c357c26ec4..f7721088494c 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -777,15 +777,15 @@ static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
 static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
 				struct regmap *regmap)
 {
-	u32 mode_regval, opmode_regval;
+	u32 mode_val, opmode_val;
 	int ret;
 
-	ret = regmap_read(regmap, PLL_MODE(pll), &mode_regval);
-	ret |= regmap_read(regmap, PLL_OPMODE(pll), &opmode_regval);
+	ret = regmap_read(regmap, PLL_MODE(pll), &mode_val);
+	ret |= regmap_read(regmap, PLL_OPMODE(pll), &opmode_val);
 	if (ret)
 		return 0;
 
-	return ((opmode_regval & PLL_RUN) && (mode_regval & PLL_OUTCTRL));
+	return ((opmode_val & PLL_RUN) && (mode_val & PLL_OUTCTRL));
 }
 
 static int clk_trion_pll_is_enabled(struct clk_hw *hw)
@@ -1445,12 +1445,12 @@ EXPORT_SYMBOL_GPL(clk_trion_pll_configure);
 static int __alpha_pll_trion_prepare(struct clk_hw *hw, u32 pcal_done)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
-	u32 regval;
+	u32 val;
 	int ret;
 
 	/* Return early if calibration is not needed. */
-	regmap_read(pll->clkr.regmap, PLL_STATUS(pll), &regval);
-	if (regval & pcal_done)
+	regmap_read(pll->clkr.regmap, PLL_STATUS(pll), &val);
+	if (val & pcal_done)
 		return 0;
 
 	/* On/off to calibrate */
@@ -1476,7 +1476,7 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	unsigned long rrate;
-	u32 regval, l, alpha_width = pll_alpha_width(pll);
+	u32 val, l, alpha_width = pll_alpha_width(pll);
 	u64 a;
 	int ret;
 
@@ -1497,8 +1497,8 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	/* Wait for 2 reference cycles before checking the ACK bit. */
 	udelay(1);
-	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &regval);
-	if (!(regval & ALPHA_PLL_ACK_LATCH)) {
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (!(val & ALPHA_PLL_ACK_LATCH)) {
 		pr_err("Lucid PLL latch failed. Output may be unstable!\n");
 		return -EINVAL;
 	}
-- 
2.26.2

