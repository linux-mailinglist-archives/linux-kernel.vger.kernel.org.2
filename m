Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2A41FEC4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 01:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhJBXpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 19:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhJBXpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 19:45:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB0C0613EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 16:43:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i24so6105431lfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yFmuyFIbVn7VdGil6arszv4U78PVs7ha5E+FdkUpQro=;
        b=ryarz8ImKFeJcmktlcnTO+7fpdIL92jAAHDUmxDk4FyVI2Q2KlHrThK1dWbsUJyuRu
         Dr63+4rouwOERPQkF0wSmPwWAFfC4nMzm9vN+SYd2/N01YuRoajo7vk5qPhKh+16HYzD
         yM/MN0IIZra43vgnf2N0hELlyLxrC8/1HVZEaFwQCuBSRvniUjX0qVkxdsrZTuH5AuWN
         9R3yD3pAcFfBYY7GYYQFmWgl2voLqiQOcryis4htxyr38FJzIdFyh5eHOdECAgQ+ArSa
         R4zyjDOYQN2g0NYMKgbYFdSlvc2h2V/s6kTrcW9OIabmr2HO/gprdxr5NjpnfiYCQqPL
         eCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFmuyFIbVn7VdGil6arszv4U78PVs7ha5E+FdkUpQro=;
        b=ouQkvwSGkGi3pfrZp1zVXrEJE7zNZvrJOki1dnSRJ7R5e8lV/7Ejp15MU8iG+0y0se
         jQbCZDPhqt1zYsOYUG7YnYJBxBANvWjqHH3JFAOACM+VzmmCSVbrEgaCeX5nvEfNCEV5
         vyE4QONJRj2iRnAhNv/rtibVxwnWCLcQgMN8saWoKR0q3FTnLyRVY7DimGnAQUl2ovg6
         JQkfaMl3eJu+coV3aZ1DhP+fQiewrgFjOZux/7+to65mJBMoMGglcOJ4yED1Tpzl7s92
         bArK+k2hVHSP7aRwJQxjx02OmqJp32AsH2kTnYQgxkIijbSJ+Dn7eS1tdFxf9aS+HUj1
         Vc5w==
X-Gm-Message-State: AOAM531YOTDKhTRCFbEIzDgqVI5qZe1iAwHFeWhRokgqnnfvfP0uGOKx
        Vt3osrWb87pxuvNieCTkOuY+KHigN/9/sw==
X-Google-Smtp-Source: ABdhPJxfVHKTvP/nCvaBBstidOInydHI2Dz7CPdAz5Aetr5aasdgikUG9t+klAJGbROOmvlktYbEtw==
X-Received: by 2002:a2e:4a19:: with SMTP id x25mr6292646lja.114.1633218209460;
        Sat, 02 Oct 2021 16:43:29 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a16sm1165315lfr.186.2021.10.02.16.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 16:43:28 -0700 (PDT)
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
Message-ID: <b48957cb-f835-cfa4-34f7-0ab2f96474ed@linaro.org>
Date:   Sun, 3 Oct 2021 02:43:28 +0300
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

Not quite. a6xx_gmu_get_mmio() can return NULL, as it uses ioremap() 
internally. And ioremap returns NULL in case of error. So the proper 
check should be IS_ERR_OR_NULL().

> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
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
