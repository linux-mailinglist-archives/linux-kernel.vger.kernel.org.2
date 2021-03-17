Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12033EF65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCQLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229960AbhCQLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615980022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaEGLo4X+NXL8tELF4RXIvdfb6RpjHhM2xKHX0rYoII=;
        b=eRpkPngK4+BG1H7lUe73NJJDxiVf2Ocx/7rbcfkPYmP/7JErzSOU5OF76KoRpos8G4BhaD
        QPiyiUX7i09RUklsynEVmFCYM6zqXkkbEg/HEuzcqFCyZFwhFWPV2zRW4KenDIjBUMPIYF
        cAQwvBRSQBQNZt1y4Vy0BHi94aXqykI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-R_kdP-m1Nz2gWLDFCNTusQ-1; Wed, 17 Mar 2021 07:20:20 -0400
X-MC-Unique: R_kdP-m1Nz2gWLDFCNTusQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D6F83DD21;
        Wed, 17 Mar 2021 11:20:19 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8683A5D9C0;
        Wed, 17 Mar 2021 11:20:16 +0000 (UTC)
Subject: Re: [RFC] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
 <745496f5-e099-8780-e42e-f347b55e8476@redhat.com>
 <72902ace-5f00-b484-aa71-e6841fb7d082@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2541b182-1f1c-c1ed-c15c-9d71160eb6fe@redhat.com>
Date:   Wed, 17 Mar 2021 12:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <72902ace-5f00-b484-aa71-e6841fb7d082@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 05:29, Anshuman Khandual wrote:
> 
> 
> On 3/8/21 2:07 PM, David Hildenbrand wrote:
>> On 08.03.21 04:27, Anshuman Khandual wrote:
>>> Platforms like arm and arm64 have redefined pfn_valid() because their early
>>> memory sections might have contained memmap holes caused by memblock areas
>>> tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
>>> for struct page backing. This scenario could be captured with a new option
>>> CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
>>> improved to accommodate such platforms. This reduces overall code footprint
>>> and also improves maintainability.
>>>
>>> Commit 4f5b0c178996 ("arm, arm64: move free_unused_memmap() to generic mm")
>>> had used CONFIG_HAVE_ARCH_PFN_VALID to gate free_unused_memmap(), which in
>>> turn had expanded its scope to new platforms like arc and m68k. Rather lets
>>> restrict back the scope for free_unused_memmap() to arm and arm64 platforms
>>> using this new config option i.e CONFIG_HAVE_EARLY_SECTION_MEMMAP.
>>>
>>> While here, it exports the symbol memblock_is_map_memory() to build drivers
>>> that depend on pfn_valid() but does not have the required visibility. After
>>> this new config is in place, just drop CONFIG_HAVE_ARCH_PFN_VALID from both
>>> arm and arm64 platforms.
>>>
>>> Cc: Russell King <linux@armlinux.org.uk>
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
>>> This applies on 5.12-rc2 along with arm64 pfn_valid() fix patches [1] and
>>> has been lightly tested on the arm64 platform. The idea to represent this
>>> unique situation on the arm and arm64 platforms with a config option was
>>> proposed by David H during an earlier discussion [2]. This still does not
>>> build on arm platform due to pfn_valid() resolution errors. Nonetheless
>>> wanted to get some early feedback whether the overall approach here, is
>>> acceptable or not.
>>
>> It might make sense to keep the arm variant for now. The arm64 variant is where the magic happens and where we missed updates when working on the generic variant.
> 
> Sure, will drop the changes on arm.
> 
>>
>> The generic variant really only applies to 64bit targets where we have SPARSEMEM. See x86 as an example.
> 
> Okay.
> 
>>
>> [...]
>>
>>>    /*
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 47946cec7584..93532994113f 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1409,8 +1409,23 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>>>    }
>>>    #endif
>>>    +bool memblock_is_map_memory(phys_addr_t addr);
>>> +
>>>    #ifndef CONFIG_HAVE_ARCH_PFN_VALID
>>>    static inline int pfn_valid(unsigned long pfn)
>>> +{
>>> +    phys_addr_t addr = PFN_PHYS(pfn);
>>> +
>>> +    /*
>>> +     * Ensure the upper PAGE_SHIFT bits are clear in the
>>> +     * pfn. Else it might lead to false positives when
>>> +     * some of the upper bits are set, but the lower bits
>>> +     * match a valid pfn.
>>> +     */
>>> +    if (PHYS_PFN(addr) != pfn)
>>> +        return 0;
>>
>> I think this should be fine for other archs as well.
>>
>>> +
>>> +#ifdef CONFIG_SPARSEMEM
>>
>> Why do we need the ifdef now? If that's to cover the arm case, then please consider the arm64 case only for now.
> 
> Yes, it is not needed.
> 
>>
>>>    {
>>>        struct mem_section *ms;
>>>    @@ -1423,7 +1438,14 @@ static inline int pfn_valid(unsigned long pfn)
>>>         * Traditionally early sections always returned pfn_valid() for
>>>         * the entire section-sized span.
>>>         */
>>> -    return early_section(ms) || pfn_section_valid(ms, pfn);
>>> +    if (early_section(ms))
>>> +        return IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ?
>>> +            memblock_is_map_memory(pfn << PAGE_SHIFT) : 1;
>>> +
>>> +    return pfn_section_valid(ms, pfn);
>>> +}
>>> +#endif
>>> +    return 1;
>>>    }
>>>    #endif
>>>    diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 24c045b24b95..0ec20f661b3f 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -135,6 +135,16 @@ config HAVE_FAST_GUP
>>>    config ARCH_KEEP_MEMBLOCK
>>>        bool
>>>    +config HAVE_EARLY_SECTION_MEMMAP_HOLES
>>> +    depends on ARCH_KEEP_MEMBLOCK && SPARSEMEM_VMEMMAP
>>> +    def_bool n
>>> +    help
>>> +      Early sections on certain platforms might have portions which are
>>> +      not backed with struct page mapping as their memblock entries are
>>> +      marked with MEMBLOCK_NOMAP. When subscribed, this option enables
>>> +      specific handling for those memory sections in certain situations
>>> +      such as pfn_valid().
>>> +
>>>    # Keep arch NUMA mapping infrastructure post-init.
>>>    config NUMA_KEEP_MEMINFO
>>>        bool
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index afaefa8fc6ab..d9fa2e62ab7a 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -1744,6 +1744,7 @@ bool __init_memblock memblock_is_map_memory(phys_addr_t addr)
>>>            return false;
>>>        return !memblock_is_nomap(&memblock.memory.regions[i]);
>>>    }
>>> +EXPORT_SYMBOL(memblock_is_map_memory);
>>>      int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
>>>                 unsigned long *start_pfn, unsigned long *end_pfn)
>>> @@ -1926,7 +1927,7 @@ static void __init free_unused_memmap(void)
>>>        unsigned long start, end, prev_end = 0;
>>>        int i;
>>>    -    if (!IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) ||
>>> +    if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ||
>>>            IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
>>>            return;
>>>   
>>
>> With
>>
>> commit 1f90a3477df3ff1a91e064af554cdc887c8f9e5e
>> Author: Dan Williams <dan.j.williams@intel.com>
>> Date:   Thu Feb 25 17:17:05 2021 -0800
>>
>>      mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions
>>
>> (still in -next I think)
> 
> Already has merged mainline.
> 
>>
>> You'll also have to take care of pfn_to_online_page().
>>
> 
> Something like this would work ?
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5ba51a8bdaeb..19812deb807f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -309,6 +309,11 @@ struct page *pfn_to_online_page(unsigned long pfn)
>           * Save some code text when online_section() +
>           * pfn_section_valid() are sufficient.
>           */
> +       if (IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES)) {
> +               if (early_section(ms) && !memblock_is_map_memory(PFN_PHYS(pfn)))
> +                       return NULL;
> +       }
> +
>          if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
>                  return NULL;
> 

Sorry for the late reply, just stumbled over this again.

I think, yes. I do wonder if we then still need the 
CONFIG_HAVE_ARCH_PFN_VALID handling below - are there any custom 
pfn_valid() implementation with SPARSE remaining? I don't think so.

-- 
Thanks,

David / dhildenb

