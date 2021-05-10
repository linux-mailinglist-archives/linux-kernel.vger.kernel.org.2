Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FD37799E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEJBKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:10:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:48517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhEJBKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:10:53 -0400
IronPort-SDR: Dd13cNik9vFSJMUdeTbgShLyo57BQaZm+y8dPifexY+f9gDiMsbw7AoBg6LmUOcme6eCDUMcpf
 tZ62jJPRqsNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="220024021"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="220024021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 18:09:47 -0700
IronPort-SDR: ZBtY8N/+MVvY5N4tMR5NoQUFqfIMbL4Q9bmxKKMYewPvlWIWbS0mwXSF89kXVmnusuD1rH4tZb
 DuvHUsGfIQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="621024331"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 09 May 2021 18:09:43 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking
 framework
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
Date:   Mon, 10 May 2021 09:08:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 5/8/21 3:35 PM, Keqian Zhu wrote:
> Hi Baolu,
> 
> On 2021/5/8 11:46, Lu Baolu wrote:
>> Hi Keqian,
>>
>> On 5/7/21 6:21 PM, Keqian Zhu wrote:
>>> Some types of IOMMU are capable of tracking DMA dirty log, such as
>>> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
>>> dirty log tracking framework in the IOMMU base layer.
>>>
>>> Four new essential interfaces are added, and we maintaince the status
>>> of dirty log tracking in iommu_domain.
>>> 1. iommu_support_dirty_log: Check whether domain supports dirty log tracking
>>> 2. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
>>> 3. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
>>> 4. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>>>
>>> Note: Don't concurrently call these interfaces with other ops that
>>> access underlying page table.
>>>
>>> Signed-off-by: Keqian Zhu<zhukeqian1@huawei.com>
>>> Signed-off-by: Kunkun Jiang<jiangkunkun@huawei.com>
>>> ---
>>>    drivers/iommu/iommu.c        | 201 +++++++++++++++++++++++++++++++++++
>>>    include/linux/iommu.h        |  63 +++++++++++
>>>    include/trace/events/iommu.h |  63 +++++++++++
>>>    3 files changed, 327 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 808ab70d5df5..0d15620d1e90 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1940,6 +1940,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>        domain->type = type;
>>>        /* Assume all sizes by default; the driver may override this later */
>>>        domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>> +    mutex_init(&domain->switch_log_lock);
>>>          return domain;
>>>    }
>>> @@ -2703,6 +2704,206 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>>>    }
>>>    EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
>>>    +bool iommu_support_dirty_log(struct iommu_domain *domain)
>>> +{
>>> +    const struct iommu_ops *ops = domain->ops;
>>> +
>>> +    return ops->support_dirty_log && ops->support_dirty_log(domain);
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_support_dirty_log);
>> I suppose this interface is to ask the vendor IOMMU driver to check
>> whether each device/iommu in the domain supports dirty bit tracking.
>> But what will happen if new devices with different tracking capability
>> are added afterward?
> Yep, this is considered in the vfio part. We will query again after attaching or
> detaching devices from the domain.  When the domain becomes capable, we enable
> dirty log for it. When it becomes not capable, we disable dirty log for it.

If that's the case, why not putting this logic in the iommu subsystem so
that it doesn't need to be duplicate in different upper layers?

For example, add something like dirty_page_trackable in the struct of
iommu_domain and ask the vendor iommu driver to update it once any
device is added/removed to/from the domain. It's also better to disallow
any domain attach/detach once the dirty page tracking is on.

> 
>> To make things simple, is it possible to support this tracking only when
>> all underlying IOMMUs support dirty bit tracking?
> IIUC, all underlying IOMMUs you refer is of system wide. I think this idea may has
> two issues. 1) The target domain may just contains part of system IOMMUs. 2) The
> dirty tracking capability can be related to the capability of devices. For example,
> we can track dirty log based on IOPF, which needs the capability of devices. That's
> to say, we can make this framework more common.

Yes. Fair enough. Thanks for sharing.

> 
>> Or, the more crazy idea is that we don't need to check this capability
>> at all. If dirty bit tracking is not supported by hardware, just mark
>> all pages dirty?
> Yeah, I think this idea is nice:).
> 
> Still one concern is that we may have other dirty tracking methods in the future,
> if we can't track dirty through iommu, we can still try other methods.
> 
> If there is no interface to check this capability, we have no chance to try
> other methods. What do you think?
> 

Agreed.

Best regards,
baolu
