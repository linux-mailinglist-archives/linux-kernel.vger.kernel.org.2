Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F289A3B7DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhF3G5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhF3G5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:57:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA1261A1D;
        Wed, 30 Jun 2021 06:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625036061;
        bh=lkWD4eHzI3MLLHSJwOSX5kTC7sQqmCyDRrCyURVy4fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cr3a9380ZsPM0JvQ1p9k/SmP8RqcJiKD5yGOdqNsGwWt83X27H575o1uom1E3XWbQ
         XTNh4Uqw5duR+NfmwVf3PAu11DV5Z/0MKiMCBI6i81SUc4eQAcfqyKy1QY6aTaSmpv
         Db14i8qnzASuiLcOH5EtT6Sq+HAKXgEPluY1H/tnkOHkZDPEcPUMo7EC4YIFUCUxkn
         aOxZE7jcgwW6961SGZMMAXnp6bk7QdWV4lrHBjVR0DvqtDbO/lBpowCb88QI0LNSSX
         bgy56t8HU0ajQxaJk6/ZmMg2WB47pdv20R99f2g9D/b99sbrmiHaIuFyDhPveo0pGf
         Kzq5XwOLsMyIg==
Date:   Wed, 30 Jun 2021 08:54:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Fix setting wrong driver_data
Message-ID: <20210630085416.4b3d9864@coco.lan>
In-Reply-To: <20210622043329.392072-1-axel.lin@ingics.com>
References: <20210622043329.392072-1-axel.lin@ingics.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 22 Jun 2021 12:33:29 +0800
Axel Lin <axel.lin@ingics.com> escreveu:

> Current code set "config.driver_data = sreg" but sreg only init the mutex,
> the othere fields are just zero. Fix it by pass *info to config.driver_data
> so each regulator can get corresponding data by rdev_get_drvdata().
> 
> Separate enable_mutex from struct hi6421_spmi_reg_info since only need one
> mutex for the driver.
> 
> Fixes: d2dfd50a0b57 ("staging: hikey9xx: hi6421v600-regulator: move LDO config from DT")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

As discussed on a separate thread, this patch is broken. See below.

> ---
>  drivers/regulator/hi6421v600-regulator.c | 26 ++++++++++++++----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
> index b5a19938fd3a..21153ee03a3f 100644
> --- a/drivers/regulator/hi6421v600-regulator.c
> +++ b/drivers/regulator/hi6421v600-regulator.c
> @@ -16,13 +16,15 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/spmi.h>
>  
> +struct hi6421_spmi_reg_priv {
> +	/* Serialize regulator enable logic */
> +	struct mutex enable_mutex;
> +};
> +
>  struct hi6421_spmi_reg_info {
>  	struct regulator_desc	desc;
>  	u8			eco_mode_mask;
>  	u32			eco_uA;
> -
> -	/* Serialize regulator enable logic */
> -	struct mutex enable_mutex;
>  };
>  
>  static const unsigned int ldo3_voltages[] = {
> @@ -96,11 +98,12 @@ static const unsigned int ldo34_voltages[] = {
>  
>  static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
>  {
> -	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
> +	struct hi6421_spmi_reg_priv *priv;
>  	int ret;
>  
> +	priv = dev_get_drvdata(rdev->dev.parent);
>  	/* cannot enable more than one regulator at one time */
> -	mutex_lock(&sreg->enable_mutex);
> +	mutex_lock(&priv->enable_mutex);
>  
>  	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
>  				 rdev->desc->enable_mask,
> @@ -109,7 +112,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
>  	/* Avoid powering up multiple devices at the same time */
>  	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
>  
> -	mutex_unlock(&sreg->enable_mutex);
> +	mutex_unlock(&priv->enable_mutex);
>  
>  	return ret;
>  }
> @@ -225,7 +228,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>  {
>  	struct device *pmic_dev = pdev->dev.parent;
>  	struct regulator_config config = { };
> -	struct hi6421_spmi_reg_info *sreg;
> +	struct hi6421_spmi_reg_priv *priv;
>  	struct hi6421_spmi_reg_info *info;
>  	struct device *dev = &pdev->dev;
>  	struct hi6421_spmi_pmic *pmic;
> @@ -241,17 +244,18 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>  	if (WARN_ON(!pmic))
>  		return -ENODEV;
>  
> -	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
> -	if (!sreg)
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
>  		return -ENOMEM;
>  
> -	mutex_init(&sreg->enable_mutex);
> +	mutex_init(&priv->enable_mutex);
> +	platform_set_drvdata(pdev, priv);
>  
>  	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
>  		info = &regulator_info[i];
>  
>  		config.dev = pdev->dev.parent;

This is the main problem of this patch. See, pdev->dev.parent is
actually the device's parent (e. g. the SPMI controller's device).

Looking at (devm_)regulator_register() implementation, it uses it to
store the rdev->dev.parent:

	struct regulator_dev *
	regulator_register(const struct regulator_desc *regulator_desc,
			   const struct regulator_config *cfg)
	{
...

	dev = cfg->dev;
...
	rdev->dev.parent = dev;

So, while you used platform_set_drvdata() to set the data for the
regulator's platform driver, when the driver tries to access the
mutex, the code does, instead:

	static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
	{
		struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
		struct hi6421_spmi_reg_priv *priv;
	 	int ret;
	 
		priv = dev_get_drvdata(rdev->dev.parent);

		mutex_lock(&priv->enable_mutex);

At this point, priv will be set to the value of the SPMI controller
dev data, instead of pointing to the area stored via
platform_set_drvdata().

As the data stored there is not the enable_mutex, a call to
mutex_lock() makes the device to hang at boot time (or to cause some
other random issue, as it is using a different memory than what
it was expected).

Thanks,
Mauro
