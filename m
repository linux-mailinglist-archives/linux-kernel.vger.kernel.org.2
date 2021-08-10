Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E133DD5E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhHBMnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:43:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:32889 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhHBMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:43:23 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D138024000A;
        Mon,  2 Aug 2021 12:43:02 +0000 (UTC)
Subject: Re: [PATCH v2 -next] riscv: mm: remove redundant trampoline PGD for
 64bit
From:   Alex Ghiti <alex@ghiti.fr>
To:     Nanyong Sun <sunnanyong@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup.patel@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmerdabbelt@google.com, atish.patra@wdc.com,
        wangkefeng.wang@huawei.com, tiantao6@hisilicon.com,
        qiuwenbo@phytium.com.cn, rppt@kernel.org, jszhang@kernel.org,
        mick@ics.forth.gr
References: <20210728024910.1417720-1-sunnanyong@huawei.com>
 <3199c658-ffac-729d-d93d-8895e7d3668e@ghiti.fr>
Message-ID: <6198036e-353c-dac5-5399-8b823a89f926@ghiti.fr>
Date:   Mon, 2 Aug 2021 14:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3199c658-ffac-729d-d93d-8895e7d3668e@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nanyong,

Le 28/07/2021 � 13:55, Alex Ghiti a �crit�:
> 
> 
> Le 28/07/2021 � 04:49, Nanyong Sun a �crit�:
>> Remove redundant trampoline PGD for 64bit and add more comment
>> for why 32bit systems need trampoline PGD.
>>
>> There was a patch and discussion similar to this,refer to
>> the link [1][2].
>>
>> The trampoline PGD is redundant for 64bit systems because:
>> 1. The early PGD covers the entire kernel mapping. Directly
>> loading early PGD can achieve the result in boot stage.
>> A more trampoline PGD makes code hard to understand.
>> 2. Directly loading early PGD is safe in 64bit systems since
>> the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
>> which has a very big gap with RAM address.It won't fall into
>> the corner case that 32bit system worrys.
>> 3. Remove redundant trampoline PGD can benefit to code maintaince,
>> because 64bit systems have more page table levels.For example:
>> If we want to support SV48 which has 4 page table levels, we have
>> to add a trampoline_pud and insert it before trampoline_pmd.
>>
>> Reference link:
>> [1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/ 
>>
>> [2]https://lkml.org/lkml/2019/3/28/147
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> 
> I have not reviewed this patch yet! :)
> 
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: weiyongjun <weiyongjun1@huawei.com>
>> ---
>> v2 changes:
>> �� Adjust codes based on the review suggestions from Alex Ghiti,
>> �� make codes more readable.
>> ---
>> � arch/riscv/kernel/head.S | 46 ++++++++++++++++++++++++++--------------
>> � arch/riscv/mm/init.c���� | 16 ++++----------
>> � 2 files changed, 34 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index fce5184b22c3..3816aa5edc69 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -89,29 +89,52 @@ relocate:
>> ����� add ra, ra, a1
>> ����� /* Point stvec to virtual address of intruction after satp write */
>> -��� la a2, 1f
>> +#ifdef CONFIG_64BIT
>> +��� la a2, load_done
>> +#else
>> +��� la a2, load_kernel_pgd
>> +#endif
>> ����� add a2, a2, a1
>> ����� csrw CSR_TVEC, a2
>> -��� /* Compute satp for kernel page tables, but don't load it yet */
>> +��� /* Compute satp for kernel page tables.
>> +���� * For 64bit systems, load it and trap to stvec.
>> +���� * For 32bit systems, don't load it yet.
>> +���� */
>> ����� srl a2, a0, PAGE_SHIFT
>> ����� li a1, SATP_MODE
>> ����� or a2, a2, a1
>> ����� /*
>> +���� * Before writing satp, we need a full fence here because 
>> setup_vm() just
>> +���� * wrote these PTEs and we need to ensure the new translations 
>> are in use.
>> +���� */
>> +��� sfence.vma
>> +#ifndef CONFIG_64BIT
>> +��� /*
>> +���� * 32bit systems need firstly loading a trampoline to handle a 
>> corner
>> +���� * case where load address range overlaps kernel virtual address 
>> range.
>> ������ * Load trampoline page directory, which will cause us to trap to
>> -���� * stvec if VA != PA, or simply fall through if VA == PA.� We need a
>> -���� * full fence here because setup_vm() just wrote these PTEs and 
>> we need
>> -���� * to ensure the new translations are in use.
>> +���� * stvec if VA != PA, or simply fall through if VA == PA.
>> ������ */
>> ����� la a0, trampoline_pg_dir
>> ����� XIP_FIXUP_OFFSET a0
>> ����� srl a0, a0, PAGE_SHIFT
>> ����� or a0, a0, a1
>> -��� sfence.vma
>> ����� csrw CSR_SATP, a0
>> +#endif
>> � .align 2
>> -1:
>> +load_kernel_pgd:
>> +������� /*
>> +�������� * Switch to kernel page tables.� A full fence is necessary 
>> in order to
>> +�������� * avoid using the trampoline translations, which are only 
>> correct for
>> +�������� * the first superpage.� Fetching the fence is guarnteed to work
>> +�������� * because that first superpage is translated the same way.
>> +�������� */
>> +������� csrw CSR_SATP, a2
>> +������� sfence.vma
>> +
>> +load_done:
>> ����� /* Set trap vector to spin forever to help debug */
>> ����� la a0, .Lsecondary_park
>> ����� csrw CSR_TVEC, a0


I suppose stvec was set this way to catch any problem with early_pg_dir, 
you moved that and then this defeats this original purpose.


>> @@ -122,15 +145,6 @@ relocate:
>> ����� la gp, __global_pointer$
>> � .option pop
>> -��� /*
>> -���� * Switch to kernel page tables.� A full fence is necessary in 
>> order to
>> -���� * avoid using the trampoline translations, which are only 
>> correct for
>> -���� * the first superpage.� Fetching the fence is guarnteed to work
>> -���� * because that first superpage is translated the same way.
>> -���� */
>> -��� csrw CSR_SATP, a2
>> -��� sfence.vma
>> -
>> ����� ret
>> � #endif /* CONFIG_MMU */
>> � #ifdef CONFIG_SMP
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index ac48742fa6fc..306fcb2334fa 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -219,13 +219,17 @@ unsigned long pfn_base __ro_after_init;
>> � EXPORT_SYMBOL(pfn_base);
>> � pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> +#ifndef CONFIG_64BIT
>> � pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> +#endif /* CONFIG_64BIT */


As stated in Documentation/process/coding-style.rst, it is better to use 
__maybe_unused rather than #ifdefs.


>> � static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>> � pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>> � #ifdef CONFIG_XIP_KERNEL
>> +#ifndef CONFIG_64BIT
>> � #define trampoline_pg_dir����� ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
>> +#endif /* CONFIG_64BIT */


Using __maybe_unused allows to remove those too.


>> � #define fixmap_pte������������ ((pte_t *)XIP_FIXUP(fixmap_pte))
>> � #define early_pg_dir���������� ((pgd_t *)XIP_FIXUP(early_pg_dir))
>> � #endif /* CONFIG_XIP_KERNEL */
>> @@ -300,13 +304,11 @@ static void __init create_pte_mapping(pte_t *ptep,
>> � #ifndef __PAGETABLE_PMD_FOLDED
>> -static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> � static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> � static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>> � static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata 
>> __aligned(PAGE_SIZE);
>> � #ifdef CONFIG_XIP_KERNEL
>> -#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
>> � #define fixmap_pmd���� ((pmd_t *)XIP_FIXUP(fixmap_pmd))
>> � #define early_pmd����� ((pmd_t *)XIP_FIXUP(early_pmd))
>> � #endif /* CONFIG_XIP_KERNEL */
>> @@ -585,16 +587,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>> ����� /* Setup fixmap PMD */
>> ����� create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>> ���������������� (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
>> -��� /* Setup trampoline PGD and PMD */
>> -��� create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
>> -�������������� (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
>> -#ifdef CONFIG_XIP_KERNEL
>> -��� create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
>> -�������������� kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
>> -#else
>> -��� create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
>> -�������������� kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
>> -#endif
>> � #else
>> ����� /* Setup trampoline PGD */
>> ����� create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
>>
> 

Overall this version adds more complexity to assembly code than I 
thought, but I don't see any way to improve that (which does not mean 
there isn't!).

Thanks,

Alex


> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
