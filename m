Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3029240F8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhIQNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhIQNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:16:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:15:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso2146891wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=863rDzgm6GPiRv2oz/rPhhprRER5SGAc3WVRBtM2tnE=;
        b=TQKTNnByl8lrFJJnM6mkJKrtO151zspcTYnmNdL1C2FPpyL/letcPBZ/EOxBHLJqQs
         H78AN8Ji0C/IOOOm81ChYRSPbc5qjkO7y2Z9A1vGYluXDrCgR5woB8l29xee4I6HnsaK
         CsHj1pt//Jy4hJrRSLfu+qkCTLfymvmOWvVGqtvQ/LL/6EuFg/D7x1rCSg57dA9S40yx
         Zua8fZzlTWpcS9AQmsfn7ltaEhgCpDrrYUmCIi2CmHA3PG6/FQOsxqRVtOH3Sfh0m4pL
         +F3ZqDhAg9Qe2KCDZXsqewjFzRom5hLU8zoymoW9kauu+jvTdxOyr8oaaTMBFmWk6lov
         fjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=863rDzgm6GPiRv2oz/rPhhprRER5SGAc3WVRBtM2tnE=;
        b=1ZZUJkGVqF9fp5Tv744IpxK0nzqk43fJRDB9QEBEXeCjBvmAvAaPk16DqeN9MJTarb
         8KTTYEe8JPD9DcAeiPuBXULoR3+PYSmNHxC1hnotaI+9LWtLWBOfuX7F4lu/rWHqs7AN
         hte1T49uGF0evSdY78wEpiyInJJYPtaOcffHP5vSbdQHF9KhYkyHRs4KFaQbvGN5hBuS
         rxdL4Job/fEbaxleylepmQmnlb3eUq4PhurxruI6phRq4URbGz2aLO/ODbk3jb7D9Pzs
         d9E5CkTSezSR5tY0eoai+/bB4dyoEwXJvJeQchl/OuFvWIa2WvUDSV5/pXrsS+XUrqPu
         AFoA==
X-Gm-Message-State: AOAM532avbR9muFj5OSIg4gdpwhe0ljMg/JG9rdROHCABpEimjdOaIBp
        hk1TF0eSYH+rkFC/1nx0MWDKlQ==
X-Google-Smtp-Source: ABdhPJwTAX3Mp0CKA9u+J2sMTE2qBrnRf02sEzm9iBGJV7sTxVQgo6eAjiU1eSdpqSp8hutpl4NI9A==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr15355800wmc.3.1631884531273;
        Fri, 17 Sep 2021 06:15:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v10sm7031284wri.29.2021.09.17.06.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 06:15:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 14:15:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] video: backlight: Make use of the helper function
 dev_err_probe()
Message-ID: <20210917131529.3oc7xeb4xpvgq5og@maple.lan>
References: <20210917125324.18031-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917125324.18031-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 08:53:23PM +0800, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: backlight patches are handled in one

This appears to leave a lot of backlight drivers with the same code
pattern that are not updated. As my last e-mail, please can you explain
why you selected these drivers and no others?

I would expect this type of change to be made with the assistance of a
script to automatically help you identify and change the code patterns
you are targetting. This would allow you to update all the backlight
drivers at once.


Daniel.


>  drivers/video/backlight/bd6107.c      | 16 +++++--------
>  drivers/video/backlight/l4f00242t03.c | 34 ++++++++++-----------------
>  2 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
> index 515184fbe33a..e21b793302a2 100644
> --- a/drivers/video/backlight/bd6107.c
> +++ b/drivers/video/backlight/bd6107.c
> @@ -120,7 +120,6 @@ static int bd6107_probe(struct i2c_client *client,
>  	struct backlight_device *backlight;
>  	struct backlight_properties props;
>  	struct bd6107 *bd;
> -	int ret;
>  
>  	if (pdata == NULL) {
>  		dev_err(&client->dev, "No platform data\n");
> @@ -148,11 +147,9 @@ static int bd6107_probe(struct i2c_client *client,
>  	 * the reset.
>  	 */
>  	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(bd->reset)) {
> -		dev_err(&client->dev, "unable to request reset GPIO\n");
> -		ret = PTR_ERR(bd->reset);
> -		return ret;
> -	}
> +	if (IS_ERR(bd->reset))
> +		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
> +				     "unable to request reset GPIO\n");
>  
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
> @@ -164,10 +161,9 @@ static int bd6107_probe(struct i2c_client *client,
>  					      dev_name(&client->dev),
>  					      &bd->client->dev, bd,
>  					      &bd6107_backlight_ops, &props);
> -	if (IS_ERR(backlight)) {
> -		dev_err(&client->dev, "failed to register backlight\n");
> -		return PTR_ERR(backlight);
> -	}
> +	if (IS_ERR(backlight))
> +		return dev_err_probe(&client->dev, PTR_ERR(backlight),
> +				     "failed to register backlight\n");
>  
>  	backlight_update_status(backlight);
>  	i2c_set_clientdata(client, backlight);
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> index 46f97d1c3d21..8d81d4dec3c6 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -179,37 +179,29 @@ static int l4f00242t03_probe(struct spi_device *spi)
>  	priv->spi = spi;
>  
>  	priv->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(priv->reset)) {
> -		dev_err(&spi->dev,
> -			"Unable to get the lcd l4f00242t03 reset gpio.\n");
> -		return PTR_ERR(priv->reset);
> -	}
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(priv->reset),
> +				     "Unable to get the lcd l4f00242t03 reset gpio.\n");
>  	gpiod_set_consumer_name(priv->reset, "lcd l4f00242t03 reset");
>  
>  	priv->enable = devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
> -	if (IS_ERR(priv->enable)) {
> -		dev_err(&spi->dev,
> -			"Unable to get the lcd l4f00242t03 data en gpio.\n");
> -		return PTR_ERR(priv->enable);
> -	}
> +	if (IS_ERR(priv->enable))
> +		return dev_err_probe(&spi->dev, PTR_ERR(priv->enable),
> +				     "Unable to get the lcd l4f00242t03 data en gpio.\n");
>  	gpiod_set_consumer_name(priv->enable, "lcd l4f00242t03 data enable");
>  
>  	priv->io_reg = devm_regulator_get(&spi->dev, "vdd");
> -	if (IS_ERR(priv->io_reg)) {
> -		dev_err(&spi->dev, "%s: Unable to get the IO regulator\n",
> -		       __func__);
> -		return PTR_ERR(priv->io_reg);
> -	}
> +	if (IS_ERR(priv->io_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(priv->io_reg),
> +				     "%s: Unable to get the IO regulator\n", __func__);
>  
>  	priv->core_reg = devm_regulator_get(&spi->dev, "vcore");
> -	if (IS_ERR(priv->core_reg)) {
> -		dev_err(&spi->dev, "%s: Unable to get the core regulator\n",
> -		       __func__);
> -		return PTR_ERR(priv->core_reg);
> -	}
> +	if (IS_ERR(priv->core_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(priv->core_reg),
> +				     "%s: Unable to get the core regulator\n", __func__);
>  
>  	priv->ld = devm_lcd_device_register(&spi->dev, "l4f00242t03", &spi->dev,
> -					priv, &l4f_ops);
> +					    priv, &l4f_ops);
>  	if (IS_ERR(priv->ld))
>  		return PTR_ERR(priv->ld);
>  
> -- 
> 2.25.1
> 
