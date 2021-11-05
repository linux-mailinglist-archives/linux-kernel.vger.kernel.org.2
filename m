Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7388F446A67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhKEVOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKEVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:14:46 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F64EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 14:12:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id p138so3452093qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E63rFcABRFafy7FYzxz7iS49IsPyTowk4qVbpdWjfQw=;
        b=EOBIa1aZzIWrZsSnRKO2Y2n4rBeO1VRY9xAopIoS7KtRFmVP1JLerEKABFZaA6TP3i
         dNb0+z3E81/8g6cY0kUnZtRC/ppRCI8f8ydTevXYm9rlvXmEgosz+zwT7OfllS/lbwoj
         q4GBd9DlQEPBDGOqqCeNw7xR7rGLeH4mE4av/ut1VAg6V4+XZdk+w0y5KrKGeekEJIzj
         uAuRws4NBYX3N3Na0d4QWjOhl4cxRLwdpG+l6ZPYgwh3pxPudmkWUkgqp/h9dGtSHfXJ
         SduWkGODG203Y6u9jRTZszmqg925sR51Z0jEgLBF3jgQvGy78AByMxvcps+Zuer/C4Nb
         RnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E63rFcABRFafy7FYzxz7iS49IsPyTowk4qVbpdWjfQw=;
        b=MZW+C2v2nAqJaxikDqW10/bfp1bvSj78IJk/QDtZA0rrsnukcvoAY/aUnL5nF90wp0
         46994U+jYtkGuliQQMb3y2z3uSY+p6wQvmyHLSFzwPywV+Wz7GUQOAG0r/zW13PHaUd+
         bFof3njcJNMBJlwyamkzZISfVk7LGFfruJlBxUsr3MESQ6VYmxcJI2trvOYIqslmRPyJ
         pd8kZrVIr1PWiJUwT9Xnsf3Wg/wTWQZ6bbrotplzI8mEtVuaeKvOvb95oJyG1Amyi4Ov
         nb45YdYIJpLZFmraYHLefL/X6kTWGYhu1/iLSJsWz5/MSWSfsQdzC0JJ2nsENKnEdvxZ
         23Jw==
X-Gm-Message-State: AOAM5333cfp6Q4BenlOwNqfT45264ZLMxBvhqag2pNEwBWh2G+3mUDg+
        0No0jf1VhyBjytyzKniSaDyugw==
X-Google-Smtp-Source: ABdhPJwB5ojt8u4YPwOut4pV362BuCfMS+WpbyXqmWaXmfj8HaB90DX8AcfEKFB7vKsEfTCX/uyzew==
X-Received: by 2002:a05:620a:bca:: with SMTP id s10mr47942153qki.416.1636146725249;
        Fri, 05 Nov 2021 14:12:05 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id g19sm6764888qtg.78.2021.11.05.14.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 14:12:04 -0700 (PDT)
Subject: Re: [PATCH] crypto: qce: fix uaf on qce_skcipher_register_one
To:     Chengfeng Ye <cyeaa@connect.ust.hk>, herbert@gondor.apana.org.au,
        davem@davemloft.net, svarbanov@mm-sol.com
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211104134642.20638-1-cyeaa@connect.ust.hk>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <7a158429-6eed-bbcb-f4d0-a6db8ba40d58@linaro.org>
Date:   Fri, 5 Nov 2021 17:12:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211104134642.20638-1-cyeaa@connect.ust.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/21 9:46 AM, Chengfeng Ye wrote:
> Pointer alg points to sub field of tmpl, it
> is dereferenced after tmpl is freed. Fix
> this by accessing alg before free tmpl.
> 
> Fixes: ec8f5d8f ("crypto: qce - Qualcomm crypto engine driver")
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

> ---
>   drivers/crypto/qce/skcipher.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
> index 8ff10928f581..3d27cd5210ef 100644
> --- a/drivers/crypto/qce/skcipher.c
> +++ b/drivers/crypto/qce/skcipher.c
> @@ -484,8 +484,8 @@ static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
>   
>   	ret = crypto_register_skcipher(alg);
>   	if (ret) {
> -		kfree(tmpl);
>   		dev_err(qce->dev, "%s registration failed\n", alg->base.cra_name);
> +		kfree(tmpl);
>   		return ret;
>   	}
>   
> 

-- 
Warm Regards
Thara (She/Her/Hers)
