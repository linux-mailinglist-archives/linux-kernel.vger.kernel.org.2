Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872D39FCEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhFHQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:58:23 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:37511 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhFHQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:58:22 -0400
Received: by mail-qk1-f173.google.com with SMTP id i67so20832885qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u0jkiDRYCG9tDKJ5bWYS1XDj3QKmjRotfMyh8Z3wS/8=;
        b=A5JfgkNIXbw7zRFkCQvIO7v0/mtkxi+fmo+QnohaqF2ZVD9FOYLVvx37F/fINlIt7U
         IUhslFH3Q9p0bAyz2sjljW5BZE9qoSUtMFiG+tNzeFL6P1doG3yJDeVJJZl5w/m46n4j
         K1Blp0UxBcATeQHcNooWc5Jc8QetEa169iQrHKhPhqMUiD/Yx+LOc9gmn/kYmYThJcK5
         QHkkwGuIz4reZ0citIlB+tRh4QEymvX/R5qaLVS0LL7upgmuSgF7cdObCyguqYbSnbyn
         FUgHFL8qabZUglarZxie3yMRqr5x2KX1vGoCdyPp35YzDoK3tX7sCr4SLC+k1ERg2G6t
         GqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u0jkiDRYCG9tDKJ5bWYS1XDj3QKmjRotfMyh8Z3wS/8=;
        b=CMd5nfDaMKG8Bbd0uFGUn8RLP9/uaR/a9DVCib7EbrWS5vwjf9j/Bt9WPpL6v+iglH
         yhaCeYB3zm0XTzwL6vVf+optEZb7KUSCbm7UfWxXGKuWu0U91zz3FeRti1iuySh2YcrH
         fCmKbaO682rYXBcoVrSHE+e+U3FkPa3TYA6COc5fJ9VGfxMJohCBIUnLpv21NWtgD4Nl
         UIqbLUfqNbBJa79R2DDEAc4zK1YJlqKaibdOonMd8IHqzdwj3qXl2QlQ5vepAG/yrZou
         v4n23Cb58fMwGmn7KbzBsbdn+wkaix9U83sbwY9ERUULnqeCFsramEVVONoJDQ+7a5hu
         Wa0g==
X-Gm-Message-State: AOAM530re+MwdXId0HVMw6IH/DwKwRc6wOqqPPXSJ2sRf5UB05cg8YTG
        4i+aBonrbYXJEAK1s7KguHoVmUInwxQCEg0adu0HKg==
X-Google-Smtp-Source: ABdhPJzsgmTE+FYjCjQ89/qlYNd7CK3mU8AEGjcZnqOY3tWmhR+skZOgk9rTfy7cVDsI+1rBwYiq9g==
X-Received: by 2002:a37:6884:: with SMTP id d126mr22160972qkc.497.1623171328720;
        Tue, 08 Jun 2021 09:55:28 -0700 (PDT)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h19sm9936019qtq.5.2021.06.08.09.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:55:28 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] drm/msm/a6xx: add support for Adreno 660 GPU
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513171431.18632-1-jonathan@marek.ca>
 <20210513171431.18632-7-jonathan@marek.ca>
 <055b924e-43fe-1b2b-7292-43a88f9798c2@codeaurora.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <8dd37a7b-b58f-3cf6-346e-ca5add2a163c@marek.ca>
Date:   Tue, 8 Jun 2021 12:53:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <055b924e-43fe-1b2b-7292-43a88f9798c2@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 11:05 AM, Akhil P Oommen wrote:
> On 5/13/2021 10:44 PM, Jonathan Marek wrote:

...

>> @@ -519,7 +519,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>>       if (!pdcptr)
>>           goto err;
>> -    if (adreno_is_a650(adreno_gpu))
>> +    if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
> 
> why not adreno_is_a650_family() here?
> 

Based on downstream, a620 is part of a650_family but does not have 
pdc_in_aop flag.

>> @@ -751,7 +751,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, 
>> unsigned int state)
>>       int ret;
>>       u32 chipid;
> We need to program this register here:
> gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, 1);
> 

msm-4.19 does not have this write for a650, but msm-5.4 then adds it. 
Will make it a separate change since it affects a650 and not just a660.

>> -    if (adreno_is_a650(adreno_gpu))
>> +    if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
>>           gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
>>       if (state == GMU_WARM_BOOT) {
>> @@ -1494,12 +1494,28 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, 
>> struct device_node *node)
>>       if (ret)
>>           goto err_put_device;
>> +
>> +    /* A660 now requires handling "prealloc requests" in GMU firmware
>> +     * For now just hardcode allocations based on the known firmware.
>> +     * note: there is no indication that these correspond to "dummy" or
>> +     * "debug" regions, but this "guess" allows reusing these BOs which
>> +     * are otherwise unused by a660.
>> +     */
>> +    gmu->dummy.size = SZ_4K;
>> +    if (adreno_is_a660(adreno_gpu)) {
>> +        ret = a6xx_gmu_memory_alloc(gmu, &gmu->debug, SZ_4K * 7, 
>> 0x60400000);
>> +        if (ret)
>> +            goto err_memory;
> 
> I think we can simply ignore this allocation for a660 because it was 
> required for an unused feature. Do you see any issue if you ignore this 
> allocation?
> 

Yes, without it there will be an error:

arm-smmu 3da0000.iommu: Unhandled context fault: fsr=0x402, 
iova=0x60400000, fsynr=0x32, cbfrsynra=0x5, cb=2

>> +
>> +        gmu->dummy.size = SZ_8K;
>> +    }
>> +
>>       /* Allocate memory for the GMU dummy page */
>> -    ret = a6xx_gmu_memory_alloc(gmu, &gmu->dummy, SZ_4K, 0x60000000);
>> +    ret = a6xx_gmu_memory_alloc(gmu, &gmu->dummy, gmu->dummy.size, 
>> 0x60000000);
>>       if (ret)
>>           goto err_memory;
>> -    if (adreno_is_a650(adreno_gpu)) {
>> +    if (adreno_is_a650_family(adreno_gpu)) {
>>           ret = a6xx_gmu_memory_alloc(gmu, &gmu->icache,
>>               SZ_16M - SZ_16K, 0x04000);
>>           if (ret)
>> @@ -885,6 +937,13 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>>       /* Protect registers from the CP */
>>       a6xx_set_cp_protect(gpu);
>> +    if (adreno_is_a660(adreno_gpu)) {
>> +        gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
>> +        gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
>> +        /* Set dualQ + disable afull for A660 GPU but not for A635 */
>> +        gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
>> +    }
>> +
> gpu_rmw(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0, (1 << 9));
> We need this for a640, a650 and a660.
> 

Will make this a separate patch too, since it affects non-a660 GPUs too.

>>       /* Enable expanded apriv for targets that support it */
>>       if (gpu->hw_apriv) {
>>           gpu_write(gpu, REG_A6XX_CP_APRIV_CNTL,
>> +/* check for a650, a660, or any derivatives */
>> +static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
>> +{
>> +       return gpu->revn == 650 || gpu->revn == 620 ||
>> +              gpu->revn == 660 || gpu->revn == 635;
> We can remove 635 references throughout since that is not a valid adreno 
> chipid anymore.
> 
> -Akhil

I will remove it for my patch (it can discussed when adding 635 support, 
but I think you will need to have a 6xx ID for the GPU)

>> +}
>> +
>>   int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t 
>> *value);
>>   const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
>>           const char *fwname);
>>
