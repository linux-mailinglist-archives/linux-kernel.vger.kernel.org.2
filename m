Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463A7306FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhA1HnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:43:17 -0500
Received: from foss.arm.com ([217.140.110.172]:53190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232151AbhA1Hmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:42:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D6631B;
        Wed, 27 Jan 2021 23:42:07 -0800 (PST)
Received: from [10.163.92.92] (unknown [10.163.92.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBE83F68F;
        Wed, 27 Jan 2021 23:42:03 -0800 (PST)
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
 <d527c0b8-415b-2425-9f4a-9edec43d8ae5@redhat.com>
 <4c7a92f3-4c5a-c3c6-7fed-befed2f3d3cb@arm.com>
 <8ad7d1d2-6d0a-1c3c-5c18-3d5b8ca5feb8@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <05db75d4-f5ec-4481-19fa-5fb622f97969@arm.com>
Date:   Thu, 28 Jan 2021 13:12:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ad7d1d2-6d0a-1c3c-5c18-3d5b8ca5feb8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/27/21 2:59 PM, David Hildenbrand wrote:
> On 27.01.21 05:06, Anshuman Khandual wrote:
>>
>>
>> On 1/25/21 2:43 PM, David Hildenbrand wrote:
>>> On 25.01.21 07:22, Anshuman Khandual wrote:
>>>>
>>>> On 12/22/20 12:42 PM, Anshuman Khandual wrote:
>>>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>>>> into the system via memremap_pages() called from a driver, their respective
>>>>> memory sections will not have SECTION_IS_EARLY set.
>>>>>
>>>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>>>> skipped as its always going to be positive and that will be an optimization
>>>>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
>>>>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>>>>
>>>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>>>> performance for normal hotplug memory as well.
>>>>>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>
>>>> Hello David/Mike,
>>>>
>>>> Given that we would need to rework early sections, memblock semantics via a
>>>> new config i.e EARLY_SECTION_MEMMAP_HOLES and also some possible changes to
>>>> ARCH_KEEP_MEMBLOCK and HAVE_ARCH_PFN_VALID, wondering if these patches here
>>>> which fixes a problem (and improves performance) can be merged first. After
>>>> that, I could start working on the proposed rework. Could you please let me
>>>> know your thoughts on this. Thank you.
>>>
>>> As I said, we might have to throw in an pfn_section_valid() check, to
>>> catch not-section-aligned ZONE_DEVICE ranges (I assume this is possible
>>> on arm64 as well, no?).
>>
>> pfn_section_valid() should be called only for !early_section() i.e normal
>> hotplug and ZONE_DEVICE memory ? Because early boot memory should always
>> be section aligned.
> 
> Well, at least not on x86-64 you can have early sections intersect with ZONE_DEVICE memory.
> 
> E.g., have 64MB boot memory in a section. Later, we add ZONE_DEVICE memory which might cover the remaining 64MB. For pfn_valid() on x86-64, we always return "true" for such sections, because we always have the memmap for the whole early section allocated during boot. So, there it's "simple".

This is the generic pfn_valid() used on X86. As you mentioned this
does not test pfn_section_valid() if the section is early assuming
that vmemmap coverage is complete.

#ifndef CONFIG_HAVE_ARCH_PFN_VALID
static inline int pfn_valid(unsigned long pfn)
{
        struct mem_section *ms;

        if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
                return 0;
        ms = __nr_to_section(pfn_to_section_nr(pfn));
        if (!valid_section(ms))
                return 0;
        /*
         * Traditionally early sections always returned pfn_valid() for
         * the entire section-sized span.
         */
        return early_section(ms) || pfn_section_valid(ms, pfn);
}
#endif

Looking at the code, seems like early sections get initialized via
sparse_init() only in section granularity but then please correct
me otherwise.

> 
> Now, arm64 seems to discard some parts of the vmemmap, so the remaining 64MB in such an early section might not have a memmap anymore? TBH, I don't know.

Did not get that. Could you please be more specific on how arm64 discards
parts of the vmemmap.

> 
> Most probably only performing the check for
> !early_section() is sufficient on arm64, but I really can't tell as I don't know what we're actually discarding and if something as described for x86-64 is even possible on arm64.

Seems like direct users for arch_add_memory() and __add_pages() like
pagemap_range() can cause subsection hotplug and vmemmap mapping. So
pfn_section_valid() should be applicable only for !early_sections().

Although a simple test on arm64 shows that both boot memory and
traditional memory hotplug gets entire subsection_map populated. But
that might not be always true for ZONE_DEVICE memory.

> 
> We should really try to take the magic out of arm64 vmemmap handling.

I would really like to understand more about this.

> 
>>
>>>
>>> Apart from that, I'm fine with a simple fix upfront, that can be more
>>> easily backported if needed. (Q: do we? is this stable material?)
>>>
>>
>> Right, an upfront fix here would help in backporting. AFAICS it should be
>> backported to the stable as pte_devmap and ZONE_DEVICE have been around
>> for some time now. Do you have a particular stable version which needs to
>> be tagged in the patch ?
> 
> I haven't looked yet TBH. I guess it is broken since ZONE_DEVICE was enabled on arm64?
> 
Sure, will figure this out.
