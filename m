Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3D33181A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCHUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhCHUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:07:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:07:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54C82E7B;
        Mon,  8 Mar 2021 21:07:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615234028;
        bh=GP0ZO73fgCa0N7PUX0082crl8nWyEVV99FkSUPDVM1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB45rY/P50uxmMn2k/N6sb7d2DNBWe511Q8PeG21e3oyOzHUCPftTFWOWtb0H1g07
         wCKPqY5fq8HnroIcjFlv/XvZLXVBQenMT6ri0FiSMlQlYPzswOK3cvaqcUjuGBdEY5
         RwV4P542/yv81YYBtx+jIrDJoL4Fo2YNHdaQbZjA=
Date:   Mon, 8 Mar 2021 22:06:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     anurag.kumar.vulisha@xilinx.com, kishon@ti.com, vkoul@kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Handle the clock enable/disable properly
Message-ID: <YEaDzWeakpJv4DaT@pendragon.ideasonboard.com>
References: <1615229356-26237-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615229356-26237-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch.

On Tue, Mar 09, 2021 at 12:19:16AM +0530, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 2b65f84..0ec534e 100644
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
> +	int i;

i is never negative, so you can make it an unsigned int.

>  
>  	/* Save the snapshot ICM_CFG registers. */
>  	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable(gtr_dev->clk[i]);

Why is this only clk_disable(), and not clk_disable_unprepare() ? Same
question for xpsgtr_resume().

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
> +		err = clk_enable(gtr_dev->clk[i]);
> +		if (err)
> +			return err;

In case of error we need to disable the clocks that have been
successfully enabled already.

> +	}
>  
>  	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -865,6 +877,7 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
>  static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  {
>  	unsigned int refclk;
> +	int ret;
>  
>  	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
>  		unsigned long rate;
> @@ -882,6 +895,12 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)

There's an error check above that needs to jump to err_clk_put too.

>  		if (!clk)
>  			continue;
>  
> +		gtr_dev->clk[refclk] = clk;
> +
> +		ret = clk_prepare_enable(gtr_dev->clk[refclk]);
> +		if (ret)
> +			return ret;

It would be nice to move the driver to runtime PM to keep the clocks
disabled when the PHY isn't in use. It can be done in a separate patch.

> +
>  		/*
>  		 * Get the spread spectrum (SSC) settings for the reference
>  		 * clock rate.
> @@ -899,11 +918,17 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>  			dev_err(gtr_dev->dev,
>  				"Invalid rate %lu for reference clock %u\n",
>  				rate, refclk);
> -			return -EINVAL;
> +			goto err_clk_put;
>  		}
>  	}
>  
>  	return 0;
> +
> +err_clk_put:
> +	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->clk); refclk++)
> +		clk_disable_unprepare(gtr_dev->clk[refclk]);
> +
> +	return -EINVAL;
>  }
>  
>  static int xpsgtr_probe(struct platform_device *pdev)
> @@ -913,6 +938,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  	struct phy_provider *provider;
>  	unsigned int port;
>  	int ret;
> +	int i;

unsigned int here too.

>  
>  	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
>  	if (!gtr_dev)
> @@ -951,7 +977,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>  		if (IS_ERR(phy)) {
>  			dev_err(&pdev->dev, "failed to create PHY\n");
> -			return PTR_ERR(phy);
> +			ret = PTR_ERR(phy);
> +			goto err_clk_put;
>  		}
>  
>  		gtr_phy->phy = phy;
> @@ -962,9 +989,16 @@ static int xpsgtr_probe(struct platform_device *pdev)
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
