Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDD3AE8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFUMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:17:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3294 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFUMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:17:32 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7pFW27Qbz6FBVY;
        Mon, 21 Jun 2021 20:07:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 14:15:17 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 13:15:16 +0100
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        <nadav.amit@gmail.com>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <aaec67ab-0bb9-3c15-de81-97b92918c5c5@huawei.com>
Date:   Mon, 21 Jun 2021 13:08:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 12:59, Robin Murphy wrote:

+ Nadav

>> On a personal level I would be happy with that approach, but I think
>> it's better to not start changing things right away in a follow-up series.
>>
>> So how about we add this patch (which replaces 6/6 "iommu: Remove mode
>> argument from iommu_set_dma_strict()")?
>>
>> Robin, any opinion?
> For me it boils down to whether there are any realistic workloads where
> non-strict mode*would*  still perform better under virtualisation. The
> only reason for the user to explicitly pass "iommu.strict=0" is because
> they expect it to increase unmap performance; if it's only ever going to
> lead to an unexpected performance loss, I don't see any value in
> overriding the kernel's decision purely for the sake of subservience.
> 
> If there*are*  certain valid cases for allowing it for people who really
> know what they're doing, then we should arguably also log a counterpart
> message to say "we're honouring your override but beware it may have the
> opposite effect to what you expect" for the benefit of other users who
> assume it's a generic go-faster knob. At that point it starts getting
> non-trivial enough that I'd want to know for sure it's worthwhile.
> 
> The other reason this might be better to revisit later is that an AMD
> equivalent is still in flight[1], and there might be more that can
> eventually be factored out. I think both series are pretty much good to
> merge for 5.14, but time's already tight to sort out the conflicts which
> exist as-is, without making them any worse.

ok, fine. Can revisit.

As for getting these merged, I'll dry-run merging both of those series 
to see the conflicts. It doesn't look too problematic from a glance.

Cheers,
John

> 
> Robin.
> 
> [1]
> https://lore.kernel.org/linux-iommu/20210616100500.174507-3-namit@vmware.com/
> 
>> ------->8---------
>>
>> [PATCH] iommu/vt-d: Make "iommu.strict" override batching due to
>>    virtualization
>>
>> As a change in policy, make iommu.strict cmdline argument override
>> whether we disable batching due to virtualization.
>>
>> The API of iommu_set_dma_strict() is changed to accept a "force"
>> argument, which means that we always set iommu_dma_strict true,
>> regardless of whether we already set via cmdline. Also return a boolean,
>> to tell whether iommu_dma_strict was set or not.
>>
>> Note that in all pre-existing callsites of iommu_set_dma_strict(),
>> argument strict was true, so this argument is dropped.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 06666f9d8116..e8d65239b359 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4380,10 +4380,8 @@ int __init intel_iommu_init(void)
>>             * is likely to be much lower than the overhead of synchronizing
>>             * the virtual and physical IOMMU page-tables.
>>             */
>> -        if (cap_caching_mode(iommu->cap)) {
>> +        if (cap_caching_mode(iommu->cap) && iommu_set_dma_strict(false))
>>                pr_info_once("IOMMU batching disallowed due to
>> virtualization\n");
>> -            iommu_set_dma_strict(true);
>> -        }
>>            iommu_device_sysfs_add(&iommu->iommu, NULL,
>>                           intel_iommu_groups,
>>                           "%s", iommu->name);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 60b1ec42e73b..1434bee64af3 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -349,10 +349,14 @@ static int __init iommu_dma_setup(char *str)
>>    }
>>    early_param("iommu.strict", iommu_dma_setup);
>>
>> -void iommu_set_dma_strict(bool strict)
>> +/* Return true if we set iommu_dma_strict */
>> +bool iommu_set_dma_strict(bool force)
>>    {
>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>> -        iommu_dma_strict = strict;
>> +    if (force || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT)) {
>> +        iommu_dma_strict = true;
>> +        return true;
>> +    }
>> +    return false;
>>    }
>>
>>    bool iommu_get_dma_strict(struct iommu_domain *domain)
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 32d448050bf7..f17b20234296 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
>>    int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>>            unsigned long quirks);
>>
>> -void iommu_set_dma_strict(bool val);
>> +bool iommu_set_dma_strict(bool force);
>>    bool iommu_get_dma_strict(struct iommu_domain *domain);
>>
>>    extern int report_iommu_fault(struct iommu_domain *domain, struct
>> device *dev,

