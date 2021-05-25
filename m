Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC938FA73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhEYGBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:01:05 -0400
Received: from foss.arm.com ([217.140.110.172]:52036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhEYGBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:01:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66ADAD6E;
        Mon, 24 May 2021 22:59:34 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 966303F73D;
        Mon, 24 May 2021 22:59:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, david@redhat.com, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
 <10e5eecf-3ef5-f691-f38a-7ca305b707c1@arm.com> <YKtNH09vbtWeZ830@kernel.org>
Message-ID: <ba369b7c-81b4-d823-3c4c-df1e4fd6e9a2@arm.com>
Date:   Tue, 25 May 2021 11:30:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YKtNH09vbtWeZ830@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/21 12:22 PM, Mike Rapoport wrote:
> Hello Anshuman,
> 
> On Mon, May 24, 2021 at 10:28:32AM +0530, Anshuman Khandual wrote:
>>
>> On 4/22/21 1:20 PM, Anshuman Khandual wrote:
>>> Platforms like arm and arm64 have redefined pfn_valid() because their early
>>> memory sections might have contained memmap holes after freeing parts of it
>>> during boot, which should be skipped while validating a pfn for struct page
>>> backing. This scenario on certain platforms where memmap is not continuous,
>>> could be captured with a new option CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES.
>>> Then the generic pfn_valid() can be improved to accommodate such platforms.
>>> This reduces overall code footprint and also improves maintainability.
>>>
>>> free_unused_memmap() and pfn_to_online_page() have been updated to include
>>> such cases. This also exports memblock_is_memory() for all drivers that use
>>> pfn_valid() but lack required visibility. After the new config is in place,
>>> drop CONFIG_HAVE_ARCH_PFN_VALID from arm64 platforms.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This patch applies on the latest mainline kernel after Mike's series
>>> regarding arm64 based pfn_valid().
>>>
>>> https://lore.kernel.org/linux-mm/20210422061902.21614-1-rppt@kernel.org/T/#t
>>>
>>> Changes in RFC V2:
>>>
>>> - Dropped support for arm (32 bit)
>>> - Replaced memblock_is_map_memory() check with memblock_is_memory()
>>> - MEMBLOCK_NOMAP memory are no longer skipped for pfn_valid()
>>> - Updated pfn_to_online_page() per David
>>> - Updated free_unused_memmap() to preserve existing semantics per Mike
>>> - Exported memblock_is_memory() instead of memblock_is_map_memory()
>>>
>>> Changes in RFC V1:
>>>
>>> - https://patchwork.kernel.org/project/linux-mm/patch/1615174073-10520-1-git-send-email-anshuman.khandual@arm.com/
>>>
>>>  arch/arm64/Kconfig            |  2 +-
>>>  arch/arm64/include/asm/page.h |  1 -
>>>  arch/arm64/mm/init.c          | 41 -----------------------------------
>>>  include/linux/mmzone.h        | 18 ++++++++++++++-
>>>  mm/Kconfig                    |  9 ++++++++
>>>  mm/memblock.c                 |  8 +++++--
>>>  mm/memory_hotplug.c           |  5 +++++
>>>  7 files changed, 38 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index b4a9b493ce72..4cdc3570ffa9 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -144,7 +144,6 @@ config ARM64
>>>  	select HAVE_ARCH_KGDB
>>>  	select HAVE_ARCH_MMAP_RND_BITS
>>>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>> -	select HAVE_ARCH_PFN_VALID
>>>  	select HAVE_ARCH_PREL32_RELOCATIONS
>>>  	select HAVE_ARCH_SECCOMP_FILTER
>>>  	select HAVE_ARCH_STACKLEAK
>>> @@ -167,6 +166,7 @@ config ARM64
>>>  		if $(cc-option,-fpatchable-function-entry=2)
>>>  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>>>  		if DYNAMIC_FTRACE_WITH_REGS
>>> +	select HAVE_EARLY_SECTION_MEMMAP_HOLES
>>>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>>>  	select HAVE_FAST_GUP
>>>  	select HAVE_FTRACE_MCOUNT_RECORD
>>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>>> index 75ddfe671393..fcbef3eec4b2 100644
>>> --- a/arch/arm64/include/asm/page.h
>>> +++ b/arch/arm64/include/asm/page.h
>>> @@ -37,7 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
>>>  
>>>  typedef struct page *pgtable_t;
>>>  
>>> -int pfn_valid(unsigned long pfn);
>>>  int pfn_is_map_memory(unsigned long pfn);
>>>  
>>>  #include <asm/memory.h>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index f431b38d0837..5731a11550d8 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -217,47 +217,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>>>  	free_area_init(max_zone_pfns);
>>>  }
>>>  
>>> -int pfn_valid(unsigned long pfn)
>>> -{
>>> -	phys_addr_t addr = PFN_PHYS(pfn);
>>> -
>>> -	/*
>>> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
>>> -	 * pfn. Else it might lead to false positives when
>>> -	 * some of the upper bits are set, but the lower bits
>>> -	 * match a valid pfn.
>>> -	 */
>>> -	if (PHYS_PFN(addr) != pfn)
>>> -		return 0;
>>> -
>>> -#ifdef CONFIG_SPARSEMEM
>>> -{
>>> -	struct mem_section *ms;
>>> -
>>> -	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>> -		return 0;
>>> -
>>> -	ms = __pfn_to_section(pfn);
>>> -	if (!valid_section(ms))
>>> -		return 0;
>>> -
>>> -	/*
>>> -	 * ZONE_DEVICE memory does not have the memblock entries.
>>> -	 * memblock_is_memory() check for ZONE_DEVICE based
>>> -	 * addresses will always fail. Even the normal hotplugged
>>> -	 * memory will never have MEMBLOCK_NOMAP flag set in their
>>> -	 * memblock entries. Skip memblock search for all non early
>>> -	 * memory sections covering all of hotplug memory including
>>> -	 * both normal and ZONE_DEVICE based.
>>> -	 */
>>> -	if (!early_section(ms))
>>> -		return pfn_section_valid(ms, pfn);
>>> -}
>>> -#endif
>>> -	return memblock_is_memory(addr);
>>> -}
>>> -EXPORT_SYMBOL(pfn_valid);
>>> -
>>>  int pfn_is_map_memory(unsigned long pfn)
>>>  {
>>>  	phys_addr_t addr = PFN_PHYS(pfn);
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 961f0eeefb62..18bf71665211 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1421,10 +1421,22 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>>>   *
>>>   * Return: 1 for PFNs that have memory map entries and 0 otherwise
>>>   */
>>> +bool memblock_is_memory(phys_addr_t addr);
>>> +
>>>  static inline int pfn_valid(unsigned long pfn)
>>>  {
>>> +	phys_addr_t addr = PFN_PHYS(pfn);
>>>  	struct mem_section *ms;
>>>  
>>> +	/*
>>> +	 * Ensure the upper PAGE_SHIFT bits are clear in the
>>> +	 * pfn. Else it might lead to false positives when
>>> +	 * some of the upper bits are set, but the lower bits
>>> +	 * match a valid pfn.
>>> +	 */
>>> +	if (PHYS_PFN(addr) != pfn)
>>> +		return 0;
>>> +
>>>  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>  		return 0;
>>>  	ms = __nr_to_section(pfn_to_section_nr(pfn));
>>> @@ -1434,7 +1446,11 @@ static inline int pfn_valid(unsigned long pfn)
>>>  	 * Traditionally early sections always returned pfn_valid() for
>>>  	 * the entire section-sized span.
>>>  	 */
>>> -	return early_section(ms) || pfn_section_valid(ms, pfn);
>>> +	if (early_section(ms))
>>> +		return IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ?
>>> +			memblock_is_memory(pfn << PAGE_SHIFT) : 1;
>>> +
>>> +	return pfn_section_valid(ms, pfn);
>>>  }
>>>  #endif
>>
>> Hello David/Mike,
>>
>> Now that pfn_is_map_memory() usage has been decoupled from pfn_valid() and
>> SPARSEMEM_VMEMMAP is only available memory model on arm64, wondering if we
>> still need this HAVE_EARLY_SECTION_MEMMAP_HOLES proposal ? Please do kindly
>> suggest. Thank you.
> 
> Even now arm64 still frees parts of the memory map and pfn_valid() should
> be able to tell if a part of a section is freed or not.
> 
> For instance for the following memory configuration
>     
>         |<----section---->|<----hole---->|<----section---->|
>         +--------+--------+--------------+--------+--------+
>         | bank 0 | unused |              | bank 1 | unused |
>         +--------+--------+--------------+--------+--------+
> 
> the memory map corresponding to the "unused" areas is freed, but the generic
> pfn_valid() will still return 1 there.

But is not free_unused_memmap() return early when CONFIG_SPARSEMEM_VMEMMAP
is enabled, which is the only option now on arm64. Then how can memmap have
holes (from unused areas) anymore ? Am I missing something here.

> 
> So we either should stop freeing unused memory map on arm64, or keep
> arm64::pfn_valid() or implement something along the lines of this patch.
> 
> I personally don't think that the memory savings from freeing the unused
> memory map worth the pain of maintenance and bugs happening here and there.
> 
