Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AA350189
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhCaNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhCaNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:40:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B67C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 06:40:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u20so23842614lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7F1deS5QWVK4KYnOzaLbhNHQC6aug03ApEK2A2NzYGA=;
        b=H43yUMdSWba5CkZEw+Cqmmn7i4lFJ/UW3UcmfVjvwhoJFqyAJ+/8/4cTEcyYPG8bbH
         dsTQmmErgLzmewm2gjllG3X4poLoKENQVXhYC4IyArHGJbZpa5KVIi2kMNxU082JQeSI
         D4kkZIqNxUHr/QdWRiy4yDOAMcXaab27tJQUUiWIVd2moAeylcLBuQNRxChBNa4cgLLd
         Z3irhXRGAyIj8/DI9abbrA8pigSviyJ8mbrrE03WZYYkig7Lktj/RUNA1v7vu/FX3vpd
         123lof+XmUeB8yk0Hxa64AM94RRyzUdnSJoADFmc4FJUa/TvU6eUSI42BZ524KUD/6yx
         t2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F1deS5QWVK4KYnOzaLbhNHQC6aug03ApEK2A2NzYGA=;
        b=nS0+z6SPu7VRCoBbiDT7gkUT0+zzrPgiaJ8FFeFKug5nJH7ZxfC7hWPy3d+JolIrPQ
         l2U+q2gcCPRe1M1gq7u82yvntIqwIe+I+EoVIukHMjzkcE8T3tyuv5RzubXf+/PaKdaS
         JOFp9qyy5RIuT0QTKf5DXfYOroi5zgyXkOMb7EmXf9b4u7Q+41hiHjG0NgQonFUiJCzH
         0iWNnXetgnGzKH3wMCLr/xDUctWCpzf2wDacrwN/c7HD0WI5gtrUGk8QqZhNe7Ypck1J
         AWXoZBdrQIG8uGWVRHxo8xn9yuFE+bTw3GdyP5fsthDyQSSTYnmLvZwi52KknCv1Pauk
         ACtg==
X-Gm-Message-State: AOAM532qu76p9HNIYDIsXODfZvB3ocBWWB3Zig3uGqX9zxrB1lozeRzY
        hPRQXqBKgZxt50eWx3QpXOEgQ3iE9J9iVA==
X-Google-Smtp-Source: ABdhPJxwrrlNr1BbyXtUcHSomrDs3y/v2bqflV4EZT9tDuK09E34s8j9WdMzKx42fAwlSEWQPvNvog==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr2182526ljj.78.1617198008818;
        Wed, 31 Mar 2021 06:40:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b25sm237748lff.268.2021.03.31.06.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 06:40:08 -0700 (PDT)
Subject: Re: [PATCH v2] drm/msm: a6xx: Make sure the SQE microcode is safe
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210210005205.783377-1-jcrouse@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <af099fda-a7be-8fe5-ed9e-cfcd6f13c09c@linaro.org>
Date:   Wed, 31 Mar 2021 16:40:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210210005205.783377-1-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/02/2021 03:52, Jordan Crouse wrote:
> Most a6xx targets have security issues that were fixed with new versions
> of the microcode(s). Make sure that we are booting with a safe version of
> the microcode for the target and print a message and error if not.
> 
> v2: Add more informative error messages and fix typos
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

[skipped]

> +	}  else {
> +		/*
> +		 * a650 tier targets don't need whereami but still need to be
> +		 * equal to or newer than 1.95 for other security fixes
> +		 */
> +		if (adreno_is_a650(adreno_gpu)) {
> +			if ((buf[0] & 0xfff) >= 0x195) {
> +				ret = true;
> +				goto out;
> +			}

I think this is incorrect. The latest firmware i have here also fails 
this check, with the buf[0] = 0x016dd099, so buf[0] & 0xfff = 0x099.

Could you please confirm the versioning?

> +
> +			DRM_DEV_ERROR(&gpu->pdev->dev,
> +				"a650 SQE ucode is too old. Have version %x need at least %x\n",
> +				buf[0] & 0xfff, 0x195);
> +		}
> +
> +		/*
> +		 * When a660 is added those targets should return true here
> +		 * since those have all the critical security fixes built in
> +		 * from the start
> +		 */
> +	}
> +out:
>   	msm_gem_put_vaddr(obj);
> +	return ret;
>   }
>   
>   static int a6xx_ucode_init(struct msm_gpu *gpu)
> @@ -566,7 +611,13 @@ static int a6xx_ucode_init(struct msm_gpu *gpu)
>   		}
>   
>   		msm_gem_object_set_name(a6xx_gpu->sqe_bo, "sqefw");
> -		a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->sqe_bo);
> +		if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->sqe_bo)) {
> +			msm_gem_unpin_iova(a6xx_gpu->sqe_bo, gpu->aspace);
> +			drm_gem_object_put(a6xx_gpu->sqe_bo);
> +
> +			a6xx_gpu->sqe_bo = NULL;
> +			return -EPERM;
> +		}
>   	}
>   
>   	gpu_write64(gpu, REG_A6XX_CP_SQE_INSTR_BASE_LO,


-- 
With best wishes
Dmitry
