Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DB40400D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350670AbhIHUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbhIHUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:01:15 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 13:00:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id k20-20020a4ad114000000b0029133123994so1172094oor.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RtxwRt2rTuC496QAV96NN3FjKBQdlap5HoR2ATAA9hU=;
        b=RsOiPsYODfTsIryeJE0IlLhSwf62h5Se7YksEGS0zegwU3Il8jCzlrJ5if1mEFhhWZ
         ydKf5ZGJ6tTV/T4rdQn0/ly2reLSXSyVv2w7UYsfWj56TP4Bkqsbt/pB9G03uZUbkKXL
         qWoY1WnDs4Stetsc1dJaf4YW/bNtlFlNXxvCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RtxwRt2rTuC496QAV96NN3FjKBQdlap5HoR2ATAA9hU=;
        b=jnxhVEm/tmaQQtb/KB+auAjlVww6kT7eX4eZiGlxfQxSTsAJv25tAeX2N5fCpHG1Th
         Bt5oouBMf+s3ElVo6lq6FBtq43cHyZG3GIab6KvbG65z4sWp/H7rVe0qbSU2Knwx0+Up
         TzxZV2EkTYD7AZWkKB3Kri/QfKRIFALOevMKWAp/MOwn/gXfemiPAl2MLHtLNnjF6P2j
         x9ss0jvm4fkSV7EFKFNAalX0a8g+toKww2OYucEb+040RuOOKLDeD+cvf0lRBjxWwBFW
         oshN+TwlYUDlDtAnX3izshmnimVJa/Utm0k1uLjYLYJbvzRCv/NvCC+Sqz9AcU+cchO7
         8OGQ==
X-Gm-Message-State: AOAM530neg4JxubvInlMtaR8EImzXmUNIrfhDxRtenezBW5+mxM+63ys
        IDB59TKjQYUho8ZfSXkj+vCzow==
X-Google-Smtp-Source: ABdhPJxVIKlbDojIl6ZNygmPq7kE1gZ8MAYMaX+VkWQ1Tv7ShdXJr5e2KhVp5DP7gFiCu0ty2mXMfQ==
X-Received: by 2002:a05:6820:613:: with SMTP id e19mr21508oow.67.1631131206643;
        Wed, 08 Sep 2021 13:00:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z18sm14301oib.27.2021.09.08.13.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 13:00:06 -0700 (PDT)
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c8c57be3-5a86-062c-bd5c-5132d05dde3f@linuxfoundation.org>
Date:   Wed, 8 Sep 2021 14:00:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-2-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> Add Collaborative Processor Performance Control Extension feature flag
> for AMD processors.
> 

Please add a couple of sentences about the feature and what it does.

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..f7aea50e3371 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>   #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>   #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>   #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_CPPC_EXT	(13*32+27) /* Collaborative Processor Performance Control Extension */
>   
>   /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>   #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> 

thanks,
-- Shuah
