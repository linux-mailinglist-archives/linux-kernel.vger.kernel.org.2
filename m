Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8314606E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357906AbhK1Obv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 09:31:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34686 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhK1O3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 09:29:48 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F8F2F1;
        Sun, 28 Nov 2021 15:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638109589;
        bh=aDo+KpfazdLA9WVSgQWdRL/jZ1a/ht778m7IQb3iUms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABBb2xbKQkX4MJw5ayTonQvxjkTJK8JzYWAjtcJB7RWI8VtV2tqUvhVA/Su0P00YJ
         AIEs2YdC6n+bnrz425hqpHCy2zMVr/Q5sIOJv8fVpdKi44DaayWl0U8pAut0yqorqI
         owPF+GcJaVhjEDYkhh82+Q/SG5ucUX6DL6BvTK5s=
Date:   Sun, 28 Nov 2021 16:26:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset
Message-ID: <YaORfba924MN9vL+@pendragon.ideasonboard.com>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch.

On Sun, Nov 28, 2021 at 06:50:07AM -0600, Adam Ford wrote:
> Most of the blk-ctrl reset bits are found in one register, however
> there are two bits in offset 8 for pulling the MIPI DPHY out of reset
> and one of them needs to be set when IMX8MM_DISPBLK_PD_MIPI_CSI is brought
> out of reset or the MIPI_CSI hangs.
> 
> Since MIPI_DSI is impacted, add the additional one for MIPI_DSI too.

The patch looks good to me. I however wonder if we should clear those
two bits at probe time, in order to start in a known state.

With or without that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: 926e57c065df ("soc: imx: imx8m-blk-ctrl: add DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> V3:  Split the  mipi_phy_rst_mask for CSI and DSI into their respective domains.
> 
> V2:  Make a note that the extra register is only for Mini/Nano DISPLAY_BLK_CTRL
>      Rename the new register to mipi_phy_rst_mask
>      Encapsulate the edits to this register with an if-statement
>      
>  drivers/soc/imx/imx8m-blk-ctrl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 519b3651d1d9..c2f076b56e24 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -17,6 +17,7 @@
>  
>  #define BLK_SFT_RSTN	0x0
>  #define BLK_CLK_EN	0x4
> +#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
>  
>  struct imx8m_blk_ctrl_domain;
>  
> @@ -36,6 +37,15 @@ struct imx8m_blk_ctrl_domain_data {
>  	const char *gpc_name;
>  	u32 rst_mask;
>  	u32 clk_mask;
> +
> +	/*
> +	 * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
> +	 * which is used to control the reset for the MIPI Phy.
> +	 * Since it's only present in certain circumstances,
> +	 * an if-statement should be used before setting and clearing this
> +	 * register.
> +	 */
> +	u32 mipi_phy_rst_mask;
>  };
>  
>  #define DOMAIN_MAX_CLKS 3
> @@ -78,6 +88,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  
>  	/* put devices into reset */
>  	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +	if (data->mipi_phy_rst_mask)
> +		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>  
>  	/* enable upstream and blk-ctrl clocks to allow reset to propagate */
>  	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
> @@ -99,6 +111,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  
>  	/* release reset */
>  	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +	if (data->mipi_phy_rst_mask)
> +		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>  
>  	/* disable upstream clocks */
>  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> @@ -120,6 +134,9 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	struct imx8m_blk_ctrl *bc = domain->bc;
>  
>  	/* put devices into reset and disable clocks */
> +	if (data->mipi_phy_rst_mask)
> +		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> +
>  	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
>  	regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>  
> @@ -480,6 +497,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>  		.gpc_name = "mipi-dsi",
>  		.rst_mask = BIT(5),
>  		.clk_mask = BIT(8) | BIT(9),
> +		.mipi_phy_rst_mask = BIT(17),
>  	},
>  	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
>  		.name = "dispblk-mipi-csi",
> @@ -488,6 +506,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>  		.gpc_name = "mipi-csi",
>  		.rst_mask = BIT(3) | BIT(4),
>  		.clk_mask = BIT(10) | BIT(11),
> +		.mipi_phy_rst_mask = BIT(16),
>  	},
>  };
>  

-- 
Regards,

Laurent Pinchart
