Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EC382093
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEPTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:12:09 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51739 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEPTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:12:08 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 24D2EFF803;
        Sun, 16 May 2021 19:10:48 +0000 (UTC)
Subject: Re: [PATCH] riscv: mm: init: Consolidate vars, functions
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210516211556.43c00055@xhacker>
 <20210516211922.2110232e@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <66c8965d-494f-6c2f-0739-9bee13fc507c@ghiti.fr>
Date:   Sun, 16 May 2021 21:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516211922.2110232e@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 16/05/2021 15:19, Jisheng Zhang wrote:
> On Sun, 16 May 2021 21:15:56 +0800 Jisheng Zhang  wrote:
> 
>> From: Jisheng Zhang <jszhang@kernel.org>
>>
>> Consolidate the following items in init.c
>>
>> Staticize global vars as much as possible;
>> Add __initdata mark if the global var isn't needed after init
>> Add __init mark if the func isn't needed after init
>> Add __ro_after_init if the global var is read only after init
> 
> Hi Alexandre,
> 
> I think kernel_virt_addr can be removed, users can directly use
> the KERNEL_LINK_ADDR MACRO. Maybe I miss the reason of intrducing
> it in commit 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of
> linear mapping"), could you please comment?
> 
> Thanks in advance

kernel_virt_addr will be used when I push my relocatable series since 
then, the kernel virtual address will be different from 
KERNEL_LINK_ADDR. I agree this was not needed in 2bfc6cd81bd17e43 
("riscv: Move kernel mapping outside of linear mapping"), I'm a bit late 
in pushing the relocatable series.

> 
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   arch/riscv/include/asm/set_memory.h |  2 +-
>>   arch/riscv/mm/init.c                | 36 +++++++++++++++--------------
>>   2 files changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
>> index 086f757e8ba3..9d4d455726d4 100644
>> --- a/arch/riscv/include/asm/set_memory.h
>> +++ b/arch/riscv/include/asm/set_memory.h
>> @@ -27,7 +27,7 @@ static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0;
>>   #endif
>>   
>>   #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
>> -void protect_kernel_linear_mapping_text_rodata(void);
>> +void __init protect_kernel_linear_mapping_text_rodata(void);
>>   #else
>>   static inline void protect_kernel_linear_mapping_text_rodata(void) {}
>>   #endif
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 4c4c92ce0bb8..eac2d5c27b3e 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -53,7 +53,7 @@ struct pt_alloc_ops {
>>   #endif
>>   };
>>   
>> -static phys_addr_t dma32_phys_limit __ro_after_init;
>> +static phys_addr_t dma32_phys_limit __initdata;
>>   
>>   static void __init zone_sizes_init(void)
>>   {
>> @@ -184,7 +184,7 @@ extern char _sdata[], _edata[];
>>   #endif /* CONFIG_XIP_KERNEL */
>>   
>>   #ifdef CONFIG_MMU
>> -static struct pt_alloc_ops _pt_ops __ro_after_init;
>> +static struct pt_alloc_ops _pt_ops __initdata;
>>   
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
>> @@ -200,13 +200,13 @@ EXPORT_SYMBOL(va_pa_offset);
>>   #endif
>>   /* Offset between kernel mapping virtual address and kernel load address */
>>   #ifdef CONFIG_64BIT
>> -unsigned long va_kernel_pa_offset;
>> +unsigned long va_kernel_pa_offset __ro_after_init;
>>   EXPORT_SYMBOL(va_kernel_pa_offset);
>>   #endif
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define va_kernel_pa_offset    (*((unsigned long *)XIP_FIXUP(&va_kernel_pa_offset)))
>>   #endif
>> -unsigned long va_kernel_xip_pa_offset;
>> +unsigned long va_kernel_xip_pa_offset __ro_after_init;
>>   EXPORT_SYMBOL(va_kernel_xip_pa_offset);
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define va_kernel_xip_pa_offset        (*((unsigned long *)XIP_FIXUP(&va_kernel_xip_pa_offset)))
>> @@ -216,7 +216,7 @@ EXPORT_SYMBOL(pfn_base);
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> -pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>> +static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>>   
>>   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>   
>> @@ -253,7 +253,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
>>   	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
>>   }
>>   
>> -static inline pte_t *get_pte_virt_late(phys_addr_t pa)
>> +static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
>>   {
>>   	return (pte_t *) __va(pa);
>>   }
>> @@ -272,7 +272,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
>>   	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>   }
>>   
>> -static phys_addr_t alloc_pte_late(uintptr_t va)
>> +static phys_addr_t __init alloc_pte_late(uintptr_t va)
>>   {
>>   	unsigned long vaddr;
>>   
>> @@ -296,10 +296,10 @@ static void __init create_pte_mapping(pte_t *ptep,
>>   
>>   #ifndef __PAGETABLE_PMD_FOLDED
>>   
>> -pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> -pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> -pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>> -pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>> +static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>> +static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>>   
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
>> @@ -319,7 +319,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
>>   	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
>>   }
>>   
>> -static pmd_t *get_pmd_virt_late(phys_addr_t pa)
>> +static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
>>   {
>>   	return (pmd_t *) __va(pa);
>>   }
>> @@ -336,7 +336,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
>>   	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>   }
>>   
>> -static phys_addr_t alloc_pmd_late(uintptr_t va)
>> +static phys_addr_t __init alloc_pmd_late(uintptr_t va)
>>   {
>>   	unsigned long vaddr;
>>   
>> @@ -454,14 +454,16 @@ asmlinkage void __init __copy_data(void)
>>   #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>>   #endif
>>   
>> -uintptr_t load_pa, load_sz;
>> +static uintptr_t load_pa __initdata;
>> +static uintptr_t load_sz __initdata;
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define load_pa        (*((uintptr_t *)XIP_FIXUP(&load_pa)))
>>   #define load_sz        (*((uintptr_t *)XIP_FIXUP(&load_sz)))
>>   #endif
>>   
>>   #ifdef CONFIG_XIP_KERNEL
>> -uintptr_t xiprom, xiprom_sz;
>> +static uintptr_t xiprom __inidata;
>> +static uintptr_t xiprom_sz __initdata;
>>   #define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
>>   #define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
>>   
>> @@ -646,7 +648,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>   }
>>   
>>   #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
>> -void protect_kernel_linear_mapping_text_rodata(void)
>> +void __init protect_kernel_linear_mapping_text_rodata(void)
>>   {
>>   	unsigned long text_start = (unsigned long)lm_alias(_start);
>>   	unsigned long init_text_start = (unsigned long)lm_alias(__init_text_begin);
>> @@ -858,7 +860,7 @@ static void __init reserve_crashkernel(void)
>>    * reserved once we call early_init_fdt_scan_reserved_mem()
>>    * later on.
>>    */
>> -static int elfcore_hdr_setup(struct reserved_mem *rmem)
>> +static int __init elfcore_hdr_setup(struct reserved_mem *rmem)
>>   {
>>   	elfcorehdr_addr = rmem->base;
>>   	elfcorehdr_size = rmem->size;
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
