Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0237736039A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhDOHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:43:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:43:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLWTj2pXpzpYNv;
        Thu, 15 Apr 2021 15:40:25 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 15:43:09 +0800
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
 <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
 <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
Date:   Thu, 15 Apr 2021 15:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/15 15:03, Lu Baolu wrote:
> On 4/15/21 2:18 PM, Keqian Zhu wrote:
>> Hi Baolu,
>>
>> Thanks for the review!
>>
>> On 2021/4/14 15:00, Lu Baolu wrote:
>>> Hi Keqian,
>>>
>>> On 4/13/21 4:54 PM, Keqian Zhu wrote:
>>>> Some types of IOMMU are capable of tracking DMA dirty log, such as
>>>> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
>>>> dirty log tracking framework in the IOMMU base layer.
>>>>
>>>> Three new essential interfaces are added, and we maintaince the status
>>>> of dirty log tracking in iommu_domain.
>>>> 1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
>>>> 2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
>>>> 3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>>>>
>>>> A new dev feature are added to indicate whether a specific type of
>>>> iommu hardware supports and its driver realizes them.
>>>>
>>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 150 ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/iommu.h |  53 +++++++++++++++
>>>>    2 files changed, 203 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index d0b0a15dba84..667b2d6d2fc0 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -1922,6 +1922,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>>        domain->type = type;
>>>>        /* Assume all sizes by default; the driver may override this later */
>>>>        domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>>> +    mutex_init(&domain->switch_log_lock);
>>>>          return domain;
>>>>    }
>>>> @@ -2720,6 +2721,155 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>>>>    +int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
>>>> +               unsigned long iova, size_t size, int prot)
>>>> +{
>>>> +    const struct iommu_ops *ops = domain->ops;
>>>> +    int ret;
>>>> +
>>>> +    if (unlikely(!ops || !ops->switch_dirty_log))
>>>> +        return -ENODEV;
>>>> +
>>>> +    mutex_lock(&domain->switch_log_lock);
>>>> +    if (enable && domain->dirty_log_tracking) {
>>>> +        ret = -EBUSY;
>>>> +        goto out;
>>>> +    } else if (!enable && !domain->dirty_log_tracking) {
>>>> +        ret = -EINVAL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    ret = ops->switch_dirty_log(domain, enable, iova, size, prot);
>>>> +    if (ret)
>>>> +        goto out;
>>>> +
>>>> +    domain->dirty_log_tracking = enable;
>>>> +out:
>>>> +    mutex_unlock(&domain->switch_log_lock);
>>>> +    return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_switch_dirty_log);
>>>
>>> Since you also added IOMMU_DEV_FEAT_HWDBM, I am wondering what's the
>>> difference between
>>>
>>> iommu_switch_dirty_log(on) vs. iommu_dev_enable_feature(IOMMU_DEV_FEAT_HWDBM)
>>>
>>> iommu_switch_dirty_log(off) vs. iommu_dev_disable_feature(IOMMU_DEV_FEAT_HWDBM)
>> Indeed. As I can see, IOMMU_DEV_FEAT_AUX is not switchable, so enable/disable
>> are not applicable for it. IOMMU_DEV_FEAT_SVA is switchable, so we can use these
>> interfaces for it.
>>
>> IOMMU_DEV_FEAT_HWDBM is used to indicate whether hardware supports HWDBM, so we should
> 
> Previously we had iommu_dev_has_feature() and then was cleaned up due to
> lack of real users. If you have a real case for it, why not bringing it
> back?
Yep, good suggestion.

> 
>> design it as not switchable. I will modify the commit message of patch#12, thanks!
> 
> I am not sure that I fully get your point. But I can't see any gaps of
> using iommu_dev_enable/disable_feature() to switch dirty log on and off.
> Probably I missed anything.
IOMMU_DEV_FEAT_HWDBM just tells user whether underlying IOMMU driver supports
dirty tracking, it is not used to management the status of dirty log tracking.

The feature reporting is per device, but the status management is per iommu_domain.
Only when all devices in a domain support HWDBM, we can start dirty log for the domain.

And I think we'd better not mix the feature reporting and status management. Thoughts?

> 
>>
>>>
>>>> +
>>>> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
>>>> +             size_t size, unsigned long *bitmap,
>>>> +             unsigned long base_iova, unsigned long bitmap_pgshift)
>>>> +{
>>>> +    const struct iommu_ops *ops = domain->ops;
>>>> +    unsigned int min_pagesz;
>>>> +    size_t pgsize;
>>>> +    int ret = 0;
>>>> +
>>>> +    if (unlikely(!ops || !ops->sync_dirty_log))
>>>> +        return -ENODEV;
>>>> +
>>>> +    min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>>>> +    if (!IS_ALIGNED(iova | size, min_pagesz)) {
>>>> +        pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
>>>> +               iova, size, min_pagesz);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    mutex_lock(&domain->switch_log_lock);
>>>> +    if (!domain->dirty_log_tracking) {
>>>> +        ret = -EINVAL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    while (size) {
>>>> +        pgsize = iommu_pgsize(domain, iova, size);
>>>> +
>>>> +        ret = ops->sync_dirty_log(domain, iova, pgsize,
>>>> +                      bitmap, base_iova, bitmap_pgshift);
>>>
>>> Any reason why do you want to do this in a per-4K page manner? This can
>>> lead to a lot of indirect calls and bad performance.
>>>
>>> How about a sync_dirty_pages()?
>> The function name of iommu_pgsize() is a bit puzzling. Actually it will try to
>> compute the max size that fit into size, so the pgsize can be a large page size
>> even if the underlying mapping is 4K. The __iommu_unmap() also has a similar logic.
> 
> This series has some improvement on the iommu_pgsize() helper.
> 
> https://lore.kernel.org/linux-iommu/20210405191112.28192-1-isaacm@codeaurora.org/
OK, I get your idea. I will look into that, thanks!

BRs,
Keqian
