Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20D037F1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhEMDpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:45:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2493 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhEMDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:45:17 -0400
Received: from dggeml706-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fgcs9178GzYjKj;
        Thu, 13 May 2021 11:41:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggeml706-chm.china.huawei.com (10.3.17.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 11:44:01 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 11:44:01 +0800
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
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <wangkefeng.wang@huawei.com>
References: <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
 <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
 <b077916e-d3f7-ec6c-8c80-b5b642ee111f@huawei.com>
 <YJUWywpGwOpM8hzo@kernel.org>
 <33c67e13-dc48-9a2f-46d8-a532e17380fb@huawei.com>
 <YJd6QXcmVl+HM4Ob@kernel.org>
 <b91cd653-842b-0e77-5c00-17a0ac9c4b50@huawei.com>
 <YJpEwF2cGjS5mKma@kernel.org>
 <c3006cd0-fff6-ab45-da83-a216d40388f2@huawei.com>
 <YJuRPVWubjQKyKBj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <f0034620-b95b-3ba5-f7a2-c8be33d842c7@huawei.com>
Date:   Thu, 13 May 2021 11:44:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJuRPVWubjQKyKBj@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/12 16:26, Mike Rapoport wrote:
> On Wed, May 12, 2021 at 11:08:14AM +0800, Kefeng Wang wrote:
>>
>> On 2021/5/11 16:48, Mike Rapoport wrote:
>>> On Mon, May 10, 2021 at 11:10:20AM +0800, Kefeng Wang wrote:
>>>>
>>>>>> The memory is not continuous, see MEMBLOCK:
>>>>>>     memory size = 0x4c0fffff reserved size = 0x027ef058
>>>>>>     memory.cnt  = 0xa
>>>>>>     memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
>>>>>>     memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
>>>>>>     memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
>>>>>>     memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
>>>>>>     memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
>>>>>>     memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
>>>>>>     memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
>>>>>> ...
>>>>>>
>>>>>> The pfn_range [0xde600,0xde700] => addr_range [0xde600000,0xde700000]
>>>>>> is not available memory, and we won't create memmap , so with or without
>>>>>> your patch, we can't see the range in free_memmap(), right?
>>>>>
>>>>> This is not available memory and we won't see the reange in free_memmap(),
>>>>> but we still should create memmap for it and that's what my patch tried to
>>>>> do.
>>>>>
>>>>> There are a lot of places in core mm that operate on pageblocks and
>>>>> free_unused_memmap() should make sure that any pageblock has a valid memory
>>>>> map.
>>>>>
>>>>> Currently, that's not the case when SPARSEMEM=y and my patch tried to fix
>>>>> it.
>>>>>
>>>>> Can you please send log with my patch applied and with the printing of
>>>>> ranges that are freed in free_unused_memmap() you've used in previous
>>>>> mails?
>>>
>>>> with your patch[1] and debug print in free_memmap,
>>>> ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86800, 86800000
>>>> ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e000, 8e000000
>>>> ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
>>>> ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de400, de400000
>>>> ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
>>>> ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
>>>> ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
>>>
>>> It seems that freeing of the memory map is suboptimal still because that
>>> code was not designed for memory layout that has more holes than Swiss
>>> cheese.
>>>
>>> Still, the range [0xde600,0xde700] is not freed and there should be struct
>>> pages for this range.
>>>
>>> Can you add
>>>
>>> 	dump_page(pfn_to_page(0xde600), "");
>>>
>>> say, in the end of memblock_free_all()?
>>>
>> The range [0xde600,0xde700] is not memory, so it won't create struct page
>> for it when sparse_init?
> 
> sparse_init() indeed does not create memory map for unpopulated memory, but
> it has pretty coarse granularity, i.e. 64M in your configuration. A hole
> should be at least 64M in order to skip allocation of the memory map for
> it.
> 
> For example, your memory layout has a hole of 192M at pfn 0xc0000 and this
> hole won't have the memory map.
> 
> However the hole 0xdca00 - 0xde70 will still have a memory map in the
> section  that covers 0xdc000 - 0xe0000.
> 
> I've tried outline this in a sketch below, hope it helps.
> 
> Memory:
>                            c0000      cc000                      dca00
> --------------------------+          +--------------------------+ +----+
>   memory bank              |<- hole ->| memory bank              | | mb |
> --------------------------+          +--------------------------+ +----+
>                                                                  de700  dea00
> 
> Memory map:
> 
> b0000    b4000            c0000      cc000   d0000    d8000    dc000
> +--------+--------+- ... -+          +--------+- ... -+--------+---------+
> | memmap | memmap | ...   |<- hole ->| memmap |  ...  | memmap | memmap  |
> +--------+--------+- ... -+          +--------+- ... -+--------+---------+
> 
> 
Thanks for the sketch, it is more clear,

>> After apply patch[1], the dump_page log,
>>
>> page:ef3cc000 is uninitialized and poisoned
>> raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>> page dumped because:
> 
> This means that there is a memory map entry, and it got poisoned during the
> initialization and never got reinitialized to sensible values, which would
> be PageReserved() in this case.
> 
> I believe this was fixed by commit 0740a50b9baa ("mm/page_alloc.c: refactor
> initialization of struct page for holes in memory layout") in the mainline
> tree.
> 
> Can you backport it to your 5.10 tree and check if it helps?
>   
Hi Mike, the 0740a50b9baa is already in 5.10, tags/v5.10.24~5

commit 4c84191cbc3eff49568d3c5cccb628fa382cf7fb
Author: Mike Rapoport <rppt@kernel.org>
Date:   Fri Mar 12 21:07:12 2021 -0800

     mm/page_alloc.c: refactor initialization of struct page for holes 
in memory layout

     commit 0740a50b9baa4472cfb12442df4b39e2712a64a4 upstream.

but check init_unavailable_range(), we need deal with the hole in the
range of one pageblock.

For our scene, pageblock range: 0xde600,0xde7ff, but the available pfn 
begin with 0xde700.

If pfn(eg, 0xde600) is not valid, the step in init_unavailable_range is
pageblock_nr_pages, and ALIGN_DOWN(pfn, pageblock_nr_pages) from 0xde600
to 0xde700 is same, so the page range for pfn [0xde600,0xde700] won't be
initialized.

After add the following patch, the oom test could passed,

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..0c7e04f86f9f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6484,13 +6484,14 @@ static u64 __meminit 
init_unavailable_range(unsigned long spfn,
                                             unsigned long epfn,
                                             int zone, int node)
  {
-       unsigned long pfn;
+       unsigned long pfn, pfn_down;
+       unsigned long epfn_down = ALIGN_DOWN(epfn, pageblock_nr_pages);
         u64 pgcnt = 0;

         for (pfn = spfn; pfn < epfn; pfn++) {
-               if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
-                       pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
-                               + pageblock_nr_pages - 1;
+               pfn_down = ALIGN_DOWN(pfn, pageblock_nr_pages);
+               if (!pfn_valid(pfn_down) && pfn_down != epfn_down) {
+                       pfn = pfn_down + pageblock_nr_pages - 1;
                         continue;
                 }
                 __init_single_page(pfn_to_page(pfn), pfn, zone, node);


Before:
On node 0 totalpages: 311551
   Normal zone: 1230 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 157440 pages, LIFO batch:31
   Normal zone: 16384 pages in unavailable ranges
   HighMem zone: 154111 pages, LIFO batch:31
   HighMem zone: 1 pages in unavailable ranges

page:ef3cc000 is uninitialized and poisoned
raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff

After:
On node 0 totalpages: 311551
   Normal zone: 1230 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 157440 pages, LIFO batch:31
   Normal zone: 17152 pages in unavailable ranges
   HighMem zone: 154111 pages, LIFO batch:31
   HighMem zone: 513 pages in unavailable ranges
...
page:(ptrval) refcount:1 mapcount:0 mapping:00000000 index:0x0 pfn:0xde600
flags: 0xdd001000(reserved)
raw: dd001000 ef3cc004 ef3cc004 00000000 00000000 00000000 ffffffff 00000001

