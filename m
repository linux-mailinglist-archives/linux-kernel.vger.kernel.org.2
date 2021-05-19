Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F583892E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354972AbhESPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354963AbhESPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:45:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EAEC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:44:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso3710294wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nu3OSdvPAQ7VkA5Lu/t0kQYvXnt9HghzAhj6ZR5wXc=;
        b=KW4jncRtsVJ0qOZ8xXM9WdklXP/wPTxhSi5g4UQZUOyLMg5rF0WFjn6wOI3G5tB1X+
         wvH5LtDvcBr0gj+jyw9Y3DzVQek2meyK5G0iRkndiLobnkoEtVdKkjvUNIeTGF5xJ29D
         HeXVJcFy+WVxXf8muJp4RNBPVa9e2hShFmstZsEZLy7NWK0rJCnuDNTHdAGXh3vhGGwD
         V+zB7FaW6abbE218yv3F3NKmajccjq4im07xAPAB2M6E8GOjs6wzmBmDrChrbi/4PGUR
         WH/qzpOQISHnWW7+DMT4j9Emc+1TFBFXtARDDrlJX7Mm7im/5w68aG63BPt+IFfe6XyF
         xqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nu3OSdvPAQ7VkA5Lu/t0kQYvXnt9HghzAhj6ZR5wXc=;
        b=NOnFrIojC5dVVucPYb+ATs5750rOiLAJMb1DpQ5xIDeFb0cDKy6sbQdXG19GV8WiwN
         dgyZvV2WySUnY//sVsru/v6EmfuuzW6+fDiOQTI3KIzex00fpNPq7vneWIqgs8RppzYQ
         Ldphdhq7Pp6PHuGnNXHWZS9G+RN9l3LxnC6jAto4F+T8c47Q9F6wPeKYJ5jZiqnD3II0
         j7p+jOuCLLKV49xLZ40xOpUIQFSs705WeurFUFat+pQEnvFHAv//mdHNuQw8TV0780at
         kxMwOOVXeXm01UJM9rZB1i/FuLXNBF/h3zUJTeNaDnwyD60BhrTl50ZH07DSQAQ8c4q7
         6/Hw==
X-Gm-Message-State: AOAM530I9tyD4JVdmgdDa1CbB/of6KG5qwpFRYwns0HQZ9jAe6Z5cZ1p
        Utf132j8DsCJBwSyk/YnCOpQFw==
X-Google-Smtp-Source: ABdhPJxm3DicWObRp7AE2/siDsEzYxCeS+fBjpBkSEKmMtJQ29aNWO0Wp4a8UD/rCQih9Wz3T4VICQ==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr11921329wmh.183.1621439061770;
        Wed, 19 May 2021 08:44:21 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q1sm6200684wmq.48.2021.05.19.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:44:21 -0700 (PDT)
Date:   Wed, 19 May 2021 16:44:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Message-ID: <20210519154419.n74hcf7lnqvmuuvf@maple.lan>
References: <20210517095839.81833-1-juergh@canonical.com>
 <20210519110300.17918-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519110300.17918-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:03:00PM +0200, Juerg Haefliger wrote:
> Remove leading whitespaces, replace multi spaces with tabs, and fix help
> text indentation.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  drivers/video/backlight/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b902c1..c887338de386 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -128,12 +128,12 @@ config LCD_HX8357
>  	  If you have a HX-8357 LCD panel, say Y to enable its LCD control
>  	  driver.
>  
> -  config LCD_OTM3225A
> -  	tristate "ORISE Technology OTM3225A support"
> -  	depends on SPI
> -  	help
> -  	  If you have a panel based on the OTM3225A controller
> -  	  chip then say y to include a driver for it.
> +config LCD_OTM3225A
> +	tristate "ORISE Technology OTM3225A support"
> +	depends on SPI
> +	help
> +	  If you have a panel based on the OTM3225A controller
> +	  chip then say y to include a driver for it.
>  
>  endif # LCD_CLASS_DEVICE
>  
> @@ -269,11 +269,11 @@ config BACKLIGHT_MAX8925
>  	  WLED output, say Y here to enable this driver.
>  
>  config BACKLIGHT_APPLE
> -       tristate "Apple Backlight Driver"
> -       depends on X86 && ACPI
> -       help
> -	 If you have an Intel-based Apple say Y to enable a driver for its
> -	 backlight.
> +	tristate "Apple Backlight Driver"
> +	depends on X86 && ACPI
> +	help
> +	  If you have an Intel-based Apple say Y to enable a driver for its
> +	  backlight.
>  
>  config BACKLIGHT_TOSA
>  	tristate "Sharp SL-6000 Backlight Driver"
> -- 
> 2.27.0
> 
