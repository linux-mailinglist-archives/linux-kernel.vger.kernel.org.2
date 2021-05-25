Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC038FE64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhEYKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231637AbhEYKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621937085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEMarepUYpuQv4Tl+GWAkfzqYcfKaB044Ds0uKZVtes=;
        b=N/GSsjUpKFXCq5NT9g+bqtAyi9q2lt1aHtFSdmBHqfToPpNqxifmpG6naRTXXAFiG+Mr3w
        nr4P+wF4XYZLYeLZhs2EJTQgVUj+KPwF8kkvDNYUtFYylaDHZW50TKyMDYCrNRyR5lfXX3
        TSb1jaQNpw4yzpHTv5e3jmsWjyABczY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-E-ZASJrsOw-4JH9l3nIUjw-1; Tue, 25 May 2021 06:04:43 -0400
X-MC-Unique: E-ZASJrsOw-4JH9l3nIUjw-1
Received: by mail-wr1-f72.google.com with SMTP id d12-20020adfc3cc0000b029011166e2f1a7so13317315wrg.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rEMarepUYpuQv4Tl+GWAkfzqYcfKaB044Ds0uKZVtes=;
        b=R+zfRz9RK1DvEjd5DlhQ7WMNUJ5D8DmSGIS+RcQ6chxJw22bCidTwkZPhvmzhCDbtj
         bCPNr+DZvANq69hOmykFVqd1gb20R2x4BJcK+lq1cuLoSzyaCkFSqe1VnmTIbsCZZ3gN
         yBanW0KcUeKWCcpE9rhfAHSbNEslMa0/p0iZkG2eUublu/QecVpCTUA1+TmAdKw6gwHf
         FvtN7iHg5YGX6VxuiQsXohy180Vv1PCkg6iZuG73R0FNBD4MONMduJdYH6s9NcFqM7Df
         YN/frarspM2jU3cCvq17jbGgq6yCrSS0bSlc4Cg4LHNi/aREAfTGaiLyA+f5DCQW39aG
         rHUA==
X-Gm-Message-State: AOAM532SXvZXAFuRV0on63BlIR4ksq2uarLiofdHPULC93yT6VkINIt2
        YQd6HCR2BkTHYm6lSKgcP+r9d6KFePgOhiQnLbBtCOQPhMf5Z71oR38X/FaNFom1FRPRqaBlV4Q
        srh92EWNrXEbRaYW7kL10yykIT6wzmaNxII8DsdeBMOakrHy7Y7cuD+046cZQXUwbj2pO5uKe
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr26809458wrt.168.1621937082243;
        Tue, 25 May 2021 03:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyswEisE4HffAcfiuhK1eDXDYyGX350jzEtm+odGzt14QcYGCxZ2zA6Dn2zVW+beu1c46XwHg==
X-Received: by 2002:a5d:50c1:: with SMTP id f1mr26809418wrt.168.1621937081876;
        Tue, 25 May 2021 03:04:41 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id m5sm2170961wmq.6.2021.05.25.03.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:04:41 -0700 (PDT)
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
To:     Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
 <10e5eecf-3ef5-f691-f38a-7ca305b707c1@arm.com> <YKtNH09vbtWeZ830@kernel.org>
 <ba369b7c-81b4-d823-3c4c-df1e4fd6e9a2@arm.com> <YKyaBi9zoTsCNrgd@kernel.org>
 <dfa5fc60-eddc-1359-7a5f-a5c3a1d8a25b@arm.com> <YKzLYunC/4QfwYkj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1f603aab-0577-7e44-e0fe-6563ed424918@redhat.com>
Date:   Tue, 25 May 2021 12:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKzLYunC/4QfwYkj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.21 12:03, Mike Rapoport wrote:
> On Tue, May 25, 2021 at 03:22:53PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 5/25/21 12:02 PM, Mike Rapoport wrote:
>>> On Tue, May 25, 2021 at 11:30:15AM +0530, Anshuman Khandual wrote:
>>>>
>>>> On 5/24/21 12:22 PM, Mike Rapoport wrote:
>>>>> Hello Anshuman,
>>>>>
>>>>> On Mon, May 24, 2021 at 10:28:32AM +0530, Anshuman Khandual wrote:
>>>>>>
>>>>>> On 4/22/21 1:20 PM, Anshuman Khandual wrote:
>>>>>>> Platforms like arm and arm64 have redefined pfn_valid() because their early
>>>>>>> memory sections might have contained memmap holes after freeing parts of it
>>>>>>> during boot, which should be skipped while validating a pfn for struct page
>>>>>>> backing. This scenario on certain platforms where memmap is not continuous,
>>>>>>> could be captured with a new option CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES.
>>>>>>> Then the generic pfn_valid() can be improved to accommodate such platforms.
>>>>>>> This reduces overall code footprint and also improves maintainability.
>>>>>>>
>>>>>>> free_unused_memmap() and pfn_to_online_page() have been updated to include
>>>>>>> such cases. This also exports memblock_is_memory() for all drivers that use
>>>>>>> pfn_valid() but lack required visibility. After the new config is in place,
>>>>>>> drop CONFIG_HAVE_ARCH_PFN_VALID from arm64 platforms.
>>>>>>>
>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> Cc: Mike Rapoport <rppt@kernel.org>
>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>> Cc: linux-mm@kvack.org
>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>> ---
>>>>>>> This patch applies on the latest mainline kernel after Mike's series
>>>>>>> regarding arm64 based pfn_valid().
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-mm/20210422061902.21614-1-rppt@kernel.org/T/#t
>>>>>>>
>>>>>>> Changes in RFC V2:
>>>>>>>
>>>>>>> - Dropped support for arm (32 bit)
>>>>>>> - Replaced memblock_is_map_memory() check with memblock_is_memory()
>>>>>>> - MEMBLOCK_NOMAP memory are no longer skipped for pfn_valid()
>>>>>>> - Updated pfn_to_online_page() per David
>>>>>>> - Updated free_unused_memmap() to preserve existing semantics per Mike
>>>>>>> - Exported memblock_is_memory() instead of memblock_is_map_memory()
>>>>>>>
>>>>>>> Changes in RFC V1:
>>>>>>>
>>>>>>> - https://patchwork.kernel.org/project/linux-mm/patch/1615174073-10520-1-git-send-email-anshuman.khandual@arm.com/
>>>>>>>
>>>>>>>   arch/arm64/Kconfig            |  2 +-
>>>>>>>   arch/arm64/include/asm/page.h |  1 -
>>>>>>>   arch/arm64/mm/init.c          | 41 -----------------------------------
>>>>>>>   include/linux/mmzone.h        | 18 ++++++++++++++-
>>>>>>>   mm/Kconfig                    |  9 ++++++++
>>>>>>>   mm/memblock.c                 |  8 +++++--
>>>>>>>   mm/memory_hotplug.c           |  5 +++++
>>>>>>>   7 files changed, 38 insertions(+), 46 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>>> index b4a9b493ce72..4cdc3570ffa9 100644
>>>>>>> --- a/arch/arm64/Kconfig
>>>>>>> +++ b/arch/arm64/Kconfig
>>>>>>> @@ -144,7 +144,6 @@ config ARM64
>>>>>>>   	select HAVE_ARCH_KGDB
>>>>>>>   	select HAVE_ARCH_MMAP_RND_BITS
>>>>>>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>>>>>> -	select HAVE_ARCH_PFN_VALID
>>>>>>>   	select HAVE_ARCH_PREL32_RELOCATIONS
>>>>>>>   	select HAVE_ARCH_SECCOMP_FILTER
>>>>>>>   	select HAVE_ARCH_STACKLEAK
>>>>>>> @@ -167,6 +166,7 @@ config ARM64
>>>>>>>   		if $(cc-option,-fpatchable-function-entry=2)
>>>>>>>   	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>>>>>>>   		if DYNAMIC_FTRACE_WITH_REGS
>>>>>>> +	select HAVE_EARLY_SECTION_MEMMAP_HOLES
>>>>>>>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>>>>>>>   	select HAVE_FAST_GUP
>>>>>>>   	select HAVE_FTRACE_MCOUNT_RECORD
>>>>>>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>>>>>>> index 75ddfe671393..fcbef3eec4b2 100644
>>>>>>> --- a/arch/arm64/include/asm/page.h
>>>>>>> +++ b/arch/arm64/include/asm/page.h
>>>>>>> @@ -37,7 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
>>>>>>>   
>>>>>>>   typedef struct page *pgtable_t;
>>>>>>>   
>>>>>>> -int pfn_valid(unsigned long pfn);
>>>>>>>   int pfn_is_map_memory(unsigned long pfn);
>>>>>>>   
>>>>>>>   #include <asm/memory.h>
>>>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>>>> index f431b38d0837..5731a11550d8 100644
>>>>>>> --- a/arch/arm64/mm/init.c
>>>>>>> +++ b/arch/arm64/mm/init.c
>>>>>>> @@ -217,47 +217,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>>>>>>>   	free_area_init(max_zone_pfns);
>>>>>>>   }
>>>>>>>   
>>>>>>> -int pfn_valid(unsigned long pfn)
>>>>>>> -{
>>>>>>> -	phys_addr_t addr = PFN_PHYS(pfn);
>>>>>>> -
>>>>>>> -	/*
>>>>>>> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
>>>>>>> -	 * pfn. Else it might lead to false positives when
>>>>>>> -	 * some of the upper bits are set, but the lower bits
>>>>>>> -	 * match a valid pfn.
>>>>>>> -	 */
>>>>>>> -	if (PHYS_PFN(addr) != pfn)
>>>>>>> -		return 0;
>>>>>>> -
>>>>>>> -#ifdef CONFIG_SPARSEMEM
>>>>>>> -{
>>>>>>> -	struct mem_section *ms;
>>>>>>> -
>>>>>>> -	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>>>>> -		return 0;
>>>>>>> -
>>>>>>> -	ms = __pfn_to_section(pfn);
>>>>>>> -	if (!valid_section(ms))
>>>>>>> -		return 0;
>>>>>>> -
>>>>>>> -	/*
>>>>>>> -	 * ZONE_DEVICE memory does not have the memblock entries.
>>>>>>> -	 * memblock_is_memory() check for ZONE_DEVICE based
>>>>>>> -	 * addresses will always fail. Even the normal hotplugged
>>>>>>> -	 * memory will never have MEMBLOCK_NOMAP flag set in their
>>>>>>> -	 * memblock entries. Skip memblock search for all non early
>>>>>>> -	 * memory sections covering all of hotplug memory including
>>>>>>> -	 * both normal and ZONE_DEVICE based.
>>>>>>> -	 */
>>>>>>> -	if (!early_section(ms))
>>>>>>> -		return pfn_section_valid(ms, pfn);
>>>>>>> -}
>>>>>>> -#endif
>>>>>>> -	return memblock_is_memory(addr);
>>>>>>> -}
>>>>>>> -EXPORT_SYMBOL(pfn_valid);
>>>>>>> -
>>>>>>>   int pfn_is_map_memory(unsigned long pfn)
>>>>>>>   {
>>>>>>>   	phys_addr_t addr = PFN_PHYS(pfn);
>>>>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>>>>> index 961f0eeefb62..18bf71665211 100644
>>>>>>> --- a/include/linux/mmzone.h
>>>>>>> +++ b/include/linux/mmzone.h
>>>>>>> @@ -1421,10 +1421,22 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>>>>>>>    *
>>>>>>>    * Return: 1 for PFNs that have memory map entries and 0 otherwise
>>>>>>>    */
>>>>>>> +bool memblock_is_memory(phys_addr_t addr);
>>>>>>> +
>>>>>>>   static inline int pfn_valid(unsigned long pfn)
>>>>>>>   {
>>>>>>> +	phys_addr_t addr = PFN_PHYS(pfn);
>>>>>>>   	struct mem_section *ms;
>>>>>>>   
>>>>>>> +	/*
>>>>>>> +	 * Ensure the upper PAGE_SHIFT bits are clear in the
>>>>>>> +	 * pfn. Else it might lead to false positives when
>>>>>>> +	 * some of the upper bits are set, but the lower bits
>>>>>>> +	 * match a valid pfn.
>>>>>>> +	 */
>>>>>>> +	if (PHYS_PFN(addr) != pfn)
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>>   	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>>>>>   		return 0;
>>>>>>>   	ms = __nr_to_section(pfn_to_section_nr(pfn));
>>>>>>> @@ -1434,7 +1446,11 @@ static inline int pfn_valid(unsigned long pfn)
>>>>>>>   	 * Traditionally early sections always returned pfn_valid() for
>>>>>>>   	 * the entire section-sized span.
>>>>>>>   	 */
>>>>>>> -	return early_section(ms) || pfn_section_valid(ms, pfn);
>>>>>>> +	if (early_section(ms))
>>>>>>> +		return IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ?
>>>>>>> +			memblock_is_memory(pfn << PAGE_SHIFT) : 1;
>>>>>>> +
>>>>>>> +	return pfn_section_valid(ms, pfn);
>>>>>>>   }
>>>>>>>   #endif
>>>>>>
>>>>>> Hello David/Mike,
>>>>>>
>>>>>> Now that pfn_is_map_memory() usage has been decoupled from pfn_valid() and
>>>>>> SPARSEMEM_VMEMMAP is only available memory model on arm64, wondering if we
>>>>>> still need this HAVE_EARLY_SECTION_MEMMAP_HOLES proposal ? Please do kindly
>>>>>> suggest. Thank you.
>>>>>
>>>>> Even now arm64 still frees parts of the memory map and pfn_valid() should
>>>>> be able to tell if a part of a section is freed or not.
>>>>>
>>>>> For instance for the following memory configuration
>>>>>      
>>>>>          |<----section---->|<----hole---->|<----section---->|
>>>>>          +--------+--------+--------------+--------+--------+
>>>>>          | bank 0 | unused |              | bank 1 | unused |
>>>>>          +--------+--------+--------------+--------+--------+
>>>>>
>>>>> the memory map corresponding to the "unused" areas is freed, but the generic
>>>>> pfn_valid() will still return 1 there.
>>>>
>>>> But is not free_unused_memmap() return early when CONFIG_SPARSEMEM_VMEMMAP
>>>> is enabled, which is the only option now on arm64. Then how can memmap have
>>>> holes (from unused areas) anymore ? Am I missing something here.
>>>   
>>> Ah, you are right, I missed this detail myself :)
>>>
>>> With CONFIG_SPARSEMEM_VMEMMAP as the only memory model for arm64, we can
>>> simply rid of arm64::pfn_valid() without any changes to the generic
>>> version.
>>
>> Though just moved the pfn bits sanity check into generic pfn_valid().
>> I hope this looks okay.
>>
>>  From 7a63f460bcb6ae171c2081bfad81edd9e8f3b7a0 Mon Sep 17 00:00:00 2001
>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>> Date: Tue, 25 May 2021 10:27:09 +0100
>> Subject: [PATCH] arm64/mm: Drop HAVE_ARCH_PFN_VALID
>>
>> CONFIG_SPARSEMEM_VMEMMAP is now the only available memory model on arm64
>> platforms and free_unused_memmap() would just return without creating any
>> holes in the memmap mapping. There is no need for any special handling in
>> pfn_valid() and HAVE_ARCH_PFN_VALID can just be dropped. This also moves
>> the pfn upper bits sanity check into generic pfn_valid().
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> 

Indeed, looks good

Acked-by: David Hildenbrand <david@redhat.com>

>> ---
>>   arch/arm64/Kconfig            |  1 -
>>   arch/arm64/include/asm/page.h |  1 -
>>   arch/arm64/mm/init.c          | 37 -----------------------------------
>>   include/linux/mmzone.h        |  9 +++++++++
>>   4 files changed, 9 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index d7dc8698cf8e..7904728befcc 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -154,7 +154,6 @@ config ARM64
>>   	select HAVE_ARCH_KGDB
>>   	select HAVE_ARCH_MMAP_RND_BITS
>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>> -	select HAVE_ARCH_PFN_VALID
>>   	select HAVE_ARCH_PREL32_RELOCATIONS
>>   	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>>   	select HAVE_ARCH_SECCOMP_FILTER
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index 75ddfe671393..fcbef3eec4b2 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -37,7 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
>>   
>>   typedef struct page *pgtable_t;
>>   
>> -int pfn_valid(unsigned long pfn);
>>   int pfn_is_map_memory(unsigned long pfn);
>>   
>>   #include <asm/memory.h>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 725aa84f2faa..49019ea0c8a8 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -219,43 +219,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>>   	free_area_init(max_zone_pfns);
>>   }
>>   
>> -int pfn_valid(unsigned long pfn)
>> -{
>> -	phys_addr_t addr = PFN_PHYS(pfn);
>> -	struct mem_section *ms;
>> -
>> -	/*
>> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
>> -	 * pfn. Else it might lead to false positives when
>> -	 * some of the upper bits are set, but the lower bits
>> -	 * match a valid pfn.
>> -	 */
>> -	if (PHYS_PFN(addr) != pfn)
>> -		return 0;
>> -
>> -	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>> -		return 0;
>> -
>> -	ms = __pfn_to_section(pfn);
>> -	if (!valid_section(ms))
>> -		return 0;
>> -
>> -	/*
>> -	 * ZONE_DEVICE memory does not have the memblock entries.
>> -	 * memblock_is_map_memory() check for ZONE_DEVICE based
>> -	 * addresses will always fail. Even the normal hotplugged
>> -	 * memory will never have MEMBLOCK_NOMAP flag set in their
>> -	 * memblock entries. Skip memblock search for all non early
>> -	 * memory sections covering all of hotplug memory including
>> -	 * both normal and ZONE_DEVICE based.
>> -	 */
>> -	if (!early_section(ms))
>> -		return pfn_section_valid(ms, pfn);
>> -
>> -	return memblock_is_memory(addr);
>> -}
>> -EXPORT_SYMBOL(pfn_valid);
>> -
>>   int pfn_is_map_memory(unsigned long pfn)
>>   {
>>   	phys_addr_t addr = PFN_PHYS(pfn);
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index a9b263d4cf9d..d0c4fc506fa3 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1443,6 +1443,15 @@ static inline int pfn_valid(unsigned long pfn)
>>   {
>>   	struct mem_section *ms;
>>   
>> +	/*
>> +	 * Ensure the upper PAGE_SHIFT bits are clear in the
>> +	 * pfn. Else it might lead to false positives when
>> +	 * some of the upper bits are set, but the lower bits
>> +	 * match a valid pfn.
>> +	 */
>> +	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
>> +		return 0;
>> +
>>   	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>   		return 0;
>>   	ms = __nr_to_section(pfn_to_section_nr(pfn));
>> -- 
>> 2.20.1
> 


-- 
Thanks,

David / dhildenb

