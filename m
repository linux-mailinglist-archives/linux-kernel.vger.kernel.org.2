Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993D9366996
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhDUK7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:59:35 -0400
Received: from foss.arm.com ([217.140.110.172]:59314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhDUK7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E3F113E;
        Wed, 21 Apr 2021 03:59:00 -0700 (PDT)
Received: from [10.163.74.228] (unknown [10.163.74.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99953F73B;
        Wed, 21 Apr 2021 03:58:56 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 3/4] arm64: decouple check whether pfn is in linear map
 from pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-4-rppt@kernel.org>
Message-ID: <0a7cc0d4-5d3d-7d6d-f4c3-bb2965b810e6@arm.com>
Date:   Wed, 21 Apr 2021 16:29:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421065108.1987-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/21 12:21 PM, Mike Rapoport wrote:
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
>  arch/arm64/include/asm/memory.h |  2 +-
>  arch/arm64/include/asm/page.h   |  1 +
>  arch/arm64/kvm/mmu.c            |  2 +-
>  arch/arm64/mm/init.c            | 11 +++++++++++
>  arch/arm64/mm/ioremap.c         |  4 ++--
>  arch/arm64/mm/mmu.c             |  2 +-
>  6 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0aabc3be9a75..194f9f993d30 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  
>  #define virt_addr_valid(addr)	({					\
>  	__typeof__(addr) __addr = __tag_reset(addr);			\
> -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
> +	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
>  })
>  
>  void dump_mem_limit(void);
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 012cffc574e8..99a6da91f870 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
>  typedef struct page *pgtable_t;
>  
>  extern int pfn_valid(unsigned long);
> +extern int pfn_is_map_memory(unsigned long);

Check patch is complaining about this.

WARNING: function definition argument 'unsigned long' should also have an identifier name
#50: FILE: arch/arm64/include/asm/page.h:41:
+extern int pfn_is_map_memory(unsigned long);


>  
>  #include <asm/memory.h>
>  
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8711894db8c2..23dd99e29b23 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>  
>  static bool kvm_is_device_pfn(unsigned long pfn)
>  {
> -	return !pfn_valid(pfn);
> +	return !pfn_is_map_memory(pfn);
>  }
>  
>  /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3685e12aba9b..dc03bdc12c0f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -258,6 +258,17 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  
> +int pfn_is_map_memory(unsigned long pfn)
> +{
> +	phys_addr_t addr = PFN_PHYS(pfn);
> +

Should also bring with it, the comment regarding upper bits in
the pfn from arm64 pfn_valid().

> +	if (PHYS_PFN(addr) != pfn)
> +		return 0;
> +	

 ^^^^^ trailing spaces here.

ERROR: trailing whitespace
#81: FILE: arch/arm64/mm/init.c:263:
+^I$

> +	return memblock_is_map_memory(addr);
> +}
> +EXPORT_SYMBOL(pfn_is_map_memory);
> +

Is the EXPORT_SYMBOL() required to build drivers which will use
pfn_is_map_memory() but currently use pfn_valid() ?
