Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73630A0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhBADsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:48:12 -0500
Received: from foss.arm.com ([217.140.110.172]:46872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhBADsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:48:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A39C1042;
        Sun, 31 Jan 2021 19:47:23 -0800 (PST)
Received: from [10.163.93.126] (unknown [10.163.93.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382673F718;
        Sun, 31 Jan 2021 19:47:18 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64/mm: Reorganize pfn_valid()
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1611905986-20155-1-git-send-email-anshuman.khandual@arm.com>
 <1611905986-20155-3-git-send-email-anshuman.khandual@arm.com>
 <9050792c-feba-1b72-681e-ebc28fc1fcc5@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <681dd64b-e10a-1ec8-abad-d3eee0ddfa45@arm.com>
Date:   Mon, 1 Feb 2021 09:17:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9050792c-feba-1b72-681e-ebc28fc1fcc5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 3:37 PM, David Hildenbrand wrote:
> On 29.01.21 08:39, Anshuman Khandual wrote:
>> There are multiple instances of pfn_to_section_nr() and __pfn_to_section()
>> when CONFIG_SPARSEMEM is enabled. This can be just optimized if the memory
>> section is fetched earlier. Hence bifurcate pfn_valid() into two different
>> definitions depending on whether CONFIG_SPARSEMEM is enabled. Also replace
>> the open coded pfn <--> addr conversion with __[pfn|phys]_to_[phys|pfn]().
>> This does not cause any functional change.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/init.c | 38 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 1141075e4d53..09adca90c57a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -217,18 +217,25 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>>       free_area_init(max_zone_pfns);
>>   }
>>   +#ifdef CONFIG_SPARSEMEM
>>   int pfn_valid(unsigned long pfn)
>>   {
>> -    phys_addr_t addr = pfn << PAGE_SHIFT;
>> +    struct mem_section *ms = __pfn_to_section(pfn);
>> +    phys_addr_t addr = __pfn_to_phys(pfn);
> 
> I'd just use PFN_PHYS() here, which is more frequently used in the kernel.

Sure, will replace.

> 
>>   -    if ((addr >> PAGE_SHIFT) != pfn)
>> +    /*
>> +     * Ensure the upper PAGE_SHIFT bits are clear in the
>> +     * pfn. Else it might lead to false positives when
>> +     * some of the upper bits are set, but the lower bits
>> +     * match a valid pfn.
>> +     */
>> +    if (__phys_to_pfn(addr) != pfn)
> 
> and here PHYS_PFN(). Comment is helpful. :)

Sure, will replace.

> 
>>           return 0;
>>   -#ifdef CONFIG_SPARSEMEM
>>       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>           return 0;
>>   -    if (!valid_section(__pfn_to_section(pfn)))
>> +    if (!valid_section(ms))
>>           return 0;
>>         /*
>> @@ -240,11 +247,28 @@ int pfn_valid(unsigned long pfn)
>>        * memory sections covering all of hotplug memory including
>>        * both normal and ZONE_DEVICE based.
>>        */
>> -    if (!early_section(__pfn_to_section(pfn)))
>> -        return pfn_section_valid(__pfn_to_section(pfn), pfn);
>> -#endif
>> +    if (!early_section(ms))
>> +        return pfn_section_valid(ms, pfn);
>> +
>>       return memblock_is_map_memory(addr);
>>   }
>> +#else
>> +int pfn_valid(unsigned long pfn)
>> +{
>> +    phys_addr_t addr = __pfn_to_phys(pfn);
>> +
>> +    /*
>> +     * Ensure the upper PAGE_SHIFT bits are clear in the
>> +     * pfn. Else it might lead to false positives when
>> +     * some of the upper bits are set, but the lower bits
>> +     * match a valid pfn.
>> +     */
>> +    if (__phys_to_pfn(addr) != pfn)
>> +        return 0;
>> +
>> +    return memblock_is_map_memory(addr);
>> +}
> 
> 
> I think you can avoid duplicating the code by doing something like:

Right and also this looks more compact as well. Initially though about
it but then was apprehensive about the style in #ifdef { } #endif code
block inside the function. After this change, the resulting patch also
clears checkpatch.pl test. Will do the change.

> 
> 
> phys_addr_t addr = PFN_PHYS(pfn);
> 
> if (PHYS_PFN(addr) != pfn)
>     return 0;
> 
> #ifdef CONFIG_SPARSEMEM
> {
>     struct mem_section *ms = __pfn_to_section(pfn);
> 
>     if (!valid_section(ms))
>         return 0;
>     if (!early_section(ms))
>         return pfn_section_valid(ms, pfn);
> }
> #endif
> return memblock_is_map_memory(addr);
> 
