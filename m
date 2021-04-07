Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC43356760
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbhDGI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhDGI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:58:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:51:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f6so10950070wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7UIS5BzGY0LxafWxdkJk0JUpBxwtTMj3dF4rm14v6Y=;
        b=IN8He/6oHXi1vchgVEOBGinoJSH+M8cjhNw3IRJDcUCoKDMVsD9WiCHDZf6TCtUgI1
         jEHZch/6NAbMUG+SJisSN6JPKSHcU6hcLP0dR8PBfLaZ481NgYKvEv1h5QJ4j1dl0ZTV
         htoDecW4ebV/7Q7QRvPQuQT5+i9sAIsIMgVVbfl8hB/evGjna5m9tGSOtpmx8iMCGF2e
         YQ+KntNbI1TqBj0XfnA1eOuOJXypMDLUFGQjDgdJXcvc2Hob4l4tL3m83071ACbQENkI
         bSj31I8OBMutoAomsOtv5lTPp9cSo+B/CbO9c79jAXb9hWfOHarseGmJO2ccpegKFCUU
         saXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q7UIS5BzGY0LxafWxdkJk0JUpBxwtTMj3dF4rm14v6Y=;
        b=pDmmD8iIePRhnFimwpeQ9B84rhnVVGX+B9fikMPOmyagQkJs5M2mFQ/rHE4RcT9Nsw
         K4pSCVmXmyViZI30nDJC0VovlJsT0MTrauY8xBYhwrEQ9M10LxH3ssKqHSmkwQnQGBFa
         N2Nw6Xo6ow8sveKtrxki1IKXh7gbJ31mpMxz4DX6N/QG2K7aVAqaUI6NCh9CNvmqASIW
         7lH8RPfLXLrDjVy8c5/DAFPHh9cmKYOssziATwayyOazty9Oa8hIXS+7OU/1m7p4S/Jf
         DjWoUo6DI0Vyp0BY22a8/2VwsXbLxSKUwUtTfHnTUMn58TpGdDP/71IKlDHcG9DoP33r
         YD+A==
X-Gm-Message-State: AOAM532ZobvddExKdB8YMzAHE4+oPDwYralAR079o43JDARfW49daEvn
        jz1aM63gc4GH2mLBDP8gj68ZFA==
X-Google-Smtp-Source: ABdhPJx6a0J9G+t37xv0QGQfKUYzMxMoFRYyeFK+8ZZvkuCruFAeLva91ShU7lSmDbGiMgDAd3BH8A==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr2966319wrr.271.1617785492760;
        Wed, 07 Apr 2021 01:51:32 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:1202:4b29:31f6:551c? ([2a01:e0a:90c:e290:1202:4b29:31f6:551c])
        by smtp.gmail.com with ESMTPSA id g35sm6619081wmp.42.2021.04.07.01.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 01:51:32 -0700 (PDT)
Subject: Re: [PATCH] thermal: amlogic: Omit superfluous error message in
 amlogic_thermal_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>, glaroque@baylibre.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210222061105.6008-1-tangbin@cmss.chinamobile.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d1740a66-455e-4b13-e524-8be0049620cd@baylibre.com>
Date:   Wed, 7 Apr 2021 10:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222061105.6008-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 07:11, Tang Bin wrote:
> The function devm_platform_ioremap_resource has already contains error
> message, so remove the redundant dev_err here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/thermal/amlogic_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index ccb1fe18e..bba9f3b14 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -253,10 +253,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, pdata);
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(base)) {
> -		dev_err(dev, "failed to get io address\n");
> +	if (IS_ERR(base))
>  		return PTR_ERR(base);
> -	}
>  
>  	pdata->regmap = devm_regmap_init_mmio(dev, base,
>  					      pdata->data->regmap_config);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
