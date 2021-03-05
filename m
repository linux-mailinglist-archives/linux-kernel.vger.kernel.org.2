Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0143032DF81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCECP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:15:28 -0500
Received: from regular1.263xmail.com ([211.150.70.196]:49296 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:15:26 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id C7DC11FC7;
        Fri,  5 Mar 2021 10:14:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P32477T140679432865536S1614910477033718_;
        Fri, 05 Mar 2021 10:14:47 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f0489e01959ccfed2a739688f3c40b10>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: finley.xiao@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v3 3/4] clk: rockchip: support more core div setting
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
References: <20210301064749.10392-1-zhangqing@rock-chips.com>
 <20210301064749.10392-4-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <2bc0f6c5-a7b9-8fcc-fc5c-a6a576392789@rock-chips.com>
Date:   Fri, 5 Mar 2021 10:14:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301064749.10392-4-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/1 下午2:47, Elaine Zhang wrote:
> Use arrays to support more core independent div settings.
> A55 supports each core to work at different frequencies, and each core
> has an independent divider control.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Patch looks good to me.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk-cpu.c    | 53 +++++++++++++++++--------------
>   drivers/clk/rockchip/clk-px30.c   |  7 ++--
>   drivers/clk/rockchip/clk-rk3036.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3128.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3188.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3228.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3288.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3308.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3328.c |  7 ++--
>   drivers/clk/rockchip/clk-rk3368.c | 14 ++++----
>   drivers/clk/rockchip/clk-rk3399.c | 14 ++++----
>   drivers/clk/rockchip/clk-rv1108.c |  7 ++--
>   drivers/clk/rockchip/clk.h        | 24 +++++++-------
>   13 files changed, 94 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
> index fa9027fb1920..47288197c9d7 100644
> --- a/drivers/clk/rockchip/clk-cpu.c
> +++ b/drivers/clk/rockchip/clk-cpu.c
> @@ -84,10 +84,10 @@ static unsigned long rockchip_cpuclk_recalc_rate(struct clk_hw *hw,
>   {
>   	struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_hw(hw);
>   	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
> -	u32 clksel0 = readl_relaxed(cpuclk->reg_base + reg_data->core_reg);
> +	u32 clksel0 = readl_relaxed(cpuclk->reg_base + reg_data->core_reg[0]);
>   
> -	clksel0 >>= reg_data->div_core_shift;
> -	clksel0 &= reg_data->div_core_mask;
> +	clksel0 >>= reg_data->div_core_shift[0];
> +	clksel0 &= reg_data->div_core_mask[0];
>   	return parent_rate / (clksel0 + 1);
>   }
>   
> @@ -120,6 +120,7 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
>   	const struct rockchip_cpuclk_rate_table *rate;
>   	unsigned long alt_prate, alt_div;
>   	unsigned long flags;
> +	int i = 0;
>   
>   	/* check validity of the new rate */
>   	rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
> @@ -142,10 +143,10 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
>   	if (alt_prate > ndata->old_rate) {
>   		/* calculate dividers */
>   		alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
> -		if (alt_div > reg_data->div_core_mask) {
> +		if (alt_div > reg_data->div_core_mask[0]) {
>   			pr_warn("%s: limiting alt-divider %lu to %d\n",
> -				__func__, alt_div, reg_data->div_core_mask);
> -			alt_div = reg_data->div_core_mask;
> +				__func__, alt_div, reg_data->div_core_mask[0]);
> +			alt_div = reg_data->div_core_mask[0];
>   		}
>   
>   		/*
> @@ -158,19 +159,17 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
>   		pr_debug("%s: setting div %lu as alt-rate %lu > old-rate %lu\n",
>   			 __func__, alt_div, alt_prate, ndata->old_rate);
>   
> -		writel(HIWORD_UPDATE(alt_div, reg_data->div_core_mask,
> -					      reg_data->div_core_shift) |
> -		       HIWORD_UPDATE(reg_data->mux_core_alt,
> -				     reg_data->mux_core_mask,
> -				     reg_data->mux_core_shift),
> -		       cpuclk->reg_base + reg_data->core_reg);
> -	} else {
> -		/* select alternate parent */
> -		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
> -				     reg_data->mux_core_mask,
> -				     reg_data->mux_core_shift),
> -		       cpuclk->reg_base + reg_data->core_reg);
> +		for (i = 0; i < reg_data->num_cores; i++) {
> +			writel(HIWORD_UPDATE(alt_div, reg_data->div_core_mask[i],
> +					     reg_data->div_core_shift[i]),
> +			       cpuclk->reg_base + reg_data->core_reg[i]);
> +		}
>   	}
> +	/* select alternate parent */
> +	writel(HIWORD_UPDATE(reg_data->mux_core_alt,
> +			     reg_data->mux_core_mask,
> +			     reg_data->mux_core_shift),
> +	       cpuclk->reg_base + reg_data->core_reg[0]);
>   
>   	spin_unlock_irqrestore(cpuclk->lock, flags);
>   	return 0;
> @@ -182,6 +181,7 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
>   	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
>   	const struct rockchip_cpuclk_rate_table *rate;
>   	unsigned long flags;
> +	int i = 0;
>   
>   	rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
>   	if (!rate) {
> @@ -202,12 +202,17 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
>   	 * primary parent by the extra dividers that were needed for the alt.
>   	 */
>   
> -	writel(HIWORD_UPDATE(0, reg_data->div_core_mask,
> -				reg_data->div_core_shift) |
> -	       HIWORD_UPDATE(reg_data->mux_core_main,
> -				reg_data->mux_core_mask,
> -				reg_data->mux_core_shift),
> -	       cpuclk->reg_base + reg_data->core_reg);
> +	writel(HIWORD_UPDATE(reg_data->mux_core_main,
> +			     reg_data->mux_core_mask,
> +			     reg_data->mux_core_shift),
> +	       cpuclk->reg_base + reg_data->core_reg[0]);
> +
> +	/* remove dividers */
> +	for (i = 0; i < reg_data->num_cores; i++) {
> +		writel(HIWORD_UPDATE(0, reg_data->div_core_mask[i],
> +				     reg_data->div_core_shift[i]),
> +		       cpuclk->reg_base + reg_data->core_reg[i]);
> +	}
>   
>   	if (ndata->old_rate > ndata->new_rate)
>   		rockchip_cpuclk_set_dividers(cpuclk, rate);
> diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
> index 6fb9c98b7d24..b58619eb412b 100644
> --- a/drivers/clk/rockchip/clk-px30.c
> +++ b/drivers/clk/rockchip/clk-px30.c
> @@ -124,9 +124,10 @@ static struct rockchip_cpuclk_rate_table px30_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data px30_cpuclk_data = {
> -	.core_reg = PX30_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0xf,
> +	.core_reg[0] = PX30_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0xf,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 7,
> diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
> index 6a46f85ad837..91d56ad45817 100644
> --- a/drivers/clk/rockchip/clk-rk3036.c
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -102,9 +102,10 @@ static struct rockchip_cpuclk_rate_table rk3036_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
> -	.core_reg = RK2928_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK2928_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 7,
> diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
> index 4b1122e98e16..aa53797dbfc1 100644
> --- a/drivers/clk/rockchip/clk-rk3128.c
> +++ b/drivers/clk/rockchip/clk-rk3128.c
> @@ -117,9 +117,10 @@ static struct rockchip_cpuclk_rate_table rk3128_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3128_cpuclk_data = {
> -	.core_reg = RK2928_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK2928_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 7,
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index 0b76ad34de00..ee6d48d147d5 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -145,9 +145,10 @@ static struct rockchip_cpuclk_rate_table rk3066_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3066_cpuclk_data = {
> -	.core_reg = RK2928_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK2928_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 8,
> diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
> index 47d6482dda9d..a24a35553e13 100644
> --- a/drivers/clk/rockchip/clk-rk3228.c
> +++ b/drivers/clk/rockchip/clk-rk3228.c
> @@ -119,9 +119,10 @@ static struct rockchip_cpuclk_rate_table rk3228_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3228_cpuclk_data = {
> -	.core_reg = RK2928_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK2928_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 6,
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 93c794695c46..baa5aebd3277 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -179,9 +179,10 @@ static struct rockchip_cpuclk_rate_table rk3288_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3288_cpuclk_data = {
> -	.core_reg = RK3288_CLKSEL_CON(0),
> -	.div_core_shift = 8,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK3288_CLKSEL_CON(0),
> +	.div_core_shift[0] = 8,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 15,
> diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
> index 5bf15f2a44b7..2c3bd0c749f2 100644
> --- a/drivers/clk/rockchip/clk-rk3308.c
> +++ b/drivers/clk/rockchip/clk-rk3308.c
> @@ -109,9 +109,10 @@ static struct rockchip_cpuclk_rate_table rk3308_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3308_cpuclk_data = {
> -	.core_reg = RK3308_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0xf,
> +	.core_reg[0] = RK3308_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0xf,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 6,
> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
> index 2429b7c2a8b3..267ab54937d3 100644
> --- a/drivers/clk/rockchip/clk-rk3328.c
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> @@ -130,9 +130,10 @@ static struct rockchip_cpuclk_rate_table rk3328_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3328_cpuclk_data = {
> -	.core_reg = RK3328_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK3328_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 3,
>   	.mux_core_shift = 6,
> diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
> index 9a0dab9448db..2c50cc2cc6db 100644
> --- a/drivers/clk/rockchip/clk-rk3368.c
> +++ b/drivers/clk/rockchip/clk-rk3368.c
> @@ -154,9 +154,10 @@ static struct clk_div_table div_ddrphy_t[] = {
>   #define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
>   
>   static const struct rockchip_cpuclk_reg_data rk3368_cpuclkb_data = {
> -	.core_reg = RK3368_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK3368_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 7,
> @@ -164,11 +165,12 @@ static const struct rockchip_cpuclk_reg_data rk3368_cpuclkb_data = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3368_cpuclkl_data = {
> -	.core_reg = RK3368_CLKSEL_CON(2),
> -	.div_core_shift = 0,
> +	.core_reg[0] = RK3368_CLKSEL_CON(2),
> +	.div_core_shift[0] = 0,
>   	.mux_core_alt = 1,
> +	.num_cores = 1,
>   	.mux_core_main = 0,
> -	.div_core_mask = 0x1f,
> +	.div_core_mask[0] = 0x1f,
>   	.mux_core_shift = 7,
>   	.mux_core_mask = 0x1,
>   };
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 7df2f1e00347..311ffb3308a8 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -291,9 +291,10 @@ static struct rockchip_clk_branch rk3399_pmuclk_wifi_fracmux __initdata =
>   			RK3399_PMU_CLKSEL_CON(1), 14, 1, MFLAGS);
>   
>   static const struct rockchip_cpuclk_reg_data rk3399_cpuclkl_data = {
> -	.core_reg = RK3399_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK3399_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 3,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 6,
> @@ -301,9 +302,10 @@ static const struct rockchip_cpuclk_reg_data rk3399_cpuclkl_data = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rk3399_cpuclkb_data = {
> -	.core_reg = RK3399_CLKSEL_CON(2),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RK3399_CLKSEL_CON(2),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 3,
>   	.mux_core_main = 1,
>   	.mux_core_shift = 6,
> diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
> index 5947d3192866..5f49af3c970a 100644
> --- a/drivers/clk/rockchip/clk-rv1108.c
> +++ b/drivers/clk/rockchip/clk-rv1108.c
> @@ -106,9 +106,10 @@ static struct rockchip_cpuclk_rate_table rv1108_cpuclk_rates[] __initdata = {
>   };
>   
>   static const struct rockchip_cpuclk_reg_data rv1108_cpuclk_data = {
> -	.core_reg = RV1108_CLKSEL_CON(0),
> -	.div_core_shift = 0,
> -	.div_core_mask = 0x1f,
> +	.core_reg[0] = RV1108_CLKSEL_CON(0),
> +	.div_core_shift[0] = 0,
> +	.div_core_mask[0] = 0x1f,
> +	.num_cores = 1,
>   	.mux_core_alt = 1,
>   	.mux_core_main = 0,
>   	.mux_core_shift = 8,
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 2271a84124b0..7e60ac810101 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -323,6 +323,7 @@ struct rockchip_cpuclk_clksel {
>   };
>   
>   #define ROCKCHIP_CPUCLK_NUM_DIVIDERS	2
> +#define ROCKCHIP_CPUCLK_MAX_CORES	4
>   struct rockchip_cpuclk_rate_table {
>   	unsigned long prate;
>   	struct rockchip_cpuclk_clksel divs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
> @@ -330,22 +331,23 @@ struct rockchip_cpuclk_rate_table {
>   
>   /**
>    * struct rockchip_cpuclk_reg_data - register offsets and masks of the cpuclock
> - * @core_reg:		register offset of the core settings register
> - * @div_core_shift:	core divider offset used to divide the pll value
> - * @div_core_mask:	core divider mask
> - * @mux_core_alt:	mux value to select alternate parent
> + * @core_reg[]:	register offset of the cores setting register
> + * @div_core_shift[]:	cores divider offset used to divide the pll value
> + * @div_core_mask[]:	cores divider mask
> + * @num_cores:	number of cpu cores
>    * @mux_core_main:	mux value to select main parent of core
>    * @mux_core_shift:	offset of the core multiplexer
>    * @mux_core_mask:	core multiplexer mask
>    */
>   struct rockchip_cpuclk_reg_data {
> -	int		core_reg;
> -	u8		div_core_shift;
> -	u32		div_core_mask;
> -	u8		mux_core_alt;
> -	u8		mux_core_main;
> -	u8		mux_core_shift;
> -	u32		mux_core_mask;
> +	int	core_reg[ROCKCHIP_CPUCLK_MAX_CORES];
> +	u8	div_core_shift[ROCKCHIP_CPUCLK_MAX_CORES];
> +	u32	div_core_mask[ROCKCHIP_CPUCLK_MAX_CORES];
> +	int	num_cores;
> +	u8	mux_core_alt;
> +	u8	mux_core_main;
> +	u8	mux_core_shift;
> +	u32	mux_core_mask;
>   };
>   
>   struct clk *rockchip_clk_register_cpuclk(const char *name,


