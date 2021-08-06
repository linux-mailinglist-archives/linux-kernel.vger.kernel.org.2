Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62A3E2870
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhHFKSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhHFKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:18:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BA5860E97;
        Fri,  6 Aug 2021 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628245104;
        bh=Ip01cdoo3exxtjwMtvNqg+Q3tg6d6FumHeook5Pxp7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUAtowA2iX/Wyhsl8xAF/CF7753yJkVMiV//WcPD1OvQep1r2M3ecSErhYefHwzzr
         1UUxkD2fF6fcqT62we5T+STQmArhfnTnJpmgQZgUK04Y+tpJUu681YOfdJ8swhMgRG
         vRTXydK92fK4LRx4vAdMVjN/iKD5WrLawTqkRaA70498g0P0DfoCal3AN92NkWR2ql
         TkcD2qFAgYZipdnrnn/jOVTTNfFXD/ReZ/jdevkH2WWgQ8/tmqJCTeizV0ksDI1tWH
         6Hk3oqnZURkTcss15YUQSCj0AJlZEW03FYB+dsAAbK5lKYdNpASFh6luTewv+MJ/4O
         uRVgcJ52a2POg==
Date:   Fri, 6 Aug 2021 15:48:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/7] phy: cdns-dphy: Prepare for Rx support
Message-ID: <YQ0MZqI36bz1Jp87@matsya>
References: <20210624184108.21312-1-p.yadav@ti.com>
 <20210624184108.21312-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624184108.21312-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-21, 00:11, Pratyush Yadav wrote:
> The Rx programming sequence differs from the Tx programming sequence.
> Currently only Tx mode is supported. Move all the Tx related parts into
> a set of Tx-specific hooks that are then called by the main PHY
> framework hooks. This way when Rx support is added all that is needed to
> be done is to plug in the Rx hooks.
> 
> The clocks "psm" and "pll_ref" are not used by the Rx path so make them
> optional in the probe and then check if they exist in the power_on()
> hook.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/phy/cadence/cdns-dphy.c | 140 ++++++++++++++++++++++++--------
>  1 file changed, 104 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index ba042e39cfaf..8656f2102a91 100644
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
> @@ -86,12 +91,18 @@ struct cdns_dphy_ops {
>  struct cdns_dphy {
>  	struct cdns_dphy_cfg cfg;
>  	void __iomem *regs;
> +	struct device *dev;
>  	struct clk *psm_clk;
>  	struct clk *pll_ref_clk;
>  	const struct cdns_dphy_ops *ops;
>  	struct phy *phy;
>  };
>  
> +struct cdns_dphy_driver_data {
> +	const struct cdns_dphy_ops *tx;
> +	const struct cdns_dphy_ops *rx;
> +};
> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     struct phy_configure_opts_mipi_dphy *opts,
> @@ -199,20 +210,9 @@ static void cdns_dphy_ref_set_psm_div(struct cdns_dphy *dphy, u8 div)
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
> @@ -232,24 +232,13 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
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
> @@ -279,9 +268,21 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
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
> +	if (submode != PHY_MIPI_DPHY_SUBMODE_TX)
> +		return -EINVAL;
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
> @@ -293,16 +294,77 @@ static int cdns_dphy_power_on(struct phy *phy)
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
> +/*
> + * This is the reference implementation of DPHY hooks. Specific integration of
> + * this IP may have to re-implement some of them depending on how they decided
> + * to wire things in the SoC.
> + */
> +static const struct cdns_dphy_driver_data ref_dphy_ops = {
> +	.tx = &tx_ref_dphy_ops,
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

why do you need a dphy specific power_on/off only to call internal
ops..? If there is no additional logic lets drop this and continue the
phy ops for this

-- 
~Vinod
