Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07730F33F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhBDMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:34:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235804AbhBDMex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:34:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C759D6E;
        Thu,  4 Feb 2021 04:34:07 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60DA13F73B;
        Thu,  4 Feb 2021 04:34:05 -0800 (PST)
Subject: Re: [PATCH 10/12] arm64: kasan: simplify and inline MTE functions
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1612208222.git.andreyknvl@google.com>
 <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <074b893e-beea-8fcc-75df-778d29331236@arm.com>
Date:   Thu, 4 Feb 2021 12:37:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:43 PM, Andrey Konovalov wrote:
> This change provides a simpler implementation of mte_get_mem_tag(),
> mte_get_random_tag(), and mte_set_mem_tag_range().
> 
> Simplifications include removing system_supports_mte() checks as these
> functions are onlye called from KASAN runtime that had already checked
> system_supports_mte(). Besides that, size and address alignment checks
> are removed from mte_set_mem_tag_range(), as KASAN now does those.
> 
> This change also moves these functions into the asm/mte-kasan.h header
> and implements mte_set_mem_tag_range() via inline assembly to avoid
> unnecessary functions calls.
> 
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/cache.h     |  1 -
>  arch/arm64/include/asm/kasan.h     |  1 +
>  arch/arm64/include/asm/mte-def.h   |  2 +
>  arch/arm64/include/asm/mte-kasan.h | 64 ++++++++++++++++++++++++++----
>  arch/arm64/include/asm/mte.h       |  2 -
>  arch/arm64/kernel/mte.c            | 46 ---------------------
>  arch/arm64/lib/mte.S               | 16 --------
>  7 files changed, 60 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 77cbbe3625f2..a074459f8f2f 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -6,7 +6,6 @@
>  #define __ASM_CACHE_H
>  
>  #include <asm/cputype.h>
> -#include <asm/mte-kasan.h>
>  
>  #define CTR_L1IP_SHIFT		14
>  #define CTR_L1IP_MASK		3
> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> index 0aaf9044cd6a..12d5f47f7dbe 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/linkage.h>
>  #include <asm/memory.h>
> +#include <asm/mte-kasan.h>
>  #include <asm/pgtable-types.h>
>  
>  #define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
> diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
> index 2d73a1612f09..cf241b0f0a42 100644
> --- a/arch/arm64/include/asm/mte-def.h
> +++ b/arch/arm64/include/asm/mte-def.h
> @@ -11,4 +11,6 @@
>  #define MTE_TAG_SIZE		4
>  #define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
>  
> +#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
> +
>  #endif /* __ASM_MTE_DEF_H  */
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 8ad981069afb..1f090beda7e6 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -11,13 +11,16 @@
>  
>  #include <linux/types.h>
>  
> +#ifdef CONFIG_ARM64_MTE
> +
>  /*
> - * The functions below are meant to be used only for the
> - * KASAN_HW_TAGS interface defined in asm/memory.h.
> + * These functions are meant to be only used from KASAN runtime through
> + * the arch_*() interface defined in asm/memory.h.
> + * These functions don't include system_supports_mte() checks,
> + * as KASAN only calls them when MTE is supported and enabled.
>   */
> -#ifdef CONFIG_ARM64_MTE
>  
> -static inline u8 mte_get_ptr_tag(void *ptr)
> +static __always_inline u8 mte_get_ptr_tag(void *ptr)
>  {
>  	/* Note: The format of KASAN tags is 0xF<x> */
>  	u8 tag = 0xF0 | (u8)(((u64)(ptr)) >> MTE_TAG_SHIFT);
> @@ -25,9 +28,54 @@ static inline u8 mte_get_ptr_tag(void *ptr)
>  	return tag;
>  }
>  
> -u8 mte_get_mem_tag(void *addr);
> -u8 mte_get_random_tag(void);
> -void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> +/* Get allocation tag for the address. */
> +static __always_inline u8 mte_get_mem_tag(void *addr)
> +{
> +	asm(__MTE_PREAMBLE "ldg %0, [%0]"
> +		: "+r" (addr));
> +
> +	return mte_get_ptr_tag(addr);
> +}
> +
> +/* Generate a random tag. */
> +static __always_inline u8 mte_get_random_tag(void)
> +{
> +	void *addr;
> +
> +	asm(__MTE_PREAMBLE "irg %0, %0"
> +		: "+r" (addr));
> +
> +	return mte_get_ptr_tag(addr);
> +}
> +
> +/*
> + * Assign allocation tags for a region of memory based on the pointer tag.
> + * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> + * size must be non-zero and MTE_GRANULE_SIZE aligned.
> + */
> +static __always_inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +	u64 curr, end;
> +
> +	if (!size)
> +		return;
> +
> +	curr = (u64)__tag_set(addr, tag);
> +	end = curr + size;
> +
> +	do {
> +		/*
> +		 * 'asm volatile' is required to prevent the compiler to move
> +		 * the statement outside of the loop.
> +		 */
> +		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> +			     :
> +			     : "r" (curr)
> +			     : "memory");
> +
> +		curr += MTE_GRANULE_SIZE;
> +	} while (curr != end);
> +}
>  
>  void mte_enable_kernel_sync(void);
>  void mte_enable_kernel_async(void);
> @@ -47,10 +95,12 @@ static inline u8 mte_get_mem_tag(void *addr)
>  {
>  	return 0xFF;
>  }
> +
>  static inline u8 mte_get_random_tag(void)
>  {
>  	return 0xFF;
>  }
> +
>  static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  {
>  	return addr;
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 237bb2f7309d..43169b978cd3 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -8,8 +8,6 @@
>  #include <asm/compiler.h>
>  #include <asm/mte-def.h>
>  
> -#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
> -
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitfield.h>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 7763ac1f2917..8b27b70e1aac 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -19,7 +19,6 @@
>  #include <asm/barrier.h>
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
> -#include <asm/mte-kasan.h>
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> @@ -88,51 +87,6 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  	return ret;
>  }
>  
> -u8 mte_get_mem_tag(void *addr)
> -{
> -	if (!system_supports_mte())
> -		return 0xFF;
> -
> -	asm(__MTE_PREAMBLE "ldg %0, [%0]"
> -	    : "+r" (addr));
> -
> -	return mte_get_ptr_tag(addr);
> -}
> -
> -u8 mte_get_random_tag(void)
> -{
> -	void *addr;
> -
> -	if (!system_supports_mte())
> -		return 0xFF;
> -
> -	asm(__MTE_PREAMBLE "irg %0, %0"
> -	    : "+r" (addr));
> -
> -	return mte_get_ptr_tag(addr);
> -}
> -
> -void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> -{
> -	void *ptr = addr;
> -
> -	if ((!system_supports_mte()) || (size == 0))
> -		return addr;
> -
> -	/* Make sure that size is MTE granule aligned. */
> -	WARN_ON(size & (MTE_GRANULE_SIZE - 1));
> -
> -	/* Make sure that the address is MTE granule aligned. */
> -	WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
> -
> -	tag = 0xF0 | tag;
> -	ptr = (void *)__tag_set(ptr, tag);
> -
> -	mte_assign_mem_tag_range(ptr, size);
> -
> -	return ptr;
> -}
> -
>  void mte_init_tags(u64 max_tag)
>  {
>  	static bool gcr_kernel_excl_initialized;
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 9e1a12e10053..351537c12f36 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -149,19 +149,3 @@ SYM_FUNC_START(mte_restore_page_tags)
>  
>  	ret
>  SYM_FUNC_END(mte_restore_page_tags)
> -
> -/*
> - * Assign allocation tags for a region of memory based on the pointer tag
> - *   x0 - source pointer
> - *   x1 - size
> - *
> - * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> - * size must be non-zero and MTE_GRANULE_SIZE aligned.
> - */
> -SYM_FUNC_START(mte_assign_mem_tag_range)
> -1:	stg	x0, [x0]
> -	add	x0, x0, #MTE_GRANULE_SIZE
> -	subs	x1, x1, #MTE_GRANULE_SIZE
> -	b.gt	1b
> -	ret
> -SYM_FUNC_END(mte_assign_mem_tag_range)
> 

-- 
Regards,
Vincenzo
