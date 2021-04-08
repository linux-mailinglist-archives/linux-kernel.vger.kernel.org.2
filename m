Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79578357BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhDHFOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:14:23 -0400
Received: from foss.arm.com ([217.140.110.172]:39390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHFOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:14:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6251424;
        Wed,  7 Apr 2021 22:14:11 -0700 (PDT)
Received: from [10.163.67.84] (unknown [10.163.67.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 174233F73D;
        Wed,  7 Apr 2021 22:14:07 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC/RFT PATCH 2/3] arm64: decouple check whether pfn is normal
 memory from pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-3-rppt@kernel.org>
Message-ID: <4a788546-b854-fd35-644a-f1d9075a9a78@arm.com>
Date:   Thu, 8 Apr 2021 10:44:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407172607.8812-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/21 10:56 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The intended semantics of pfn_valid() is to verify whether there is a
> struct page for the pfn in question and nothing else.

Should there be a comment affirming this semantics interpretation, above the
generic pfn_valid() in include/linux/mmzone.h ?

> 
> Yet, on arm64 it is used to distinguish memory areas that are mapped in the
> linear map vs those that require ioremap() to access them.
> 
> Introduce a dedicated pfn_is_memory() to perform such check and use it
> where appropriate.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  arch/arm64/include/asm/page.h   | 1 +
>  arch/arm64/kvm/mmu.c            | 2 +-
>  arch/arm64/mm/init.c            | 6 ++++++
>  arch/arm64/mm/ioremap.c         | 4 ++--
>  arch/arm64/mm/mmu.c             | 2 +-
>  6 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0aabc3be9a75..7e77fdf71b9d 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  
>  #define virt_addr_valid(addr)	({					\
>  	__typeof__(addr) __addr = __tag_reset(addr);			\
> -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
> +	__is_lm_address(__addr) && pfn_is_memory(virt_to_pfn(__addr));	\
>  })
>  
>  void dump_mem_limit(void);
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 012cffc574e8..32b485bcc6ff 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
>  typedef struct page *pgtable_t;
>  
>  extern int pfn_valid(unsigned long);
> +extern int pfn_is_memory(unsigned long);
>  
>  #include <asm/memory.h>
>  
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8711894db8c2..ad2ea65a3937 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>  
>  static bool kvm_is_device_pfn(unsigned long pfn)
>  {
> -	return !pfn_valid(pfn);
> +	return !pfn_is_memory(pfn);
>  }
>  
>  /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3685e12aba9b..258b1905ed4a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  
> +int pfn_is_memory(unsigned long pfn)
> +{
> +	return memblock_is_map_memory(PFN_PHYS(pfn));
> +}
> +EXPORT_SYMBOL(pfn_is_memory);> +

Should not this be generic though ? There is nothing platform or arm64
specific in here. Wondering as pfn_is_memory() just indicates that the
pfn is linear mapped, should not it be renamed as pfn_is_linear_memory()
instead ? Regardless, it's fine either way.

>  static phys_addr_t memory_limit = PHYS_ADDR_MAX;
>  
>  /*
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index b5e83c46b23e..82a369b22ef5 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -43,7 +43,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
>  	/*
>  	 * Don't allow RAM to be mapped.
>  	 */
> -	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> +	if (WARN_ON(pfn_is_memory(__phys_to_pfn(phys_addr))))
>  		return NULL;
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL(iounmap);
>  void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>  {
>  	/* For normal memory we already have a cacheable mapping. */
> -	if (pfn_valid(__phys_to_pfn(phys_addr)))
> +	if (pfn_is_memory(__phys_to_pfn(phys_addr)))
>  		return (void __iomem *)__phys_to_virt(phys_addr);
>  
>  	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5d9550fdb9cf..038d20fe163f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -81,7 +81,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> -	if (!pfn_valid(pfn))
> +	if (!pfn_is_memory(pfn))
>  		return pgprot_noncached(vma_prot);
>  	else if (file->f_flags & O_SYNC)
>  		return pgprot_writecombine(vma_prot);
> 
