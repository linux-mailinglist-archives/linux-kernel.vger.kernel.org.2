Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D7341231
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCSBiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCSBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:37:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:37:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 546AA4FD;
        Fri, 19 Mar 2021 02:37:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616117875;
        bh=Thu4D/gcRRsbB+L0SIeYzvGUWd62xfEsqC7314uIkow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQUqiLdN1WXbE1yq6Vp1mvoIrlhXYKoCIGLGbT7XObzRG5LsNq304MvDnPVD3Xn6I
         AAMRoAFJzGMdnI8fvUhvNTsmOg/yjCccqQ+Gb656QQjGJr2KbOa6Jvx1pTUNQZAAUz
         xjG5Z3JfybboQiyx+coFV99MOU/ZFE+rdGu+XsV4=
Date:   Fri, 19 Mar 2021 03:37:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     kishon@ti.com, vkoul@kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v2] phy: zynqmp: Handle the clock enable/disable properly
Message-ID: <YFQATabI/3V/aTfL@pendragon.ideasonboard.com>
References: <1615288664-45034-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615288664-45034-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch.

On Tue, Mar 09, 2021 at 04:47:44PM +0530, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 57 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 2b65f84..37fcecf 100644
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
> +	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> +		clk_disable_unprepare(gtr_dev->clk[i]);

You should only disable the clocks that have been successfully enabled.
Something like this should do:

	while (i-- > 0)
		clk_disable_unprepare(gtr_dev->clk[i]);

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
> +		gtr_dev->clk[refclk] = clk;
> +
> +		ret = clk_prepare_enable(gtr_dev->clk[refclk]);
> +		if (ret)
> +			goto err_clk_put;
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
> +	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->clk); refclk++)
> +		clk_disable_unprepare(gtr_dev->clk[refclk]);

Here too you will disable a clock that hasn't been enabled if
clk_prepare_enable() failed. Clocks that haven't been retrieved at all
are fine, as clk_disable_unprepare() can be safely called with a NULL
pointer. This could be fixed by replacing the code above with

		ret = clk_prepare_enable(clk);
		if (ret)
			goto err_clk_put;

		gtr_dev->clk[refclk] = clk;

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
