Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1099343921A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhJYJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhJYJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A652460E75;
        Mon, 25 Oct 2021 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635153153;
        bh=MjBexmc+UwyAQdIuRX30ws8hPJix22br3QpCrOQ0dyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3UxHM3x7BttuZNCO0VVvfuOeg4fHL89nqnrZVHKEOQY6MXLzHNC9zx6s7ADGIScu
         MYHd78nLDFRPNUHSgz1/TUjG0oqdjB/iMtOJT6eKcWe4JFMXEg+TnN8R1GAcLHRH+R
         eqstupuMGJdObAZZnMrqBHrtasQcu36j7hVvzUbdLiFmE9BuHfnrgMBMwY2xFhm3d8
         1lg1nVIs6uevMiYHDZjwHdCrvU9wtDlnOQobZd4izjbUJ52fiAmBiI06qqF/3zIqG6
         5HZtePMCpWFTT992jJKvR56D9qmAB1PYz1f2oNDfeRiIcP1ko+OBlxUFcLXRiOiE7B
         GDILHcbTOcSVQ==
Date:   Mon, 25 Oct 2021 12:12:28 +0300
From:   Abel Vesa <abelvesa@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: imx: gate off peripheral clock slice
Message-ID: <YXZ0/C9KUZM7ceTY@ryzen>
References: <20211022130946.16683-1-peng.fan@oss.nxp.com>
 <eeac9ec3-1775-acc8-61c4-1d5c12ab0a29@pengutronix.de>
 <DU2PR04MB90209C3309DFCB331BF95A0588809@DU2PR04MB9020.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB90209C3309DFCB331BF95A0588809@DU2PR04MB9020.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22 15:46:20, Peng Fan wrote:
> Hi Ahmad,
> 
> > Subject: Re: [PATCH] clk: imx: gate off peripheral clock slice
> > 
> > Hello Peng,
> > 
> > On 22.10.21 15:09, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The Peripheral clocks are default enabled when SoC power on, and
> > > bootloader not gate off the clocks when booting Linux Kernel.
> > >
> > > So Linux Kernel is not aware the peripheral clocks are enabled and
> > > still take them as disabled because of enable count is zero.
> > >
> > > Then Peripheral clock's source without clock gated off could be
> > > changed when have assigned-parents in device tree
> > >
> > > However, per i.MX8M* reference mannual, "Peripheral clock slices must
> > > be stopped to change the clock source", so need to gate off the the
> > > peripheral clock when registering the clocks to avoid glitch.
> > 
> > This sounds like a fix that should be backported. If so, could you provide a
> > Fixes: Tag?
> 
> We not see any critical issue without this patch, just to avoid
> any potential risk here. So I not add fix tag here.
> 
> Abel, do you prefer a fixes tag or leave it as is?
> 

Lets put a fixes tag still. That way, it will be backported and
it will probably save someone (who's maybe using an older kernel) a headache.
Plus, it will get in sooner.

> Thanks,
> Peng.
> 
> > 
> > Thanks,
> > Ahmad
> > 
> > >
> > > Tested boot on i.MX8MM/P-EVK board
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-composite-8m.c
> > > b/drivers/clk/imx/clk-composite-8m.c
> > > index 2dfd6149e528..ee41fbf90589 100644
> > > --- a/drivers/clk/imx/clk-composite-8m.c
> > > +++ b/drivers/clk/imx/clk-composite-8m.c
> > > @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> > char *name,
> > >  	struct clk_mux *mux = NULL;
> > >  	const struct clk_ops *divider_ops;
> > >  	const struct clk_ops *mux_ops;
> > > +	u32 val;
> > >
> > >  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > >  	if (!mux)
> > > @@ -216,8 +217,14 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> > char *name,
> > >  		div->width = PCG_PREDIV_WIDTH;
> > >  		divider_ops = &imx8m_clk_composite_divider_ops;
> > >  		mux_ops = &clk_mux_ops;
> > > -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> > > +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
> > >  			flags |= CLK_SET_PARENT_GATE;
> > > +			if (!(flags & CLK_IS_CRITICAL)) {
> > > +				val = readl(reg);
> > > +				val &= ~BIT(PCG_CGC_SHIFT);
> > > +				writel(val, reg);
> > > +			}
> > > +		}
> > >  	}
> > >
> > >  	div->lock = &imx_ccm_lock;
> > >
> > 
> > 
> > --
> > Pengutronix e.K.                           |
> > |
> > Steuerwalder Str. 21                       |
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.p
> > engutronix.de%2F&amp;data=04%7C01%7Cpeng.fan%40nxp.com%7Cb5b827
> > 20263e43680e9208d995597f48%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> > 7C0%7C0%7C637705033902868076%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> > oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> > 000&amp;sdata=PolK7YYK66Bbyd6KJgINnvma8JZ6OdDZ8e1cp6rvIww%3D&a
> > mp;reserved=0  |
> > 31137 Hildesheim, Germany                  | Phone:
> > +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> > +49-5121-206917-5555 |
