Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5490320AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBUNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:45:24 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57133 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229802AbhBUNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:45:20 -0500
Received: from [192.168.1.176] (dynamic-078-055-128-098.78.55.pool.telefonica.de [78.55.128.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5723A2064792E;
        Sun, 21 Feb 2021 14:44:36 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
 <1b2652e9-903e-c02f-8393-2775ae60f0b4@molgen.mpg.de>
Message-ID: <90b556ae-abdc-ffe7-e473-15ff1488f572@molgen.mpg.de>
Date:   Sun, 21 Feb 2021 14:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1b2652e9-903e-c02f-8393-2775ae60f0b4@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexander,


Am 01.06.20 um 04:48 schrieb Paul Menzel:

[…]

> Am 31.05.20 um 09:22 schrieb Alexander Monakov:
> 
>> Adding Shuah Khan to Cc: I've noticed you've seen this issue on Ryzen 2400GE;
>> can you have a look at the patch? Would be nice to know if it fixes the
>> problem for you too.
> 
>> On Fri, 29 May 2020, Alexander Monakov wrote:
>>
>>> The driver performs an extra check if the IOMMU's capabilities advertise
>>> presence of performance counters: it verifies that counters are writable
>>> by writing a hard-coded value to a counter and testing that reading that
>>> counter gives back the same value.
>>>
>>> Unfortunately it does so quite early, even before pci_enable_device is
>>> called for the IOMMU, i.e. when accessing its MMIO space is not
>>> guaranteed to work. On Ryzen 4500U CPU, this actually breaks the test:
>>> the driver assumes the counters are not writable, and disables the
>>> functionality.
>>>
>>> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
>>> the issue. This is the earliest point in amd_iommu_init_pci where the
>>> call succeeds on my laptop.
>>>
>>> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> Cc: iommu@lists.linux-foundation.org
>>> ---
>>>
>>> PS. I'm seeing another hiccup with IOMMU probing on my system:
>>> pci 0000:00:00.2: can't derive routing for PCI INT A
>>> pci 0000:00:00.2: PCI INT A: not connected
>>>
>>> Hopefully I can figure it out, but I'd appreciate hints.
> 
> I guess it’s a firmware bug, but I contacted the linux-pci folks [1].

Unfortunately, it’s still present in Linux 5.11.

>>>   drivers/iommu/amd_iommu_init.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd_iommu_init.c 
>>> b/drivers/iommu/amd_iommu_init.c
>>> index 5b81fd16f5fa..1b7ec6b6a282 100644
>>> --- a/drivers/iommu/amd_iommu_init.c
>>> +++ b/drivers/iommu/amd_iommu_init.c
>>> @@ -1788,8 +1788,6 @@ static int __init iommu_init_pci(struct 
>>> amd_iommu *iommu)
>>>       if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
>>>           amd_iommu_np_cache = true;
>>> -    init_iommu_perf_ctr(iommu);
>>> -
>>>       if (is_rd890_iommu(iommu->dev)) {
>>>           int i, j;
>>> @@ -1891,8 +1889,10 @@ static int __init amd_iommu_init_pci(void)
>>>       init_device_table_dma();
>>> -    for_each_iommu(iommu)
>>> +    for_each_iommu(iommu) {
>>>           iommu_flush_all_caches(iommu);
>>> +        init_iommu_perf_ctr(iommu);
>>> +    }
>>>       if (!ret)
>>>           print_iommu_info();
>>>
>>> base-commit: 75caf310d16cc5e2f851c048cd597f5437013368
> 
> Thank you very much for fixing this issue, which is almost two years old 
> for me.
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> MSI MSI MS-7A37/B350M MORTAR with AMD Ryzen 3 2200G
> Link: https://lore.kernel.org/linux-iommu/20180727102710.GA6738@8bytes.org/

Just a small note, that I am applying your patch, but it looks like 
there is still some timing issue. At least today, I noticed it during 
one boot with Linux 5.11. (Before I never noticed it again in the 
several years, but I am not always paying attention and do not save the 
logs.)


Kind regards,

Paul


> [1]: https://lore.kernel.org/linux-pci/8579bd14-e369-1141-917b-204d20cff528@molgen.mpg.de/
