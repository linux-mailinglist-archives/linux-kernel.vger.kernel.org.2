Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD0452CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhKPI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhKPI2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C1361B49;
        Tue, 16 Nov 2021 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637051134;
        bh=QAjKaUITJh85DQxjILDk66ZZ2DD739TBS0bdfMMRImI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPJBN/lM1PeY+qyhBLdcF6kWXbS2ipAsjtHiBhKeiiRdkO8/LzoT8cjKgywvxsjWv
         lq7LC64jzHBdrb7WJOeQS7q3/CHoGRBzC5CzQb29zbDZaDqlRiK016GJHGuhygMVU1
         zJTu7Sn+FW63l7jBR8H41mc5G8o63I4TcMMAAgEszeIiH5NinjgOf+TgDXHVHrl+h3
         A5FS8K9prHO6J0Y8Q1/Ro6enN3ULagpndjDmgmrkbmIoOXxnZ5EmxxmkUVBr2YZOZH
         XkCd6LJSxEOkei1IcRKmxQPbwDBVVriqlsUblG8R2QbZS4JiqjljFA0xOhR/EJAWg1
         vUeMKv2g42hNw==
Date:   Tue, 16 Nov 2021 13:55:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 2/6] clk: qcom: Add LUCID_EVO PLL type for SDX65
Message-ID: <YZNq+Y07kwhbIboe@matsya>
References: <cover.1637047731.git.quic_vamslank@quicinc.com>
 <5a048452c128e4b678609bef780e2c1328c482fc.1637047731.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a048452c128e4b678609bef780e2c1328c482fc.1637047731.git.quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-11-21, 23:38, quic_vamslank@quicinc.com wrote:
> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add a LUCID_EVO PLL type for SDX65 SoC from Qualcomm.
> 
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 171 +++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |   3 +
>  2 files changed, 174 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index eaedcceb766f..b2dbb8d56773 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.

This line should ideally come after the below line..

>   * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
>   */
>  
> @@ -139,6 +140,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>  		[PLL_OFF_OPMODE] = 0x28,
>  		[PLL_OFF_STATUS] = 0x38,
>  	},
> +	[CLK_ALPHA_PLL_TYPE_LUCID_EVO] = {
> +		[PLL_OFF_OPMODE] = 0x04,
> +		[PLL_OFF_STATUS] = 0x0c,
> +		[PLL_OFF_L_VAL] = 0x10,
> +		[PLL_OFF_ALPHA_VAL] = 0x14,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_USER_CTL_U] = 0x1c,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_CONFIG_CTL_U] = 0x24,
> +		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
> +		[PLL_OFF_TEST_CTL] = 0x2c,
> +		[PLL_OFF_TEST_CTL_U] = 0x30,
> +		[PLL_OFF_TEST_CTL_U1] = 0x34,
> +        },
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  
> @@ -175,6 +190,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  #define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
>  #define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
>  
> +/* LUCID EVO PLL specific settings and offsets */
> +#define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
> +#define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
> +
>  /* ZONDA PLL specific */
>  #define ZONDA_PLL_OUT_MASK	0xf
>  #define ZONDA_STAY_IN_CFA	BIT(16)
> @@ -1951,3 +1970,155 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
>  	.set_rate = clk_zonda_pll_set_rate,
>  };
>  EXPORT_SYMBOL(clk_alpha_pll_zonda_ops);
> +
> +static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	struct regmap *regmap = pll->clkr.regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
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
> +	ret = trion_pll_is_enabled(pll, regmap);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret) {
> +		pr_warn("%s PLL is already enabled\n",
> +				clk_hw_get_name(&pll->clkr.hw));

this should fit in a single line

> +		return 0;
> +	}
> +
> +	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
> +	if (ret)
> +		return ret;
> +
> +	/* Set operation mode to RUN */
> +	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
> +
> +	ret = wait_for_pll_enable_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the PLL outputs */
> +	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the global PLL outputs */
> +	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
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
> +	struct regmap *regmap = pll->clkr.regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
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
> +	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
> +	if (ret)
> +		return;
> +
> +	/* Disable the PLL outputs */
> +	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
> +	if (ret)
> +		return;
> +
> +	/* Place the PLL mode in STANDBY */
> +	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
> +}
> +
> +static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)

pls align this to preceding line open brace

> +{
> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +	struct regmap *regmap = pll->clkr.regmap;
> +	u32 l, frac;
> +
> +	regmap_read(regmap, PLL_L_VAL(pll), &l);
> +	l &= LUCID_EVO_PLL_L_VAL_MASK;
> +	regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac);
> +
> +	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
> +}

I think this can use __alpha_pll_trion_set_rate()

> +
> +static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate)
> +{
> +	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
> +	struct regmap *regmap = pll->clkr.regmap;
> +	int i, val, div, ret;
> +
> +	/*
> +	 * If the PLL is in FSM mode, then treat set_rate callback as a
> +	 * no-operation.
> +	 */
> +	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
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
> +	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
> +			(BIT(pll->width) - 1) << pll->post_div_shift,
> +			val << pll->post_div_shift);
> +}

This looks _very_ similar to clk_lucid_5lpe_pll_postdiv_set_rate() maybe
add a helper which both can use and pass on the
LUCID_EVO_ENABLE_VOTE_RUN as argument to helper?

-- 
~Vinod
