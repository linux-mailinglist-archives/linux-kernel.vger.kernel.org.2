Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF5324C84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhBYJLn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Feb 2021 04:11:43 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236089AbhBYJIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:08:39 -0500
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lFCcS-0000It-Tw; Thu, 25 Feb 2021 10:07:36 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     sboyd@kernel.org, "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
Subject: Re: [PATCH v1 3/4] clk: rockchip: support more core div setting
Date:   Thu, 25 Feb 2021 10:07:36 +0100
Message-ID: <3100125.44csPzL39Z@diego>
In-Reply-To: <6759a56c-56d1-da63-5299-0d76966329df@rock-chips.com>
References: <20210223095352.11544-1-zhangqing@rock-chips.com> <5312231.BaHzMo0RvP@diego> <6759a56c-56d1-da63-5299-0d76966329df@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Donnerstag, 25. Februar 2021, 03:59:32 CET schrieb elaine.zhang:
> 在 2021/2/23 下午6:22, Heiko Stübner 写道:
> > Am Dienstag, 23. Februar 2021, 10:53:51 CET schrieb Elaine Zhang:
> >> A55 supports each core to work at different frequencies, and each core
> >> has an independent divider control.
> >>
> >> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >> ---
> >>   drivers/clk/rockchip/clk-cpu.c | 25 +++++++++++++++++++++++++
> >>   drivers/clk/rockchip/clk.h     | 17 ++++++++++++++++-
> >>   2 files changed, 41 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
> >> index fa9027fb1920..cac06f4f7573 100644
> >> --- a/drivers/clk/rockchip/clk-cpu.c
> >> +++ b/drivers/clk/rockchip/clk-cpu.c
> >> @@ -164,6 +164,18 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
> >>   				     reg_data->mux_core_mask,
> >>   				     reg_data->mux_core_shift),
> >>   		       cpuclk->reg_base + reg_data->core_reg);
> >> +		if (reg_data->core1_reg)
> >> +			writel(HIWORD_UPDATE(alt_div, reg_data->div_core1_mask,
> >> +					     reg_data->div_core1_shift),
> >> +			       cpuclk->reg_base + reg_data->core1_reg);
> >> +		if (reg_data->core2_reg)
> >> +			writel(HIWORD_UPDATE(alt_div, reg_data->div_core2_mask,
> >> +					     reg_data->div_core2_shift),
> >> +			       cpuclk->reg_base + reg_data->core2_reg);
> >> +		if (reg_data->core3_reg)
> >> +			writel(HIWORD_UPDATE(alt_div, reg_data->div_core3_mask,
> >> +					     reg_data->div_core3_shift),
> >> +			       cpuclk->reg_base + reg_data->core3_reg);
> > for (i = 0; i < reg_data->num_cores; i++)
> > 	writel(...)
> >
> >>   	} else {
> >>   		/* select alternate parent */
> >>   		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
> >> @@ -209,6 +221,19 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
> >>   				reg_data->mux_core_shift),
> >>   	       cpuclk->reg_base + reg_data->core_reg);
> >>   
> >> +	if (reg_data->core1_reg)
> >> +		writel(HIWORD_UPDATE(0, reg_data->div_core1_mask,
> >> +				     reg_data->div_core1_shift),
> >> +		       cpuclk->reg_base + reg_data->core1_reg);
> >> +	if (reg_data->core2_reg)
> >> +		writel(HIWORD_UPDATE(0, reg_data->div_core2_mask,
> >> +				     reg_data->div_core2_shift),
> >> +		       cpuclk->reg_base + reg_data->core2_reg);
> >> +	if (reg_data->core3_reg)
> >> +		writel(HIWORD_UPDATE(0, reg_data->div_core3_mask,
> >> +				     reg_data->div_core3_shift),
> >> +		       cpuclk->reg_base + reg_data->core3_reg);
> >> +
> > for (i = 0; i < reg_data->num_cores; i++)
> > 	writel(...)
> >
> >>   	if (ndata->old_rate > ndata->new_rate)
> >>   		rockchip_cpuclk_set_dividers(cpuclk, rate);
> >>   
> >> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> >> index 2271a84124b0..b46c93fd0cb5 100644
> >> --- a/drivers/clk/rockchip/clk.h
> >> +++ b/drivers/clk/rockchip/clk.h
> >> @@ -322,7 +322,7 @@ struct rockchip_cpuclk_clksel {
> >>   	u32 val;
> >>   };
> >>   
> >> -#define ROCKCHIP_CPUCLK_NUM_DIVIDERS	2
> >> +#define ROCKCHIP_CPUCLK_NUM_DIVIDERS	5
> > please move this into a separate patch, as yes the rk3568 needs more
> > dividers but that isn't related to adding separate core divider controls.
> >
> > [...]
> > add
> >
> > #define ROCKCHIP_CPUCLK_MAX_CORES	4
> >
> >>   struct rockchip_cpuclk_rate_table {
> >>   	unsigned long prate;
> >>   	struct rockchip_cpuclk_clksel divs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
> >> @@ -333,6 +333,12 @@ struct rockchip_cpuclk_rate_table {
> >>    * @core_reg:		register offset of the core settings register
> >>    * @div_core_shift:	core divider offset used to divide the pll value
> >>    * @div_core_mask:	core divider mask
> >> + * @div_core1_shift:	core1 divider offset used to divide the pll value
> >> + * @div_core1_mask:	core1 divider mask
> >> + * @div_core2_shift:	core2 divider offset used to divide the pll value
> >> + * @div_core2_mask:	core2 divider mask
> >> + * @div_core3_shift:	core3 divider offset used to divide the pll value
> >> + * @div_core3_mask:	core3 divider mask
> >>    * @mux_core_alt:	mux value to select alternate parent
> >>    * @mux_core_main:	mux value to select main parent of core
> >>    * @mux_core_shift:	offset of the core multiplexer
> >> @@ -342,6 +348,15 @@ struct rockchip_cpuclk_reg_data {
> >>   	int		core_reg;
> >>   	u8		div_core_shift;
> >>   	u32		div_core_mask;
> >> +	int		core1_reg;
> >> +	u8		div_core1_shift;
> >> +	u32		div_core1_mask;
> >> +	int		core2_reg;
> >> +	u8		div_core2_shift;
> >> +	u32		div_core2_mask;
> >> +	int		core3_reg;
> >> +	u8		div_core3_shift;
> >> +	u32		div_core3_mask;
> > please make this instead like:
> >
> > int	core_reg[ROCKCHIP_CPUCLK_MAX_CORES];
> > u8	div_core_shift[ROCKCHIP_CPUCLK_MAX_CORES];
> > u32	div_core_mask[ROCKCHIP_CPUCLK_MAX_CORES];
> > int	num_cores;
>
> This is also my original intention, but with such modification, other 
> SOCs of RK need to be modified, otherwise they cannot be compatible with 
> the old SOC.

That is actually no problem, especially as the diff should be just a simple

static const struct rockchip_cpuclk_reg_data px30_cpuclk_data = {
-	.core_reg = PX30_CLKSEL_CON(0),
-	.div_core_shift = 0,
-	.div_core_mask = 0xf,
+	.core_reg[0] = PX30_CLKSEL_CON(0),
+	.div_core_shift[0] = 0,
+	.div_core_mask[0] = 0xf,
+	.num_cores = 1,
	.mux_core_alt = 1,
	.mux_core_main = 0,
	.mux_core_shift = 7,
	.mux_core_mask = 0x1,
};

So please go the clean way :-) 

Thanks
Heiko


