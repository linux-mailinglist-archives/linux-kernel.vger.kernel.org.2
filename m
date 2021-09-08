Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13550403979
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351623AbhIHMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhIHMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:08:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC745C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 05:07:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so2961959wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKkXisCl2vIi7OCx8uRGfHdsX0k2dDIgnIlUiuL+Z/Y=;
        b=JnOw9NpBCJWVZZ7iNJI979Pib4l2Z6LsNopyLTg13EkvXDZAZIYHBf6alkeJ3CcUUo
         E2j1KcTKOXOZfAKgihAk+9zTUEEFYiE1rAobG1mL5rZeSpc8UrXH+ZTovHtTnf6WxHoj
         tuA5dqHmYrEDw1X0kDL0RrmzYSVcHj/vGDLXjsGDcYh34STSoxnW7tTtgcGLxqErs/OI
         vdXTqAk37kFohJoydya+FyqMLoaOnFaD9MXkycdCoFembCzxhKJLKKeFnAeVyQkX331w
         pl4cI6FX0etmJvwWgGeyN4wtfsIXtT9evwlq0AOj5gN34Qcuq2UXdEKacySWTvhaLIH4
         O04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xKkXisCl2vIi7OCx8uRGfHdsX0k2dDIgnIlUiuL+Z/Y=;
        b=SWiXzG1qiEuvP5oZr8ewkJR7pulQev9Gi+Pm8H59LqD1WKSFMeYlobB7w38Q2OjETb
         tOQIWNWfvaDAisODaZo9p6/w4fyOHPYhZhdWVN8O++U5TuBylnRnPx8yaLCICOr6wb3s
         mSv3/lY7ublGNASp09Eiff4i5y4aRc0U0SwqI/e6jPFdeZs9vFNOyZF4UV3QYrPZ8q+k
         rgXyXdTT6RUcIt3kCizh+DAjWgmz13D9HMRGgx2m33eUPUfVVH5dgx6pkL0kB+zdDqPP
         HqoqI3vtBiLlu/7u0rUB/tyJPhd7+Eha2LBx7ymTzKtdPDKIwT0IzX4IvHnwVIguHy7B
         apbg==
X-Gm-Message-State: AOAM532wJ/CVWgFT25RJv2pjS0kZknbGWNjCsxmQxzHUpsBtgbcA3KNd
        HKAF2CHeoZzIjK4Apqmvlnd+MO4/UHQqPq+J
X-Google-Smtp-Source: ABdhPJwSSpAail5nl9T9TWoMaDxdil36KbTbvhFE3B+c19tOhhcm0J3vdXa3Hm58ilTQjL+kaX6kYw==
X-Received: by 2002:adf:c44b:: with SMTP id a11mr3748453wrg.416.1631102857845;
        Wed, 08 Sep 2021 05:07:37 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:19d:2e13:ec0a:9d59? ([2001:861:44c0:66c0:19d:2e13:ec0a:9d59])
        by smtp.gmail.com with ESMTPSA id l15sm1739951wms.38.2021.09.08.05.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 05:07:37 -0700 (PDT)
Subject: Re: [PATCH] staging: media: meson: vdec: Make use of the helper
 function devm_platform_ioremap_resource_byname()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210908105730.1882-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <4cd6453f-8b0e-a438-0e97-53e3962d652b@baylibre.com>
Date:   Wed, 8 Sep 2021 14:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908105730.1882-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2021 12:57, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/staging/media/meson/vdec/vdec.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
> index e51d69c4729d..8549d95be0f2 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -994,7 +994,6 @@ static int vdec_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct video_device *vdev;
>  	struct amvdec_core *core;
> -	struct resource *r;
>  	const struct of_device_id *of_id;
>  	int irq;
>  	int ret;
> @@ -1006,13 +1005,11 @@ static int vdec_probe(struct platform_device *pdev)
>  	core->dev = dev;
>  	platform_set_drvdata(pdev, core);
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dos");
> -	core->dos_base = devm_ioremap_resource(dev, r);
> +	core->dos_base = devm_platform_ioremap_resource_byname(pdev, "dos");
>  	if (IS_ERR(core->dos_base))
>  		return PTR_ERR(core->dos_base);
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "esparser");
> -	core->esparser_base = devm_ioremap_resource(dev, r);
> +	core->esparser_base = devm_platform_ioremap_resource_byname(pdev, "esparser");
>  	if (IS_ERR(core->esparser_base))
>  		return PTR_ERR(core->esparser_base);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
