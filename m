Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50741C4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhI2MrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343839AbhI2MrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:47:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F262261440;
        Wed, 29 Sep 2021 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632919520;
        bh=RXDE5M5rS3BG4DB0A4fRr/sgXzl2aeSejpL7gbAGn24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdh0ZJEm/CHv4v+/bE4sfFG59Ez2paMS/wHUQ6RtlqKpoTyGnVFkFawnK+5SR1t+S
         WK/o4bhGXw24dNxY7+G7SAUEle61ItyU7kfnjG0bJAgiS7hpcomfZfv3hwAf7u0rvA
         VLIQGLFrNAKM87b9LyMhMh5w4e39aLi9N9BKgNo3+8zim0O4oj/1d74o4Ly5rcJmRi
         hZf0oo/88L2V26uE8m+bXchf+cU0IfpIepvB5dN27QRZfzS5gWmFBokL1US0VIdsa6
         euafbZoEmRhedDtaf7pnV75m6UVz1uDe34jjRdWr0KgS7lErl3ptVSvIhIj5KyKBSi
         Sndd96WL9W2Fw==
Date:   Wed, 29 Sep 2021 13:45:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 10/15] arm64: kexec: use ld script for relocation
 function
Message-ID: <20210929124513.GD21631@willie-the-truck>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-11-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:13:20PM -0400, Pasha Tatashin wrote:
> Currently, relocation code declares start and end variables
> which are used to compute its size.
> 
> The better way to do this is to use ld script incited, and put relocation
> function in its own section.

"incited"? I don't understand ...

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/sections.h   |  1 +
>  arch/arm64/kernel/machine_kexec.c   | 16 ++++++----------
>  arch/arm64/kernel/relocate_kernel.S | 15 ++-------------
>  arch/arm64/kernel/vmlinux.lds.S     | 19 +++++++++++++++++++
>  4 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> index e4ad9db53af1..152cb35bf9df 100644
> --- a/arch/arm64/include/asm/sections.h
> +++ b/arch/arm64/include/asm/sections.h
> @@ -21,5 +21,6 @@ extern char __exittext_begin[], __exittext_end[];
>  extern char __irqentry_text_start[], __irqentry_text_end[];
>  extern char __mmuoff_data_start[], __mmuoff_data_end[];
>  extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
> +extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
>  
>  #endif /* __ASM_SECTIONS_H */
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index cf5d6f22a041..83da6045cd45 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -21,14 +21,11 @@
>  #include <asm/mmu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/page.h>
> +#include <asm/sections.h>
>  #include <asm/trans_pgd.h>
>  
>  #include "cpu-reset.h"
>  
> -/* Global variables for the arm64_relocate_new_kernel routine. */
> -extern const unsigned char arm64_relocate_new_kernel[];
> -extern const unsigned long arm64_relocate_new_kernel_size;
> -
>  /**
>   * kexec_image_info - For debugging output.
>   */
> @@ -163,6 +160,7 @@ static void *kexec_page_alloc(void *arg)
>  int machine_kexec_post_load(struct kimage *kimage)
>  {
>  	void *reloc_code = page_to_virt(kimage->control_code_page);
> +	long reloc_size;
>  	struct trans_pgd_info info = {
>  		.trans_alloc_page	= kexec_page_alloc,
>  		.trans_alloc_arg	= kimage,
> @@ -183,17 +181,15 @@ int machine_kexec_post_load(struct kimage *kimage)
>  			return rc;
>  	}
>  
> -	memcpy(reloc_code, arm64_relocate_new_kernel,
> -	       arm64_relocate_new_kernel_size);
> +	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
> +	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
>  	kimage->arch.kern_reloc = __pa(reloc_code);
>  
>  	/* Flush the reloc_code in preparation for its execution. */
>  	dcache_clean_inval_poc((unsigned long)reloc_code,
> -			       (unsigned long)reloc_code +
> -			       arm64_relocate_new_kernel_size);
> +			       (unsigned long)reloc_code +  reloc_size);

Extra whitespace.

>  	icache_inval_pou((uintptr_t)reloc_code,
> -			 (uintptr_t)reloc_code +
> -			 arm64_relocate_new_kernel_size);
> +			 (uintptr_t)reloc_code + reloc_size);
>  	kexec_list_flush(kimage);
>  	kexec_image_info(kimage);
>  
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index b4fb97312a80..9d2400855ee4 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -15,6 +15,7 @@
>  #include <asm/sysreg.h>
>  #include <asm/virt.h>
>  
> +.pushsection    ".kexec_relocate.text", "ax"

Just use .section if you're putting the entire file in there?

>  /*
>   * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
>   *
> @@ -77,16 +78,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
>  	mov	x3, xzr
>  	br	x4				/* Jumps from el1 */
>  SYM_CODE_END(arm64_relocate_new_kernel)
> -
> -.align 3	/* To keep the 64-bit values below naturally aligned. */
> -
> -.Lcopy_end:
> -.org	KEXEC_CONTROL_PAGE_SIZE
> -
> -/*
> - * arm64_relocate_new_kernel_size - Number of bytes to copy to the
> - * control_code_page.
> - */
> -.globl arm64_relocate_new_kernel_size
> -arm64_relocate_new_kernel_size:
> -	.quad	.Lcopy_end - arm64_relocate_new_kernel
> +.popsection
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index f6b1a88245db..ab457b609e69 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -63,6 +63,7 @@
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/kernel-pgtable.h>
> +#include <asm/kexec.h>
>  #include <asm/memory.h>
>  #include <asm/page.h>
>  
> @@ -100,6 +101,16 @@ jiffies = jiffies_64;
>  #define HIBERNATE_TEXT
>  #endif
>  
> +#ifdef CONFIG_KEXEC_CORE
> +#define KEXEC_TEXT					\
> +	. = ALIGN(SZ_4K);				\
> +	__relocate_new_kernel_start = .;		\
> +	*(.kexec_relocate.text)				\
> +	__relocate_new_kernel_end = .;
> +#else
> +#define KEXEC_TEXT
> +#endif
> +
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  #define TRAMP_TEXT					\
>  	. = ALIGN(PAGE_SIZE);				\
> @@ -160,6 +171,7 @@ SECTIONS
>  			HYPERVISOR_TEXT
>  			IDMAP_TEXT
>  			HIBERNATE_TEXT
> +			KEXEC_TEXT
>  			TRAMP_TEXT
>  			*(.fixup)
>  			*(.gnu.warning)
> @@ -348,3 +360,10 @@ ASSERT(swapper_pg_dir - reserved_pg_dir == RESERVED_SWAPPER_OFFSET,
>  ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
>         "TRAMP_SWAPPER_OFFSET is wrong!")
>  #endif
> +
> +#ifdef CONFIG_KEXEC_CORE
> +/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
> +ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
> +	<= SZ_4K, "kexec relocation code is too big or misaligned")
> +ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")

Typo: "brokern",

Will
