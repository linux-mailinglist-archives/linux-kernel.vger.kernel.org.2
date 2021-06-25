Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8E3B4783
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:42:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F079661941;
        Fri, 25 Jun 2021 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624639179;
        bh=w5/OqeXF4/TsrOFyz/dLno5l4vfpZqui9UjQWfeRBqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/LqK/+D0nHFl9q/RMq8fKqil0BCqzEwcntOfFFVi3peTwHTfq06ZuwBAL4hAKaSW
         LUXNBXdVNgIxKw09lKAY6p2FUAEbUFHh99BejkEO41p7q+Gey5bShm5AMTTColjThv
         YAP3+SJXD6Xr1wUK7fqmEXfqTRLQFuGyF3To5EDZXV9zSSbv4Q41KNjeSP1yw/yNzd
         bxOjol9m0Mv2F3ZRWlVkQ6NhFxBJoPhSYyipskJrQpSFuHdCokFho0Sqg++JXSdp9A
         0HX4UC3qXN3ylTv+zlK9n7nrv6EdqThHuCx+q4k1YeqrfGo33XMXE6SaYsArvmePlB
         IzDT++s0yO3Fg==
Date:   Fri, 25 Jun 2021 18:39:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Fix setting wrong driver_data
Message-ID: <20210625183935.17fae37f@coco.lan>
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

This won't work, as platform data was already set, as it is already used
as part of the MFD/SPMI binding logic. With the current 
struct hi6421_spmi_pmic, this is not a big problem, as, due to some
code churns, there are enough space for a mutex at the beginning of
the struct, but the code breaks when those are removed.

I'll send a separate patch addressing this issue.

Thanks,
Mauro
