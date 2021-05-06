Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFD37540F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhEFMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:48:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17590 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhEFMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:48:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbYFr4TdPz1BJCs;
        Thu,  6 May 2021 20:45:20 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 20:47:52 +0800
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
 <YI+32ocTbec5Rm4e@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <82cfbb7f-dd4f-12d8-dc76-847f06172200@huawei.com>
Date:   Thu, 6 May 2021 20:47:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YI+32ocTbec5Rm4e@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/3 16:44, Mike Rapoport wrote:
> On Mon, May 03, 2021 at 10:07:01AM +0200, David Hildenbrand wrote:
>> On 03.05.21 08:26, Mike Rapoport wrote:
>>> On Fri, Apr 30, 2021 at 07:24:37PM +0800, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2021/4/30 17:51, Mike Rapoport wrote:
>>>>> On Thu, Apr 29, 2021 at 06:22:55PM +0800, Kefeng Wang wrote:
>>>>>>
>>>>>> On 2021/4/29 14:57, Mike Rapoport wrote:
>>>>>>
>>>>>>>>> Do you use SPARSMEM? If yes, what is your section size?
>>>>>>>>> What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
>>>>>>>> Yes,
>>>>>>>>
>>>>>>>> CONFIG_SPARSEMEM=y
>>>>>>>>
>>>>>>>> CONFIG_SPARSEMEM_STATIC=y
>>>>>>>>
>>>>>>>> CONFIG_FORCE_MAX_ZONEORDER = 11
>>>>>>>>
>>>>>>>> CONFIG_PAGE_OFFSET=0xC0000000
>>>>>>>> CONFIG_HAVE_ARCH_PFN_VALID=y
>>>>>>>> CONFIG_HIGHMEM=y
>>>>>>>> #define SECTION_SIZE_BITS    26
>>>>>>>> #define MAX_PHYSADDR_BITS    32
>>>>>>>> #define MAX_PHYSMEM_BITS     32
>>>>>>
>>>>>>
>>>>>> With the patch,  the addr is aligned, but the panic still occurred,
>>>>>
>>>>> Is this the same panic at move_freepages() for range [de600, de7ff]?
>>>>>
>>>>> Do you enable CONFIG_ARM_LPAE?
>>>>
>>>> no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
>>>> move_freepages at
>>>>
>>>> start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000] :  pfn =de600, page
>>>> =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
>>>>
>>>>>> __free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
>>>>>> __free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
>>>>>> __free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200
>>>
>>> Hmm, [de600, de7ff] is not added to the free lists which is correct. But
>>> then it's unclear how the page for de600 gets to move_freepages()...
>>>
>>> Can't say I have any bright ideas to try here...
>>
>> Are we missing some checks (e.g., PageReserved()) that pfn_valid_within()
>> would have "caught" before?
> 
> Unless I'm missing something the crash happens in __rmqueue_fallback():
> 
> do_steal:
> 	page = get_page_from_free_area(area, fallback_mt);
> 
> 	steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
> 								can_steal);
> 		-> move_freepages()
> 			-> BUG()
> 
> So a page from free area should be sane as the freed range was never added
> it to the free lists.

Sorry for the late response due to the vacation.

The pfn in range [de600, de7ff] won't be added into the free lists via 
__free_memory_core(), but the pfn could be added into freelists via 
free_highmem_page()

I add some debug[1] in add_to_free_list(), we could see the calltrace

free_highpages, range_pfn [b0200, c0000], range_addr [b0200000, c0000000]
free_highpages, range_pfn [cc000, dca00], range_addr [cc000000, dca00000]
free_highpages, range_pfn [de700, dea00], range_addr [de700000, dea00000]
add_to_free_list, ===> pfn = de700
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:900 add_to_free_list+0x8c/0xec
pfn = de700
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #48
Hardware name: Hisilicon A9
[<c010a600>] (show_stack) from [<c04b21c4>] (dump_stack+0x9c/0xc0)
[<c04b21c4>] (dump_stack) from [<c011c708>] (__warn+0xc0/0xec)
[<c011c708>] (__warn) from [<c011c7a8>] (warn_slowpath_fmt+0x74/0xa4)
[<c011c7a8>] (warn_slowpath_fmt) from [<c023721c>] 
(add_to_free_list+0x8c/0xec)
[<c023721c>] (add_to_free_list) from [<c0237e00>] 
(free_pcppages_bulk+0x200/0x278)
[<c0237e00>] (free_pcppages_bulk) from [<c0238d14>] 
(free_unref_page+0x58/0x68)
[<c0238d14>] (free_unref_page) from [<c023bb54>] 
(free_highmem_page+0xc/0x50)
[<c023bb54>] (free_highmem_page) from [<c070620c>] (mem_init+0x21c/0x254)
[<c070620c>] (mem_init) from [<c0700b38>] (start_kernel+0x258/0x5c0)
[<c0700b38>] (start_kernel) from [<00000000>] (0x0)

so any idea?

[1] debug
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1ba9f9f9dbd8..ee3619c04f93 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -286,7 +286,7 @@ static void __init free_highpages(void)
                 /* Truncate partial highmem entries */
                 if (start < max_low)
                         start = max_low;
-
+               pr_info("%s, range_pfn [%lx, %lx], range_addr [%x, 
%x]\n", __func__, start, end, range_start, range_end);
                 for (; start < end; start++)
                         free_highmem_page(pfn_to_page(start));

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 592479f43c74..920f041f0c6f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -892,7 +892,14 @@ compaction_capture(struct capture_control *capc, 
struct page *page,
  static inline void add_to_free_list(struct page *page, struct zone *zone,
                                     unsigned int order, int migratetype)
  {
+       unsigned long pfn;
         struct free_area *area = &zone->free_area[order];
+       pfn = page_to_pfn(page);
+       if (pfn >= 0xde600 && pfn < 0xde7ff) {
+               pr_info("%s, ===> pfn = %lx", __func__, pfn);
+               WARN_ONCE(pfn == 0xde700, "pfn = %lx", pfn);
+       }



> 
> And honestly, with the memory layout reported elsewhere in the stack I'd
> say that the bootloader/fdt beg for fixes...
> 
