Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF60367D24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhDVJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhDVJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619082234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBPIqE9re75l34eoDms0OtxOrGa4ChUZqthAcy2zOrM=;
        b=eAnkxA79jnWDfCIe3QAxugWykP2KoLXAoDAwSK2zzaByVxzPTZPuTh5ykVJp1oggUXcSmi
        TuR7gPs/neKNpisQgx0oujefKkjJdbFblr3w0m/d4EGoisQYTqo4cS4KFDBeUyTx+DyB0l
        booD/WuZaMzxKH4y/GScFJcyciN595c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-S2sAY63aOA6ACxY41KwCQg-1; Thu, 22 Apr 2021 05:03:52 -0400
X-MC-Unique: S2sAY63aOA6ACxY41KwCQg-1
Received: by mail-ej1-f69.google.com with SMTP id r17-20020a1709069591b029037cf6a4a56dso7007273ejx.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tBPIqE9re75l34eoDms0OtxOrGa4ChUZqthAcy2zOrM=;
        b=Pjj+Q/F80iIBeT+tbMBJ8qgOxjsKlkKjiMi9kGuGTf5mt3TocRpsjX/Tt0kkSfxmhI
         /+suZ2rN0VnKJ4OAWA61F0cddXU9DnDzzuRjgeb7Q+5OFU6I35b1wZolzWYmRI/YMRi1
         EIGr7tXGcu7RM09VV2mPA6zX+F+CVF41RqY2d/ULzNo+/8XohwSQ/AfZbJW4zS/PkcRc
         U9VsAetV1Ud0spaVRyt4yVbnKfJjZd/lFF43fDAL8qWPO0R1DUaF2AhWWbHCBP+9zUyB
         GKbwOdF7gsq1Lt7HR0c0+vufgV8HSZt2OUlOaiJ2O+xXu5V9B4AXid2xleNUMUg/BhYl
         yDow==
X-Gm-Message-State: AOAM531UDEqHupdi0tR2yQiMWccUgeYCkank84TvhuwLLei87yDTElW3
        CBKtbYm5GHBBAA1knRvSV+48IbIsABSoiYlsRDBKMElrJgvrB+ik+8XTHIKwW0W1lkoGA4z6cPx
        8ofANentj8FniNWCCguphA5AhfC1Ua3iF+eyo7Pm3YVV69W/F+5dgcNBS5LWIZIXXNAY6jB61
X-Received: by 2002:a17:906:6789:: with SMTP id q9mr2284329ejp.295.1619082231235;
        Thu, 22 Apr 2021 02:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0ZIkGyQ8YQhVpysHUbBH/txixJO1HYTzsDCKxnSGD6bzgdJdqq8evOkJVZOlVMTKlCWdCMQ==
X-Received: by 2002:a17:906:6789:: with SMTP id q9mr2284296ejp.295.1619082230970;
        Thu, 22 Apr 2021 02:03:50 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id n14sm1399947ejy.90.2021.04.22.02.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:03:50 -0700 (PDT)
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <ce4f8045-2481-103f-f418-28cb43c7c7ff@redhat.com>
Date:   Thu, 22 Apr 2021 11:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.21 09:50, Anshuman Khandual wrote:
> Platforms like arm and arm64 have redefined pfn_valid() because their early
> memory sections might have contained memmap holes after freeing parts of it
> during boot, which should be skipped while validating a pfn for struct page
> backing. This scenario on certain platforms where memmap is not continuous,
> could be captured with a new option CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES.
> Then the generic pfn_valid() can be improved to accommodate such platforms.
> This reduces overall code footprint and also improves maintainability.
> 
> free_unused_memmap() and pfn_to_online_page() have been updated to include
> such cases. This also exports memblock_is_memory() for all drivers that use
> pfn_valid() but lack required visibility. After the new config is in place,
> drop CONFIG_HAVE_ARCH_PFN_VALID from arm64 platforms.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on the latest mainline kernel after Mike's series
> regarding arm64 based pfn_valid().
> 
> https://lore.kernel.org/linux-mm/20210422061902.21614-1-rppt@kernel.org/T/#t
> 
> Changes in RFC V2:
> 
> - Dropped support for arm (32 bit)
> - Replaced memblock_is_map_memory() check with memblock_is_memory()
> - MEMBLOCK_NOMAP memory are no longer skipped for pfn_valid()
> - Updated pfn_to_online_page() per David
> - Updated free_unused_memmap() to preserve existing semantics per Mike
> - Exported memblock_is_memory() instead of memblock_is_map_memory()
> 
> Changes in RFC V1:
> 
> - https://patchwork.kernel.org/project/linux-mm/patch/1615174073-10520-1-git-send-email-anshuman.khandual@arm.com/
> 
>   arch/arm64/Kconfig            |  2 +-
>   arch/arm64/include/asm/page.h |  1 -
>   arch/arm64/mm/init.c          | 41 -----------------------------------
>   include/linux/mmzone.h        | 18 ++++++++++++++-
>   mm/Kconfig                    |  9 ++++++++
>   mm/memblock.c                 |  8 +++++--
>   mm/memory_hotplug.c           |  5 +++++
>   7 files changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b4a9b493ce72..4cdc3570ffa9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -144,7 +144,6 @@ config ARM64
>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> -	select HAVE_ARCH_PFN_VALID
>   	select HAVE_ARCH_PREL32_RELOCATIONS
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_STACKLEAK
> @@ -167,6 +166,7 @@ config ARM64
>   		if $(cc-option,-fpatchable-function-entry=2)
>   	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>   		if DYNAMIC_FTRACE_WITH_REGS
> +	select HAVE_EARLY_SECTION_MEMMAP_HOLES
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>   	select HAVE_FAST_GUP
>   	select HAVE_FTRACE_MCOUNT_RECORD
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 75ddfe671393..fcbef3eec4b2 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -37,7 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
>   
>   typedef struct page *pgtable_t;
>   
> -int pfn_valid(unsigned long pfn);
>   int pfn_is_map_memory(unsigned long pfn);
>   
>   #include <asm/memory.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f431b38d0837..5731a11550d8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -217,47 +217,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   	free_area_init(max_zone_pfns);
>   }
>   
> -int pfn_valid(unsigned long pfn)
> -{
> -	phys_addr_t addr = PFN_PHYS(pfn);
> -
> -	/*
> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
> -	 * pfn. Else it might lead to false positives when
> -	 * some of the upper bits are set, but the lower bits
> -	 * match a valid pfn.
> -	 */
> -	if (PHYS_PFN(addr) != pfn)
> -		return 0;
> -
> -#ifdef CONFIG_SPARSEMEM
> -{
> -	struct mem_section *ms;
> -
> -	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> -		return 0;
> -
> -	ms = __pfn_to_section(pfn);
> -	if (!valid_section(ms))
> -		return 0;
> -
> -	/*
> -	 * ZONE_DEVICE memory does not have the memblock entries.
> -	 * memblock_is_memory() check for ZONE_DEVICE based
> -	 * addresses will always fail. Even the normal hotplugged
> -	 * memory will never have MEMBLOCK_NOMAP flag set in their
> -	 * memblock entries. Skip memblock search for all non early
> -	 * memory sections covering all of hotplug memory including
> -	 * both normal and ZONE_DEVICE based.
> -	 */
> -	if (!early_section(ms))
> -		return pfn_section_valid(ms, pfn);
> -}
> -#endif
> -	return memblock_is_memory(addr);
> -}
> -EXPORT_SYMBOL(pfn_valid);
> -
>   int pfn_is_map_memory(unsigned long pfn)
>   {
>   	phys_addr_t addr = PFN_PHYS(pfn);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 961f0eeefb62..18bf71665211 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1421,10 +1421,22 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>    *
>    * Return: 1 for PFNs that have memory map entries and 0 otherwise
>    */
> +bool memblock_is_memory(phys_addr_t addr);
> +
>   static inline int pfn_valid(unsigned long pfn)
>   {
> +	phys_addr_t addr = PFN_PHYS(pfn);
>   	struct mem_section *ms;
>   
> +	/*
> +	 * Ensure the upper PAGE_SHIFT bits are clear in the
> +	 * pfn. Else it might lead to false positives when
> +	 * some of the upper bits are set, but the lower bits
> +	 * match a valid pfn.
> +	 */
> +	if (PHYS_PFN(addr) != pfn)
> +		return 0;
> +
>   	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>   		return 0;
>   	ms = __nr_to_section(pfn_to_section_nr(pfn));
> @@ -1434,7 +1446,11 @@ static inline int pfn_valid(unsigned long pfn)
>   	 * Traditionally early sections always returned pfn_valid() for
>   	 * the entire section-sized span.
>   	 */
> -	return early_section(ms) || pfn_section_valid(ms, pfn);
> +	if (early_section(ms))
> +		return IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ?
> +			memblock_is_memory(pfn << PAGE_SHIFT) : 1;
> +
> +	return pfn_section_valid(ms, pfn);
>   }
>   #endif
>   
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 24c045b24b95..db7128111874 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -135,6 +135,15 @@ config HAVE_FAST_GUP
>   config ARCH_KEEP_MEMBLOCK
>   	bool
>   
> +config HAVE_EARLY_SECTION_MEMMAP_HOLES
> +	depends on ARCH_KEEP_MEMBLOCK && SPARSEMEM_VMEMMAP
> +	def_bool n
> +	help
> +	  Early sections on certain platforms might have some memory ranges that
> +	  are not backed with struct page mappings. When subscribed, this option
> +	  enables special handling for those memory ranges in certain situations
> +	  such as pfn_valid().
> +
>   # Keep arch NUMA mapping infrastructure post-init.
>   config NUMA_KEEP_MEMINFO
>   	bool
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3abf2c3fea7f..93f8a9c8428d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1740,6 +1740,7 @@ bool __init_memblock memblock_is_memory(phys_addr_t addr)
>   {
>   	return memblock_search(&memblock.memory, addr) != -1;
>   }
> +EXPORT_SYMBOL(memblock_is_memory);
>   
>   bool __init_memblock memblock_is_map_memory(phys_addr_t addr)
>   {
> @@ -1931,8 +1932,11 @@ static void __init free_unused_memmap(void)
>   	unsigned long start, end, prev_end = 0;
>   	int i;
>   
> -	if (!IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) ||
> -	    IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +		return;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) &&
> +	    !IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
>   		return;
>   
>   	/*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..8c78b6a3d888 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -309,6 +309,11 @@ struct page *pfn_to_online_page(unsigned long pfn)
>   	 * Save some code text when online_section() +
>   	 * pfn_section_valid() are sufficient.
>   	 */
> +	if (IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES)) {
> +		if (early_section(ms) && !memblock_is_memory(PFN_PHYS(pfn)))
> +			return NULL;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
>   		return NULL;
>   
> 

What about doing one step at a time and switching only over to generic 
pfn_valid() in case of CONFIG_SPARSEMEM? (meaning: freeing the memmap 
only with !CONFIG_SPARSEMEM)

IOW, avoiding having to adjust generic pfn_valid()/pfn_to_online_page() 
at all. Am i missing something or should that be possible?

-- 
Thanks,

David / dhildenb

