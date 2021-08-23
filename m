Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8291D3F4303
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhHWB0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbhHWBZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:25:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2300C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:25:17 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E0262A5;
        Mon, 23 Aug 2021 03:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629681914;
        bh=bF2eM1CLvpsJGygBy58TLBZiUmvSjAow9dAwMvxRQJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLIjcQmRAXuB8GHRI1aEPQK5Cu88VUiWcO0j1ZwQw3aV1RFy9Ca3IyQdPMH18DQpz
         6NulzCNcXb7ymG4AT415Klfr+Qg6bUfXIr5CPKNrG4pdqluJY9KeaiR+Gb+VPfYuRO
         VXLeTxethNbxdBwcj0sRMq/M+o90qMl3uOlbnVRY=
Date:   Mon, 23 Aug 2021 04:25:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 1/6] phy: cdns-dphy: Prepare for Rx support
Message-ID: <YSL48RA2ksldoCyX@pendragon.ideasonboard.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820190346.18550-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Sat, Aug 21, 2021 at 12:33:41AM +0530, Pratyush Yadav wrote:
> The Rx programming sequence differs from the Tx programming sequence.
> Currently only Tx mode is supported. For example, the power on and off,
> validation, and configuration procedures are all different between Rx
> and Tx DPHYs. Currently they are only written from a Tx point of view
> and they won't work with an Rx DPHY. Move them to cdns_dphy_ops so they
> can be defined by the implementation, accommodating both Rx and Tx mode
> DPHYs.
> 
> The clocks "psm" and "pll_ref" are not used by the Rx path so make them
> optional in the probe and then check if they exist in the Tx power_on()
> hook.

I think it would be better to check them at probe time.

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v4:
> - Instead of having both Rx and Tx modes in the same driver data, keep
>   them separate since the op selection is based on compatible now. For
>   that reason, the cdns_dphy_driver_data struct is no longer needed.
> - Rename ref_dphy_ops to tx_ref_dphy_ops to clarify their purpose.
> - Drop submode checks in validate() hook.
> 
>  drivers/phy/cadence/cdns-dphy.c | 123 ++++++++++++++++++++++----------
>  1 file changed, 87 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index ba042e39cfaf..0a169d649216 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -75,6 +75,11 @@ struct cdns_dphy;
>  struct cdns_dphy_ops {
>  	int (*probe)(struct cdns_dphy *dphy);
>  	void (*remove)(struct cdns_dphy *dphy);
> +	int (*power_on)(struct cdns_dphy *dphy);
> +	int (*power_off)(struct cdns_dphy *dphy);
> +	int (*validate)(struct cdns_dphy *dphy, enum phy_mode mode, int submode,
> +			union phy_configure_opts *opts);
> +	int (*configure)(struct cdns_dphy *dphy, union phy_configure_opts *opts);
>  	void (*set_psm_div)(struct cdns_dphy *dphy, u8 div);
>  	void (*set_clk_lane_cfg)(struct cdns_dphy *dphy,
>  				 enum cdns_dphy_clk_lane_cfg cfg);
> @@ -86,6 +91,7 @@ struct cdns_dphy_ops {
>  struct cdns_dphy {
>  	struct cdns_dphy_cfg cfg;
>  	void __iomem *regs;
> +	struct device *dev;
>  	struct clk *psm_clk;
>  	struct clk *pll_ref_clk;
>  	const struct cdns_dphy_ops *ops;
> @@ -199,20 +205,9 @@ static void cdns_dphy_ref_set_psm_div(struct cdns_dphy *dphy, u8 div)
>  	       dphy->regs + DPHY_PSM_CFG);
>  }
>  
> -/*
> - * This is the reference implementation of DPHY hooks. Specific integration of
> - * this IP may have to re-implement some of them depending on how they decided
> - * to wire things in the SoC.
> - */
> -static const struct cdns_dphy_ops ref_dphy_ops = {
> -	.get_wakeup_time_ns = cdns_dphy_ref_get_wakeup_time_ns,
> -	.set_pll_cfg = cdns_dphy_ref_set_pll_cfg,
> -	.set_psm_div = cdns_dphy_ref_set_psm_div,
> -};
> -
> -static int cdns_dphy_config_from_opts(struct phy *phy,
> -				      struct phy_configure_opts_mipi_dphy *opts,
> -				      struct cdns_dphy_cfg *cfg)
> +static int cdns_dphy_tx_config_from_opts(struct phy *phy,
> +					 struct phy_configure_opts_mipi_dphy *opts,
> +					 struct cdns_dphy_cfg *cfg)
>  {
>  	struct cdns_dphy *dphy = phy_get_drvdata(phy);
>  	unsigned int dsi_hfp_ext = 0;
> @@ -232,24 +227,13 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
>  	return 0;
>  }
>  
> -static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
> -			      union phy_configure_opts *opts)
> +static int cdns_dphy_tx_configure(struct cdns_dphy *dphy,
> +				  union phy_configure_opts *opts)
>  {
>  	struct cdns_dphy_cfg cfg = { 0 };
> -
> -	if (mode != PHY_MODE_MIPI_DPHY)
> -		return -EINVAL;
> -
> -	return cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> -}
> -
> -static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> -{
> -	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> -	struct cdns_dphy_cfg cfg = { 0 };
>  	int ret;
>  
> -	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> +	ret = cdns_dphy_tx_config_from_opts(dphy->phy, &opts->mipi_dphy, &cfg);
>  	if (ret)
>  		return ret;
>  
> @@ -279,9 +263,18 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	return 0;
>  }
>  
> -static int cdns_dphy_power_on(struct phy *phy)
> +static int cdns_dphy_tx_validate(struct cdns_dphy *dphy, enum phy_mode mode,
> +				 int submode, union phy_configure_opts *opts)
>  {
> -	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +	struct cdns_dphy_cfg cfg = { 0 };
> +
> +	return cdns_dphy_tx_config_from_opts(dphy->phy, &opts->mipi_dphy, &cfg);
> +}
> +
> +static int cdns_dphy_tx_power_on(struct cdns_dphy *dphy)
> +{
> +	if (!dphy->psm_clk || !dphy->pll_ref_clk)
> +		return -EINVAL;
>  
>  	clk_prepare_enable(dphy->psm_clk);
>  	clk_prepare_enable(dphy->pll_ref_clk);
> @@ -293,16 +286,73 @@ static int cdns_dphy_power_on(struct phy *phy)
>  	return 0;
>  }
>  
> -static int cdns_dphy_power_off(struct phy *phy)
> +static int cdns_dphy_tx_power_off(struct cdns_dphy *dphy)
>  {
> -	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> -
>  	clk_disable_unprepare(dphy->pll_ref_clk);
>  	clk_disable_unprepare(dphy->psm_clk);
>  
>  	return 0;
>  }
>  
> +/*
> + * This is the reference implementation of DPHY hooks. Specific integration of
> + * this IP may have to re-implement some of them depending on how they decided
> + * to wire things in the SoC.
> + */
> +static const struct cdns_dphy_ops tx_ref_dphy_ops = {
> +	.power_on = cdns_dphy_tx_power_on,
> +	.power_off = cdns_dphy_tx_power_off,
> +	.validate = cdns_dphy_tx_validate,
> +	.configure = cdns_dphy_tx_configure,
> +	.get_wakeup_time_ns = cdns_dphy_ref_get_wakeup_time_ns,
> +	.set_pll_cfg = cdns_dphy_ref_set_pll_cfg,
> +	.set_psm_div = cdns_dphy_ref_set_psm_div,
> +};
> +
> +static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
> +			      union phy_configure_opts *opts)
> +{
> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +
> +	if (mode != PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	if (dphy->ops->validate)
> +		return dphy->ops->validate(dphy, mode, submode, opts);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_power_on(struct phy *phy)
> +{
> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +
> +	if (dphy->ops->power_on)
> +		return dphy->ops->power_on(dphy);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_power_off(struct phy *phy)
> +{
> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +
> +	if (dphy->ops->power_off)
> +		return dphy->ops->power_off(dphy);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +
> +	if (dphy->ops->configure)
> +		return dphy->ops->configure(dphy, opts);
> +
> +	return 0;
> +}
> +

Given that all of these are essentially pass-through operations, how
about getting rid of the indirection ? I would create a new structure:

struct cdns_dphy_info {
	const struct phy_ops *phy_ops;
	const struct cdns_dphy_ops *dphy_ops;
};

and reference it in cdns_dphy_of_match. The cdns_dphy structure would
then store a pointer to cdns_dphy_info. That way you won't have to
extend cdns_dphy_ops, which could possibly be renamed to
cdns_dphy_tx_ops as you don't use those operations for rx.

>  static const struct phy_ops cdns_dphy_ops = {
>  	.configure	= cdns_dphy_configure,
>  	.validate	= cdns_dphy_validate,
> @@ -320,6 +370,7 @@ static int cdns_dphy_probe(struct platform_device *pdev)
>  	if (!dphy)
>  		return -ENOMEM;
>  	dev_set_drvdata(&pdev->dev, dphy);
> +	dphy->dev = &pdev->dev;
>  
>  	dphy->ops = of_device_get_match_data(&pdev->dev);
>  	if (!dphy->ops)
> @@ -329,11 +380,11 @@ static int cdns_dphy_probe(struct platform_device *pdev)
>  	if (IS_ERR(dphy->regs))
>  		return PTR_ERR(dphy->regs);
>  
> -	dphy->psm_clk = devm_clk_get(&pdev->dev, "psm");
> +	dphy->psm_clk = devm_clk_get_optional(dphy->dev, "psm");
>  	if (IS_ERR(dphy->psm_clk))
>  		return PTR_ERR(dphy->psm_clk);
>  
> -	dphy->pll_ref_clk = devm_clk_get(&pdev->dev, "pll_ref");
> +	dphy->pll_ref_clk = devm_clk_get_optional(dphy->dev, "pll_ref");
>  	if (IS_ERR(dphy->pll_ref_clk))
>  		return PTR_ERR(dphy->pll_ref_clk);
>  
> @@ -369,7 +420,7 @@ static int cdns_dphy_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id cdns_dphy_of_match[] = {
> -	{ .compatible = "cdns,dphy", .data = &ref_dphy_ops },
> +	{ .compatible = "cdns,dphy", .data = &tx_ref_dphy_ops },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, cdns_dphy_of_match);

-- 
Regards,

Laurent Pinchart
