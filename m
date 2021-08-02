Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30C33DDD40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHBQJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:09:56 -0400
Received: from foss.arm.com ([217.140.110.172]:38148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhHBQJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:09:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9C311D4;
        Mon,  2 Aug 2021 09:09:45 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976F73F66F;
        Mon,  2 Aug 2021 09:09:42 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be
 flexible
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com,
        mst@redhat.com, airlied@linux.ie, gregkh@linuxfoundation.org,
        linuxarm@huawei.com, jonathanh@nvidia.com,
        iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
        daniel@ffwll.ch, bingbu.cao@intel.com, digetx@gmail.com,
        mchehab@kernel.org, jasowang@redhat.com, tian.shu.qiu@intel.com
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
 <20210802150153.GC28735@willie-the-truck>
 <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <83de3911-145d-77c8-17c1-981e4ff825d3@arm.com>
Date:   Mon, 2 Aug 2021 17:09:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-02 16:23, John Garry wrote:
> On 02/08/2021 16:01, Will Deacon wrote:
>> On Wed, Jul 14, 2021 at 06:36:39PM +0800, John Garry wrote:
>>> Some LLDs may request DMA mappings whose IOVA length exceeds that of the
>>> current rcache upper limit.
>>
>> What's an LLD?
>>
> 
> low-level driver
> 
> maybe I'll stick with simply "drivers"
> 
>>> This means that allocations for those IOVAs will never be cached, and
>>> always must be allocated and freed from the RB tree per DMA mapping 
>>> cycle.
>>> This has a significant effect on performance, more so since commit
>>> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
>>> fails"), as discussed at [0].
>>>
>>> As a first step towards allowing the rcache range upper limit be
>>> configured, hold this value in the IOVA rcache structure, and allocate
>>> the rcaches separately.
>>>
>>> [0] 
>>> https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/ 
>>>
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/iommu/dma-iommu.c |  2 +-
>>>   drivers/iommu/iova.c      | 23 +++++++++++++++++------
>>>   include/linux/iova.h      |  4 ++--
>>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 98ba927aee1a..4772278aa5da 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -434,7 +434,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct 
>>> iommu_domain *domain,
>>>        * rounding up anything cacheable to make sure that can't 
>>> happen. The
>>>        * order of the unadjusted size will still match upon freeing.
>>>        */
>>> -    if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>>> +    if (iova_len < (1 << (iovad->rcache_max_size - 1)))
>>>           iova_len = roundup_pow_of_two(iova_len);
>>>       dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index b6cf5f16123b..07ce73fdd8c1 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -15,6 +15,8 @@
>>>   /* The anchor node sits above the top of the usable address space */
>>>   #define IOVA_ANCHOR    ~0UL
>>> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA 
>>> range size (in pages) */
>>
>> Is that the same as an 'order'? i.e. IOVA_RANGE_CACHE_MAX_ORDER?
> 
> Yeah, that may be better. I was just using the same name as before.
> 
>>
>>> +
>>>   static bool iova_rcache_insert(struct iova_domain *iovad,
>>>                      unsigned long pfn,
>>>                      unsigned long size);
>>> @@ -881,7 +883,14 @@ static void init_iova_rcaches(struct iova_domain 
>>> *iovad)
>>>       unsigned int cpu;
>>>       int i;
>>> -    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>> +    iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
>>> +
>>> +    iovad->rcaches = kcalloc(iovad->rcache_max_size,
>>> +                 sizeof(*iovad->rcaches), GFP_KERNEL);
>>> +    if (!iovad->rcaches)
>>> +        return;
>>
>> Returning quietly here doesn't seem like the right thing to do. At 
>> least, I
>> don't think the rest of the functions here are checking rcaches against
>> NULL.
>>
> 
> For sure, but that is what other code which can fail here already does, 
> like:
> 
> static void init_iova_rcaches(struct iova_domain *iovad)
> {
>      ...
> 
>      for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>          ...
> 
>          rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), 
> cache_line_size());
>          if (WARN_ON(!rcache->cpu_rcaches))
>              continue;
> }
> 
> and that is not safe either.

Yeah, along with flush queues, historically this has all been 
super-dodgy in terms of failure handling (or lack of).

> This issue was raised a while ago. I don't mind trying to fix it - a 
> slightly painful part is that it touches a few subsystems.

Maybe pull the rcache init out of iova_domain_init() entirely? Only 
iommu-dma uses {alloc,free}_iova_fast(), so TBH it's only a great big 
waste of memory for all the other IOVA domain users anyway.

The other week I started pondering how much of iommu-dma only needs to 
be exposed to the IOMMU core rather than the whole kernel now; I suppose 
there's probably an equal argument to be made for some of these bits of 
the IOVA API, and this might pave the way towards some more logical 
separation, but let's get the functional side dealt with before we worry 
too much about splitting headers.

Robin.
