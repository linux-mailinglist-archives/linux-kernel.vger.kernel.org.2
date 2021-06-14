Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C993A6D05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhFNRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:21:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234137AbhFNRVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8101F11D4;
        Mon, 14 Jun 2021 10:19:36 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07B363F70D;
        Mon, 14 Jun 2021 10:19:34 -0700 (PDT)
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
 <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
Date:   Mon, 14 Jun 2021 18:19:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 18:03, John Garry wrote:
> On 14/06/2021 17:25, Robin Murphy wrote:
>> On 2021-06-11 13:20, John Garry wrote:
>>> We only ever now set strict mode enabled in iommu_set_dma_strict(), so
>>> just remove the argument.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/iommu/amd/init.c    | 2 +-
>>>   drivers/iommu/intel/iommu.c | 6 +++---
>>>   drivers/iommu/iommu.c       | 5 ++---
>>>   include/linux/iommu.h       | 2 +-
>>>   4 files changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>>> index 0e6ae6d68f14..27e9677ec303 100644
>>> --- a/drivers/iommu/amd/init.c
>>> +++ b/drivers/iommu/amd/init.c
>>> @@ -3098,7 +3098,7 @@ static int __init parse_amd_iommu_options(char 
>>> *str)
>>>   {
>>>       for (; *str; ++str) {
>>>           if (strncmp(str, "fullflush", 9) == 0)
>>> -            iommu_set_dma_strict(true);
>>> +            iommu_set_dma_strict();
>>>           if (strncmp(str, "force_enable", 12) == 0)
>>>               amd_iommu_force_enable = true;
>>>           if (strncmp(str, "off", 3) == 0)
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 6763e516362c..e77b8b6e7838 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -452,7 +452,7 @@ static int __init intel_iommu_setup(char *str)
>>>               pr_warn("intel_iommu=forcedac deprecated; use 
>>> iommu.forcedac instead\n");
>>>               iommu_dma_forcedac = true;
>>>           } else if (!strncmp(str, "strict", 6)) {
>>> -            iommu_set_dma_strict(true);
>>> +            iommu_set_dma_strict();
>>>           } else if (!strncmp(str, "sp_off", 6)) {
>>>               pr_info("Disable supported super page\n");
>>>               intel_iommu_superpage = 0;
>>> @@ -4392,7 +4392,7 @@ int __init intel_iommu_init(void)
>>>            */
>>>           if (cap_caching_mode(iommu->cap)) {
>>>               pr_warn("IOMMU batching disallowed due to 
>>> virtualization\n");
>>> -            iommu_set_dma_strict(true);
>>> +            iommu_set_dma_strict();
>>>           }
>>>           iommu_device_sysfs_add(&iommu->iommu, NULL,
>>>                          intel_iommu_groups,
>>> @@ -5663,7 +5663,7 @@ static void quirk_calpella_no_shadow_gtt(struct 
>>> pci_dev *dev)
>>>       } else if (dmar_map_gfx) {
>>>           /* we have to ensure the gfx device is idle before we flush */
>>>           pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
>>> -        iommu_set_dma_strict(true);
>>> +        iommu_set_dma_strict();
>>>       }
>>>   }
>>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, 
>>> quirk_calpella_no_shadow_gtt);
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index ccbd5d4c1a50..146cb71c7441 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -350,10 +350,9 @@ static int __init iommu_dma_setup(char *str)
>>>   }
>>>   early_param("iommu.strict", iommu_dma_setup);
>>> -void iommu_set_dma_strict(bool strict)
>>> +void iommu_set_dma_strict(void)
>>>   {
>>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>
>> We shouldn't need to keep IOMMU_CMD_LINE_STRICT at all now, since it 
>> was only to prevent a driver's "default lazy" setting passed in here 
>> from downgrading an explicitly-set strict mode.
>>
>> With that cleaned up too,
>>
> 
> Patch 1/5 mentions whether the invalidation policy comes from the 
> cmdline - similar to the default domain type print - so I was going to 
> keep that.

Oh, silly me, I'd forgotten that already and was just looking at my 
local tree... Let's keep it for consistency with how we report the 
domain type then.

> And then maybe we should also set it from the deprecated x86 
> driver-specific params.

I don't think it's worth exporting more low-level guts to allow that to 
happen - tying in to iommu_set_dma_strict() would be too late, as 
before. I think the separate pr_warn()s which announce the relevant 
parameter is deprecated (but has still taken effect) should be enough.

Cheers,
Robin.
