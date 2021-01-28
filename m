Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAD30741A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhA1Kt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhA1Kto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:49:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77223C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:49:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so4893717wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FiLg8koZzFFIIjcPeegfAacRaJIBA7V42bfPp42lOV8=;
        b=sm+wd3C8tunflXHyxlaQRjfer+D7EeWBR7dOtqLatBkedelPvSMdK89rZVUTbJ4vCQ
         u7IYHIr4xnQel8ULjvNl0yjSpUURbhaqo88Ip2fUKMZoFkd3ryyECcCTP2kf2Z146vVB
         Pmc0vpK+lZsAAe+/a94WSrdygKRlxLU9vBHOc6WrvLck3dvjSUoEUjXzebpexN15bF9k
         jM+P8kcl5+rRUpsizPVfYZOunen0CwTGjtG8vprE50WHsVsjVNGdQYS2/8HhyOzRlw7C
         iPa1zD86w80Ho9H/jGyirHFxodc+XPuOh8Q2OUDQwI3nKa8mR74SHy4Vuk/PA9iRJBez
         C0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiLg8koZzFFIIjcPeegfAacRaJIBA7V42bfPp42lOV8=;
        b=uJntT8V7As1muE1dkO5uWu2jY/PGtH/7R1hhuhkiZv/YP78QE8NZRlvKGw1sXFzESp
         a1oQ706sV8Rj1mNCNy/oFrEPjC9Y7jeIqMIB2J3hGVS4nm3c4DF1CaDWq7Y25QqKsHZQ
         BMdIdEr4KfDhS6F5dWunW/dwK/F73qGpN4y56UYRYngsN4SxmEOnBwFpfmAD/oS1KUYy
         6DPcGofYnzYIGwGgjf3Wu6GDrIHqUIexawpkRRPz9d/LdFzNli3VBWmuSlNhR/nsXaXA
         jLyHB2BYnXzJfDEiGFLsGci6ngixnOJjofuZRjAOZfKhc6Qcd5vACKFTPWHHRLq3xrUR
         A+Gw==
X-Gm-Message-State: AOAM531Aq4wJz4EOBD1Etb4H2kq7jJEhVr63sd8eDG6xkyqjpRa8nkrS
        VGb/tcYcSQFHPMNUZotZTTEQBA==
X-Google-Smtp-Source: ABdhPJyFCP6jRG7uwA6TDz/h9WJOEs9xc4fD/ffZsngV7ExqzXZqyPkNyKjeEFDrQmQZX6RW5QSwrA==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr15193598wrp.127.1611830942202;
        Thu, 28 Jan 2021 02:49:02 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u10sm5334118wmj.40.2021.01.28.02.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:49:01 -0800 (PST)
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210127201732.743938-1-christophe.jaillet@wanadoo.fr>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] media: venus: core: Fix some resource leaks in the error
 path of 'venus_probe()'
Message-ID: <309678ef-c3b9-0269-0715-05a469c04345@linaro.org>
Date:   Thu, 28 Jan 2021 12:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <20210127201732.743938-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for the fix!

On 1/27/21 22:17, Christophe JAILLET wrote:
> If an error occurs after a successful 'of_icc_get()' call, it must be
> undone by a corresponding 'icc_put()' call.

This works, but why not switch to devm_of_icc_get() instead?

Thanks,
Georgi

> 
> Add it in the error handling path of the probe function as already done in
> the remove function.
> 
> Fixes: 32f0a6ddc8c9 ("media: venus: Use on-chip interconnect API")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/media/platform/qcom/venus/core.c | 31 +++++++++++++++++-------
>   1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 0bde19edac86..8fd5da941067 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -200,27 +200,35 @@ static int venus_probe(struct platform_device *pdev)
>   		return PTR_ERR(core->video_path);
>   
>   	core->cpucfg_path = of_icc_get(dev, "cpu-cfg");
> -	if (IS_ERR(core->cpucfg_path))
> -		return PTR_ERR(core->cpucfg_path);
> +	if (IS_ERR(core->cpucfg_path)) {
> +		ret = PTR_ERR(core->cpucfg_path);
> +		goto err_video_path_put;
> +	}
>   
>   	core->irq = platform_get_irq(pdev, 0);
> -	if (core->irq < 0)
> -		return core->irq;
> +	if (core->irq < 0) {
> +		ret = core->irq;
> +		goto err_cpucfg_path_put;
> +	}
>   
>   	core->res = of_device_get_match_data(dev);
> -	if (!core->res)
> -		return -ENODEV;
> +	if (!core->res) {
> +		ret = -ENODEV;
> +		goto err_cpucfg_path_put;
> +	}
>   
>   	mutex_init(&core->pm_lock);
>   
>   	core->pm_ops = venus_pm_get(core->res->hfi_version);
> -	if (!core->pm_ops)
> -		return -ENODEV;
> +	if (!core->pm_ops) {
> +		ret = -ENODEV;
> +		goto err_cpucfg_path_put;
> +	}
>   
>   	if (core->pm_ops->core_get) {
>   		ret = core->pm_ops->core_get(dev);
>   		if (ret)
> -			return ret;
> +			goto err_cpucfg_path_put;
>   	}
>   
>   	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
> @@ -305,6 +313,11 @@ static int venus_probe(struct platform_device *pdev)
>   err_core_put:
>   	if (core->pm_ops->core_put)
>   		core->pm_ops->core_put(dev);
> +err_cpucfg_path_put:
> +	icc_put(core->cpucfg_path);
> +err_video_path_put:
> +	icc_put(core->video_path);
> +
>   	return ret;
>   }
>   
> 
