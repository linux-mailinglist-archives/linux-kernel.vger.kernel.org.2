Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2D403396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhIHFCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhIHFCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:02:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F75C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 22:01:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j12so1342922ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59SJITlNj+Ou6NpeOcti6W+PeG703q0PmtIG/+riV2I=;
        b=ewqoX5GR0GQDQStexYRcZ8xnE1vXQfU8hhosIS3fUSkXLkIpSJm68doabddqprhh6s
         2un8bUilB5SbvudD8sEsLBDLuXPA6oKuScLLAFTn6dZQfGgeyvqp3aOEbzmMo4G8F9if
         l6bgH2wRzBpW2pgxKleFAF0tQY07wiPiIZkTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59SJITlNj+Ou6NpeOcti6W+PeG703q0PmtIG/+riV2I=;
        b=l34zNXn4U1hn+dhp0E9LHdGHdoiYptD7RsEbVF42ii0D8Rd78dprA4lLwZKFqttQIz
         8enIzM8zQGiT8cBh078Dni1jauIk19Q7O3wm4CXFNk6Oi7getaL6if21mUb/hLjotH+W
         0aIVIoVqUEVU+bhCUDLAHq+17/8UdZqEzEGNHk416uU441EBVUqcrD1rqzTGoidK2dx2
         e2RavtahGeyOEuoBie+/tbuQ4V2KuixiRd8EWLgGFnDfeECPbvOd2dEfkBRFCWLR5MTE
         Nj+/IPFYMExORlJQSXUTuP1IcLxk8W1cKBflMopcx19lNepeNgF1LqBXrxmzefs3UD19
         1CSA==
X-Gm-Message-State: AOAM533XnNniCuZU1rPDQuJ19YEme9XktiDeyGUl5XqsoqCZqpMUnLcf
        Z1ACP0Ph0oiwxvSzwki7Dr679UTucEELajzhN8Pvvw==
X-Google-Smtp-Source: ABdhPJx2VlFdtpsSPoyhBFFN0IDcYDzg5MRbDu1Cbvp0StYf9spI1uDQnWfI7uro2VByekXzT80q+7ymVwXak9jRAMw=
X-Received: by 2002:a2e:7d17:: with SMTP id y23mr1314834ljc.392.1631077263834;
 Tue, 07 Sep 2021 22:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
In-Reply-To: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 8 Sep 2021 13:00:52 +0800
Message-ID: <CAGXv+5E1Kk3PYK1GBatfBVnaEVfGCLvb5P-dN9S05LawAfimjw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 12:46 AM Brian Norris <briannorris@chromium.org> wrote:
>
> We have DT IDs for PCLK_COREDBG_L and PCLK_COREDBG_B, but we don't
> actually expose them.
>
> In exposing these clocks (and attaching them to the coresight debug
> driver), the AMBA bus may start to disable them. Because no CPU driver
> owns these clocks (e.g., cpufreq-dt doesn't enable() them -- and even if
> it did, it's not early enough -- nor does arch/arm64/kernel/smp.c), the
> common clock framework then feels the need to disable the parents
> (including the CPU PLLs) -- which is no fun for anyone.
>
> Thus, mark the CPU clocks as critical as well.

I think this part should be done regardless, and could be a separate patch
added before exposing the COREDBG clks.

Either way,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Resending, because I missed the mailing lists on the first version.
>
>  drivers/clk/rockchip/clk-rk3399.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 62a4f2543960..53ed5cca335b 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -481,7 +481,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>         COMPOSITE_NOMUX(0, "atclk_core_l", "armclkl", CLK_IGNORE_UNUSED,
>                         RK3399_CLKSEL_CON(1), 0, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>                         RK3399_CLKGATE_CON(0), 5, GFLAGS),
> -       COMPOSITE_NOMUX(0, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
> +       COMPOSITE_NOMUX(PCLK_COREDBG_L, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
>                         RK3399_CLKSEL_CON(1), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>                         RK3399_CLKGATE_CON(0), 6, GFLAGS),
>
> @@ -531,7 +531,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>         GATE(ACLK_GIC_ADB400_CORE_B_2_GIC, "aclk_core_adb400_core_b_2_gic", "armclkb", CLK_IGNORE_UNUSED,
>                         RK3399_CLKGATE_CON(14), 4, GFLAGS),
>
> -       DIV(0, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
> +       DIV(PCLK_COREDBG_B, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
>                         RK3399_CLKSEL_CON(3), 13, 2, DFLAGS | CLK_DIVIDER_READ_ONLY),
>
>         GATE(0, "pclk_dbg_cxcs_pd_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
> @@ -1514,7 +1514,10 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
>         "aclk_vio_noc",
>
>         /* ddrc */
> -       "sclk_ddrc"
> +       "sclk_ddrc",
> +
> +       "armclkl",
> +       "armclkb",
>  };
>
>  static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
> @@ -1549,9 +1552,6 @@ static void __init rk3399_clk_init(struct device_node *np)
>         rockchip_clk_register_branches(ctx, rk3399_clk_branches,
>                                   ARRAY_SIZE(rk3399_clk_branches));
>
> -       rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
> -                                     ARRAY_SIZE(rk3399_cru_critical_clocks));
> -
>         rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
>                         mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
>                         &rk3399_cpuclkl_data, rk3399_cpuclkl_rates,
> @@ -1562,6 +1562,9 @@ static void __init rk3399_clk_init(struct device_node *np)
>                         &rk3399_cpuclkb_data, rk3399_cpuclkb_rates,
>                         ARRAY_SIZE(rk3399_cpuclkb_rates));
>
> +       rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
> +                                     ARRAY_SIZE(rk3399_cru_critical_clocks));
> +

Looking at the bigger picture, maybe it's time to convert CLK_IGNORE_UNUSED
and rockchip_clk_protect_critical() to CLK_IS_CRITICAL?

ChenYu

>         rockchip_register_softrst(np, 21, reg_base + RK3399_SOFTRST_CON(0),
>                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
>
> --
> 2.33.0.153.gba50c8fa24-goog
>
