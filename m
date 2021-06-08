Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50339FE99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhFHSIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:08:23 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45861 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhFHSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:18 -0400
Received: by mail-qt1-f175.google.com with SMTP id l17so11829024qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WOlapbro2aVNPxibq8j3aKmRfZb+mvnEkxvW8XPtMuU=;
        b=u5xkaH+UZcFHSC4oAOTteBw3RDdVrJdHBHpxD0nJQ+qGNakS9xZadU94PfKBHg4bPM
         g3vn3OBBvVdO2NzCsdjQr1D+ZOjpaw4w9UKZXYfRU7Xbpy/G89rxAZR1RzLdDij2yT75
         XBwspKktwnnUGufnEc5Nx9rv+UpTYOqY8KTfjWhoRs0VCWoLbHRWlretslU1mNMAKS2n
         BlmLyqF2fjC80y2Wl21tJjT2CFRnnZZZsMRXFEF4je/StC151EirqknEtFz9ZYyTU44g
         eUguAQXU8JPYagOfxx/aRbWKtXGCSr3xz9/rWR+dK7Dp5xJs+ec55rwD6C0aoxl4Y68q
         iXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WOlapbro2aVNPxibq8j3aKmRfZb+mvnEkxvW8XPtMuU=;
        b=qiJRDJ0z47cRzVZZqK7GVH2AVqA4X22QnsNsC8RdAnAR21EL+7VP2KYRkmpD7v7ghy
         HLv6BZieZONzr5Uqi7oSrHlf57Eosaf4CIi9mTkZulIMPkSPvaSG1lb9aUPE5d1R3l9O
         jMtU6p+/4SifEQ1H33X3Ljn/W4AB+nmMb1109kfJ188tDOdxYWQbLZaDlkRHb7r8FZFO
         u+09az3MzIlwon4cPSuGP8WNPcHEUKvJi8zaA9P9Z8g3v5I74jtfB/geiLqPU9IV5kWz
         XMCdRIM+5iAh7V+ix4kLJJA3/e5BDC8E/q3zgEdFcP8qsc+01QOIR5gDlpl4bHEuCYgZ
         XS8g==
X-Gm-Message-State: AOAM530HLUmTIhMEkzVoEKYPBgw1Xuo+opKUyE8lFDOT/E88vrOUUQKZ
        loN/uLC5DnNdyDHnlduxeQx9mYfc5APDZG2xbpM=
X-Google-Smtp-Source: ABdhPJyhZOqlnVcAHTSXDc04MENqTodbdNP6uY3poRtjnX1YpaTedbGhu6Osr4KNS075sOxw/pGmfg==
X-Received: by 2002:ac8:4e2e:: with SMTP id d14mr19798627qtw.205.1623175524925;
        Tue, 08 Jun 2021 11:05:24 -0700 (PDT)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id v5sm12320418qkh.39.2021.06.08.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:05:24 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] drm/msm/a6xx: add GMU_CX_GMU_CX_FALNEXT_INTF write
 for a650
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210608172808.11803-1-jonathan@marek.ca>
 <20210608172808.11803-4-jonathan@marek.ca>
Message-ID: <4c6ae8ab-05e2-5974-4f8d-48e2a31504b0@marek.ca>
Date:   Tue, 8 Jun 2021 14:03:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210608172808.11803-4-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 1:27 PM, Jonathan Marek wrote:
> downstream msm-5.14 kernel added a write to this register, so match that.
> 

Note: this should say msm-5.4 (msm-5.14 is not a thing)

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 4 +++-
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index c1ee02d6371d..0f3390eab55e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -751,8 +751,10 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>   	int ret;
>   	u32 chipid;
>   
> -	if (adreno_is_a650(adreno_gpu))
> +	if (adreno_is_a650(adreno_gpu)) {
> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, 1);
>   		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
> +	}
>   
>   	if (state == GMU_WARM_BOOT) {
>   		ret = a6xx_rpmh_start(gmu);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
> index 5a43d3090b0c..eeef3d6d89b8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
> @@ -292,6 +292,8 @@ static inline uint32_t A6XX_GMU_GPU_NAP_CTRL_SID(uint32_t val)
>   
>   #define REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF			0x000050f0
>   
> +#define REF_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF    		0x000050f1
> +
>   #define REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_MSG			0x00005100
>   
>   #define REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_RESP			0x00005101
> 
