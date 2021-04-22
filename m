Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B7367D04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhDVI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhDVI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619081859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIBj66zrZyUe4ZvWNAXgo+JuFRJz0vbgrSJAOGRSdws=;
        b=W72Wnm570B4XmKtmVf6MBWE2e3gyyY11WaRxylyQAF25PC+cQij0IeW/FdpfZW7tUpc5iK
        Bk7h3SJPoDAkE/RHmWHDB9k7Y6LuOTgvh97HudaJeKMOZfKxxOIfZ474DT4Ry83SerorNF
        rKd0qfrxo9BlYvghjxZRvf7R32eiriE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-4q6JSUH9NASkE3BTNCq8yw-1; Thu, 22 Apr 2021 04:57:37 -0400
X-MC-Unique: 4q6JSUH9NASkE3BTNCq8yw-1
Received: by mail-wr1-f70.google.com with SMTP id f15-20020adffccf0000b02901028c7339ccso13527791wrs.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oIBj66zrZyUe4ZvWNAXgo+JuFRJz0vbgrSJAOGRSdws=;
        b=E6ItB6Cf0wLPsthrqo5PDLJrm4ZWJYjYHLcUc/rIVQPQQXVZ1V9MAQKA/F7nUQPjat
         +yk0CwITFfzdtMB9gs4d1i8if5kFMCb9hNXSgafI0oAeeRvF0t0pI46wLonQpLEVMNFP
         OCWJq2s4ugVGwtjFyX1v3UnEpTfVw3FwZ5iqQdhUcQfdIzSM0TSBl9Xda1qSZsAii1CW
         BEW4QwMW7mFwO8MMnQZqiTEdvxQn1Hkfk45p5BBnPXZlvaG61xkjwQVrvviuy73IEcSf
         6Em31ik+ST50TEGRDZnSaB08ms/pvURO4f4zTub9D1fIIQBhW6UhZAaBQH+PorcnY2Xt
         p6Bg==
X-Gm-Message-State: AOAM532A2WIcn3M913vqVUmJB13ycPhY/BZvM81AAXLe99d/S9cNcYW+
        uOmP49Piso0CLFPST4tYUWD5YznAqpIjNJrEh1aiwLlSrMgBw8mssLpipUCczpDwyTBVyFDs2VQ
        4Ijc0KHkC4XZpFCc8vsfKWfzO
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr2781986wru.269.1619081856111;
        Thu, 22 Apr 2021 01:57:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9GgNZ576++3awjONvNnTZg6aX15DKGFHF5B2kOpG6WOphS2Kg3Qfdb7AfYfoZjofNzuVBag==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr2781956wru.269.1619081855793;
        Thu, 22 Apr 2021 01:57:35 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id h8sm2072267wmq.19.2021.04.22.01.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:57:35 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] arm64: decouple check whether pfn is in linear map
 from pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210422061902.21614-1-rppt@kernel.org>
 <20210422061902.21614-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <041411e9-0fba-f053-d901-10f1d7a8cc5e@redhat.com>
Date:   Thu, 22 Apr 2021 10:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422061902.21614-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.21 08:19, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The intended semantics of pfn_valid() is to verify whether there is a
> struct page for the pfn in question and nothing else.
> 
> Yet, on arm64 it is used to distinguish memory areas that are mapped in the
> linear map vs those that require ioremap() to access them.
> 
> Introduce a dedicated pfn_is_map_memory() wrapper for
> memblock_is_map_memory() to perform such check and use it where
> appropriate.
> 
> Using a wrapper allows to avoid cyclic include dependencies.
> 
> While here also update style of pfn_valid() so that both pfn_valid() and
> pfn_is_map_memory() declarations will be consistent.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm64/include/asm/memory.h |  2 +-
>   arch/arm64/include/asm/page.h   |  3 ++-
>   arch/arm64/kvm/mmu.c            |  2 +-
>   arch/arm64/mm/init.c            | 12 ++++++++++++
>   arch/arm64/mm/ioremap.c         |  4 ++--
>   arch/arm64/mm/mmu.c             |  2 +-
>   6 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0aabc3be9a75..194f9f993d30 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>   
>   #define virt_addr_valid(addr)	({					\
>   	__typeof__(addr) __addr = __tag_reset(addr);			\
> -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
> +	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
>   })
>   
>   void dump_mem_limit(void);
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 012cffc574e8..75ddfe671393 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -37,7 +37,8 @@ void copy_highpage(struct page *to, struct page *from);
>   
>   typedef struct page *pgtable_t;
>   
> -extern int pfn_valid(unsigned long);
> +int pfn_valid(unsigned long pfn);
> +int pfn_is_map_memory(unsigned long pfn);
>   
>   #include <asm/memory.h>
>   
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8711894db8c2..23dd99e29b23 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   
>   static bool kvm_is_device_pfn(unsigned long pfn)
>   {
> -	return !pfn_valid(pfn);
> +	return !pfn_is_map_memory(pfn);
>   }
>   
>   /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3685e12aba9b..966a7a18d528 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -258,6 +258,18 @@ int pfn_valid(unsigned long pfn)
>   }
>   EXPORT_SYMBOL(pfn_valid);
>   
> +int pfn_is_map_memory(unsigned long pfn)
> +{
> +	phys_addr_t addr = PFN_PHYS(pfn);
> +
> +	/* avoid false positives for bogus PFNs, see comment in pfn_valid() */
> +	if (PHYS_PFN(addr) != pfn)
> +		return 0;
> +
> +	return memblock_is_map_memory(addr);
> +}
> +EXPORT_SYMBOL(pfn_is_map_memory);
> +
>   static phys_addr_t memory_limit = PHYS_ADDR_MAX;
>   
>   /*
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index b5e83c46b23e..b7c81dacabf0 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -43,7 +43,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
>   	/*
>   	 * Don't allow RAM to be mapped.
>   	 */
> -	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> +	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
>   		return NULL;
>   
>   	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL(iounmap);
>   void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>   {
>   	/* For normal memory we already have a cacheable mapping. */
> -	if (pfn_valid(__phys_to_pfn(phys_addr)))
> +	if (pfn_is_map_memory(__phys_to_pfn(phys_addr)))
>   		return (void __iomem *)__phys_to_virt(phys_addr);
>   
>   	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5d9550fdb9cf..26045e9adbd7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -81,7 +81,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>   pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>   			      unsigned long size, pgprot_t vma_prot)
>   {
> -	if (!pfn_valid(pfn))
> +	if (!pfn_is_map_memory(pfn))
>   		return pgprot_noncached(vma_prot);
>   	else if (file->f_flags & O_SYNC)
>   		return pgprot_writecombine(vma_prot);
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

