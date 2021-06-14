Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1D3A6CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhFNRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:11:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3240 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhFNRLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:11:13 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3czB2N7wz6H7db;
        Tue, 15 Jun 2021 00:56:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 19:09:08 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 18:09:07 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
Date:   Mon, 14 Jun 2021 18:03:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2021 17:25, Robin Murphy wrote:
> On 2021-06-11 13:20, John Garry wrote:
>> We only ever now set strict mode enabled in iommu_set_dma_strict(), so
>> just remove the argument.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/amd/init.c    | 2 +-
>>   drivers/iommu/intel/iommu.c | 6 +++---
>>   drivers/iommu/iommu.c       | 5 ++---
>>   include/linux/iommu.h       | 2 +-
>>   4 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 0e6ae6d68f14..27e9677ec303 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -3098,7 +3098,7 @@ static int __init parse_amd_iommu_options(char 
>> *str)
>>   {
>>       for (; *str; ++str) {
>>           if (strncmp(str, "fullflush", 9) == 0)
>> -            iommu_set_dma_strict(true);
>> +            iommu_set_dma_strict();
>>           if (strncmp(str, "force_enable", 12) == 0)
>>               amd_iommu_force_enable = true;
>>           if (strncmp(str, "off", 3) == 0)
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 6763e516362c..e77b8b6e7838 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -452,7 +452,7 @@ static int __init intel_iommu_setup(char *str)
>>               pr_warn("intel_iommu=forcedac deprecated; use 
>> iommu.forcedac instead\n");
>>               iommu_dma_forcedac = true;
>>           } else if (!strncmp(str, "strict", 6)) {
>> -            iommu_set_dma_strict(true);
>> +            iommu_set_dma_strict();
>>           } else if (!strncmp(str, "sp_off", 6)) {
>>               pr_info("Disable supported super page\n");
>>               intel_iommu_superpage = 0;
>> @@ -4392,7 +4392,7 @@ int __init intel_iommu_init(void)
>>            */
>>           if (cap_caching_mode(iommu->cap)) {
>>               pr_warn("IOMMU batching disallowed due to 
>> virtualization\n");
>> -            iommu_set_dma_strict(true);
>> +            iommu_set_dma_strict();
>>           }
>>           iommu_device_sysfs_add(&iommu->iommu, NULL,
>>                          intel_iommu_groups,
>> @@ -5663,7 +5663,7 @@ static void quirk_calpella_no_shadow_gtt(struct 
>> pci_dev *dev)
>>       } else if (dmar_map_gfx) {
>>           /* we have to ensure the gfx device is idle before we flush */
>>           pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
>> -        iommu_set_dma_strict(true);
>> +        iommu_set_dma_strict();
>>       }
>>   }
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, 
>> quirk_calpella_no_shadow_gtt);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ccbd5d4c1a50..146cb71c7441 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -350,10 +350,9 @@ static int __init iommu_dma_setup(char *str)
>>   }
>>   early_param("iommu.strict", iommu_dma_setup);
>> -void iommu_set_dma_strict(bool strict)
>> +void iommu_set_dma_strict(void)
>>   {
>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> 
> We shouldn't need to keep IOMMU_CMD_LINE_STRICT at all now, since it was 
> only to prevent a driver's "default lazy" setting passed in here from 
> downgrading an explicitly-set strict mode.
> 
> With that cleaned up too,
> 

Patch 1/5 mentions whether the invalidation policy comes from the 
cmdline - similar to the default domain type print - so I was going to 
keep that.

And then maybe we should also set it from the deprecated x86 
driver-specific params.

But if you think that there is not much value in this additional info, 
then I can just drop it.

Cheers,
John
