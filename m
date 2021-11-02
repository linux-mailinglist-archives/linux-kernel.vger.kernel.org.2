Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22033442C60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhKBLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhKBLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:22:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C85C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:19:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c4so2740166wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BV8Q7dK1iGHktSvqteqNvvvCLpO0ziqstJ96eN7bGFk=;
        b=A1gsw59Vbk/Jh1FfF8wS+fZtmmzy1sG243dqu4q2SMzGM5qQYUYDVZP2dsnTKhumxp
         vrtteRbXOpg23prSjFtAQLzUZ87X+FU+3hZTiIHXw5q/3zwPu4dQy9u51X8K0YAyrMGo
         xhWx511b8CXLTsotaAbOw+sK5xJoworEZpNaugvmeVuFgX1eXUZv0pyUqdmY+kCnQrnk
         Uh33ILG3NHJlqOpoEK6UFl3JpyIXOLufPjgM5H+AbuWCao8XS7cc1+f2GSCmJkpgiJvh
         zbHVUrhxO5aenN6OxX7Yg7+wjZ/Om+tKDR9iv2klL8KHDMv25Ssm2sSWftq0LJ4eEJbP
         1TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BV8Q7dK1iGHktSvqteqNvvvCLpO0ziqstJ96eN7bGFk=;
        b=SAN8lqsigafljfaExN5Shi5TOqBeCtV7iORz28VaF7wYVIURJ4Ny1UO5jd23lpWBbI
         ewwGzLOMm+HqWBkIaQ0REqsJKPt9IuLrbXsgEZEfPoVggGLGfMjWMGQD2kkbvAqcv8rm
         EdnjP0W8y6+q5bmdmbESaoF5iBwjwaOHllpoRDY3X13tEBFuwOhuCQo2ZiXBOOfXbv4O
         Rt4B8K2iHItweZOXSBnyvE7UUfRMvpcfD9KIfyjQtElViAqGJ2wF0P3bTyRaANxg79B0
         Q6rkmpar8GFmc97lwvuuk27dyR9uKJP0jbwkZrrMWr/WzW7laQnANDA7jqY+INmV4ins
         mRXA==
X-Gm-Message-State: AOAM531umDQiqN7vPiYUYLnQ+4GMoxgWfXn6EdAZjNvtFPXgQLRPNbKC
        QpUu6pUOwIdwJZwlDbWCsG6Y6w==
X-Google-Smtp-Source: ABdhPJzsgj6uVqgv7RqK4Hm+cJXI2XbHFrlQVJx51sEeWWeqYjbui2a8pf8Adkd1Tw4XyS+ZlRtJEg==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr30689564wra.43.1635851984882;
        Tue, 02 Nov 2021 04:19:44 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e3sm3783843wrp.8.2021.11.02.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:19:44 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:19:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] backlight: led_bl: Add support for an "enable" GPIO
Message-ID: <20211102111942.xd7eqz2zrtb7zotc@maple.lan>
References: <20211102100455.2016610-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102100455.2016610-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 10:04:55AM +0000, Corentin LABBE wrote:
> From: Jean-Jacques Hiblot <jjhiblot@ti.com>
> 
> This patch adds support for an "enable GPIO".

Before taking this kind of change is there a good reason why backlight
should manage the GPIO? I thought that the LED subsystem was a sub
system for LEDs (not LED controllers). In other words if you direct
that the LED be lit up then isn't it the LED driver's job to manage
the GPIO and ensure that it lights up?


Daniel.


> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Signed-off-by: Corentin LABBE <clabbe@baylibre.com>
> ---
>  drivers/video/backlight/led_bl.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index f54d256e2d54..ebd7acc32980 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/backlight.h>
>  #include <linux/leds.h>
> +#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> @@ -15,6 +16,7 @@ struct led_bl_data {
>  	struct device		*dev;
>  	struct backlight_device	*bl_dev;
>  	struct led_classdev	**leds;
> +	struct gpio_desc        *enable_gpio;
>  	bool			enabled;
>  	int			nb_leds;
>  	unsigned int		*levels;
> @@ -35,6 +37,9 @@ static void led_bl_set_brightness(struct led_bl_data *priv, int level)
>  	for (i = 0; i < priv->nb_leds; i++)
>  		led_set_brightness(priv->leds[i], bkl_brightness);
>  
> +	if (!priv->enabled)
> +		gpiod_set_value_cansleep(priv->enable_gpio, 1);
> +
>  	priv->enabled = true;
>  }
>  
> @@ -48,6 +53,9 @@ static void led_bl_power_off(struct led_bl_data *priv)
>  	for (i = 0; i < priv->nb_leds; i++)
>  		led_set_brightness(priv->leds[i], LED_OFF);
>  
> +	if (priv->enabled)
> +		gpiod_set_value_cansleep(priv->enable_gpio, 0);
> +
>  	priv->enabled = false;
>  }
>  
> @@ -209,6 +217,11 @@ static int led_bl_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->bl_dev);
>  	}
>  
> +	priv->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> +						    GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->enable_gpio))
> +		return PTR_ERR(priv->enable_gpio);
> +
>  	for (i = 0; i < priv->nb_leds; i++)
>  		led_sysfs_disable(priv->leds[i]);
>  
> -- 
> 2.25.1
> 
