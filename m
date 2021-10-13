Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC142CA03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhJMT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:28:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE485C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:26:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so16444669lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cqg6OlscZqEMvb/ReYXudBaSyipapWX2ho/bKAy2P6s=;
        b=QIG+ixl2Q4prZfyV2wCaaV06GK34fLeJljGPY2tmislnOnnZgid7OA0rtWBo2t1esQ
         afLbkXegUw8WteZuauN8DY9jGP1mQwJQaW3ImwlYDIdxUiDuLqIcY27qyI0RyBSXan/Z
         McxnsDpDOA8ZCTeLKYdTVX4lPhTSWMxeZUVvyNIxDQlqzvLav/ktJErSDZFwdFdV+OXC
         gwVnso03jrqpF7HGBdkBDmGG5QzCb9hOn71y9ANa75N0QrsXa4Wv9Eg/MSg2+nL6JtGX
         jPWdB7AWpsfuPYHmi5FfPW7/vIs8PGanB/plcFVlvijuJGnn+ii7JWR5WkwWhkEFVOlf
         pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cqg6OlscZqEMvb/ReYXudBaSyipapWX2ho/bKAy2P6s=;
        b=LptJnAb7bvz1ioonupyYZ3ubuE4vCcDJoGdtX3uxtATuB4alQLWSn+omBaLu2p0ro0
         SQ//hGezueUeBEy6le2v7s53vrygoFpEnyMXttFuu1Iiv5kh0nlbsOwyiAb7YglhQWw3
         sxpgEnIeqjrjl68Ct1RE+MpebeZ/pn277UMJzRj6+trUSKtCn6y6Crmym+GIT1rRJ01m
         +JB29pQQ6joClFLg87/EYEAoa1ny5gq+MkyIUPErxun/sa7TGI3egxPyItom7uHChVqA
         NqEeAvI8O5k3u8eU4Eym+pp7SkYDRgF+NGhF26pl7vEXRMjFICM/nIdgvuc0MyL/SELx
         yzlw==
X-Gm-Message-State: AOAM533rjE0S3ecR8rWEKaMXHfXSByuEMc23r2H5ktDyf1dLPTMwU3vE
        DX5aW6sWiC1DdirETRxrhEllQ99s4Jt7uA==
X-Google-Smtp-Source: ABdhPJznjZnDpqOvqSdheZSC8P42iPnMdQCzy/Tnq4TKbALGTxj9GhVYDaxKh0Q/72NXCoIRKjTuew==
X-Received: by 2002:a05:6512:14b:: with SMTP id m11mr811712lfo.410.1634153181254;
        Wed, 13 Oct 2021 12:26:21 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id g7sm31776lfr.113.2021.10.13.12.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:26:21 -0700 (PDT)
Subject: Re: [PATCH v4 17/20] crypto: qce: Print a failure msg in case probe()
 fails
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
 <20211013105541.68045-18-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <2699de22-4943-685f-5700-82137a4326ae@linaro.org>
Date:   Wed, 13 Oct 2021 22:26:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211013105541.68045-18-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 10/13/21 1:55 PM, Bhupesh Sharma wrote:
> Print a failure message (dev_err) in case the qcom qce crypto
> driver probe() fails.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 576c416461f9..cb8c77709e1e 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -281,6 +281,8 @@ static int qce_crypto_probe(struct platform_device *pdev)
>   	icc_set_bw(qce->mem_path, 0, 0);
>   err_mem_path_put:
>   	icc_put(qce->mem_path);
> +
> +	dev_err(dev, "%s failed : %d\n", __func__, ret);
>   	return ret;
>   }
>   

As for me the rationale of this change is quite non-obvious, a user is well
informed, if a driver probe fails. I would rather ask you to consider to
drop this change.

--
Best wishes,
Vladimir
