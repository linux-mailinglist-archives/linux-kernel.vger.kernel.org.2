Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3157378BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhEJMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:16:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2672 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhEJLIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:08:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdyrG4tK6z1BKRQ;
        Mon, 10 May 2021 19:05:02 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 19:07:34 +0800
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking
 framework
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
 <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
Date:   Mon, 10 May 2021 19:07:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 2021/5/10 9:08, Lu Baolu wrote:
> Hi Keqian,
> 
> On 5/8/21 3:35 PM, Keqian Zhu wrote:
>> Hi Baolu,
>>
>> On 2021/5/8 11:46, Lu Baolu wrote:
>>> Hi Keqian,
>>>
>>> On 5/7/21 6:21 PM, Keqian Zhu wrote:
>>>> Some types of IOMMU are capable of tracking DMA dirty log, such as
>>>> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
>>>> dirty log tracking framework in the IOMMU base layer.
>>>>
>>>> Four new essential interfaces are added, and we maintaince the status
>>>> of dirty log tracking in iommu_domain.
>>>> 1. iommu_support_dirty_log: Check whether domain supports dirty log tracking
>>>> 2. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
>>>> 3. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
>>>> 4. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>>>>
>>>> Note: Don't concurrently call these interfaces with other ops that
>>>> access underlying page table.
>>>>
>>>> Signed-off-by: Keqian Zhu<zhukeqian1@huawei.com>
>>>> Signed-off-by: Kunkun Jiang<jiangkunkun@huawei.com>
>>>> ---
>>>>    drivers/iommu/iommu.c        | 201 +++++++++++++++++++++++++++++++++++
>>>>    include/linux/iommu.h        |  63 +++++++++++
>>>>    include/trace/events/iommu.h |  63 +++++++++++
>>>>    3 files changed, 327 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 808ab70d5df5..0d15620d1e90 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -1940,6 +1940,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>>        domain->type = type;
>>>>        /* Assume all sizes by default; the driver may override this later */
>>>>        domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>>> +    mutex_init(&domain->switch_log_lock);
>>>>          return domain;
>>>>    }
>>>> @@ -2703,6 +2704,206 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
>>>>    +bool iommu_support_dirty_log(struct iommu_domain *domain)
>>>> +{
>>>> +    const struct iommu_ops *ops = domain->ops;
>>>> +
>>>> +    return ops->support_dirty_log && ops->support_dirty_log(domain);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_support_dirty_log);
>>> I suppose this interface is to ask the vendor IOMMU driver to check
>>> whether each device/iommu in the domain supports dirty bit tracking.
>>> But what will happen if new devices with different tracking capability
>>> are added afterward?
>> Yep, this is considered in the vfio part. We will query again after attaching or
>> detaching devices from the domain.  When the domain becomes capable, we enable
>> dirty log for it. When it becomes not capable, we disable dirty log for it.
> 
> If that's the case, why not putting this logic in the iommu subsystem so
> that it doesn't need to be duplicate in different upper layers?
> 
> For example, add something like dirty_page_trackable in the struct of
> iommu_domain and ask the vendor iommu driver to update it once any
> device is added/removed to/from the domain. It's also better to disallow
If we do it, the upper layer still needs to query the capability from domain and switch
dirty log tracking for it. Or do you mean the domain can switch dirty log tracking automatically
when its capability change? If so, I think we're lack of some flexibility. The upper layer
may have it's own policy, such as only enable dirty log tracking when all domains are capable,
and disable dirty log tracking when just one domain is not capable.

> any domain attach/detach once the dirty page tracking is on.
Yep, this can greatly simplify our code logic, but I don't know whether our maintainers
agree that, as they may think that IOMMU dirty logging should not change original domain
behaviors.


Thanks,
Keqian
