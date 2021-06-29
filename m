Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C823B72DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhF2NDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:03:40 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35955 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhF2NDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:03:39 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A9C21240013;
        Tue, 29 Jun 2021 13:01:05 +0000 (UTC)
Subject: Re: [PATCH -next] riscv: mm: remove redundant trampoline PGD for
 64bit
To:     Nanyong Sun <sunnanyong@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup.patel@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmerdabbelt@google.com, atish.patra@wdc.com,
        wangkefeng.wang@huawei.com
References: <20210527144819.12101-1-sunnanyong@huawei.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <33f93026-cbd2-acd4-e737-c744207f82f2@ghiti.fr>
Date:   Tue, 29 Jun 2021 15:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210527144819.12101-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nanyong,

Le 27/05/2021 à 16:48, Nanyong Sun a écrit :
> Remove redundant trampoline PGD for 64bit and add more comment
> for why 32bit systems need trampoline PGD.
> 
> There was a patch and discussion similar to this,refer to
> the link [1][2].
> 
> The trampoline PGD is redundant for 64bit systems because:
> 1. The early PGD covers the entire kernel mapping. Directly
> loading early PGD can achieve the result in boot stage.
> A more trampoline PGD makes code hard to understand.
> 2. Directly loading early PGD is safe in 64bit systems since
> the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
> which has a very big gap with RAM address.It won't fall into
> the corner case that 32bit system worrys.
> 3. Remove redundant trampoline PGD can benefit to code maintaince,
> because 64bit systems have more page table levels.For example:
> If we want to support SV48 which has 4 page table levels, we have
> to add a trampoline_pud and insert it before trampoline_pmd.

I do agree with your last point about code maintenance and this would be 
a welcome improvement before I respin my sv48 series.

Some comments below though.

> 
> Reference link:
> [1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/
> [2]https://lkml.org/lkml/2019/3/28/147
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   arch/riscv/kernel/head.S | 13 +++++++++++--
>   arch/riscv/mm/init.c     | 21 +++++++--------------
>   2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 89cc58ab52b4..1897b17c5fcc 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -93,12 +93,18 @@ relocate:
>   	add a2, a2, a1
>   	csrw CSR_TVEC, a2

This is not needed in 64-bit then.

>   
> -	/* Compute satp for kernel page tables, but don't load it yet */
> +	/* Compute satp for kernel page tables */
>   	srl a2, a0, PAGE_SHIFT
>   	li a1, SATP_MODE
>   	or a2, a2, a1
> -
> +#ifdef CONFIG_64BIT
> +	/* Load kernel page directory */
> +	sfence.vma
> +	csrw CSR_SATP, a2
> +#else
>   	/*
> +	 * 32bit system need a trampoline to handle a corner case where

s/system/systems or s/need/needs.

> +	 * load address range overlaps kernel virtual address range.
>   	 * Load trampoline page directory, which will cause us to trap to
>   	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
>   	 * full fence here because setup_vm() just wrote these PTEs and we need
> @@ -110,6 +116,7 @@ relocate:
>   	or a0, a0, a1
>   	sfence.vma
>   	csrw CSR_SATP, a0
> +#endif /* CONFIG_64BIT */
>   .align 2
>   1:
>   	/* Set trap vector to spin forever to help debug */
> @@ -122,6 +129,7 @@ relocate:
>   	la gp, __global_pointer$
>   .option pop
>   
> +#ifdef CONFIG_32BIT
>   	/*
>   	 * Switch to kernel page tables.  A full fence is necessary in order to
>   	 * avoid using the trampoline translations, which are only correct for
> @@ -130,6 +138,7 @@ relocate:
>   	 */
>   	csrw CSR_SATP, a2
>   	sfence.vma
> +#endif /* CONFIG_32BIT */
> 

I would have done something like that instead, in order to avoid to copy 
the code that loads the kernel page table:


diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 89cc58ab52b4..1251f4d201a8 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -98,18 +98,23 @@ relocate:
         li a1, SATP_MODE
         or a2, a2, a1

+       /*
+        * We need a full fence here because setup_vm() just wrote these 
PTEs
+        * and we need to ensure the new translations are in use.
+        */
+       sfence.vma
+
+#ifndef CONFIG_64BIT
         /*
          * Load trampoline page directory, which will cause us to trap to
-        * stvec if VA != PA, or simply fall through if VA == PA.  We need a
-        * full fence here because setup_vm() just wrote these PTEs and 
we need
-        * to ensure the new translations are in use.
+        * stvec if VA != PA, or simply fall through if VA == PA.
          */
         la a0, trampoline_pg_dir
         XIP_FIXUP_OFFSET a0
         srl a0, a0, PAGE_SHIFT
         or a0, a0, a1
-       sfence.vma
         csrw CSR_SATP, a0
+#endif


>   	ret
>   #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 11b61bea0c4d..b7226ac2d04f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -210,13 +210,17 @@ unsigned long pfn_base __ro_after_init;
>   EXPORT_SYMBOL(pfn_base);
>   
>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +#ifdef CONFIG_32BIT
>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +#endif /* CONFIG_32BIT */
>   pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>   
>   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>   
>   #ifdef CONFIG_XIP_KERNEL
> +#ifdef CONFIG_32BIT
>   #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> +#endif /* CONFIG_32BIT */
>   #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
>   #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
>   #endif /* CONFIG_XIP_KERNEL */
> @@ -291,13 +295,11 @@ static void __init create_pte_mapping(pte_t *ptep,
>   
>   #ifndef __PAGETABLE_PMD_FOLDED
>   
> -pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>   pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>   pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>   pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>   
>   #ifdef CONFIG_XIP_KERNEL
> -#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
>   #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
>   #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
>   #endif /* CONFIG_XIP_KERNEL */
> @@ -543,21 +545,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	/* Setup fixmap PMD */
>   	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>   			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
> -	/* Setup trampoline PGD and PMD */
> -	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
> -			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
> -#ifdef CONFIG_XIP_KERNEL
> -	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
> -			   xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
> -#else
> -	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
> -			   load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
> -#endif
> -#else
> +#endif /* __PAGETABLE_PMD_FOLDED */
> +#ifdef CONFIG_32BIT

Why did you change the #else for an #ifdef CONFIG_32BIT? 
__PAGETABLE_PMD_FOLDED <=> CONFIG_32BIT anyway.

>   	/* Setup trampoline PGD */
>   	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>   			   load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
> -#endif
> +#endif /* CONFIG_32BIT */

If you use IS_ENABLED(CONFIG_32BIT) instead of #ifdef (and maybe rather 
CONFIG_64BIT as this is the config that is widely used to distinguish 
between both), that would avoid the #ifdef around trampoline_pg_dir 
which would be even more readable.

>   
>   	/*
>   	 * Setup early PGD covering entire kernel which will allow
> 

Thanks,

Alex
