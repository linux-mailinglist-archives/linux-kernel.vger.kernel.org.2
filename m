Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6E44060B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhJ3ADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:03:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14184 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhJ3AD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635552057; x=1667088057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/Mtp7x6fozVDUG1WOXoVJmfuFdrNejBhB36RxqyAkQw=;
  b=a8YqSIxFkSR2sy3vRg74/x9psSfSB4DnSDqsMkjX13I0HJUgai/1JAHD
   KOshYA3JeQ9OchH9ok4rgLyvNRgswGbC6EZKqw2dJRT/F40MCg1livQhN
   w+LVuPbqms/FSkKXsClCf8Km8wWLlCSzBWAvESIUubr9kTkYUTyQRUBok
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2021 17:00:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 17:00:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 29 Oct 2021 17:00:56 -0700
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 29 Oct 2021 17:00:56 -0700
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        "Vamsi Krishna Lanka" <quic_vamslank@quicinc.com>
Subject: [PATCH v3 2/6] clk: qcom: Add LUCID_EVO PLL type for SDX65
Date:   Fri, 29 Oct 2021 17:00:38 -0700
Message-ID: <1635552042-16250-3-git-send-email-quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635552042-16250-1-git-send-email-quic_vamslank@quicinc.com>
References: <1635552042-16250-1-git-send-email-quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Add a LUCID_EVO PLL type for SDX65 SoC from Qualcomm.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 171 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |   3 +
 2 files changed, 174 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index eaedcce..b2dbb8d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
  */
 
@@ -139,6 +140,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_OPMODE] = 0x28,
 		[PLL_OFF_STATUS] = 0x38,
 	},
+	[CLK_ALPHA_PLL_TYPE_LUCID_EVO] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+		[PLL_OFF_TEST_CTL_U1] = 0x34,
+        },
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
@@ -175,6 +190,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
 #define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
 
+/* LUCID EVO PLL specific settings and offsets */
+#define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
+#define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
+
 /* ZONDA PLL specific */
 #define ZONDA_PLL_OUT_MASK	0xf
 #define ZONDA_STAY_IN_CFA	BIT(16)
@@ -1951,3 +1970,155 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL(clk_alpha_pll_zonda_ops);
+
+static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_lock(pll);
+	}
+
+	/* Check if PLL is already enabled */
+	ret = trion_pll_is_enabled(pll, regmap);
+	if (ret < 0)
+		return ret;
+	else if (ret) {
+		pr_warn("%s PLL is already enabled\n",
+				clk_hw_get_name(&pll->clkr.hw));
+		return 0;
+	}
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+	if (ret)
+		return ret;
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+	return ret;
+}
+
+static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+
+static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 l, frac;
+
+	regmap_read(regmap, PLL_L_VAL(pll), &l);
+	l &= LUCID_EVO_PLL_L_VAL_MASK;
+	regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac);
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
+}
+
+static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int i, val, div, ret;
+
+	/*
+	 * If the PLL is in FSM mode, then treat set_rate callback as a
+	 * no-operation.
+	 */
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN)
+		return 0;
+
+	if (!pll->post_div_table) {
+		pr_err("Missing the post_div_table for the PLL\n");
+		return -EINVAL;
+	}
+
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].div == div) {
+			val = pll->post_div_table[i].val;
+			break;
+		}
+	}
+
+	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
+			(BIT(pll->width) - 1) << pll->post_div_shift,
+			val << pll->post_div_shift);
+}
+
+const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
+	.enable = alpha_pll_lucid_evo_enable,
+	.disable = alpha_pll_lucid_evo_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 55e4fa4..6e9907d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -17,6 +17,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
+	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -151,6 +152,8 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
 
 extern const struct clk_ops clk_alpha_pll_zonda_ops;
 #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
+extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
 
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
-- 
2.7.4

