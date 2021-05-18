Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBE387EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbhERRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237923AbhERRqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:46:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4302A611AC;
        Tue, 18 May 2021 17:44:44 +0000 (UTC)
Date:   Tue, 18 May 2021 18:44:41 +0100
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
Subject: Re: [PATCH v3] kasan: speed up mte_set_mem_tag_range
Message-ID: <20210518174439.GA28491@arm.com>
References: <20210517235546.3038875-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517235546.3038875-1-eugenis@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:55:46PM -0700, Evgenii Stepanov wrote:
> Use DC GVA / DC GZVA to speed up KASan memory tagging in HW tags mode.
> 
> The first cacheline is always tagged using STG/STZG even if the address is
> cacheline-aligned, as benchmarks show it is faster than a conditional
> branch.
[...]
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index ddd4d17cf9a0..e29a0e2ab35c 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -48,45 +48,7 @@ static inline u8 mte_get_random_tag(void)
>  	return mte_get_ptr_tag(addr);
>  }
>  
> -/*
> - * Assign allocation tags for a region of memory based on the pointer tag.
> - * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> - * size must be non-zero and MTE_GRANULE_SIZE aligned.
> - */
> -static inline void mte_set_mem_tag_range(void *addr, size_t size,
> -						u8 tag, bool init)

With commit 2cb34276427a ("arm64: kasan: simplify and inline MTE
functions") you wanted this inlined for performance. Does this not
matter much that it's now out of line?

> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index d31e1169d9b8..c06ada79a437 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -18,3 +18,5 @@ obj-$(CONFIG_CRC32) += crc32.o
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  
>  obj-$(CONFIG_ARM64_MTE) += mte.o
> +
> +obj-$(CONFIG_KASAN_HW_TAGS) += mte-kasan.o
> diff --git a/arch/arm64/lib/mte-kasan.S b/arch/arm64/lib/mte-kasan.S
> new file mode 100644
> index 000000000000..9f6975e2af60
> --- /dev/null
> +++ b/arch/arm64/lib/mte-kasan.S
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Google Inc.
> + */
> +#include <linux/const.h>
> +#include <linux/linkage.h>
> +
> +#include <asm/mte-def.h>
> +
> +	.arch	armv8.5-a+memtag
> +
> +	.macro  __set_mem_tag_range, stg, gva, start, size, linesize, tmp1, tmp2, tmp3
> +	add	\tmp3, \start, \size
> +	cmp	\size, \linesize, lsl #1
> +	b.lt	.Lsmtr3_\@

We could do with some comments here. Why the lsl #1? I think I get it
but it would be good to make this more readable.

It may be easier if you placed it in a file on its own (as it is now but
with a less generic file name) and use a few .req instead of the tmpX.
You can use the macro args only for the stg/gva.

> +
> +	sub	\tmp1, \linesize, #1
> +	bic	\tmp2, \tmp3, \tmp1
> +	orr	\tmp1, \start, \tmp1
> +
> +.Lsmtr1_\@:
> +	\stg	\start, [\start], #MTE_GRANULE_SIZE
> +	cmp	\start, \tmp1
> +	b.lt	.Lsmtr1_\@
> +
> +.Lsmtr2_\@:
> +	dc	\gva, \start
> +	add	\start, \start, \linesize
> +	cmp	\start, \tmp2
> +	b.lt	.Lsmtr2_\@
> +
> +.Lsmtr3_\@:
> +	cmp	\start, \tmp3
> +	b.ge	.Lsmtr4_\@
> +	\stg	\start, [\start], #MTE_GRANULE_SIZE
> +	b	.Lsmtr3_\@
> +.Lsmtr4_\@:
> +	.endm

If we want to get the best performance out of this, we should look at
the memset implementation and do something similar. In principle it's
not that far from a memzero, though depending on the microarchitecture
it may behave slightly differently.

Anyway, before that I wonder if we wrote all this in C + inline asm
(three while loops or maybe two and some goto), what's the performance
difference? It has the advantage of being easier to maintain even if we
used some C macros to generate gva/gzva variants.

-- 
Catalin
