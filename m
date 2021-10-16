Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6638E430393
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhJPQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbhJPQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:11:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2274C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:09:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m42so4770779wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YwrD7acOnOmUz8kuzOsdw05t0ErwSAGixf9d/VE1/Tg=;
        b=zMcWvhGfKX1dbtPtzdAyYPn3nIZhS1uqiQ8m6NhzvTzDv/8odNazih8Jtp1DhIKBFl
         SLu7C3cO67L7z6JfbKvHnMFNCMEr+CfRLzngfbV4s+b9j8WncaC7czFZMlPAr/VRNdKf
         btl5Agc6fd7LEp7LRpfK1CzXPu9y62l7Y2PacqExVQKNchEEp8CqqbPyN1ruSk0FZ4ab
         JhuY7rmhu00oK9EiDfEyu4MPMtxs4XyPmHirSImAfiowVfEE33/194wm71w/Pc/nzUSR
         XB65/S3+Qm5XFJQfaNFFzeHutQWNeOs4WLLZ4vNP6qLSh6pm36JXy2HD3xhz64VWVawO
         i/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YwrD7acOnOmUz8kuzOsdw05t0ErwSAGixf9d/VE1/Tg=;
        b=pg4MWIVNuMl3MYymRbSBN2VbprExTOUzhbPvs4JBZl+F2GR532cAcDZjZ2AL8qvQTa
         Odu33PWg2yib8eMv8LxI4IN5TlNVjaeqlsCsfhpmVtA8ypNTNHOSpMN0kJX2TtRf1Ljy
         IFAGWT2V4bXaGk1kh1f0tujSmmjfYr2G8+/RGes9Wck64soSTpbVOTx5K+NnOxZDJtOo
         4ed8urixaTCW6nGNPqfM2jHzrPkDIsomsPutMO+pp50O4RiJQH/d+7w/kvGSABrvLGGb
         0Io4uHD7kqLHkXOD/Gz6bnpQ64DkVzVcfdPNQjTewmdXNpY7YnEFICqoUZQVE5D+B71H
         9HXw==
X-Gm-Message-State: AOAM530GYfE2Jlg4W+XA0I08TA1rpZ1f2lCqXL7A5hP8uDQdmnh6g7PG
        S+BAveZetr3migrtP/E82Sj7fA==
X-Google-Smtp-Source: ABdhPJwi/rrSzXlVlH1Tk5NoyfM+ZKFQY/2OeC/C/rVDmiC2Txrtbl2kzlCG5czTNBYQ/5oBB2Cx+w==
X-Received: by 2002:a05:600c:1c10:: with SMTP id j16mr19481180wms.28.1634400541218;
        Sat, 16 Oct 2021 09:09:01 -0700 (PDT)
Received: from [192.168.0.30] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z1sm7731018wrt.94.2021.10.16.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 09:09:00 -0700 (PDT)
Message-ID: <0b15a2b6-1fd1-1e52-4896-e588272b25d3@linaro.org>
Date:   Sat, 16 Oct 2021 17:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] drm/msm/devfreq: Add 1ms delay before clamping freq
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20210927230455.1066297-1-robdclark@gmail.com>
 <vFWu4k2fr7YZdUamZdttf2XTTm05kYAza_JI_jGvD28ZV19dUqZmoWkqsf3Bgw_kAbQj87uGiMS0F0O7wtXtEw==@protonmail.internalid>
 <20210927230455.1066297-2-robdclark@gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20210927230455.1066297-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/09/2021 00:04, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a short delay before clamping to idle frequency on active->idle
> transition.  It takes ~0.5ms to increase the freq again on the next
> idle->active transition, so this helps avoid extra freq transitions
> on workloads that bounce between CPU and GPU.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Note that this sort of re-introduces the theoretical race solved
> by [1].. but that should not be a problem with something along the
> lines of [2].
> 
> [1] https://patchwork.freedesktop.org/patch/455910/?series=95111&rev=1
> [2] https://patchwork.freedesktop.org/patch/455928/?series=95119&rev=1
> 
>   drivers/gpu/drm/msm/msm_gpu.h         |  7 +++++
>   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 38 +++++++++++++++++++++------
>   2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 32a859307e81..2fcb6c195865 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -120,6 +120,13 @@ struct msm_gpu_devfreq {
>   	 * it is inactive.
>   	 */
>   	unsigned long idle_freq;
> +
> +	/**
> +	 * idle_work:
> +	 *
> +	 * Used to delay clamping to idle freq on active->idle transition.
> +	 */
> +	struct msm_hrtimer_work idle_work;
>   };
> 
>   struct msm_gpu {
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index 15b64f35c0f6..36e1930ee26d 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -96,8 +96,12 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
>   	.get_cur_freq = msm_devfreq_get_cur_freq,
>   };
> 
> +static void msm_devfreq_idle_work(struct kthread_work *work);
> +
>   void msm_devfreq_init(struct msm_gpu *gpu)
>   {
> +	struct msm_gpu_devfreq *df = &gpu->devfreq;
> +
>   	/* We need target support to do devfreq */
>   	if (!gpu->funcs->gpu_busy)
>   		return;
> @@ -113,25 +117,27 @@ void msm_devfreq_init(struct msm_gpu *gpu)
>   	msm_devfreq_profile.freq_table = NULL;
>   	msm_devfreq_profile.max_state = 0;
> 
> -	gpu->devfreq.devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
> +	df->devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
>   			&msm_devfreq_profile, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>   			NULL);
> 
> -	if (IS_ERR(gpu->devfreq.devfreq)) {
> +	if (IS_ERR(df->devfreq)) {
>   		DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
> -		gpu->devfreq.devfreq = NULL;
> +		df->devfreq = NULL;
>   		return;
>   	}
> 
> -	devfreq_suspend_device(gpu->devfreq.devfreq);
> +	devfreq_suspend_device(df->devfreq);
> 
> -	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node,
> -			gpu->devfreq.devfreq);
> +	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node, df->devfreq);
>   	if (IS_ERR(gpu->cooling)) {
>   		DRM_DEV_ERROR(&gpu->pdev->dev,
>   				"Couldn't register GPU cooling device\n");
>   		gpu->cooling = NULL;
>   	}
> +
> +	msm_hrtimer_work_init(&df->idle_work, gpu->worker, msm_devfreq_idle_work,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>   }
> 
>   void msm_devfreq_cleanup(struct msm_gpu *gpu)
> @@ -179,6 +185,11 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>   	unsigned int idle_time;
>   	unsigned long target_freq = df->idle_freq;
> 
> +	/*
> +	 * Cancel any pending transition to idle frequency:
> +	 */
> +	hrtimer_cancel(&df->idle_work.timer);
> +
>   	/*
>   	 * Hold devfreq lock to synchronize with get_dev_status()/
>   	 * target() callbacks
> @@ -209,9 +220,12 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>   	mutex_unlock(&df->devfreq->lock);
>   }
> 
> -void msm_devfreq_idle(struct msm_gpu *gpu)
> +
> +static void msm_devfreq_idle_work(struct kthread_work *work)
>   {
> -	struct msm_gpu_devfreq *df = &gpu->devfreq;
> +	struct msm_gpu_devfreq *df = container_of(work,
> +			struct msm_gpu_devfreq, idle_work.work);
> +	struct msm_gpu *gpu = container_of(df, struct msm_gpu, devfreq);
>   	unsigned long idle_freq, target_freq = 0;
> 
>   	/*
> @@ -229,3 +243,11 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> 
>   	mutex_unlock(&df->devfreq->lock);
>   }
> +
> +void msm_devfreq_idle(struct msm_gpu *gpu)
> +{
> +	struct msm_gpu_devfreq *df = &gpu->devfreq;
> +
> +	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
> +			       HRTIMER_MODE_ABS);
> +}
> --
> 2.31.1
> 

Hi Rob,

I tested this patch on the OnePlus 6, with it I'm still able to reproduce the crash introduced by
("drm/msm: Devfreq tuning").

Adjusting the delay from 1ms to 5ms seems to help, at least from some very basic testing.

Perhaps the increased power reliability of the external power supply on dev boards is helping to mask the issue (hence 
why it's harder to reproduce on db845c).

-- 
Kind Regards,
Caleb (they/them)
