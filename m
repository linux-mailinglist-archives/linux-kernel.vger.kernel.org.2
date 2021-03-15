Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6633AD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCOIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:12:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:12:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so8182416wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yFMV3sC6EFaNY9YDS9U8toqJni92w4JY/QYIQPnPelY=;
        b=OyZ63WONnapU2W573ASZ0rpWb6ycwsmmGbKRvkp+UgKKLP5oGfqLStQn73CtJ2+oBK
         jVzYsoXhiIqNmvM8rzupqhBmVIh7HphuL0RWmYmTrjjTCTd4Oni6ZS+ODaZwzQe7ci5O
         eJEdLjiLBpTQTOLlU2/IOjp9wSQIf2sWwiCS4P1Ku9zH1G3A31E37gk0xDzzlsJtWo49
         JcgAQPv2G/OiihfxF2ssP3Ah4nuSs86HDea+lK+QK1f4EQV+8+6ewvBkvNUqO+b652Y0
         LdghNX9AZybMRcpcf+F37L8SGYCXEjTs+tYxGfXFcm6j94DKk6t487nsjaYq57t2aPzq
         KhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yFMV3sC6EFaNY9YDS9U8toqJni92w4JY/QYIQPnPelY=;
        b=P5UvPTaL2UTTfFSdwkUsu/pszXAFblhpgaHplN5cMSfTuBc98SqGWtbF9oa1V/cjnK
         o+3X5Q1MF35WVN9qjuKWmDl62x2b1Gyrno6z5Lrcob0hDNWmXsnm2uNq7aYMRHuiSVMs
         iGWFlJNIZHsBO38laNXUAlEL59LuVHUcO0KuVfaSqTK1Wt7zmM6yh/h+Hzl9KTCL38IG
         MRZSGb3UMdhfLxRSmKCbda62PR7Iu4BUgKmkCNA6uAglIHwUVraLnUzpJi7NPd+iTzYU
         Wu0RZsIlNZcFzeE5SwT76h3BxfF6Yl3rxlHaNwhXVybrayejxEegypoSQIFCG5RatQbH
         Z31g==
X-Gm-Message-State: AOAM531Br5gdK0H7VF8Of0iffFN5mx0JXXNsRq3FIopTo5cWhyI1nVDG
        7qNxNfQOqROgm0PZgA4DiV7OoQ==
X-Google-Smtp-Source: ABdhPJwTKJfOyjJu/g8nYsAp4mNib1S5O6Kj5DHwHCXB84qmulUmL24LQ9lfumAhXHsFNv40ZjGrcQ==
X-Received: by 2002:a5d:4521:: with SMTP id j1mr25632781wra.354.1615795953354;
        Mon, 15 Mar 2021 01:12:33 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id z2sm20744843wrm.0.2021.03.15.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:12:32 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:12:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210315081231.GX701493@dell>
References: <20210313104258.17111-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210313104258.17111-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021, Andreas Kemnade wrote:

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
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> Changes in v3:
> - remove have_rtc variable
> - rename subdevices again
> 
> Changes in v2:
> - more comments about stacking regmap construction
> - fix accidential line removal
> - better naming for subdevices
>  drivers/mfd/ntxec.c       | 55 ++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/ntxec.h |  1 +
>  2 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 957de2b03529..ab6860ef3e9a 100644
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
> @@ -104,16 +136,22 @@ static const struct regmap_config regmap_config = {
>  	.val_format_endian = REGMAP_ENDIAN_BIG,
>  };
>  
> -static const struct mfd_cell ntxec_subdevices[] = {
> +static const struct mfd_cell ntxec_subdev[] = {
>  	{ .name = "ntxec-rtc" },
>  	{ .name = "ntxec-pwm" },
>  };
>  
> +static const struct mfd_cell ntxec_subdev_no_rtc[] = {
> +	{ .name = "ntxec-pwm" },
> +};
> +
>  static int ntxec_probe(struct i2c_client *client)
>  {
>  	struct ntxec *ec;
>  	unsigned int version;
>  	int res;
> +	const struct mfd_cell *subdevs = ntxec_subdev;
> +	size_t n_subdevs = ARRAY_SIZE(ntxec_subdev);

This is a little confusing.  I had to re-read to figure it out.

In my mind, it would be clearer to explicitly set these in the
switch, rather than have a default which can be over-written.

>  	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
>  	if (!ec)
> @@ -138,6 +176,16 @@ static int ntxec_probe(struct i2c_client *client)
>  	switch (version) {
>  	case NTXEC_VERSION_KOBO_AURA:
>  		break;
> +	case NTXEC_VERSION_TOLINO_SHINE2:
> +		subdevs = ntxec_subdev_no_rtc;
> +		n_subdevs = ARRAY_SIZE(ntxec_subdev_no_rtc);
> +		/* Another regmap stacked on top of the other */
> +		ec->regmap = devm_regmap_init(ec->dev, NULL,
> +					      ec->regmap,
> +					      &regmap_config_noack);
> +		if (IS_ERR(ec->regmap))
> +			return PTR_ERR(ec->regmap);
> +		break;
>  	default:
>  		dev_err(ec->dev,
>  			"Netronix embedded controller version %04x is not supported.\n",
> @@ -181,8 +229,9 @@ static int ntxec_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, ec);
>  
> -	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevices,
> -				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
> +	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +				   subdevs, n_subdevs,
> +				   NULL, 0, NULL);
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
