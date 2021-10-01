Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3441F784
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355665AbhJAWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJAWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:43:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4036C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 15:42:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so43757928lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ye+Ig/O23GoJ8Iq7iv3h8SxIDcT6+17KTEH2/egvfXA=;
        b=kuxvhMFSDeYBLvpTecKb2W/0DEQVCCzuQ8WydZmEuAyKLsJ/t2j2sq+9gJcCBN4sHb
         69RW+i+IQpE4EdrUeUA+5aoZr61mrZSzsYFPMcX+eKMeYm3i4F7V7L84Bxh9NguysWKP
         LsvMmbD2FlTKjLIIRCFyuX/HG7jEH4uhRuVqKVFdkviOXKlHvly1pESBR/NQ+WBHumNB
         BNzN1/ZftsFCcEt5anj6+Csv5jx84fQFS0bfJ+70XXqNEC+gOHHot0pGxjqLZfzuDwOE
         UEnXxs1QNW1rT5WJao9TDCqK/SdE9dXUklowGzFcTXHTko7Uqa4+g3kGaq+kBN2+0iXb
         4uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ye+Ig/O23GoJ8Iq7iv3h8SxIDcT6+17KTEH2/egvfXA=;
        b=WNKTfVF9k9Y0SiJzJjtrP/mwsSVcwSqPiGxIldF5qyFDJz+pUNUHW75c9aGPJqCQJL
         LURr5oNqZydKc1Rx7+n15Li9q5ZtGUlCFdXhOAmRxjGh3FmMQDe2A6xKk1uLP/IngnPp
         tl8l0XF+XNa7VzHkYspKpw9vib8LxAlH4i3GQJlH8l+gs1igR31SRni2dfg7SCGnKiFK
         AMgQljiE6J8dC25o4aPl9Hf/h6y42oZpC4A4GJCPAykweZhP8g837M5h/kThpnF8Wg0H
         8iZDWUcgw+Ywlj57WLjXh0v/nHNqX+iI7kMhqSniOsSj9M24B7F5ezIoHwoeHP3Uhrr0
         rS9w==
X-Gm-Message-State: AOAM5300mJBMhcPhuliiG6brVEq1k7zE6xvOfbgBbBaPex5p686971rP
        ZApqGzPnWpry2b0nNWaKoLzc37tIdqbHLQ==
X-Google-Smtp-Source: ABdhPJzSjmTgZF2x7IHWeD8LUXrXxoktmZ4B7IHcP4t5nkYVl1sKDlVVSXKFABEJeRK7+vfZnUasxQ==
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr556331lfu.619.1633128127810;
        Fri, 01 Oct 2021 15:42:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o21sm24068lfo.52.2021.10.01.15.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 15:42:07 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: prevent NULL dereference in
 msm_gpu_crashstate_capture()
To:     Tim Gardner <tim.gardner@canonical.com>,
        dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210929162554.14295-1-tim.gardner@canonical.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <7d251b1c-1054-6fde-602f-35eed4ac1cfe@linaro.org>
Date:   Sat, 2 Oct 2021 01:42:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929162554.14295-1-tim.gardner@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2021 19:25, Tim Gardner wrote:
> Coverity complains of a possible NULL dereference:
> 
> CID 120718 (#1 of 1): Dereference null return value (NULL_RETURNS)
> 23. dereference: Dereferencing a pointer that might be NULL state->bos when
>      calling msm_gpu_crashstate_get_bo. [show details]
> 301                        msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
> 302                                submit->bos[i].iova, submit->bos[i].flags);
> 
> Fix this by employing the same state->bos NULL check as is used in the next
> for loop.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 8a3a592da3a4..2c46cd968ac4 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -296,7 +296,7 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
>   		state->bos = kcalloc(nr,
>   			sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
>   
> -		for (i = 0; i < submit->nr_bos; i++) {
> +		for (i = 0; state->bos && i < submit->nr_bos; i++) {
>   			if (should_dump(submit, i)) {
>   				msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
>   					submit->bos[i].iova, submit->bos[i].flags);
> 


-- 
With best wishes
Dmitry
