Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B76388496
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhESBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:52:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3018 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhESBwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:52:08 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlG2Y6hXNzQp7V;
        Wed, 19 May 2021 09:47:17 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:50:47 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:50:47 +0800
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
 <2d34f990-c609-88aa-1dc0-f8e9e9623fc3@huawei.com>
 <YKPi0eBWsHBDZCg/@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <779d890b-6983-6138-4f74-eef7be0bbd4c@huawei.com>
Date:   Wed, 19 May 2021 09:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YKPi0eBWsHBDZCg/@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/18 23:52, Mike Rapoport wrote:
> On Tue, May 18, 2021 at 08:49:43PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2021/5/18 17:06, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> When unused memory map is freed the preserved part of the memory map is
>>> extended to match pageblock boundaries because lots of core mm
>>> functionality relies on homogeneity of the memory map within pageblock
>>> boundaries.
>>>
>>> Since pfn_valid() is used to check whether there is a valid memory map
>>> entry for a PFN, make it return true also for PFNs that have memory map
>>> entries even if there is no actual memory populated there.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>    arch/arm/mm/init.c | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>>> index 9d4744a632c6..bb678c0ba143 100644
>>> --- a/arch/arm/mm/init.c
>>> +++ b/arch/arm/mm/init.c
>>> @@ -125,11 +125,24 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
>>>    int pfn_valid(unsigned long pfn)
>>>    {
>>>    	phys_addr_t addr = __pfn_to_phys(pfn);
>>> +	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
>>>    	if (__phys_to_pfn(addr) != pfn)
>>>    		return 0;
>>> -	return memblock_is_map_memory(addr);
>>> +	if (memblock_is_map_memory(addr))
>>> +		return 1;
>>> +
>>> +	/*
>>> +	 * If address less than pageblock_size bytes away from a present
>>> +	 * memory chunk there still will be a memory map entry for it
>>> +	 * because we round freed memory map to the pageblock boundaries
>>> +	 */
>>> +	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
>>> +	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
>>> +		return 1;
>>
>> Hi Mike, with patch3, the system won't boot.
> 
> Hmm, apparently I've miscalculated the ranges...
> 
> Can you please check with the below patch on top of this series:

Yes, it works,

On node 0 totalpages: 311551
   Normal zone: 1230 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 157440 pages, LIFO batch:31
   Normal zone: 17152 pages in unavailable ranges
   HighMem zone: 154111 pages, LIFO batch:31
   HighMem zone: 513 pages in unavailable ranges

and the oom testcase could pass.

Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>


There is memblock_is_region_reserved(check if a region intersects 
reserved memory), it also checks the size, should we add a similar func?

> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index bb678c0ba143..2fafbbc8e73b 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -138,8 +138,9 @@ int pfn_valid(unsigned long pfn)
>   	 * memory chunk there still will be a memory map entry for it
>   	 * because we round freed memory map to the pageblock boundaries
>   	 */
> -	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
> -	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
> +	if (memblock_overlaps_region(&memblock.memory,
> +				     ALIGN_DOWN(addr, pageblock_size),
> +				     pageblock_size);
>   		return 1;
>   
>   	return 0;
> 
