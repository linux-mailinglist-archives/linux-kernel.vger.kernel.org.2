Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BF39661F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhEaQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:58:30 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:33284 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhEaPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:08:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622473600; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FpwCQzbxxmTztD+IGG6UfeVWw9QiTo3NWz7pTi0L4w8=; b=mrH6AewDzi7KHwrnwKxj6HFNCCWIyd7o44r9lPCsOLKHgmf9ig5NNSOwgqzdvmsTBeMMq47X
 9gG2rUvqY99d9Yen+Qg5gZaaXvHGTO7+UmserEgKvXHTiMb0Z3FaPO5f4gnzo9WCvg9FH+/S
 P/j9zQh9NVYeCqbUEGgSXKZlZSc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60b4fb6aea2aacd729128621 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 15:06:18
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C289FC4314A; Mon, 31 May 2021 15:06:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.105] (unknown [117.210.184.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62AFAC433D3;
        Mon, 31 May 2021 15:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62AFAC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH v2 7/8] drm/msm/a6xx: update a6xx_ucode_check_version for
 a660
To:     Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513171431.18632-1-jonathan@marek.ca>
 <20210513171431.18632-8-jonathan@marek.ca>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <cf60548e-03ae-6a13-2449-9a981a7ab84e@codeaurora.org>
Date:   Mon, 31 May 2021 20:36:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210513171431.18632-8-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2021 10:44 PM, Jonathan Marek wrote:
> Accept all SQE firmware versions for A660.
> 
> Re-organize the function a bit and print an error message for unexpected
> GPU IDs instead of failing silently.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 36 +++++++++++++--------------
>   1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 3cc23057b11d..ec66a24fc37e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -697,6 +697,11 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
>   	 * Targets up to a640 (a618, a630 and a640) need to check for a
>   	 * microcode version that is patched to support the whereami opcode or
>   	 * one that is new enough to include it by default.
> +	 *
> +	 * a650 tier targets don't need whereami but still need to be
> +	 * equal to or newer than 0.95 for other security fixes
> +	 *
> +	 * a660 targets have all the critical security fixes from the start
>   	 */
>   	if (adreno_is_a618(adreno_gpu) || adreno_is_a630(adreno_gpu) ||
>   		adreno_is_a640(adreno_gpu)) {
> @@ -720,27 +725,20 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
>   		DRM_DEV_ERROR(&gpu->pdev->dev,
>   			"a630 SQE ucode is too old. Have version %x need at least %x\n",
>   			buf[0] & 0xfff, 0x190);
> -	}  else {
> -		/*
> -		 * a650 tier targets don't need whereami but still need to be
> -		 * equal to or newer than 0.95 for other security fixes
> -		 */
> -		if (adreno_is_a650(adreno_gpu)) {
> -			if ((buf[0] & 0xfff) >= 0x095) {
> -				ret = true;
> -				goto out;
> -			}
> -
> -			DRM_DEV_ERROR(&gpu->pdev->dev,
> -				"a650 SQE ucode is too old. Have version %x need at least %x\n",
> -				buf[0] & 0xfff, 0x095);
> +	} else if (adreno_is_a650(adreno_gpu)) {
> +		if ((buf[0] & 0xfff) >= 0x095) {
> +			ret = true;
> +			goto out;
>   		}
>   
> -		/*
> -		 * When a660 is added those targets should return true here
> -		 * since those have all the critical security fixes built in
> -		 * from the start
> -		 */
> +		DRM_DEV_ERROR(&gpu->pdev->dev,
> +			"a650 SQE ucode is too old. Have version %x need at least %x\n",
> +			buf[0] & 0xfff, 0x095);
> +	} else if (adreno_is_a660(adreno_gpu)) {
> +		ret = true;
> +	} else {
> +		DRM_DEV_ERROR(&gpu->pdev->dev,
> +			"unknown GPU, add it to a6xx_ucode_check_version()!!\n");
>   	}
>   out:
>   	msm_gem_put_vaddr(obj);
> 

Can we squash this patch with the previous one?

-Akhil.
