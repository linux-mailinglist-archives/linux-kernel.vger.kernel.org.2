Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30663790A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhEJO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:26:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhEJOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:22:51 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lg6n3-0004sp-FM
        for linux-kernel@vger.kernel.org; Mon, 10 May 2021 14:21:45 +0000
Received: by mail-qk1-f200.google.com with SMTP id h190-20020a3785c70000b02902e022511825so11750375qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6n3fUFcOASAYvo6CsGAr+SCxrw/PQxhy2zE5xfjUwqY=;
        b=kPahWccNnDjeYmds3F/j6VTDz8/6p0jnQRa8q8pBrLoobRQiO2Rnd0quViwLjxFyn6
         l0Z3iBuxF/bhmnH5aZLj5CXEswM1+qro314FcZ3OLflmt3fZH9Eysxl63JwzP2inSq1h
         SMv0ndwXzJtjD5Y8DZZyf6yhLY0HKvF+M3O/r9bjMu1AZl24nCpVkQWw7HdnMUjFSf9j
         5sFoNuIeJGAhGlAE6SfFjv5fy098MLA1xuo0HYkXA42bq+2E2GEuJTUSeXlQDa2xxs4d
         E3cGhmq3p1ZN0IuNTGWdZ4/Dmmej0B1adXP3YTnqOU2/iPOZ0wKQKZ0RtnkRJK7gmXxB
         sAnA==
X-Gm-Message-State: AOAM5337RYR4k/s/xkKsryckyzIbCQvXMnU5pKSvqiRwavfgOQsvx7Cz
        MVl/h4cnHqc5v5tcdbafxsJmfNR2vbbH74RdQ/ChfXPUPz3UfdFgqm1m6/zBCe3MUHcD1xcJrMQ
        PNFNErnnYY9COBWb9alwbP8405LOxpzAc0WhpZg/sHQ==
X-Received: by 2002:a05:6214:12ab:: with SMTP id w11mr23545374qvu.14.1620656504333;
        Mon, 10 May 2021 07:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4Ne1OVLuJjOilLElob8eEW+infcU59FdG69wpEQdFGd0dFEvAfZBWX7km9U/DCHYSFx4Kjw==
X-Received: by 2002:a05:6214:12ab:: with SMTP id w11mr23545354qvu.14.1620656504168;
        Mon, 10 May 2021 07:21:44 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 7sm7122602qkd.20.2021.05.10.07.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:21:43 -0700 (PDT)
Subject: Re: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error path
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <edf3ff4d-8bd7-17cf-0d7c-96b4f704dddd@canonical.com>
Date:   Mon, 10 May 2021 10:21:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 04:12, Matti Vaittinen wrote:
> If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
> without freeing the requested IRQs.

The driver frees IRQ on probe failure, so maybe you meant missing IRQ
mapping dispose?

> 
> Simplify driver and fix the IRQ problem by switching to use the
> resource managed IRQ requesting and resource managed work-queue
> initialization.
> 
> Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive probe")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max8997.c | 45 +++++++++++----------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index e1408075ef7d..bbc592823570 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -5,6 +5,7 @@
>  //  Copyright (C) 2012 Samsung Electronics
>  //  Donggeun Kim <dg77.kim@samsung.com>
>  
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -650,27 +651,30 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  	mutex_init(&info->mutex);
>  
>  	INIT_WORK(&info->irq_work, max8997_muic_irq_work);
> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> +				   max8997_muic_irq_work);
> +	if (ret)
> +		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
>  		struct max8997_muic_irq *muic_irq = &muic_irqs[i];
>  		unsigned int virq = 0;
>  
>  		virq = irq_create_mapping(max8997->irq_domain, muic_irq->irq);
> -		if (!virq) {
> -			ret = -EINVAL;
> -			goto err_irq;
> -		}
> +		if (!virq)
> +			return -EINVAL;
> +
>  		muic_irq->virq = virq;
>  
> -		ret = request_threaded_irq(virq, NULL,
> -				max8997_muic_irq_handler,
> -				IRQF_NO_SUSPEND,
> -				muic_irq->name, info);
> +		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> +						max8997_muic_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						muic_irq->name, info);
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"failed: irq request (IRQ: %d, error :%d)\n",
>  				muic_irq->irq, ret);
> -			goto err_irq;
> +			return ret;
>  		}
>  	}
>  
> @@ -678,14 +682,13 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  	info->edev = devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
>  	if (IS_ERR(info->edev)) {
>  		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
> -		ret = PTR_ERR(info->edev);
> -		goto err_irq;
> +		return PTR_ERR(info->edev);
>  	}
>  
>  	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register extcon device\n");
> -		goto err_irq;
> +		return ret;
>  	}
>  
>  	if (pdata && pdata->muic_pdata) {
> @@ -756,23 +759,6 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  			delay_jiffies);
>  
>  	return 0;
> -
> -err_irq:
> -	while (--i >= 0)
> -		free_irq(muic_irqs[i].virq, info);

Here it will unwind what was done.

> -	return ret;
> -}
> -


Best regards,
Krzysztof
