Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E733394B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCJJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:55:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:55:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h98so22538552wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HHS3s7B2vM5MRq/T4alYcLZsp9PgXOhtJLQHTWHyG6I=;
        b=hKViq3oKw/Vzky61W3Q+HWwLjeGfUxULXZEO8L/8fo6zGoamptGPi/urnI4aaoG5V9
         bh8cmIXVfLP1j1LSIKzmXxB0CotqgvVjooLXGln71hiHo0xrQJ/pJ+Eo3FtR2zl/xtNj
         Q+536+Jl9ns1oRoM/ww7TMSe7mM0TGQsh2VVH2Sj5EdLm273Kp3zgy/xIYa+Qfmcwfir
         dBqP6mmE8OOrAvtHuWj6gXqqwVFCHZGHazZsIYLW1VNUm2jHyeY41xPEOGHXRYRDEQEb
         yH1qABj2b4FiBcSfCxVNBLHyRZnc9BhSwH1HVgpLHRaZLKFhl2VpvynMlDEIUikvz6tN
         ge4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HHS3s7B2vM5MRq/T4alYcLZsp9PgXOhtJLQHTWHyG6I=;
        b=d+in4EG93DEFJyLlyzsu0wdCBl+XASYvNOew6pEkHEEtbcsIRfQytrQjBErQ305izF
         x8GJH60QUN742Q0z0I2/mDFog9ez0OcFS4jjNEPH1tpZroGQ6AA46tV5nQKgdzRn/OG7
         DJmlPcs1ZlZVXTrG/1RjiAgC2NalNoEv45gP1knj+zVO+bD53AHFv8nXbTPhfGVrrC4k
         VIXyow/SnSnF2AWc53I2itL9BtY4F1MKwvf1b7BhSEEEs5zfjasXWmBcK9J/VZODLYWH
         dHVXas24qRq96ojW2EKM6IYsJZHEMzwKKzJ8LN1Hqn+R/NQ4V4iNql7rZKZIyaLqseJi
         1n9Q==
X-Gm-Message-State: AOAM532eTYdVyydNAMByK6oth6BGoXe/3BubkTJriMmJyMr62bIi0AwY
        JxP6c+6zscL8xNTIEG+pT3NDeg==
X-Google-Smtp-Source: ABdhPJyoZTGC2woPSF5yhEou7gGECHKgumljJpV8qoFiWV+xxml8Hs75oo+qErUSvhLuiem2nfR9bw==
X-Received: by 2002:adf:b355:: with SMTP id k21mr2655022wrd.156.1615370147356;
        Wed, 10 Mar 2021 01:55:47 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id v9sm29000370wrn.86.2021.03.10.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:55:46 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:55:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210310095545.GC701493@dell>
References: <20210308212952.20774-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308212952.20774-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, Andreas Kemnade wrote:

> Add the version of the EC in the Tolino Shine 2 HD
> to the supported versions. It seems not to have an RTC
> and does not ack data written to it.
> The vendor kernel happily ignores write errors, using
> I2C via userspace i2c-set also shows the error.
> So add a quirk to ignore that error.
> 
> PWM can be successfully configured despite of that error.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - more comments about stacking regmap construction
> - fix accidential line removal
> - better naming for subdevices
> 
>  drivers/mfd/ntxec.c       | 61 +++++++++++++++++++++++++++++++++++++--
>  include/linux/mfd/ntxec.h |  1 +
>  2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 957de2b03529..0bbd2e34e89c 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -96,6 +96,38 @@ static struct notifier_block ntxec_restart_handler = {
>  	.priority = 128,
>  };
>  
> +static int regmap_ignore_write(void *context,
> +			       unsigned int reg, unsigned int val)
> +
> +{
> +	struct regmap *regmap = context;
> +
> +	regmap_write(regmap, reg, val);
> +
> +	return 0;
> +}
> +
> +static int regmap_wrap_read(void *context, unsigned int reg,
> +			    unsigned int *val)
> +{
> +	struct regmap *regmap = context;
> +
> +	return regmap_read(regmap, reg, val);
> +}
> +
> +/*
> + * Some firmware versions do not ack written data, add a wrapper. It
> + * is used to stack another regmap on top.
> + */
> +static const struct regmap_config regmap_config_noack = {
> +	.name = "ntxec_noack",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.cache_type = REGCACHE_NONE,
> +	.reg_write = regmap_ignore_write,
> +	.reg_read = regmap_wrap_read
> +};
> +
>  static const struct regmap_config regmap_config = {
>  	.name = "ntxec",
>  	.reg_bits = 8,
> @@ -104,15 +136,20 @@ static const struct regmap_config regmap_config = {
>  	.val_format_endian = REGMAP_ENDIAN_BIG,
>  };
>  
> -static const struct mfd_cell ntxec_subdevices[] = {
> +static const struct mfd_cell ntxec_subdev[] = {
>  	{ .name = "ntxec-rtc" },
>  	{ .name = "ntxec-pwm" },
>  };
>  
> +static const struct mfd_cell ntxec_subdev_pwm[] = {
> +	{ .name = "ntxec-pwm" },
> +};

To put across what you're trying to achieve, maybe call this:

  ntxec_subdev_no_rtc[]

Then if other devices are added, the semantics/intent stays the same
and it won't have to be renamed.

>  static int ntxec_probe(struct i2c_client *client)
>  {
>  	struct ntxec *ec;
>  	unsigned int version;
> +	bool has_rtc;
>  	int res;
>  
>  	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> @@ -137,6 +174,16 @@ static int ntxec_probe(struct i2c_client *client)
>  	/* Bail out if we encounter an unknown firmware version */
>  	switch (version) {
>  	case NTXEC_VERSION_KOBO_AURA:
> +		has_rtc = true;
> +		break;
> +	case NTXEC_VERSION_TOLINO_SHINE2:
> +		has_rtc = false;
> +		/* Another regmap stacked on top of the other */
> +		ec->regmap = devm_regmap_init(ec->dev, NULL,
> +					      ec->regmap,
> +					      &regmap_config_noack);
> +		if (IS_ERR(ec->regmap))
> +			return PTR_ERR(ec->regmap);
>  		break;
>  	default:
>  		dev_err(ec->dev,
> @@ -181,8 +228,16 @@ static int ntxec_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, ec);
>  
> -	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevices,
> -				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
> +	if (has_rtc)
> +		res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +					   ntxec_subdev,
> +					   ARRAY_SIZE(ntxec_subdev),
> +					   NULL, 0, NULL);
> +	else
> +		res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +					   ntxec_subdev_pwm,
> +					   ARRAY_SIZE(ntxec_subdev_pwm),
> +					   NULL, 0, NULL);

You're over-complicating things.

Simply have a local mfd_cells variable that you assign either
'ntxec_subdev' or 'ntxec_subdev_pwm' to, then simply call
devm_mfd_add_devices() once.

It means you can also drop 'has_rtc'.

>  	if (res)
>  		dev_err(ec->dev, "Failed to add subdevices: %d\n", res);
>  
> diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> index 361204d125f1..26ab3b8eb612 100644
> --- a/include/linux/mfd/ntxec.h
> +++ b/include/linux/mfd/ntxec.h
> @@ -33,5 +33,6 @@ static inline __be16 ntxec_reg8(u8 value)
>  
>  /* Known firmware versions */
>  #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
> +#define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD */
>  
>  #endif

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
