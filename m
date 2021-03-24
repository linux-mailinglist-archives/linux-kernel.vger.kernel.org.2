Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A649346FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhCXDIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:08:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50924 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCXDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:08:18 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C22E580;
        Wed, 24 Mar 2021 04:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616555297;
        bh=OHoX5/LYISUDg9UK7L0hHBxQnF6o389Kj34EmG7DVT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7M2Bd0yliL+hGyPptJ2tf2KiE2pPs1vgBurSWeYk0677nkUw2Gkx110bQE8uktbH
         MXT3TWvJplFMusZXteBxqzQ6VTI3HZm15vufo84oh0VSQljDewivO3nf43tuRE69MV
         MkSnyeh3ZqFneFCuUnwYFyqRbrk25n4SmyS9oElI=
Date:   Wed, 24 Mar 2021 05:07:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     kishon@ti.com, vkoul@kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v3] phy: zynqmp: Handle the clock enable/disable properly
Message-ID: <YFqs99u6pLzDxZy2@pendragon.ideasonboard.com>
References: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch.

On Tue, Mar 23, 2021 at 07:49:47PM +0530, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

This looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

However, it would be really nice to make clock handling dynamic, to only
enable clocks that are needed by active PHYs. Keeping them enabled at
all times will waste power. It can be done on top of this patch. Is it
something you could work on ?

> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 57 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 2b65f84..69492a5 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -219,6 +219,7 @@ struct xpsgtr_dev {
>  	struct mutex gtr_mutex; /* mutex for locking */
>  	struct xpsgtr_phy phys[NUM_LANES];
>  	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
> +	struct clk *clk[NUM_LANES];
>  	bool tx_term_fix;
>  	unsigned int saved_icm_cfg0;
>  	unsigned int saved_icm_cfg1;
> @@ -818,11 +819,15 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  static int __maybe_unused xpsgtr_suspend(struct device *dev)
>  {
>  	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
> +	unsigned int i;
>  
>  	/* Save the snapshot ICM_CFG registers. */
>  	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
>  	return 0;
>  }
>  
> @@ -832,6 +837,13 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  	unsigned int icm_cfg0, icm_cfg1;
>  	unsigned int i;
>  	bool skip_phy_init;
> +	int err;
> +
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> +		err = clk_prepare_enable(gtr_dev->clk[i]);
> +		if (err)
> +			goto err_clk_put;
> +	}
>  
>  	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -852,6 +864,12 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>  		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
>  
>  	return 0;
> +
> +err_clk_put:
> +	while (i--)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return err;
>  }
>  
>  static const struct dev_pm_ops xpsgtr_pm_ops = {
> @@ -865,6 +883,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
>  static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  {
>  	unsigned int refclk;
> +	int ret;
>  
>  	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
>  		unsigned long rate;
> @@ -874,14 +893,22 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  
>  		snprintf(name, sizeof(name), "ref%u", refclk);
>  		clk = devm_clk_get_optional(gtr_dev->dev, name);
> -		if (IS_ERR(clk))
> -			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> -					     "Failed to get reference clock %u\n",
> -					     refclk);
> +		if (IS_ERR(clk)) {
> +			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> +					    "Failed to get reference clock %u\n",
> +					    refclk);
> +			goto err_clk_put;
> +		}
>  
>  		if (!clk)
>  			continue;
>  
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			goto err_clk_put;
> +
> +		gtr_dev->clk[refclk] = clk;
> +
>  		/*
>  		 * Get the spread spectrum (SSC) settings for the reference
>  		 * clock rate.
> @@ -899,11 +926,18 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  			dev_err(gtr_dev->dev,
>  				"Invalid rate %lu for reference clock %u\n",
>  				rate, refclk);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_clk_put;
>  		}
>  	}
>  
>  	return 0;
> +
> +err_clk_put:
> +	while (refclk--)
> +		clk_disable_unprepare(gtr_dev->clk[refclk]);
> +
> +	return ret;
>  }
>  
>  static int xpsgtr_probe(struct platform_device *pdev)
> @@ -912,6 +946,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	struct xpsgtr_dev *gtr_dev;
>  	struct phy_provider *provider;
>  	unsigned int port;
> +	unsigned int i;
>  	int ret;
>  
>  	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
> @@ -951,7 +986,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>  		if (IS_ERR(phy)) {
>  			dev_err(&pdev->dev, "failed to create PHY\n");
> -			return PTR_ERR(phy);
> +			ret = PTR_ERR(phy);
> +			goto err_clk_put;
>  		}
>  
>  		gtr_phy->phy = phy;
> @@ -962,9 +998,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
>  	if (IS_ERR(provider)) {
>  		dev_err(&pdev->dev, "registering provider failed\n");
> -		return PTR_ERR(provider);
> +		ret = PTR_ERR(provider);
> +		goto err_clk_put;
>  	}
>  	return 0;
> +
> +err_clk_put:
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);
> +
> +	return ret;
>  }
>  
>  static const struct of_device_id xpsgtr_of_match[] = {

-- 
Regards,

Laurent Pinchart
