Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01B842C9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhJMTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJMTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:25:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079DC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:23:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i24so15828634lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R1hm0iV6UGiIA3c5I3VRdziDFrSzd+si05/EX5oPHGo=;
        b=MeI+HoRDR1d4pvpj6kbjMhToPkpOhHKDWQ0pNmybbFHrHkZOdDc/vj5BVRNDQD1EL0
         IB17RhLbb5dqeZmGMwLNt36dwOaEjveuuNZ6lMGKqQJb9KJwZBxEXc0rcuWy8h2gr/We
         yvdxrwPqnhB5jmXXIWBRuo7dZTRtO30zwtVTwmQRQRfjAzkAEZSpM+cwNtvgsZt1QmNe
         a44N4b1DP31sBUmWw9GYPL47kWgrt+br7bC9ntSiTUbSOWWyM8OMcP9WuIDZ7OWoaz5R
         Z920pHsVJelDd/LufC/bUh8qPduGk/7wHyzePJYVGiUnboL/ud7Bu9XnINUtSYzTKHEF
         n7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R1hm0iV6UGiIA3c5I3VRdziDFrSzd+si05/EX5oPHGo=;
        b=h/hrwnVqhcximPF1nq1Zg3mZRVITswgXAR/nHum9buHrpdGpvz9327W+c2oe+ckLk0
         81gXLuaLEfhJ8znZGu7ysAjcPTvkNHAIZY+idI6o61FWyi91jWH13UohYtClAm3zU+Qi
         sCJo1kaN8ypgVh9jxLDWVv1PC+pmYLU7eU0Qj0XmtcjjUVg1B9oZ/GUoREcAN/AIuhiW
         2r7hYA5mQQwavlxFxEjSaW4zOmX1JKBn18eUhNkWWsc1ecgafh2D7aPT7VwhIPf0r2K5
         MSGJAldqvEtPl4vYwtla/ywmAepmNipYgwiWXwKcUWT8pIUG70NT3Ncx11GdwyJnphQi
         yF2w==
X-Gm-Message-State: AOAM5325Idi4aHqo9Cbd0RPWflv16rthaa9bqsk6J1FCa8/5eo2unzWR
        xu+fiXEz/1k2xNokIvOcCnUM8w==
X-Google-Smtp-Source: ABdhPJzjj5OtFnnJodRRFy4eoq/rtiT+vzfgHxeZ+K9/4BDA3By02/yRNyweQOfvFZm0XhT4Sz81Wg==
X-Received: by 2002:a2e:aa8b:: with SMTP id bj11mr1284215ljb.180.1634153007181;
        Wed, 13 Oct 2021 12:23:27 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id b4sm30366lft.206.2021.10.13.12.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:23:26 -0700 (PDT)
Subject: Re: [PATCH v4 16/20] crypto: qce: core: Make clocks optional
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
 <20211013105541.68045-17-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <5f69019a-86c7-fac5-2758-1be9a9092678@linaro.org>
Date:   Wed, 13 Oct 2021 22:23:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211013105541.68045-17-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 10/13/21 1:55 PM, Bhupesh Sharma wrote:
> From: Thara Gopinath <thara.gopinath@linaro.org>
> 
> On certain Snapdragon processors, the crypto engine clocks are enabled by
> default by security firmware and the driver need not/ should not handle the
> clocks. Make acquiring of all the clocks optional in crypto enginer driver

typo, s/enginer/engine/

> so that the driver intializes properly even if no clocks are specified in

typo, s/intializes/initializes/

> the dt.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 2ab0b97d718c..576c416461f9 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -213,19 +213,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	if (IS_ERR(qce->mem_path))
>   		return PTR_ERR(qce->mem_path);
>   
> -	qce->core = devm_clk_get(qce->dev, "core");
> +	qce->core = devm_clk_get_optional(qce->dev, "core");
>   	if (IS_ERR(qce->core)) {
>   		ret = PTR_ERR(qce->core);
>   		goto err_mem_path_put;
>   	}
>   
> -	qce->iface = devm_clk_get(qce->dev, "iface");
> +	qce->iface = devm_clk_get_optional(qce->dev, "iface");
>   	if (IS_ERR(qce->iface)) {
>   		ret = PTR_ERR(qce->iface);
>   		goto err_mem_path_put;
>   	}
>   
> -	qce->bus = devm_clk_get(qce->dev, "bus");
> +	qce->bus = devm_clk_get_optional(qce->dev, "bus");
>   	if (IS_ERR(qce->bus)) {
>   		ret = PTR_ERR(qce->bus);
>   		goto err_mem_path_put;
> 

--
Best wishes,
Vladimir
