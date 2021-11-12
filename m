Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40844E210
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhKLG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:57:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FBC0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:55:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t18so14396004edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=To+Hrt/YJtzMS8Ax7Q4RYEa2brHHp6skSFCVWG9Je5Y=;
        b=RqrRoXnN1GSAvBKjU1L/2WILu4krk8kArFFAx9wej/qkCuZJI8t7xhp5ecuBqdsBl/
         1y94HtlpGP4Wy+vcVo8lhpBOfhraclDkwrVe+24ZUZ5dzcF+wFgwDWv/zmfCTiWaCcvi
         1D2/bJoLnCOS14uoQx915z9vcr1LaoJsLRPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To+Hrt/YJtzMS8Ax7Q4RYEa2brHHp6skSFCVWG9Je5Y=;
        b=xjz6bUrVh1U5dyk6pkq2GvjK4dZSNWGkHAxM35NmMii759JzIeDYlt9prezZ22cdDG
         lfDtjdUe6NzG+Gc/s8SXGezBO4L+wTKYMoVAANw7ZRDeolz6tPcmQQ+s2EjK6/KfdYAp
         WjdaMPg81oRx9O0wVW9smJHbv8YpGI4qTMvlzVqebXrnI10es6ja8Kx+zW/cvwpoQxcQ
         xr5/M47vvkTUWAMQ1kuVaM7s0HrfCvjrxW93/J5W/cUwPANG/mByJeHKgxb2CQoJ3shA
         +7zfuFs6YpkN7BGtl36EPiVJYsgmuCEwYchrEftpU3yB9KaSngIpYwP0VifI1J3d+4ps
         30lQ==
X-Gm-Message-State: AOAM531qLoivmeirJ8wGf8o7tH+xwjEaB+OW4DOUWmogTEAEcfPP09P6
        +8yTvXJqg5eppKzS5NXR+iKsGyYw3yrJKdVC1eLJrSGXDZFfcQ==
X-Google-Smtp-Source: ABdhPJwOEpGKQBzUUa60Ozn0KGjXRmmDQYViyaSrxV7MX+UL5Qisz1sqfBDKiQWOmmy2d7iBt5UJqG1CoGHWBd3kqOc=
X-Received: by 2002:aa7:d748:: with SMTP id a8mr4764040eds.21.1636700102636;
 Thu, 11 Nov 2021 22:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20211106155427.753197-1-aford173@gmail.com>
In-Reply-To: <20211106155427.753197-1-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 12 Nov 2021 12:24:51 +0530
Message-ID: <CAMty3ZDi+FMLBooi2jt=dPKVC8PhaBWLgtjoe3m=GHCNiqDqQw@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        frieder.schrempf@kontron.de, linux-media@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, aford@beaconembedded.com,
        cstevens@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 6, 2021 at 9:24 PM Adam Ford <aford173@gmail.com> wrote:
>
> Most of the blk-ctrl reset bits are found in one register, however
> there are two bits in offset 8 for pulling the MIPI DPHY out of reset
> and these need to be set when IMX8MM_DISPBLK_PD_MIPI_CSI is brought
> out of reset or the MIPI_CSI hangs.
>
> Fixes: 926e57c065df ("soc: imx: imx8m-blk-ctrl: add DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>
> V2:  Make a note that the extra register is only for Mini/Nano DISPLAY_BLK_CTRL
>      Rename the new register to mipi_phy_rst_mask
>      Encapsulate the edits to this register with an if-statement

This is DPHY reset mask, not sure we can handle this via blk-ctrl.
Marek has similar patch to support this [1]. we need to phandle the
phy in host node in order to work this.

However this current patch change seems directly handling dphy reset
which indeed fine me as well.

>
>  drivers/soc/imx/imx8m-blk-ctrl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 519b3651d1d9..581eb4bc7f7d 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -17,6 +17,7 @@
>
>  #define BLK_SFT_RSTN   0x0
>  #define BLK_CLK_EN     0x4
> +#define BLK_MIPI_RESET_DIV     0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
>
>  struct imx8m_blk_ctrl_domain;
>
> @@ -36,6 +37,15 @@ struct imx8m_blk_ctrl_domain_data {
>         const char *gpc_name;
>         u32 rst_mask;
>         u32 clk_mask;
> +
> +       /*
> +        * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
> +        * which is used to control the reset for the MIPI Phy.
> +        * Since it's only present in certain circumstances,
> +        * an if-statement should be used before setting and clearing this
> +        * register.
> +        */
> +       u32 mipi_phy_rst_mask;

May be dphy_rst_mask (above comment may not be required, as it
understand directly with commit message).

>  };
>
>  #define DOMAIN_MAX_CLKS 3
> @@ -78,6 +88,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>
>         /* put devices into reset */
>         regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +       if (data->mipi_phy_rst_mask)
> +               regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>
>         /* enable upstream and blk-ctrl clocks to allow reset to propagate */
>         ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
> @@ -99,6 +111,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>
>         /* release reset */
>         regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +       if (data->mipi_phy_rst_mask)
> +               regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>
>         /* disable upstream clocks */
>         clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> @@ -120,6 +134,9 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>         struct imx8m_blk_ctrl *bc = domain->bc;
>
>         /* put devices into reset and disable clocks */
> +       if (data->mipi_phy_rst_mask)
> +               regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> +
>         regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
>         regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>
> @@ -488,6 +505,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>                 .gpc_name = "mipi-csi",
>                 .rst_mask = BIT(3) | BIT(4),
>                 .clk_mask = BIT(10) | BIT(11),
> +               .mipi_phy_rst_mask = BIT(16) | BIT(17),

DPHY has BIT(17) for Master reset and BIT(16) for Slave reset. I think
we just need master reset to enable. I've tested only BIT(17) on
mipi-dsi gpc and it is working.

Jagan.
