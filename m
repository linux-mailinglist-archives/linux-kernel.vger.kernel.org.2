Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E660E30C433
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhBBPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235752AbhBBPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:42:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F04BF64F4B;
        Tue,  2 Feb 2021 15:42:03 +0000 (UTC)
Date:   Tue, 2 Feb 2021 15:42:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] arm64: kasan: simplify and inline MTE functions
Message-ID: <20210202154200.GC26895@gaia>
References: <cover.1612208222.git.andreyknvl@google.com>
 <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43:34PM +0100, Andrey Konovalov wrote:
> +/*
> + * Assign allocation tags for a region of memory based on the pointer tag.
> + * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> + * size must be non-zero and MTE_GRANULE_SIZE aligned.
> + */

OK, so we rely on the caller to sanity-check the range. Fine by me but I
can see (un)poison_range() only doing this for the size. Do we guarantee
that the start address is aligned?

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

This function used to return a pointer and that's what the dummy static
inline does here. However, the new mte_set_mem_tag_range() doesn't
return anything. We should have consistency between the two (the new
static void definition is fine by me).

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
