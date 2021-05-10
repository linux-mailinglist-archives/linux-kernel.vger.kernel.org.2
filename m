Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46C377A66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEJDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:11:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2607 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEJDL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:11:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdmG53PPszlcpj;
        Mon, 10 May 2021 11:08:13 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 11:10:21 +0800
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
References: <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
 <YJUWywpGwOpM8hzo@kernel.org>
 <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
 <YJd6QXcmVl+HM4Ob@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b91cd653-842b-0e77-5c00-17a0ac9c4b50@huawei.com>
Date:   Mon, 10 May 2021 11:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJd6QXcmVl+HM4Ob@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/9 13:59, Mike Rapoport wrote:
> On Fri, May 07, 2021 at 08:34:52PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2021/5/7 18:30, Mike Rapoport wrote:
>>> On Fri, May 07, 2021 at 03:17:08PM +0800, Kefeng Wang wrote:
>>>>
>>>> On 2021/5/6 20:47, Kefeng Wang wrote:
>>>>>
>>>>>>>>> no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
>>>>>>>>> move_freepages at
>>>>>>>>>
>>>>>>>>> start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000]
>>>>>>>>> :  pfn =de600, page
>>>>>>>>> =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
>>>>>>>>>
>>>>>>>>>>> __free_memory_core, range: 0xb0200000 -
>>>>>>>>>>> 0xc0000000, pfn: b0200 - b0200
>>>>>>>>>>> __free_memory_core, range: 0xcc000000 -
>>>>>>>>>>> 0xdca00000, pfn: cc000 - b0200
>>>>>>>>>>> __free_memory_core, range: 0xde700000 -
>>>>>>>>>>> 0xdea00000, pfn: de700 - b0200
>>>>>>>>
>>>>>>>> Hmm, [de600, de7ff] is not added to the free lists which is
>>>>>>>> correct. But
>>>>>>>> then it's unclear how the page for de600 gets to move_freepages()...
>>>>>>>>
>>>>>>>> Can't say I have any bright ideas to try here...
>>>>>>>
>>>>>>> Are we missing some checks (e.g., PageReserved()) that
>>>>>>> pfn_valid_within()
>>>>>>> would have "caught" before?
>>>>>>
>>>>>> Unless I'm missing something the crash happens in __rmqueue_fallback():
>>>>>>
>>>>>> do_steal:
>>>>>>       page = get_page_from_free_area(area, fallback_mt);
>>>>>>
>>>>>>       steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
>>>>>>                                   can_steal);
>>>>>>           -> move_freepages()
>>>>>>               -> BUG()
>>>>>>
>>>>>> So a page from free area should be sane as the freed range was never
>>>>>> added
>>>>>> it to the free lists.
>>>>>
>>>>> Sorry for the late response due to the vacation.
>>>>>
>>>>> The pfn in range [de600, de7ff] won't be added into the free lists via
>>>>> __free_memory_core(), but the pfn could be added into freelists via
>>>>> free_highmem_page()
>>>>>
>>>>> I add some debug[1] in add_to_free_list(), we could see the calltrace
>>>>>
>>>>> free_highpages, range_pfn [b0200, c0000], range_addr [b0200000, c0000000]
>>>>> free_highpages, range_pfn [cc000, dca00], range_addr [cc000000, dca00000]
>>>>> free_highpages, range_pfn [de700, dea00], range_addr [de700000, dea00000]
>>>>> add_to_free_list, ===> pfn = de700
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:900 add_to_free_list+0x8c/0xec
>>>>> pfn = de700
>>>>> Modules linked in:
>>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #48
>>>>> Hardware name: Hisilicon A9
>>>>> [<c010a600>] (show_stack) from [<c04b21c4>] (dump_stack+0x9c/0xc0)
>>>>> [<c04b21c4>] (dump_stack) from [<c011c708>] (__warn+0xc0/0xec)
>>>>> [<c011c708>] (__warn) from [<c011c7a8>] (warn_slowpath_fmt+0x74/0xa4)
>>>>> [<c011c7a8>] (warn_slowpath_fmt) from [<c023721c>]
>>>>> (add_to_free_list+0x8c/0xec)
>>>>> [<c023721c>] (add_to_free_list) from [<c0237e00>]
>>>>> (free_pcppages_bulk+0x200/0x278)
>>>>> [<c0237e00>] (free_pcppages_bulk) from [<c0238d14>]
>>>>> (free_unref_page+0x58/0x68)
>>>>> [<c0238d14>] (free_unref_page) from [<c023bb54>]
>>>>> (free_highmem_page+0xc/0x50)
>>>>> [<c023bb54>] (free_highmem_page) from [<c070620c>] (mem_init+0x21c/0x254)
>>>>> [<c070620c>] (mem_init) from [<c0700b38>] (start_kernel+0x258/0x5c0)
>>>>> [<c0700b38>] (start_kernel) from [<00000000>] (0x0)
>>>>>
>>>>> so any idea?
>>>>
>>>> If pfn = 0xde700, due to the pageblock_nr_pages = 0x200, then the
>>>> start_pfn,end_pfn passed to move_freepages() will be [de600, de7ff],
>>>> but the range of [de600,de700] without ‘struct page' will lead to
>>>> this panic when pfn_valid_within not enabled if no HOLES_IN_ZONE,
>>>> and the same issue will occurred in isolate_freepages_block(), maybe
>>>
>>> I think your analysis is correct except one minor detail. With the #ifdef
>>> fix I've proposed earlieri [1] the memmap for [0xde600, 0xde700] should not
>>> be freed so there should be a struct page. Did you check what parts of the
>>> memmap are actually freed with this patch applied?
>>> Would you get a panic if you add
>>>
>>> 	dump_page(pfn_to_page(0xde600), "");
>>>
>>> say, in the end of memblock_free_all()?
>>
>> The memory is not continuous, see MEMBLOCK:
>>   memory size = 0x4c0fffff reserved size = 0x027ef058
>>   memory.cnt  = 0xa
>>   memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
>>   memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
>>   memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
>>   memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
>>   memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
>>   memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
>>   memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
>> ...
>>
>> The pfn_range [0xde600,0xde700] => addr_range [0xde600000,0xde700000]
>> is not available memory, and we won't create memmap , so with or without
>> your patch, we can't see the range in free_memmap(), right?
>   
> 
> This is not available memory and we won't see the reange in free_memmap(),
> but we still should create memmap for it and that's what my patch tried to
> do.
> 
> There are a lot of places in core mm that operate on pageblocks and
> free_unused_memmap() should make sure that any pageblock has a valid memory
> map.
> 
> Currently, that's not the case when SPARSEMEM=y and my patch tried to fix
> it.
> 
> Can you please send log with my patch applied and with the printing of
> ranges that are freed in free_unused_memmap() you've used in previous
> mails?
with your patch[1] and debug print in free_memmap,
----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86800, 86800000
----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e000, 8e000000
----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de400, de400000
----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
__free_memory_core, range: 0x80a03000 - 0x80a04000, pfn: 80a03 - 80a04
__free_memory_core, range: 0x80a08000 - 0x80b00000, pfn: 80a08 - 80b00
__free_memory_core, range: 0x812e8058 - 0x83000000, pfn: 812e9 - 83000
__free_memory_core, range: 0x85000000 - 0x85600000, pfn: 85000 - 85600
__free_memory_core, range: 0x86a00000 - 0x87e00000, pfn: 86a00 - 87e00
__free_memory_core, range: 0x8bd00000 - 0x8c500000, pfn: 8bd00 - 8c500
__free_memory_core, range: 0x8e300000 - 0x8ed00000, pfn: 8e300 - 8ed00
__free_memory_core, range: 0x90d00000 - 0xaf2c0000, pfn: 90d00 - af2c0
__free_memory_core, range: 0xaf430000 - 0xaf450000, pfn: af430 - af450
__free_memory_core, range: 0xaf510000 - 0xaf540000, pfn: af510 - af540
__free_memory_core, range: 0xaf560000 - 0xaf580000, pfn: af560 - af580
__free_memory_core, range: 0xafd98000 - 0xafdc8000, pfn: afd98 - afdc8
__free_memory_core, range: 0xafdd8000 - 0xafe00000, pfn: afdd8 - afe00
__free_memory_core, range: 0xafe18000 - 0xafe80000, pfn: afe18 - afe80
__free_memory_core, range: 0xafee0000 - 0xaff00000, pfn: afee0 - aff00
__free_memory_core, range: 0xaff80000 - 0xaff8d000, pfn: aff80 - aff8d
__free_memory_core, range: 0xafff2000 - 0xafff4580, pfn: afff2 - afff4
__free_memory_core, range: 0xafffe000 - 0xafffe0e0, pfn: afffe - afffe
__free_memory_core, range: 0xafffe4fc - 0xafffe500, pfn: affff - afffe
__free_memory_core, range: 0xafffe6e4 - 0xafffe700, pfn: affff - afffe
__free_memory_core, range: 0xafffe8dc - 0xafffe8e0, pfn: affff - afffe
__free_memory_core, range: 0xafffe970 - 0xafffe980, pfn: affff - afffe
__free_memory_core, range: 0xafffe990 - 0xafffe9a0, pfn: affff - afffe
__free_memory_core, range: 0xafffe9a4 - 0xafffe9c0, pfn: affff - afffe
__free_memory_core, range: 0xafffeb54 - 0xafffeb60, pfn: affff - afffe
__free_memory_core, range: 0xafffecf4 - 0xafffed00, pfn: affff - afffe
__free_memory_core, range: 0xafffefc4 - 0xafffefd8, pfn: affff - afffe
__free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
__free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
__free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200
__free_memory_core, range: 0xe0800000 - 0xe0c00000, pfn: e0800 - b0200
__free_memory_core, range: 0xf4b00000 - 0xf7000000, pfn: f4b00 - b0200
__free_memory_core, range: 0xfda00000 - 0xffffffff, pfn: fda00 - b0200
free_highpages, range_pfn [b0200, c0000], range_addr [b0200000, c0000000]
free_highpages, range_pfn [cc000, dca00], range_addr [cc000000, dca00000]
free_highpages, range_pfn [de700, dea00], range_addr [de700000, dea00000]
free_highpages, range_pfn [e0800, e0c00], range_addr [e0800000, e0c00000]
free_highpages, range_pfn [f4b00, f7000], range_addr [f4b00000, f7000000]
free_highpages, range_pfn [fda00, fffff], range_addr [fda00000, ffffffff]

>   
>>>> there are some scene, so I select HOLES_IN_ZONE in ARCH_HISI(ARM) to solve
>>>> this issue in our 5.10, should we select HOLES_IN_ZONE in all ARM or only in
>>>> ARCH_HISI, any better solution?  Thanks.
>>>
>>> I don't think that HOLES_IN_ZONE is the right solution. I believe that we
>>> must keep the memory map aligned on pageblock boundaries. That's surely not the
>>> case for SPARSEMEM as of now, and if my fix is not enough we need to find
>>> where it went wrong.
>>>
>>> Besides, I'd say that if it is possible to update your firmware to make the
>>> memory layout reported to the kernel less, hmm, esoteric, you would hit
>>> less corner cases.
>>
>> Sorry, memory layout is customized and we can't change it, some memory is
>> for special purposes by our production.
>   
> I understand that this memory cannot be used by Linux, but the firmware may
> supply the kernel with actual physical memory layout and then mark all
> the special purpose memory that kernel should not touch as reserved.
We only can modify kernel, so it is not practicable for our production, 
and this way looks like a workaround, we need find a way to solve the 
issue from kernel side.

[1] https://lore.kernel.org/lkml/YIpY8TXCSc7Lfa2Z@kernel.org

