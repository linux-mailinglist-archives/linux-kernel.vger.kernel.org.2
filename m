Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5BF403581
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbhIHHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:33:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58072 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347750AbhIHHdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:33:40 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mNs4M-0005B3-8u; Wed, 08 Sep 2021 09:32:30 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 1/2] clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}
Date:   Wed, 08 Sep 2021 09:32:29 +0200
Message-ID: <4746858.5FAZtBfuxM@diego>
In-Reply-To: <CAGXv+5E1Kk3PYK1GBatfBVnaEVfGCLvb5P-dN9S05LawAfimjw@mail.gmail.com>
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid> <CAGXv+5E1Kk3PYK1GBatfBVnaEVfGCLvb5P-dN9S05LawAfimjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. September 2021, 07:00:52 CEST schrieb Chen-Yu Tsai:
> On Wed, Sep 8, 2021 at 12:46 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > We have DT IDs for PCLK_COREDBG_L and PCLK_COREDBG_B, but we don't
> > actually expose them.
> >
> > In exposing these clocks (and attaching them to the coresight debug
> > driver), the AMBA bus may start to disable them. Because no CPU driver
> > owns these clocks (e.g., cpufreq-dt doesn't enable() them -- and even if
> > it did, it's not early enough -- nor does arch/arm64/kernel/smp.c), the
> > common clock framework then feels the need to disable the parents
> > (including the CPU PLLs) -- which is no fun for anyone.
> >
> > Thus, mark the CPU clocks as critical as well.
> 
> I think this part should be done regardless, and could be a separate patch
> added before exposing the COREDBG clks.

yep ... especially as this is sort of hidden right now, with it not
being part of the patch subject but only appearing as the last
line of the patch message ;-)

So I'd also vote for a separate patch.


Heiko

> 
> Either way,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Resending, because I missed the mailing lists on the first version.
> >
> >  drivers/clk/rockchip/clk-rk3399.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> > index 62a4f2543960..53ed5cca335b 100644
> > --- a/drivers/clk/rockchip/clk-rk3399.c
> > +++ b/drivers/clk/rockchip/clk-rk3399.c
> > @@ -481,7 +481,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
> >         COMPOSITE_NOMUX(0, "atclk_core_l", "armclkl", CLK_IGNORE_UNUSED,
> >                         RK3399_CLKSEL_CON(1), 0, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
> >                         RK3399_CLKGATE_CON(0), 5, GFLAGS),
> > -       COMPOSITE_NOMUX(0, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
> > +       COMPOSITE_NOMUX(PCLK_COREDBG_L, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
> >                         RK3399_CLKSEL_CON(1), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
> >                         RK3399_CLKGATE_CON(0), 6, GFLAGS),
> >
> > @@ -531,7 +531,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
> >         GATE(ACLK_GIC_ADB400_CORE_B_2_GIC, "aclk_core_adb400_core_b_2_gic", "armclkb", CLK_IGNORE_UNUSED,
> >                         RK3399_CLKGATE_CON(14), 4, GFLAGS),
> >
> > -       DIV(0, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
> > +       DIV(PCLK_COREDBG_B, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
> >                         RK3399_CLKSEL_CON(3), 13, 2, DFLAGS | CLK_DIVIDER_READ_ONLY),
> >
> >         GATE(0, "pclk_dbg_cxcs_pd_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
> > @@ -1514,7 +1514,10 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
> >         "aclk_vio_noc",
> >
> >         /* ddrc */
> > -       "sclk_ddrc"
> > +       "sclk_ddrc",
> > +
> > +       "armclkl",
> > +       "armclkb",
> >  };
> >
> >  static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
> > @@ -1549,9 +1552,6 @@ static void __init rk3399_clk_init(struct device_node *np)
> >         rockchip_clk_register_branches(ctx, rk3399_clk_branches,
> >                                   ARRAY_SIZE(rk3399_clk_branches));
> >
> > -       rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
> > -                                     ARRAY_SIZE(rk3399_cru_critical_clocks));
> > -
> >         rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
> >                         mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
> >                         &rk3399_cpuclkl_data, rk3399_cpuclkl_rates,
> > @@ -1562,6 +1562,9 @@ static void __init rk3399_clk_init(struct device_node *np)
> >                         &rk3399_cpuclkb_data, rk3399_cpuclkb_rates,
> >                         ARRAY_SIZE(rk3399_cpuclkb_rates));
> >
> > +       rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
> > +                                     ARRAY_SIZE(rk3399_cru_critical_clocks));
> > +
> 
> Looking at the bigger picture, maybe it's time to convert CLK_IGNORE_UNUSED
> and rockchip_clk_protect_critical() to CLK_IS_CRITICAL?
> 
> ChenYu
> 
> >         rockchip_register_softrst(np, 21, reg_base + RK3399_SOFTRST_CON(0),
> >                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
> >
> > --
> > 2.33.0.153.gba50c8fa24-goog
> >
> 




