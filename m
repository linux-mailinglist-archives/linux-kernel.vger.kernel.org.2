Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8038A0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhETJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhETJWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:22:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B80B6124C;
        Thu, 20 May 2021 09:21:08 +0000 (UTC)
Date:   Thu, 20 May 2021 10:21:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kasan: speed up mte_set_mem_tag_range
Message-ID: <20210520092105.GA12251@arm.com>
References: <20210520020305.2826694-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520020305.2826694-1-eugenis@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 07:03:05PM -0700, Evgenii Stepanov wrote:
> Use DC GVA / DC GZVA to speed up KASan memory tagging in HW tags mode.
> 
> The first cacheline is always tagged using STG/STZG even if the address is
> cacheline-aligned, as benchmarks show it is faster than a conditional
> branch.
> 
> Signed-off-by: Evgenii Stepanov <eugenis@google.com>
> Co-developed-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Some nitpicks below but it looks fine otherwise.

> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index ddd4d17cf9a0..34e23886f346 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -48,43 +48,85 @@ static inline u8 mte_get_random_tag(void)
>  	return mte_get_ptr_tag(addr);
>  }
>  
> +static inline u64 __stg_post(u64 p)
> +{
> +	asm volatile(__MTE_PREAMBLE "stg %0, [%0], #16"
> +		     : "+r"(p)
> +		     :
> +		     : "memory");
> +	return p;
> +}
> +
> +static inline u64 __stzg_post(u64 p)
> +{
> +	asm volatile(__MTE_PREAMBLE "stzg %0, [%0], #16"
> +		     : "+r"(p)
> +		     :
> +		     : "memory");
> +	return p;
> +}
> +
> +static inline void __dc_gva(u64 p)
> +{
> +	asm volatile(__MTE_PREAMBLE "dc gva, %0" : : "r"(p) : "memory");
> +}
> +
> +static inline void __dc_gzva(u64 p)
> +{
> +	asm volatile(__MTE_PREAMBLE "dc gzva, %0" : : "r"(p) : "memory");
> +}
> +
>  /*
>   * Assign allocation tags for a region of memory based on the pointer tag.
>   * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> - * size must be non-zero and MTE_GRANULE_SIZE aligned.
> + * size must be MTE_GRANULE_SIZE aligned.
>   */
> -static inline void mte_set_mem_tag_range(void *addr, size_t size,
> -						u8 tag, bool init)
> +static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
> +					 bool init)
>  {
> -	u64 curr, end;
> +	u64 curr, DCZID, mask, line_size, end1, end2, end3;

Nitpick 1: please use lowercase for variables even if they match some
register.

>  
> -	if (!size)
> -		return;
> +	/* Read DC G(Z)VA store size from the register. */
> +	__asm__ __volatile__(__MTE_PREAMBLE "mrs %0, dczid_el0"
> +			     : "=r"(DCZID)::);
> +	line_size = 4ul << (DCZID & 0xf);

No need for __MTE_PREAMBLE here, this register has been available since
8.0. Even better, just use read_cpuid(DCZID_EL0) directly rather than
asm.

I'd also call this variable block_size (or dczid_bs etc.), it's not
necessarily a cache line size (we have CTR_EL0 for that), though most
implementations probably do just that. There are a few instances below
where the comments refer to cache lines.

>  	curr = (u64)__tag_set(addr, tag);
> -	end = curr + size;
> -
> -	/*
> -	 * 'asm volatile' is required to prevent the compiler to move
> -	 * the statement outside of the loop.
> +	mask = line_size - 1;
> +	/* STG/STZG up to the end of the first cache line. */
> +	end1 = curr | mask;
> +	end3 = curr + size;
> +	/* DC GVA / GZVA in [end1, end2) */
> +	end2 = end3 & ~mask;
> +
> +	/* The following code uses STG on the first cache line even if the start
> +	 * address is cache line aligned - it appears to be faster than an
> +	 * alignment check + conditional branch. Also, if the size is at least 2
> +	 * cache lines, the first two loops can use post-condition to save one
> +	 * branch each.
>  	 */

Nitpick 2: the multiline comments start with an empty /* (as per the
coding style doc).

> -	if (init) {
> -		do {
> -			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
> -				     :
> -				     : "r" (curr)
> -				     : "memory");
> -			curr += MTE_GRANULE_SIZE;
> -		} while (curr != end);
> -	} else {
> -		do {
> -			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> -				     :
> -				     : "r" (curr)
> -				     : "memory");
> -			curr += MTE_GRANULE_SIZE;
> -		} while (curr != end);
> -	}
> +#define SET_MEMTAG_RANGE(stg_post, dc_gva)		\
> +	do {						\
> +		if (size >= 2 * line_size) {		\
> +			do {				\
> +				curr = stg_post(curr);	\
> +			} while (curr < end1);		\
> +							\
> +			do {				\
> +				dc_gva(curr);		\
> +				curr += line_size;	\
> +			} while (curr < end2);		\
> +		}					\
> +							\
> +		while (curr < end3)			\
> +			curr = stg_post(curr);		\
> +	} while (0)
> +
> +	if (init)
> +		SET_MEMTAG_RANGE(__stzg_post, __dc_gzva);
> +	else
> +		SET_MEMTAG_RANGE(__stg_post, __dc_gva);
> +#undef SET_MEMTAG_RANGE
>  }
>  
>  void mte_enable_kernel_sync(void);
> -- 
> 2.31.1.751.gd2f1c929bd-goog

With the above fixed, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(aiming at 5.14)

-- 
Catalin
