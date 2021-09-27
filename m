Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23EE41927E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhI0Kuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:50:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233848AbhI0Kui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:50:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA89ED1;
        Mon, 27 Sep 2021 03:49:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0088A3F70D;
        Mon, 27 Sep 2021 03:48:57 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:48:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix non-converging vmlinux link
Message-ID: <20210927104851.GA3292@C02TD0UTHF1T.local>
References: <20210927093043.380604-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927093043.380604-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Ard,

On Mon, Sep 27, 2021 at 11:30:11AM +0200, Arnd Bergmann wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> When the size of the vmlinux file is just below 64MB, the kernel
> may fail to link with lld, producing output such as
> 
> ld.lld: error: assignment to symbol init_pg_end does not converge
> ld.lld: error: assignment to symbol __pecoff_data_size does not converge
> 
> Change the INIT_DIR_SIZE definition to include init_pg_dir
                                        ^
Missing "not" here ---------------------'

We *need* to access `init_pg_dir` while using `init_pg_dir`, since e.g.
early_fixmap_init() needs to conntect the fixmap tables into it, so we
*must* map at least a portion of `init_pg_dir`.

We happen to over-map when using 4K pages, and so depending on the
alignment and size of the kernel Image this can work by chance. Also,
prior to v5.15-rc1, we'd over-map in all configurations, and this could
happen to work, but that was fixed in commit:

  90268574a3e8a6b8 ("arm64: head: avoid over-mapping in map_memory")

So as-is, this patch regresses working configurations at runtime,
including all 16K and 64K configs.

Is there some way we can over-estimate the size such that this will
converge? e.g. add some alignment padding such that `_end` won't
oscillate as `init_pg_end` changes?

Thanks,
Mark.

> to get a stable size calculation.
> 
> Arnd did the original report and analysis, but Ard figured what
> to do about and wrote the changes to the code.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1219
> Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Ard, I had this in my randconfig tree with comment "Ard will
> submit this with a proper changelog", but it seems we both forgot
> about it, or maybe there was something wrong with it in the
> end.
> 
> While looking for randconfig -Werror warnings in mainline I came
> across it again and can confirm that this patch (or something like
> it) is still needed. Let me know if you are happy with this version
> or if you have a better description for it. I unfortunately forgot
> the details of how this works.
> ---
>  arch/arm64/include/asm/kernel-pgtable.h | 2 +-
>  arch/arm64/kernel/head.S                | 5 ++---
>  arch/arm64/kernel/vmlinux.lds.S         | 3 +++
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 96dc0f7da258..5c622c18280a 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -86,7 +86,7 @@
>  			+ EARLY_PGDS((vstart), (vend)) 	/* each PGDIR needs a next level page table */	\
>  			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
>  			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
> -#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end))
> +#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, init_pg_dir))
>  #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
>  
>  /* Initial memory map size */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 17962452e31d..2c3011660e48 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -366,10 +366,9 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
>  	add	x5, x5, x23			// add KASLR displacement
>  	mov	x4, PTRS_PER_PGD
> -	adrp	x6, _end			// runtime __pa(_end)
>  	adrp	x3, _text			// runtime __pa(_text)
> -	sub	x6, x6, x3			// _end - _text
> -	add	x6, x6, x5			// runtime __va(_end)
> +	sub	x6, x0, x3			// init_pg_dir - _text
> +	add	x6, x6, x5			// runtime __va(init_pg_dir)
>  
>  	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index f6b1a88245db..4792ddd1ae73 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -287,6 +287,9 @@ SECTIONS
>  	BSS_SECTION(SBSS_ALIGN, 0, 0)
>  
>  	. = ALIGN(PAGE_SIZE);
> +
> +	/* ----- kernel virtual mapping ends here ---- */
> +
>  	init_pg_dir = .;
>  	. += INIT_DIR_SIZE;
>  	init_pg_end = .;
> -- 
> 2.29.2
> 
