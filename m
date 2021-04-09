Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF235A37E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhDIQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:37:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE07C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:37:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i81so6358361oif.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jt0mWpBq3sNUpgvlCnN+R/MTcVAEftEHqFK2IYG/XB4=;
        b=WOL4buhsRFkvMQViI453GGiCvUFNdZgc4ZJlJTdZ7MBQyuDpmrm4VqCDDcOyg3J4bK
         jFKEYRGmYDgV6SIwQ9TIRNLKaxuH0Fo04kDmI3mQ2FcPKLfykO+QwyF34tvceG8YcmQ3
         r0GvqBuUUfPxGGUjv9smdXWNIdyK7dK0Hb1AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jt0mWpBq3sNUpgvlCnN+R/MTcVAEftEHqFK2IYG/XB4=;
        b=atjZPno+BhdurxxwJ/HraT17KR0H/lc9Ma9Uh73aPNUpjYiy4WQztv655QrZV0oSbO
         ybQzSHz3x0Qu5wZV0KPXpyZdglN7Gr+6MECriLP6iG0umJRpI3mHy7Ckr/kv7NfqiYeY
         oq9ywlfn65beU0EJhzm1Q90M8/eRxrtMm8iPpS/yPwTSadtr6i5jZXIaAM6u6PscF8Gj
         PqVP+dv9Juuryq/PZY+nteovfIqp3u9Tdh8CTGRF6M3xKdc8IRBrcml/byxql+sZMS/i
         G8ji37V3w24/c59VY4HJEnsL82M4RMR7JC2TQ7rDTBMenkL1ZHQ5d0u3IDcpsjBaHVxX
         j7Mg==
X-Gm-Message-State: AOAM533Mn4/JI9/xI69jtAJ5q19OzHeMOnSMpdFDNB+YWbDFAVpUnOgC
        QWEBKOd6g0E2pbMRKpMky4LQIQ==
X-Google-Smtp-Source: ABdhPJzsQ95+MkAElEf4DTQwKSA8OxVjxEKU7dWZZwOzlYX2GRhaMaQ1f+vG+7hV2gl0mir70p7MEQ==
X-Received: by 2002:a05:6808:542:: with SMTP id i2mr4703717oig.84.1617986235763;
        Fri, 09 Apr 2021 09:37:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t144sm624807oih.26.2021.04.09.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 09:37:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Alexander Monakov <amonakov@ispras.ru>,
        David Coe <david.coe@live.co.uk>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
Date:   Fri, 9 Apr 2021 10:37:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
> Performance Counter (PMC) support was first introduced in
> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
> resource management"), there was a HW bug where the counters could not
> be accessed. The result was reading of the counter always return zero.
> 
> At the time, the suggested workaround was to add a test logic prior
> to initializing the PMC feature to check if the counters can be programmed
> and read back the same value. This has been working fine until the more
> recent desktop/mobile platforms start enabling power gating for the PMC,
> which prevents access to the counters. This results in the PMC support
> being disabled unnecesarily.

unnecessarily

> 
> Unfortunatly, there is no documentation of since which generation

Unfortunately,

Rephrase suggestion:
Unfortunately, it is unclear when the PMC HW bug fixed.

> of hardware the original PMC HW bug was fixed. Although, it was fixed
> soon after the first introduction of the PMC. Base on this, we assume

Based

> that the buggy platforms are less likely to be in used, and it should

in use

> be relatively safe to remove this legacy logic.

> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/init.c | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 648cdfd03074..247cdda5d683 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1714,33 +1714,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>   	return 0;
>   }
>   
> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value, bool is_write);
> -
>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
> +	u64 val;
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
>   
>   	amd_iommu_pc_present = true;
>   
> -	/* save the value to restore, if writable */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> -		goto pc_false;
> -
> -	/* Check if the performance counters can be written to */
> -	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> -	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2))
> -		goto pc_false;
> -
> -	/* restore */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> -		goto pc_false;
> -
>   	pci_info(pdev, "IOMMU performance counters supported\n");
>   
>   	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
> @@ -1748,11 +1731,6 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   	iommu->max_counters = (u8) ((val >> 7) & 0xf);
>   
>   	return;
> -
> -pc_false:
> -	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> -	amd_iommu_pc_present = false;
> -	return;
>   }
>   
>   static ssize_t amd_iommu_show_cap(struct device *dev,
> 

I will test this patch and the revert on my two AMD systems and update
you in a day or two.

thanks,
-- Shuah
