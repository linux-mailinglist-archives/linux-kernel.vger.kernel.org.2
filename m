Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB46A35A464
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhDIRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:10:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A8C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:10:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s16so1386991iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nCobqSwfZDla9Q+XsivHohjupQFazDMt1CW+z7r56vw=;
        b=f70bMEaIabgtympSuMmQtZg3AttmB0GlovZGjM6jUOF6+aHMCAA8ptxX/jdw7kvkyb
         sYYpbZK2elhek+LdqKVBJ81QinqhZkpqu2O5c56zYz3oa0nIapMA+4BYeWEMh4exe4g1
         tb6Irl+iMnyhBtfDkJi00F6RUhTgnQmZItLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCobqSwfZDla9Q+XsivHohjupQFazDMt1CW+z7r56vw=;
        b=d5MRmwaX37ComS//8nCPs+hoGFHUKIkuNUZJUzX+6ZJN2+QYYK55WpetiSOUBn0feY
         CgAKlRLvw2Tfj7Q0IZZdMJivxHfGOLbfCb9Jp6DBPA6/zMLq6ngdMU1vwsPjcxozb57a
         S0uKNbLzI12fNiShOuU8DBgpr/cM66GaJJGlwXyYF+rkV14pLTV8nUvbdfFfySEyDHKn
         au3U3I8tW2cQE1wH61rxd5ErM4aKhI9Dk/b0LlkEbMds8B1xQcqx0fnS+r3tsANmz22C
         7hR56goNpbZIO5iCxMdH6bb/wYeWGIjBG6ATXLJK3RXT3o+BREhnmthr60OTXNap8iJp
         ZWlA==
X-Gm-Message-State: AOAM531R5ftUN6PomO+ud1n/tA7U1ttQGL9jfwQQySfHKU8CH47xrxrG
        9XmL63KIUWWS/buRtuL8NOOpxw==
X-Google-Smtp-Source: ABdhPJzPiL1DMFybVIX8F5dGlFFX1YtALTjKRNVUIifbdkF2ZUF4vlKOrpP+5zJ1KVoMb4K/MtSPZQ==
X-Received: by 2002:a6b:148f:: with SMTP id 137mr5146365iou.0.1617988230815;
        Fri, 09 Apr 2021 10:10:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k13sm1362401ilu.29.2021.04.09.10.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:10:30 -0700 (PDT)
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
 <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f64e9d4-dfc5-3dec-32c9-06bfbfeafd6b@linuxfoundation.org>
Date:   Fri, 9 Apr 2021 11:10:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 10:37 AM, Shuah Khan wrote:
> On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
>> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
>> Performance Counter (PMC) support was first introduced in
>> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
>> resource management"), there was a HW bug where the counters could not
>> be accessed. The result was reading of the counter always return zero.
>>
>> At the time, the suggested workaround was to add a test logic prior
>> to initializing the PMC feature to check if the counters can be 
>> programmed
>> and read back the same value. This has been working fine until the more
>> recent desktop/mobile platforms start enabling power gating for the PMC,
>> which prevents access to the counters. This results in the PMC support
>> being disabled unnecesarily.
> 
> unnecessarily
> 
>>
>> Unfortunatly, there is no documentation of since which generation
> 
> Unfortunately,
> 
> Rephrase suggestion:
> Unfortunately, it is unclear when the PMC HW bug fixed.
> 
>> of hardware the original PMC HW bug was fixed. Although, it was fixed
>> soon after the first introduction of the PMC. Base on this, we assume
> 
> Based
> 
>> that the buggy platforms are less likely to be in used, and it should
> 
> in use
> 
>> be relatively safe to remove this legacy logic.
> 
>>
>> Link: 
>> https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/ 
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
>> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Alexander Monakov <amonakov@ispras.ru>
>> Cc: David Coe <david.coe@live.co.uk>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/init.c | 24 +-----------------------
>>   1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 648cdfd03074..247cdda5d683 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -1714,33 +1714,16 @@ static int __init init_iommu_all(struct 
>> acpi_table_header *table)
>>       return 0;
>>   }
>> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 
>> cntr,
>> -                u8 fxn, u64 *value, bool is_write);
>> -
>>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>>   {
>> +    u64 val;
>>       struct pci_dev *pdev = iommu->dev;
>> -    u64 val = 0xabcd, val2 = 0, save_reg = 0;

Why not leave this u64 val here? Having the pdev assignment as the
first line makes it easier to read/follow.

>>       if (!iommu_feature(iommu, FEATURE_PC))
>>           return;
>>       amd_iommu_pc_present = true;
>> -    /* save the value to restore, if writable */
>> -    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
>> -        goto pc_false;
>> -
>> -    /* Check if the performance counters can be written to */
>> -    if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>> -        (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
>> -        (val != val2))

Aha - this is going away anyway. Please ignore my comment on 1/2
about parenthesis around (val != val2) being unnecessary.

>> -        goto pc_false;
>> -
>> -    /* restore */
>> -    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
>> -        goto pc_false;
>> -
>>       pci_info(pdev, "IOMMU performance counters supported\n");
>>       val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
>> @@ -1748,11 +1731,6 @@ static void init_iommu_perf_ctr(struct 
>> amd_iommu *iommu)
>>       iommu->max_counters = (u8) ((val >> 7) & 0xf);
>>       return;
>> -
>> -pc_false:
>> -    pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
>> -    amd_iommu_pc_present = false;
>> -    return;
>>   }
>>   static ssize_t amd_iommu_show_cap(struct device *dev,
>>
> 

thanks,
-- Shuah
