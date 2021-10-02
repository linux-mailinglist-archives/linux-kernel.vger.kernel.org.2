Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7641FED2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhJBXxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 19:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhJBXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 19:53:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60495C0613EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 16:52:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i24so6152843lfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DWmaqaBK3VHPsKjTNJeXDdL5YO382kmrBlq18HElcSI=;
        b=FKhaKLPFJ6RQQamReLb4STcsqPATczVCwjxHPW3hG5nUKXijCucZTQyhtYt4MDYt0r
         4P1yZcIm+WF0dDL5q5ZK2yBsV2FU0kPSn228mtLdUIBD11MEaj561ldZmG8HV9soAP72
         2WarEPNFRKYS1pX89sFqu6+kVrjCTZiAeelh/ScMEJW5ETLrXUfySNd0B7egPn4bdu9l
         AVC0yl6gRffLhoirxUG4OHMjKWVRs6lLADFrD5AYnCpArhLrDyK0LRhAclr00MMH45aP
         PJOljZoVxbO0TD7umCgk88Zr/Ixh17TLdI402OgejXacBb1fZn1vcupG0auc7508hEML
         SUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWmaqaBK3VHPsKjTNJeXDdL5YO382kmrBlq18HElcSI=;
        b=ByOurgBHCevqtY1gRAt61Dt3bQBAHnVRrcfhakeRRfPhWvsXfWx8luq18a1+aTLjHm
         hj7UOREX4ZBV8EXXEgXv/w1ERv5w7oZJOQV7A5MCbAUXdqc+6U+uW5HRHIxsjdqxzjSY
         +2rSt5qXRGxpQOasbPMLDKyXpvCsTk1sculPxZYS3JsEGlvPpwnuRI8z5lOdSGfPbki1
         tKwCFBIeNbcRxdN0CticI9welU40pJ8XDdIGwVsAzCvh6q55YglAqM+MLeg6kQULqi7h
         34WBLqRp5e4zGdUI96vHI+ibBwyBT8o4QqpOpMZJajqo/gdbJFMkWZpHZ3fLseWniCTc
         WAow==
X-Gm-Message-State: AOAM531pm+Fhwp+2tfXzyZXovuPRVJeLITH5JlFf1e0t8DXYyEjL6yET
        DiL2125lf+jHjqT1EamY1UUQYZPCdg2jNw==
X-Google-Smtp-Source: ABdhPJy9JFhgCqmgrcSVr3c9iyMWIHWO+E+81TAcESUFPm5L7GEZMkZnE/pGGkQ9LWj+daE80rvfEQ==
X-Received: by 2002:a2e:4a12:: with SMTP id x18mr6618398lja.309.1633218725415;
        Sat, 02 Oct 2021 16:52:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d1sm1163650lfj.61.2021.10.02.16.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 16:52:05 -0700 (PDT)
Subject: Re: [V2] drm: msm: adreno: use IS_ERR() instead of null pointer check
To:     Wang Qing <wangqing@vivo.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1604719151-28491-1-git-send-email-wangqing@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <4b7f494e-98f4-5e06-d025-72593ccb5301@linaro.org>
Date:   Sun, 3 Oct 2021 02:52:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1604719151-28491-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2020 06:19, Wang Qing wrote:
> a6xx_gmu_get_mmio() never return null in case of error, but ERR_PTR(), so
> we should use IS_ERR() instead of null pointer check and IS_ERR_OR_NULL().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

As a second thought, ioremap's NULL is converted to ERR_PTR(-EINVAL), so 
the patch is correct.

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 491fee4..82420f7
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -492,7 +492,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>   	void __iomem *seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
>   	uint32_t pdc_address_offset;
>   
> -	if (!pdcptr || !seqptr)
> +	if (IS_ERR(pdcptr) || IS_ERR(seqptr))
>   		goto err;
>   
>   	if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
> @@ -580,9 +580,9 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>   	wmb();
>   
>   err:
> -	if (!IS_ERR_OR_NULL(pdcptr))
> +	if (!IS_ERR(pdcptr))
>   		iounmap(pdcptr);
> -	if (!IS_ERR_OR_NULL(seqptr))
> +	if (!IS_ERR(seqptr))
>   		iounmap(seqptr);
>   }
>   
> 


-- 
With best wishes
Dmitry
