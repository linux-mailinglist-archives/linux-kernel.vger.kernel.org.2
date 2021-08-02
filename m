Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF50D3DDC4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhHBPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:23:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3554 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhHBPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:23:40 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdhbZ25Vcz6FFxN;
        Mon,  2 Aug 2021 23:23:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:23:29 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:23:28 +0100
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be
 flexible
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <jonathanh@nvidia.com>,
        <sakari.ailus@linux.intel.com>, <bingbu.cao@intel.com>,
        <tian.shu.qiu@intel.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <digetx@gmail.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
 <20210802150153.GC28735@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
Date:   Mon, 2 Aug 2021 16:23:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210802150153.GC28735@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2021 16:01, Will Deacon wrote:
> On Wed, Jul 14, 2021 at 06:36:39PM +0800, John Garry wrote:
>> Some LLDs may request DMA mappings whose IOVA length exceeds that of the
>> current rcache upper limit.
> 
> What's an LLD?
> 

low-level driver

maybe I'll stick with simply "drivers"

>> This means that allocations for those IOVAs will never be cached, and
>> always must be allocated and freed from the RB tree per DMA mapping cycle.
>> This has a significant effect on performance, more so since commit
>> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
>> fails"), as discussed at [0].
>>
>> As a first step towards allowing the rcache range upper limit be
>> configured, hold this value in the IOVA rcache structure, and allocate
>> the rcaches separately.
>>
>> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c |  2 +-
>>   drivers/iommu/iova.c      | 23 +++++++++++++++++------
>>   include/linux/iova.h      |  4 ++--
>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 98ba927aee1a..4772278aa5da 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -434,7 +434,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>   	 * rounding up anything cacheable to make sure that can't happen. The
>>   	 * order of the unadjusted size will still match upon freeing.
>>   	 */
>> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>> +	if (iova_len < (1 << (iovad->rcache_max_size - 1)))
>>   		iova_len = roundup_pow_of_two(iova_len);
>>   
>>   	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index b6cf5f16123b..07ce73fdd8c1 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -15,6 +15,8 @@
>>   /* The anchor node sits above the top of the usable address space */
>>   #define IOVA_ANCHOR	~0UL
>>   
>> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range size (in pages) */
> 
> Is that the same as an 'order'? i.e. IOVA_RANGE_CACHE_MAX_ORDER?

Yeah, that may be better. I was just using the same name as before.

> 
>> +
>>   static bool iova_rcache_insert(struct iova_domain *iovad,
>>   			       unsigned long pfn,
>>   			       unsigned long size);
>> @@ -881,7 +883,14 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>>   	unsigned int cpu;
>>   	int i;
>>   
>> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
>> +
>> +	iovad->rcaches = kcalloc(iovad->rcache_max_size,
>> +				 sizeof(*iovad->rcaches), GFP_KERNEL);
>> +	if (!iovad->rcaches)
>> +		return;
> 
> Returning quietly here doesn't seem like the right thing to do. At least, I
> don't think the rest of the functions here are checking rcaches against
> NULL.
> 

For sure, but that is what other code which can fail here already does, 
like:

static void init_iova_rcaches(struct iova_domain *iovad)
{
	...

	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
		...

		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), 
cache_line_size());
		if (WARN_ON(!rcache->cpu_rcaches))
			continue;
}

and that is not safe either.

This issue was raised a while ago. I don't mind trying to fix it - a 
slightly painful part is that it touches a few subsystems.

Thanks,
John
