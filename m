Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA9345AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCWJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCWJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:34:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A8C061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:34:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so14446787edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tTpXq5PUWIqX4hPmnIy2Ebapp61tLCl5gNQ4F1z/chY=;
        b=TNAB+pss73oHQ0QY6wXA30Om65d0gL0aeIHBCFOk3CPqvHPRnnK4QRFP7SGztJPHLl
         moJkX27GJrSknpDeDTFKd/kUZj7xJrS0Y0nF8cNGfHetxCLjleifYCzl8becBmOCgEoZ
         jVT6XETkXUpmfJANhCN1wnO3v90XU1347aaeICKefMdjFUlN3e23stBSL08GopcesT8M
         c3mGnxxNSXQu4ElTDtXZLxo9nDvPT5WK8ZAixzcqcmDcf/uSam8+YbffgHjnVh42hIEp
         KzSYKmG04FyT9UkHXN5+V0Zw6ms12V8a4igrSpVxmYB0UpJD5T29oKcFA8SxylbP5eri
         ZTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tTpXq5PUWIqX4hPmnIy2Ebapp61tLCl5gNQ4F1z/chY=;
        b=QhBJoQLi228vdZ/TFDAeEf/Fy2lc/sageyT+buLAqALvK73VOJQAoxV/wtFnrB+pOP
         AjW/hOdd1Xc7oAz+4/2zrdbG0KEOWQJq9GFMjPrZyfof2B6NkuY75JYLGUN5m+stzE6e
         gHjKTjYBgij/uDVSX045RExFz34X2Mr8lSqkiPp5M00e60G6iQZWZE5UJM0A6Yw19ojE
         YxpmLj8sIXOAFrqL0aYra6pZl+XUkEqOdoFtEvn1wHfiNk0JvYdmlS4hTDjK+3Dp7fJ1
         RaxhZx2KGslhSS1lDaWUq6fPKE2X4fYxh7SsAYRVlBNAS8rwznZWk2xv8PHpz4rdNnRm
         MaRA==
X-Gm-Message-State: AOAM5326Zrb19YrEULBhHaNvUjlY/5NqLoJI1s83yTDG5l2yMj88z+SQ
        2woe3WmTn/kdyp+IvmrT9I4H8Q==
X-Google-Smtp-Source: ABdhPJyTUR1gRvZuc0hYkZFukQlamkHYSvNsVGRcUySLVY+CIKooPuVEiEfhmlu4Mqr53FQZjxpogQ==
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr3643742edb.113.1616492047679;
        Tue, 23 Mar 2021 02:34:07 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id da17sm12803300edb.83.2021.03.23.02.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:34:07 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:34:05 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: journada720: fix Wmisleading-indentation
 warning
Message-ID: <20210323093405.dp37pgnmxbpqsiif@maple.lan>
References: <20210322164134.827091-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322164134.827091-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:41:28PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc-11, we get a warning about code that looks correct
> but badly indented:
> 
> drivers/video/backlight/jornada720_bl.c: In function ‘jornada_bl_update_status’:
> drivers/video/backlight/jornada720_bl.c:66:11: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
>    66 |         } else  /* turn on backlight */
>       |           ^~~~
> 
> Change the formatting according to our normal conventions.
> 
> Fixes: 13a7b5dc0d17 ("backlight: Adds HP Jornada 700 series backlight driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm dubious that the re-indent matches the original authors intent...
but it certainly does match what was actually written and tested so
on that basis:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


 ---
>  drivers/video/backlight/jornada720_bl.c | 44 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
> index 996f7ba3b373..066d0dc98f60 100644
> --- a/drivers/video/backlight/jornada720_bl.c
> +++ b/drivers/video/backlight/jornada720_bl.c
> @@ -66,30 +66,30 @@ static int jornada_bl_update_status(struct backlight_device *bd)
>  	} else  /* turn on backlight */
>  		PPSR |= PPC_LDD1;
>  
> -		/* send command to our mcu */
> -		if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
> -			dev_info(&bd->dev, "failed to set brightness\n");
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> +	/* send command to our mcu */
> +	if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
> +		dev_info(&bd->dev, "failed to set brightness\n");
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
>  
> -		/*
> -		 * at this point we expect that the mcu has accepted
> -		 * our command and is waiting for our new value
> -		 * please note that maximum brightness is 255,
> -		 * but due to physical layout it is equal to 0, so we simply
> -		 * invert the value (MAX VALUE - NEW VALUE).
> -		 */
> -		if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
> -			!= TXDUMMY) {
> -			dev_err(&bd->dev, "set brightness failed\n");
> -			ret = -ETIMEDOUT;
> -		}
> +	/*
> +	 * at this point we expect that the mcu has accepted
> +	 * our command and is waiting for our new value
> +	 * please note that maximum brightness is 255,
> +	 * but due to physical layout it is equal to 0, so we simply
> +	 * invert the value (MAX VALUE - NEW VALUE).
> +	 */
> +	if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
> +		!= TXDUMMY) {
> +		dev_err(&bd->dev, "set brightness failed\n");
> +		ret = -ETIMEDOUT;
> +	}
>  
> -		/*
> -		 * If infact we get an TXDUMMY as output we are happy and dont
> -		 * make any further comments about it
> -		 */
> +	/*
> +	 * If infact we get an TXDUMMY as output we are happy and dont
> +	 * make any further comments about it
> +	 */
>  out:
>  	jornada_ssp_end();
>  
> -- 
> 2.29.2
> 
