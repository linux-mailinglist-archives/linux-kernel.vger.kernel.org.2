Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D523DEB02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhHCKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235388AbhHCKez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B87F060F01;
        Tue,  3 Aug 2021 10:34:43 +0000 (UTC)
Date:   Tue, 3 Aug 2021 11:34:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix idmap on [16K|36VA|48PA]
Message-ID: <20210803103440.GA5786@arm.com>
References: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:12:39AM +0530, Anshuman Khandual wrote:
> When creating the idmap, the kernel may add one extra level to idmap memory
> outside the VA range. But for [16K|36VA|48PA], we need two levels to reach
> 48 bits. If the bootloader places the kernel in memory above (1 << 46), the

Did you mean (1 << 36)?

> kernel will fail to enable the MMU. Although we are not aware of a platform
> where this happens, it is worth to accommodate such scenarios and prevent a
> possible kernel crash.
> 
> Lets fix the problem on the above configuration by creating two additional
> idmap page table levels when 'idmap_text_end' is outside the VA range. This
> reduces 'idmap_t0sz' to cover the entire PA range which would prevent table
> misconfiguration (fault) when a given 'idmap_t0sz' value requires a single
> additional page table level where as two have been built.
[...]
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c5c994a..da33bbc 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -329,7 +329,9 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  
>  #if (VA_BITS < 48)
>  #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
> +#define EXTRA_SHIFT_1	(EXTRA_SHIFT + PAGE_SHIFT - 3)
>  #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
> +#define EXTRA_PTRS_1	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT_1))
>  
>  	/*
>  	 * If VA_BITS < 48, we have to configure an additional table level.
> @@ -342,8 +344,30 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  #error "Mismatch between VA_BITS and page size/number of translation levels"
>  #endif
>  
> +/*
> + * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
> + * scenario where 'idmap_text_end' ends up high enough in the PA range
> + * requiring two additional idmap page table levels. Reduce idmap_t0sz
> + * to cover the entire PA range. This prevents table misconfiguration
> + * when a given idmap_t0sz value just requires single additional level
> + * where as two levels have been built.
> + */
> +#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)
> +	mov	x4, EXTRA_PTRS_1
> +	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
> +
> +	mov	x4, PTRS_PER_PTE
> +	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
> +
> +	mov	x5, #64 - PHYS_MASK_SHIFT
> +	adr_l	x6, idmap_t0sz
> +	str	x5, [x6]
> +	dmb	sy
> +	dc	ivac, x6
> +#else
>  	mov	x4, EXTRA_PTRS
>  	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
> +#endif
>  #else
>  	/*
>  	 * If VA_BITS == 48, we don't have to configure an additional

There's a prior idmap_t0sz setting based on __idmap_text_end. Isn't that
sufficient? We don't care about covering the whole PA space, just the
__idmap_text_end.

-- 
Catalin
