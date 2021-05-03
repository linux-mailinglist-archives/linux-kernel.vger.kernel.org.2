Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA4371828
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhECPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhECPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:41:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6FC061763;
        Mon,  3 May 2021 08:40:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v24so5761949oiv.9;
        Mon, 03 May 2021 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34dF5ctgfAlTAtJG1sBGWWovdOzk0i2UvPd5qj/cqpI=;
        b=s1q2l3fIsBxw/CGvfRSuij4fe4Vmoz7TTllOMPiOehTJaQJGWpP2fPT+pywJInE1k0
         bJA+A77zq7zS4dlrOVUqZaS6Ac6siu9uUV6xXZtfAHDzF0qAs655gI7lbfGXgmNovjcy
         ydvMzq/Nq3DsWlSbg1ZH+RMPGbrPwVSNObKbG2+I0KfOSWoJV5PU4HIlUh68oD8+8rb8
         D0EoL5i1j0eCEQSWJ4tbM8nvgnJUis7XF7O8BHmCiiHKRENp9n0KHqYFDnNt2Vgj+Bys
         aFvwAdcHT5fOQtfxq9ZqigUc4Q+m7DQ/nyDCJnJxy8Ef4vMSm/XW0p5mb5BQWTt+hZ3m
         oTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=34dF5ctgfAlTAtJG1sBGWWovdOzk0i2UvPd5qj/cqpI=;
        b=EfLR5FDSj+xmyGwy4gYOe7XTE0o4EIH7c2Nkjl6M7V81OO5dI0k3yHXQGZl1goEfGB
         YErbWLq5mAnW1p9rKPfvE2qrT86HvIPS3wjQ87TccqbTZoCPBeQt24i89ZRtwGA1HviK
         W2wFvtaytzUGvy2L+KYdXCjvUuEBXRMqCX6oR8WrCFeXHz5GAOmXOwmg9U8bZRdIswaj
         1nNUIF81HG7hXN0Kwg1OtNXxtQEzavFUAWZZxpBDkkU4YVyRqZuZHdv+ZoUl2RhNgwd9
         su6S4A/GNcQj9vW0FLFOoC6W5a/ASvYrs8Kwpzdv19xAJC7wyLZ+f0gVFM/20Cf2uzZa
         ESbw==
X-Gm-Message-State: AOAM530wTqN7ixQajHTMl1CXRwxTaW5c/uFb4043Vo4UKCkFThN9sUfB
        8qZPHuNmc7LtXs+ckDnojD0pGrto8jg=
X-Google-Smtp-Source: ABdhPJwhgY8mAkiNQqXi8RJjNt6DUyL9CyMDozpn646jH6IenhF6zuK8dzqQ/adVJOxzH4K4GLA24A==
X-Received: by 2002:aca:409:: with SMTP id 9mr1462933oie.179.1620056416894;
        Mon, 03 May 2021 08:40:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 88sm31956ott.51.2021.05.03.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:40:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 3 May 2021 08:40:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: lm75: Add TI TMP1075 support
Message-ID: <20210503154015.GA707775@roeck-us.net>
References: <20210429121150.106804-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429121150.106804-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:11:49PM +0200, Robert Marko wrote:
> TI TMP1075 is a LM75 compatible sensor, so lets
> add support for it.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/lm75.rst |  6 ++++--
>  drivers/hwmon/lm75.c         | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
> index 81257d5fc48f..8d0ab4ad5fb5 100644
> --- a/Documentation/hwmon/lm75.rst
> +++ b/Documentation/hwmon/lm75.rst
> @@ -93,9 +93,9 @@ Supported chips:
>  
>  	       https://www.st.com/resource/en/datasheet/stlm75.pdf
>  
> -  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B, TMP75C, TMP175, TMP275
> +  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B, TMP75C, TMP175, TMP275, TMP1075
>  
> -    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75b', 'tmp75c', 'tmp275'
> +    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75b', 'tmp75c', 'tmp275', 'tmp1075'
>  
>      Addresses scanned: none
>  
> @@ -119,6 +119,8 @@ Supported chips:
>  
>  	       https://www.ti.com/product/tmp275
>  
> +         https://www.ti.com/product/TMP1075
> +
>    * NXP LM75B, PCT2075
>  
>      Prefix: 'lm75b', 'pct2075'
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index e447febd121a..afdbb63237b9 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -50,6 +50,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>  	tmp75,
>  	tmp75b,
>  	tmp75c,
> +	tmp1075,
>  };
>  
>  /**
> @@ -293,6 +294,13 @@ static const struct lm75_params device_params[] = {
>  		.clr_mask = 1 << 5,	/*not one-shot mode*/
>  		.default_resolution = 12,
>  		.default_sample_time = MSEC_PER_SEC / 12,
> +	},
> +	[tmp1075] = { /* not one-shot mode, 27.5 ms sample rate */
> +		.clr_mask = 1 << 5 | 1 << 6 | 1 << 7,
> +		.default_resolution = 12,
> +		.default_sample_time = 28,
> +		.num_sample_times = 4,
> +		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
>  	}
>  };
>  
> @@ -662,6 +670,7 @@ static const struct i2c_device_id lm75_ids[] = {
>  	{ "tmp75", tmp75, },
>  	{ "tmp75b", tmp75b, },
>  	{ "tmp75c", tmp75c, },
> +	{ "tmp1075", tmp1075, },
>  	{ /* LIST END */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm75_ids);
> @@ -771,6 +780,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "ti,tmp75c",
>  		.data = (void *)tmp75c
>  	},
> +	{
> +		.compatible = "ti,tmp1075",
> +		.data = (void *)tmp1075
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, lm75_of_match);
