Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2884358A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 04:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhJUC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 22:28:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:42356 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhJUC24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 22:28:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="209028655"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="209028655"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 19:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="483985485"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2021 19:26:37 -0700
Cc:     baolu.lu@linux.intel.com, Sven Peter <sven@svenpeter.dev>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
To:     Marc Zyngier <maz@kernel.org>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
 <8735ovdbcv.wl-maz@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6a886030-cbc6-9e92-bf79-77b659da2915@linux.intel.com>
Date:   Thu, 21 Oct 2021 10:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8735ovdbcv.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 10:22 PM, Marc Zyngier wrote:
> On Wed, 20 Oct 2021 06:21:44 +0100,
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>>> The iova allocator is capable of handling any granularity which is a power
>>> of two. Remove the much stronger condition that the granularity must be
>>> smaller or equal to the CPU page size from a BUG_ON there.
>>> Instead, check this condition during __iommu_attach_device and fail
>>> gracefully.
>>>
>>> Signed-off-by: Sven Peter<sven@svenpeter.dev>
>>> ---
>>>    drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
>>>    drivers/iommu/iova.c  |  7 ++++---
>>>    include/linux/iommu.h |  5 +++++
>>>    3 files changed, 41 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index dd7863e453a5..28896739964b 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -80,6 +80,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>    						 unsigned type);
>>>    static int __iommu_attach_device(struct iommu_domain *domain,
>>>    				 struct device *dev);
>>> +static void __iommu_detach_device(struct iommu_domain *domain,
>>> +				  struct device *dev);
>>>    static int __iommu_attach_group(struct iommu_domain *domain,
>>>    				struct iommu_group *group);
>>>    static void __iommu_detach_group(struct iommu_domain *domain,
>>> @@ -1974,6 +1976,19 @@ void iommu_domain_free(struct iommu_domain *domain)
>>>    }
>>>    EXPORT_SYMBOL_GPL(iommu_domain_free);
>>>    +static int iommu_check_page_size(struct iommu_domain *domain)
>>> +{
>>> +	if (!iommu_is_paging_domain(domain))
>>> +		return 0;
>>> +
>>> +	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
>>> +		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
>>> +		return -EFAULT;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static int __iommu_attach_device(struct iommu_domain *domain,
>>>    				 struct device *dev)
>>>    {
>>> @@ -1983,9 +1998,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>>    		return -ENODEV;
>>>      	ret = domain->ops->attach_dev(domain, dev);
>>> -	if (!ret)
>>> -		trace_attach_device_to_domain(dev);
>>> -	return ret;
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>>> +	 * only limit domain->pgsize_bitmap after having attached the first
>>> +	 * device.
>>> +	 */
>>> +	ret = iommu_check_page_size(domain);
>>> +	if (ret) {
>>> +		__iommu_detach_device(domain, dev);
>>> +		return ret;
>>> +	}
>>
>> It looks odd. __iommu_attach_device() attaches an I/O page table for a
>> device. How does it relate to CPU pages? Why is it a failure case if CPU
>> page size is not covered?
> 
> If you allocate a CPU PAGE_SIZE'd region, and point it at a device
> that now can DMA to more than what you have allocated because the
> IOMMU's own page size is larger, the device has now access to data it
> shouldn't see. In my book, that's a pretty bad thing.

But even you enforce the CPU page size check here, this problem still
exists unless all DMA buffers are PAGE_SIZE aligned and sized, right?

Best regards,
baolu
