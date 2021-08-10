Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0063DB058
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhG3Af7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:35:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11076 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhG3Af5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:35:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627605353; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=R0UhK7a3bg9ekiagx1Hy4ZyEVupeQ95aYdHgxHWHBjM=; b=aBfnmHXRh78DXK533LtgSyYonK63N98TzPdL/Xu98MtqM/Wllqjlsz6MMgNXRpy/1tmUOj2s
 Hb3dYirp6dut7E8cGNvPAAp+5uE9yWnj3cldv/LUU+s5ggGsOeTJ+CnN6O/YAMFLPwMOrPwj
 FeQgWvnymB0qWKFji5tSWLDnnAA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61034946290ea35ee6e09e73 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 00:35:18
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52C61C433F1; Fri, 30 Jul 2021 00:35:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.101] (unknown [49.204.183.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D68EC433F1;
        Fri, 30 Jul 2021 00:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D68EC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 2/6] clk: qcom: Add new PLL type for SDX65
To:     quic_vamslank@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        maz@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1626986805.git.quic_vamslank@quicinc.com>
 <223a1d8020d50c35ff2621f95d69b4a626b6893b.1626986805.git.quic_vamslank@quicinc.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d16d6364-7596-1a88-59f0-b4662bd7fa93@codeaurora.org>
Date:   Fri, 30 Jul 2021 06:05:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <223a1d8020d50c35ff2621f95d69b4a626b6893b.1626986805.git.quic_vamslank@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2021 2:39 AM, quic_vamslank@quicinc.com wrote:
> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add a new PLL type for SDX65 SoC from Qualcomm.
> 
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> ---
>   drivers/clk/qcom/clk-alpha-pll.c | 170 +++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clk-alpha-pll.h |   4 +
>   2 files changed, 174 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index c6eb99169ddc..93c8917b7273 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> + * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
>    * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
>    */
>   
> @@ -126,6 +127,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>   		[PLL_OFF_TEST_CTL_U] = 0x1c,
>   		[PLL_OFF_STATUS] = 0x2c,
>   	},
> +        [CLK_ALPHA_PLL_TYPE_LUCID_EVO] = {
> +                [PLL_OFF_OPMODE] = 0x04,
> +                [PLL_OFF_STATUS] = 0x0c,
> +                [PLL_OFF_L_VAL] = 0x10,
> +                [PLL_OFF_ALPHA_VAL] = 0x14,
> +                [PLL_OFF_USER_CTL] = 0x18,
> +                [PLL_OFF_USER_CTL_U] = 0x1c,
> +                [PLL_OFF_CONFIG_CTL] = 0x20,
> +                [PLL_OFF_CONFIG_CTL_U] = 0x24,
> +                [PLL_OFF_CONFIG_CTL_U1] = 0x28,
> +                [PLL_OFF_TEST_CTL] = 0x2c,
> +                [PLL_OFF_TEST_CTL_U] = 0x30,
> +                [PLL_OFF_TEST_CTL_U1] = 0x34,
> +        },
>   };
>   EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>   
> @@ -155,12 +170,14 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>   
>   /* LUCID PLL specific settings and offsets */
>   #define LUCID_PCAL_DONE		BIT(27)
> +#define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
>   
>   /* LUCID 5LPE PLL specific settings and offsets */
>   #define LUCID_5LPE_PCAL_DONE		BIT(11)
>   #define LUCID_5LPE_ALPHA_PLL_ACK_LATCH	BIT(13)
>   #define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
>   #define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
Please add a comment

/* LUCID EVO PLL specific settings and offsets */
> +#define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
>   
>   #define pll_alpha_width(p)					\
>   		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
> @@ -1777,3 +1794,156 @@ const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
>   	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
>   };
>   EXPORT_SYMBOL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
> +
> +static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
> +	if (ret)
> +		return ret;
> +
> +	/* If in FSM mode, just vote for it */
> +	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
> +		ret = clk_enable_regmap(hw);
> +		if (ret)
> +			return ret;
> +		return wait_for_pll_enable_lock(pll);
> +	}
> +
> +	/* Check if PLL is already enabled */
> +	ret = trion_pll_is_enabled(pll, pll->clkr.regmap);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret) {
> +		pr_warn("%s PLL is already enabled\n",
> +				clk_hw_get_name(&pll->clkr.hw));
> +		return 0;
> +	}
> +
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> +			PLL_RESET_N, PLL_RESET_N);
> +	if (ret)
> +		return ret;
> +
> +	/* Set operation mode to RUN */
> +	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll), PLL_RUN);
> +
> +	ret = wait_for_pll_enable_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the PLL outputs */
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
> +			PLL_OUT_MASK, PLL_OUT_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the global PLL outputs */
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> +			PLL_OUTCTRL, PLL_OUTCTRL);
> +	if (ret)
> +		return ret;
> +
> +	/* Ensure that the write above goes through before returning. */
> +	mb();
> +	return ret;
> +}
> +
> +static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
> +	if (ret)
> +		return;
> +
> +	/* If in FSM mode, just unvote it */
> +	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
> +		clk_disable_regmap(hw);
> +		return;
> +	}
> +
> +	/* Disable the global PLL output */
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> +			PLL_OUTCTRL, 0);
> +	if (ret)
> +		return;
> +
> +	/* Disable the PLL outputs */
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
> +			PLL_OUT_MASK, 0);
> +	if (ret)
> +		return;
> +
> +	/* Place the PLL mode in STANDBY */
> +	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll),
> +			PLL_STANDBY);
> +}
> +
> +static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	u32 l, frac;
> +
> +	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
> +	l &= LUCID_EVO_PLL_L_VAL_MASK;
> +	regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac);
> +
> +	return alpha_pll_calc_rate(parent_rate, l, frac, ALPHA_REG_16BIT_WIDTH);

Can you please use "pll_alpha_width(pll)".

> +}
> +
> +static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate)
> +{
> +	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
> +	int i, val = 0, div, ret;

'val' not required to be initialized.

> +
> +	/*
> +	 * If the PLL is in FSM mode, then treat set_rate callback as a
> +	 * no-operation.
> +	 */
> +	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & LUCID_EVO_ENABLE_VOTE_RUN)
> +		return 0;
> +
> +	if (!pll->post_div_table) {
> +		pr_err("Missing the post_div_table for the PLL\n");
> +		return -EINVAL;
> +	}
> +
> +	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +	for (i = 0; i < pll->num_post_div; i++) {
> +		if (pll->post_div_table[i].div == div) {
> +			val = pll->post_div_table[i].val;
> +			break;
> +		}
> +	}
> +
> +	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
> +			(BIT(pll->width) - 1) << pll->post_div_shift,
> +			val << pll->post_div_shift);
> +}
> +
> +const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
> +	.enable = alpha_pll_lucid_evo_enable,
> +	.disable = alpha_pll_lucid_evo_disable,
> +	.is_enabled = clk_trion_pll_is_enabled,
> +	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
> +	.round_rate = clk_alpha_pll_round_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
> +
> +const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
> +	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
> +	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
> +	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 6943e933be0f..c42299bf6f6f 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -16,6 +16,7 @@ enum {
>   	CLK_ALPHA_PLL_TYPE_TRION,
>   	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
>   	CLK_ALPHA_PLL_TYPE_AGERA,
> +	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>   	CLK_ALPHA_PLL_TYPE_MAX,
>   };
>   
> @@ -148,6 +149,9 @@ extern const struct clk_ops clk_alpha_pll_lucid_5lpe_ops;
>   extern const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops;
>   extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
>   
> +extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
> +extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
> +
>   void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>   			     const struct alpha_pll_config *config);
>   void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
