Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148D342C9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhJMTYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJMTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:24:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02833C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:22:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z11so15593549lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZNqvGfSDUhWxqhwP01MEB8XD1JZ1GH8Z2KHDHZM3Nx8=;
        b=fiWDlabKcldvXhcH1LFJPBkt7hgjyPu5PaNx7z1jti+e6SONQMaWpq+NAFB9F/h9/7
         B4NBPeHtxciXGRas3IGykPvvbivLLmu9rxgJvPGYMnJaRdNmw/ArMLdAQSIpaJsYeEQx
         jgMmSTOCiJSteDCxb4BaisolDhnGl0GQELLCvAMuYPBXmiVFSIevT6MyfT+0nSN7BUzv
         Obtwd3NrsRs7UpIRAQSxm/jCT8jyLxnv4CL4Q6iXdVJ+C14S0SLCWzydhHQ6zxXPwa7/
         uh3xnmid7ZC9fQuH1q2MCAJ1GClQNk6rZLa+h0nXuAPxxv+yjy6AbAa+XMXUjLZ2XwtY
         ntMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNqvGfSDUhWxqhwP01MEB8XD1JZ1GH8Z2KHDHZM3Nx8=;
        b=NdJgnohR6un+G5OPhN/o+IBMcOS4apcpEHJZp3k3oWy3Jpd979CrARLKt9bWWH63rd
         moPp0KPJcKdGTTx3QUY//SMfO4RHL/1EDFKCLFL+XrZCjlxNAWmFSfT3DUeVtDKzNh/m
         QmWvohv6ammVgYEhTngdP/8iuf00E0bjT/++2Thce+ciqGkpueCyA0kmrEJda9kDBBtf
         Xz5jKP29p3Yk/MknbO4M052oSd/pDECaA1qNPzaZ7dq/1PbM0tHe3uzjjdpNzd38i/TM
         NY1uNYjOjLjGz5fzYdSK4npb+uYlcAnG7y2XA+jMcHi8+j6mClD9U+ilGTbwhsyKNatT
         x7wA==
X-Gm-Message-State: AOAM530KMFt8v9mYg7nIw99papdstQfUUCOoKrb/DPHc1WlfQeS72yv3
        RK2S9aC7F2Ji+XJskrHZ6FPmgA==
X-Google-Smtp-Source: ABdhPJwhQ0Tvi/hWYE2LBkCBSI8GIIWzqEWtNLi+uzns0CmK3K0UJx76rHorqw7uZBMTj8/VSw60pA==
X-Received: by 2002:a05:651c:a05:: with SMTP id k5mr1273338ljq.288.1634152930415;
        Wed, 13 Oct 2021 12:22:10 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id m3sm32470lfh.2.2021.10.13.12.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:22:10 -0700 (PDT)
Subject: Re: [PATCH v4 15/20] crypto: qce: Add new compatibles for qce crypto
 driver
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
 <20211013105541.68045-16-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <793685ac-332b-2dbb-ad61-3a31debc2c77@linaro.org>
Date:   Wed, 13 Oct 2021 22:22:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211013105541.68045-16-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 10/13/21 1:55 PM, Bhupesh Sharma wrote:
> Since we decided to use soc specific compatibles for describing
> the qce crypto IP nodes in the device-trees, adapt the driver
> now to handle the same.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 033c7278aa5d..2ab0b97d718c 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -298,8 +298,8 @@ static int qce_crypto_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id qce_crypto_of_match[] = {
> -	{ .compatible = "qcom,crypto-v5.1", },
> -	{ .compatible = "qcom,crypto-v5.4", },

This breaks backward compatibility with old/not updated dtbs, I'm not sure, if
that common rule has to be kept here, but at least it's worth to be mentioned.

> +	{ .compatible = "qcom,ipq6018-qce", },
> +	{ .compatible = "qcom,sdm845-qce", },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
> 

--
Best wishes,
Vladimir
