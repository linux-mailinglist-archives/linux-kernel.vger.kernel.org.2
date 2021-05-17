Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DEF383A05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbhEQQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244895AbhEQQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:35:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD1C01CD56
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:28:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i17so6831898wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0JwxGBKfDoUxq2NZLsErnRvzPdT2eYfu4gWuQeo9vCM=;
        b=j1J70RTbH+qyRmD8QqmKri5WuNEcnX+J4adv/ycgORjHO5/WAJsOeJ65SrOYzUnVTP
         VG3uUlqBj/EQMg9qfGG/nXtfTlY6ZLKRp2SQEaQiSmH7R+0WfsT2Otk71jl9cXMr2uWs
         lv6P0aLshi5yaJ3YHGy4YH6gXZ6eGOOlkuT0VEtB5JwR0vRjFyyOx2BIq3tTJwrSyva3
         zXyVDwm4utj0rSUQQR5h6hnEpgIu/WmZEkVoXxNdOE0mLuayt8biCpIw1qRCJ023YzUF
         RF+nlucQSrsui7y4n+FDQuWg4Km5I/qb/leF70mGmkreZNJuKjKpFUJY2lxeMlL4uxYJ
         aNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0JwxGBKfDoUxq2NZLsErnRvzPdT2eYfu4gWuQeo9vCM=;
        b=P3OJKyfdRvbJ+d594B9U8g0B1FXdbEQeKpve/cRzhK0/UvqpgeUcOwFtoeHmyxrKDW
         bTdBE1iYVWIMzGmzSpnmaqEAlTSyxICaOgncVjA5XdRXW5e5SieHMkoa/hZ3jKbjxWJJ
         dRba+nZsfIjoIDsMoa61ecUSAr2pqSp8/xfNrcmzp6Abv7f1ACqkvAzD1C6B44hE4jDi
         5JWDanBd0Vlh3FQi2vfTa0ArYpWl1b9dvuSMXKJHzvan56hUCvrDXUG0Zs1hRo9kJAjm
         FKe15XigMBPPWtSf5pv5SXTbmm0yVRpWN65gegOUoQuh1WzSE7aN7DmPiBehJze1Inhn
         0rig==
X-Gm-Message-State: AOAM532FPI1WIA8WZGJviDOfQG92mSB0RHo60BL9eYzmVT264pnzNEkS
        P+8MajCltEXU5fSg3C8rYyHmAA==
X-Google-Smtp-Source: ABdhPJwuwOUHqhdgm9HQRD81VC7JS4eqLC5JQc4toY1qtK7WE6GphAF3qIqwNcqwalRX4HpnUsEzSA==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr296464wru.396.1621265280618;
        Mon, 17 May 2021 08:28:00 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f13sm14745840wrt.86.2021.05.17.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:27:59 -0700 (PDT)
Date:   Mon, 17 May 2021 16:27:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: Re: [PATCH] backlight: Remove leading spaces in Kconfig
Message-ID: <20210517152758.lqwmborindqvavwo@maple.lan>
References: <20210517095839.81833-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517095839.81833-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:58:39AM +0200, Juerg Haefliger wrote:
> Remove leading spaces before tabs in Kconfig file(s) by running the
> following command:
> 
>   $ find drivers/video/backlight -name 'Kconfig*' | \
>     xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  drivers/video/backlight/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b902c1..a967974f6cd6 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -129,11 +129,11 @@ config LCD_HX8357
>  	  driver.
>  
>    config LCD_OTM3225A

Whilst removing the unwanted spaces (two of them on each line) could we
also remove the two unwanted spaces from the config line as well.


Daniel.


> -  	tristate "ORISE Technology OTM3225A support"
> -  	depends on SPI
> -  	help
> -  	  If you have a panel based on the OTM3225A controller
> -  	  chip then say y to include a driver for it.
> +	tristate "ORISE Technology OTM3225A support"
> +	depends on SPI
> +	help
> +	  If you have a panel based on the OTM3225A controller
> +	  chip then say y to include a driver for it.
>  
>  endif # LCD_CLASS_DEVICE
>  
> -- 
> 2.27.0
> 
