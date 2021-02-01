Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E530A6C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhBALpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:45:24 -0500
Received: from foss.arm.com ([217.140.110.172]:57226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBALpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:45:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0929B1042;
        Mon,  1 Feb 2021 03:44:37 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2373F718;
        Mon,  1 Feb 2021 03:44:35 -0800 (PST)
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU
 register space
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-4-thunder.leizhen@huawei.com>
 <fa170300-57d9-3883-c70f-d455a9e461f0@arm.com>
 <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cd174cbf-e006-c7be-a707-d7973a26ed31@arm.com>
Date:   Mon, 1 Feb 2021 11:44:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-30 01:54, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/1/29 23:27, Robin Murphy wrote:
>> On 2021-01-27 11:32, Zhen Lei wrote:
>>> commit 52f3fab0067d ("iommu/arm-smmu-v3: Don't reserve implementation
>>> defined register space") only reserves the basic SMMU register space. So
>>> the ECMDQ register space is not covered, it should be mapped again. Due
>>> to the size of this ECMDQ resource is not fixed, depending on
>>> SMMU_IDR6.CMDQ_CONTROL_PAGE_LOG2NUMQ. Processing its resource reservation
>>> to avoid resource conflict with PMCG is a bit more complicated.
>>>
>>> Therefore, the resources of the PMCG are not reserved, and the entire SMMU
>>> resources are reserved.
>>
>> This is the opposite of what I suggested. My point was that it will make the most sense to map the ECMDQ pages as a separate request anyway, therefore there is no reason to stop mapping page 0 and page 1 separately either.
> 
> I don't understand why the ECMDQ mapping must be performed separately. If the conflict with PMCG resources is eliminated. ECMDQ cannot be a separate driver like PMCG.

I mean in terms of the basic practice of not mapping megabytes worth of 
IMP-DEF crap that this driver doesn't need or even understand. If we 
don't have ECMDQ, we definitely don't need anything beyond page 1, so 
there's no point mapping it all, and indeed it's safest not to anyway. 
Even if we do have ECMDQ, it's still safer not to map all the unknown 
stuff that may be in between, and until we've mapped page 0 we don't 
know whether we have ECMDQ or not.

Therefore the most sensible thing to do either way is to map the basic 
page(s) first, then map the ECMDQ pages specifically if we determine 
that we need to. And either way we don't even need to think about this 
until adding ECMDQ support.

Robin.

>> If we need to expand the page 0 mapping to cover more of page 0 to reach the SMMU_CMDQ_CONTROL_PAGE_* registers, we can do that when we actually add ECMDQ support.
>>
>> Robin.
>>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++--------------------
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
>>>    2 files changed, 4 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index f04c55a7503c790..fde24403b06a9e3 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -3476,14 +3476,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>>>        return err;
>>>    }
>>>    -static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>>> -                      resource_size_t size)
>>> -{
>>> -    struct resource res = DEFINE_RES_MEM(start, size);
>>> -
>>> -    return devm_ioremap_resource(dev, &res);
>>> -}
>>> -
>>>    static int arm_smmu_device_probe(struct platform_device *pdev)
>>>    {
>>>        int irq, ret;
>>> @@ -3519,22 +3511,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>        }
>>>        ioaddr = res->start;
>>>    -    /*
>>> -     * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
>>> -     * the PMCG registers which are reserved by the PMU driver.
>>> -     */
>>> -    smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
>>> +    smmu->base = devm_ioremap_resource(dev, res);
>>>        if (IS_ERR(smmu->base))
>>>            return PTR_ERR(smmu->base);
>>>    -    if (arm_smmu_resource_size(smmu) > SZ_64K) {
>>> -        smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
>>> -                           ARM_SMMU_REG_SZ);
>>> -        if (IS_ERR(smmu->page1))
>>> -            return PTR_ERR(smmu->page1);
>>> -    } else {
>>> +    if (arm_smmu_resource_size(smmu) > SZ_64K)
>>> +        smmu->page1 = smmu->base + SZ_64K;
>>> +    else
>>>            smmu->page1 = smmu->base;
>>> -    }
>>>          /* Interrupt lines */
>>>    diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> index da525f46dab4fc1..63f2b476987d6ae 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> @@ -152,8 +152,6 @@
>>>    #define ARM_SMMU_PRIQ_IRQ_CFG1        0xd8
>>>    #define ARM_SMMU_PRIQ_IRQ_CFG2        0xdc
>>>    -#define ARM_SMMU_REG_SZ            0xe00
>>> -
>>>    /* Common MSI config fields */
>>>    #define MSI_CFG0_ADDR_MASK        GENMASK_ULL(51, 2)
>>>    #define MSI_CFG2_SH            GENMASK(5, 4)
>>>
>>
>> .
>>
> 
