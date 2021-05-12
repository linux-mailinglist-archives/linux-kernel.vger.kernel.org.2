Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5837B460
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhELDJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:09:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2782 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:09:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg05N6X4Tzmg6C;
        Wed, 12 May 2021 11:04:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:08:15 +0800
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To:     Mike Rapoport <rppt@kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
 <YJUWywpGwOpM8hzo@kernel.org>
 <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
 <YJd6QXcmVl+HM4Ob@kernel.org>
 <b91cd653-842b-0e77-5c00-17a0ac9c4b50@huawei.com>
 <YJpEwF2cGjS5mKma@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c3006cd0-fff6-ab45-da83-a216d40388f2@huawei.com>
Date:   Wed, 12 May 2021 11:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJpEwF2cGjS5mKma@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/11 16:48, Mike Rapoport wrote:
> On Mon, May 10, 2021 at 11:10:20AM +0800, Kefeng Wang wrote:
>>
>>>> The memory is not continuous, see MEMBLOCK:
>>>>    memory size = 0x4c0fffff reserved size = 0x027ef058
>>>>    memory.cnt  = 0xa
>>>>    memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
>>>>    memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
>>>>    memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
>>>>    memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
>>>>    memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
>>>>    memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
>>>>    memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
>>>> ...
>>>>
>>>> The pfn_range [0xde600,0xde700] => addr_range [0xde600000,0xde700000]
>>>> is not available memory, and we won't create memmap , so with or without
>>>> your patch, we can't see the range in free_memmap(), right?
>>>
>>> This is not available memory and we won't see the reange in free_memmap(),
>>> but we still should create memmap for it and that's what my patch tried to
>>> do.
>>>
>>> There are a lot of places in core mm that operate on pageblocks and
>>> free_unused_memmap() should make sure that any pageblock has a valid memory
>>> map.
>>>
>>> Currently, that's not the case when SPARSEMEM=y and my patch tried to fix
>>> it.
>>>
>>> Can you please send log with my patch applied and with the printing of
>>> ranges that are freed in free_unused_memmap() you've used in previous
>>> mails?
> 
>> with your patch[1] and debug print in free_memmap,
>> ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86800, 86800000
>> ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e000, 8e000000
>> ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
>> ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de400, de400000
>> ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
>> ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
>> ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
> 
> It seems that freeing of the memory map is suboptimal still because that
> code was not designed for memory layout that has more holes than Swiss
> cheese.
> 
> Still, the range [0xde600,0xde700] is not freed and there should be struct
> pages for this range.
> 
> Can you add
> 
> 	dump_page(pfn_to_page(0xde600), "");
> 
> say, in the end of memblock_free_all()?
>   
> 
The range [0xde600,0xde700] is not memory, so it won't create struct 
page for it when sparse_init?

After apply patch[1], the dump_page log,

page:ef3cc000 is uninitialized and poisoned
raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
page dumped because:


[1] 
https://lore.kernel.org/linux-mm/20210512031057.13580-3-wangkefeng.wang@huawei.com/T/#u
