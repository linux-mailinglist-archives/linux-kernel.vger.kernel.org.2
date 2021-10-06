Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1785D423922
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJFHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhJFHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:47:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031BC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:45:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY1cW-0001T1-Kj; Wed, 06 Oct 2021 09:45:44 +0200
Message-ID: <8c1d1b836d1acb94e22a355d064a6df867d1e9e2.camel@pengutronix.de>
Subject: Re: [PATCH 3/7] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 09:45:43 +0200
In-Reply-To: <20211006000505.627334-3-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
         <20211006000505.627334-3-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 05.10.2021 um 19:05 -0500 schrieb Adam Ford:
> This adds the description for the i.MX8MN disp blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 70 ++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index e172d295c441..8fcd5ed62f50 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  
>  #include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/power/imx8mn-power.h>
>  
>  #define BLK_SFT_RSTN	0x0
>  #define BLK_CLK_EN	0x4
> @@ -498,6 +499,75 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
>  	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
>  };
>  
> +
> +static int imx8mn_disp_power_notifier(struct notifier_block *nb,
> +				      unsigned long action, void *data)
> +{
> +	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +						 power_nb);
> +
> +	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
> +		return NOTIFY_OK;
> +
> +	/* Enable bus clock and deassert bus reset */
> +	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
> +	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
> +
> +	/*
> +	 * On power up we have no software backchannel to the GPC to
> +	 * wait for the ADB handshake to happen, so we just delay for a
> +	 * bit. On power down the GPC driver waits for the handshake.
> +	 */
> +	if (action == GENPD_NOTIFY_ON)
> +		udelay(5);
> +
> +
> +	return NOTIFY_OK;
> +}
> +
> +static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
> +	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
> +		.name = "dispblk-mipi-dsi",
> +		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
> +		.num_clks = 2,
> +		.gpc_name = "mipi-dsi",
> +		.rst_mask = BIT(0) | BIT(1),
> +		.clk_mask = BIT(0) | BIT(1),
> +	},
> +	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
> +		.name = "dispblk-mipi-csi",
> +		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
> +		.num_clks = 2,
> +		.gpc_name = "mipi-csi",
> +		.rst_mask = BIT(2) | BIT(3),
> +		.clk_mask = BIT(2) | BIT(3),
> +	},
> +	[IMX8MN_DISPBLK_PD_LCDIF] = {
> +		.name = "dispblk-lcdif",
> +		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
> +		.num_clks = 3,
> +		.gpc_name = "lcdif",
> +		.rst_mask = BIT(4) | BIT(5),
> +		.clk_mask = BIT(4) | BIT(5),
> +	},
> +	[IMX8MN_DISPBLK_PD_ISI] = {
> +		.name = "dispblk-isi",
> +		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> +						"disp_apb_root"},
> +		.num_clks = 2,

I think those are wrong. At least the num_clks and the number of clock
names is inconsistent.

> +		.gpc_name = "isi",
> +		.rst_mask = BIT(6) | BIT(7),
> +		.clk_mask = BIT(6) | BIT(7),
> +	},
> +};
> +
> +static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
> +	.max_reg = 0x84,
> +	.power_notifier_fn = imx8mn_disp_power_notifier,
> +	.domains = imx8mn_disp_blk_ctl_domain_data,
> +	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> +};
> +
You need to hook this up in imx8m_blk_ctrl_of_match, otherwise this is
all just dead code.

Regards,
Lucas

>  static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>  	{
>  		.compatible = "fsl,imx8mm-vpu-blk-ctrl",


