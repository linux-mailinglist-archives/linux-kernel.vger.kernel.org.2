Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9DC365CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhDTP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232507AbhDTP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618934282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRUjVbp/xhnBKh4OUO4qLwF9cw2sRaU2IDxMzgRt9EE=;
        b=WKy233fWkxUbPOls6EwSxRu7rUlxpiH33DQymgc/cpKaIfWk7+X2+qxn6ZAJaBwoS//AsB
        tIhLSUpKHGWlb1yKyZU8QPBMRvPCex3VUItozDXcGBazP1uKqpuDCn3mpeKOetMQH1kWHX
        uAFx5Dy8tzqPxqPDx5TEjuXqedHtuOc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-oNo2gtZfOHWTOcJDgOgDpw-1; Tue, 20 Apr 2021 11:58:00 -0400
X-MC-Unique: oNo2gtZfOHWTOcJDgOgDpw-1
Received: by mail-wr1-f72.google.com with SMTP id s7-20020adfc5470000b0290106eef17cbdso7655959wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kRUjVbp/xhnBKh4OUO4qLwF9cw2sRaU2IDxMzgRt9EE=;
        b=CJou0J+2LmZIDcd+dY2w3cLlHAYrZtE1XU8ytgnvuEOpoahckoL6G/EC+lG5HP6L8a
         D9AaQX/lea6nZJglo7htPF/qesAFfM4DHGyZ51k6hbtZsAb/pF7Q2FsRKEK0YHHeSBQ1
         BIIrr+aqnKhUVucG5h+epdrzZl46hLW8XfqEr20IPw37gf9uctI6L6QEDOOLoq1cwoix
         R/skkO7fovFEYC1k4OqODEJsUovpb970nLXYPmmnP15w22hZnkRhvnaB8jwK10O5jghX
         l8uPkbk3XeKsIAwNKSbKAisdCve9oMA+3ePu5g9ET5xG/AVmRBVD3aaYtCxkYfrQqPad
         BXWw==
X-Gm-Message-State: AOAM533JeYQaAkolVhQ7lKfC9RkgHW08/53VsaaT1AtUCeMsl3wtLAu/
        pdr6eloE1iAvq6R2oFJMufeFpGL0ryXfjsWYm7BwV0XHq2QHQ4RoD3PmoWl7PJsYjjrAAhTQlCv
        PGWXqn9d+j+bT970VmqiQG8oY
X-Received: by 2002:a7b:c312:: with SMTP id k18mr5229602wmj.89.1618934279118;
        Tue, 20 Apr 2021 08:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHImaAxee8YH0d/aTWDGKEJNDp2XNJZPNDFkBuyM4cK1Nn3spewv6GbBlRucz+5ba84q6ojQ==
X-Received: by 2002:a7b:c312:: with SMTP id k18mr5229585wmj.89.1618934278815;
        Tue, 20 Apr 2021 08:57:58 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id b12sm9569161wmj.1.2021.04.20.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:57:58 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/4] arm64: decouple check whether pfn is in linear map
 from pfn_valid()
Message-ID: <29b51a80-1543-fcec-6f5b-5ae21b78e1e9@redhat.com>
Date:   Tue, 20 Apr 2021 17:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420090925.7457-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 11:09, Mike Rapoport wrote:
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
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm64/include/asm/memory.h | 2 +-
>   arch/arm64/include/asm/page.h   | 1 +
>   arch/arm64/kvm/mmu.c            | 2 +-
>   arch/arm64/mm/init.c            | 6 ++++++
>   arch/arm64/mm/ioremap.c         | 4 ++--
>   arch/arm64/mm/mmu.c             | 2 +-
>   6 files changed, 12 insertions(+), 5 deletions(-)
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
> index 012cffc574e8..99a6da91f870 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
>   typedef struct page *pgtable_t;
>   
>   extern int pfn_valid(unsigned long);
> +extern int pfn_is_map_memory(unsigned long);
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
> index 3685e12aba9b..c54e329aca15 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
>   }
>   EXPORT_SYMBOL(pfn_valid);
>   
> +int pfn_is_map_memory(unsigned long pfn)
> +{

I think you might have to add (see pfn_valid())

if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
	return 0;

to catch false positives.

> +	return memblock_is_map_memory(PFN_PHYS(pfn));
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

As discussed, in the future it would be nice if we could just rely on 
the memmap state. There are cases where pfn_is_map_memory() will now be 
slower than pfn_valid() -- e.g., we don't check for valid_section() in 
case of CONFIG_SPARSEMEM. This would apply where pfn_valid() would have 
returned "0".

As we're not creating the direct map, kern_addr_valid() shouldn't need 
love. It'd be some kind of ugly if some generic code used by arm64 would 
be relying in case of arm64 on pfn_valid() to return the expected 
result; I doubt it.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

