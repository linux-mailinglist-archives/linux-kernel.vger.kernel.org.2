Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E731AAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhBMKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:53:28 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:14161 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhBMKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:53:24 -0500
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CC2B9240007;
        Sat, 13 Feb 2021 10:52:36 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] riscv/kasan: add KASAN_VMALLOC support
From:   Alex Ghiti <alex@ghiti.fr>
To:     Palmer Dabbelt <palmer@dabbelt.com>, nylon7@andestech.com
Cc:     aou@eecs.berkeley.edu, nickhu@andestech.com, alankao@andestech.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        nylon7717@gmail.com, glider@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aryabinin@virtuozzo.com, linux-riscv@lists.infradead.org,
        dvyukov@google.com
References: <mhng-443fd141-b9a3-4be6-a056-416877f99ea4@palmerdabbelt-glaptop>
 <2b2f3038-3e27-8763-cf78-3fbbfd2100a0@ghiti.fr>
Message-ID: <4fa97788-157c-4059-ae3f-28ab074c5836@ghiti.fr>
Date:   Sat, 13 Feb 2021 05:52:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2b2f3038-3e27-8763-cf78-3fbbfd2100a0@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nylon, Palmer,

Le 2/8/21 � 1:28 AM, Alex Ghiti a �crit�:
> Hi Nylon,
> 
> Le 1/22/21 � 10:56 PM, Palmer Dabbelt a �crit�:
>> On Fri, 15 Jan 2021 21:58:35 PST (-0800), nylon7@andestech.com wrote:
>>> It references to x86/s390 architecture.
>>> >> So, it doesn't map the early shadow page to cover VMALLOC space.
>>>
>>> Prepopulate top level page table for the range that would otherwise be
>>> empty.
>>>
>>> lower levels are filled dynamically upon memory allocation while
>>> booting.
> 
> I think we can improve the changelog a bit here with something like that:
> 
> "KASAN vmalloc space used to be mapped using kasan early shadow page. 
> KASAN_VMALLOC requires the top-level of the kernel page table to be 
> properly populated, lower levels being filled dynamically upon memory 
> allocation at runtime."
> 
>>>
>>> Signed-off-by: Nylon Chen <nylon7@andestech.com>
>>> Signed-off-by: Nick Hu <nickhu@andestech.com>
>>> ---
>>> �arch/riscv/Kconfig�������� |� 1 +
>>> �arch/riscv/mm/kasan_init.c | 57 +++++++++++++++++++++++++++++++++++++-
>>> �2 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 81b76d44725d..15a2c8088bbe 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -57,6 +57,7 @@ config RISCV
>>> ���� select HAVE_ARCH_JUMP_LABEL
>>> ���� select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>> ���� select HAVE_ARCH_KASAN if MMU && 64BIT
>>> +��� select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>>> ���� select HAVE_ARCH_KGDB
>>> ���� select HAVE_ARCH_KGDB_QXFER_PKT
>>> ���� select HAVE_ARCH_MMAP_RND_BITS if MMU
>>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>>> index 12ddd1f6bf70..4b9149f963d3 100644
>>> --- a/arch/riscv/mm/kasan_init.c
>>> +++ b/arch/riscv/mm/kasan_init.c
>>> @@ -9,6 +9,19 @@
>>> �#include <linux/pgtable.h>
>>> �#include <asm/tlbflush.h>
>>> �#include <asm/fixmap.h>
>>> +#include <asm/pgalloc.h>
>>> +
>>> +static __init void *early_alloc(size_t size, int node)
>>> +{
>>> +��� void *ptr = memblock_alloc_try_nid(size, size,
>>> +������� __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
>>> +
>>> +��� if (!ptr)
>>> +������� panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d 
>>> from=%llx\n",
>>> +����������� __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
>>> +
>>> +��� return ptr;
>>> +}
>>>
>>> �extern pgd_t early_pg_dir[PTRS_PER_PGD];
>>> �asmlinkage void __init kasan_early_init(void)
>>> @@ -83,6 +96,40 @@ static void __init populate(void *start, void *end)
>>> ���� memset(start, 0, end - start);
>>> �}
>>>
>>> +void __init kasan_shallow_populate(void *start, void *end)
>>> +{
>>> +��� unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>>> +��� unsigned long vend = PAGE_ALIGN((unsigned long)end);
>>> +��� unsigned long pfn;
>>> +��� int index;
>>> +��� void *p;
>>> +��� pud_t *pud_dir, *pud_k;
>>> +��� pgd_t *pgd_dir, *pgd_k;
>>> +��� p4d_t *p4d_dir, *p4d_k;
>>> +
>>> +��� while (vaddr < vend) {
>>> +������� index = pgd_index(vaddr);
>>> +������� pfn = csr_read(CSR_SATP) & SATP_PPN;
> 
> At this point in the boot process, we know that we use swapper_pg_dir so 
> no need to read SATP.
> 
>>> +������� pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
> 
> Here, this pgd_dir assignment is overwritten 2 lines below, so no need 
> for it.
> 
>>> +������� pgd_k = init_mm.pgd + index;
>>> +������� pgd_dir = pgd_offset_k(vaddr);
> 
> pgd_offset_k(vaddr) = init_mm.pgd + pgd_index(vaddr) so pgd_k == pgd_dir.
> 
>>> +������� set_pgd(pgd_dir, *pgd_k);
>>> +
>>> +������� p4d_dir = p4d_offset(pgd_dir, vaddr);
>>> +������� p4d_k� = p4d_offset(pgd_k, vaddr);
>>> +
>>> +������� vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> 
> Why do you increase vaddr *before* populating the first one ? And 
> pud_addr_end does that properly: it returns the next pud address if it 
> does not go beyond end address to map.
> 
>>> +������� pud_dir = pud_offset(p4d_dir, vaddr);
>>> +������� pud_k = pud_offset(p4d_k, vaddr);
>>> +
>>> +������� if (pud_present(*pud_dir)) {
>>> +����������� p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>>> +����������� pud_populate(&init_mm, pud_dir, p);
> 
> init_mm is not needed here.
> 
>>> +������� }
>>> +������� vaddr += PAGE_SIZE;
> 
> Why do you need to add PAGE_SIZE ? vaddr already points to the next pud.
> 
> It seems like this patch tries to populate userspace page table whereas 
> at this point in the boot process, only swapper_pg_dir is used or am I 
> missing something ?
> 
> Thanks,
> 
> Alex

I implemented this morning a version that fixes all the comments I made 
earlier. I was able to insert test_kasan_module on both sv39 and sv48 
without any modification: set_pgd "goes through" all the unused page 
table levels, whereas p*d_populate are noop for unused levels.

If you have any comment, do not hesitate.

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c 

index adbf94b7e68a..d643b222167c 100644 

--- a/arch/riscv/mm/kasan_init.c 

+++ b/arch/riscv/mm/kasan_init.c 

@@ -195,6 +195,31 @@ static void __init kasan_populate(void *start, void 
*end)
         memset(start, KASAN_SHADOW_INIT, end - start); 

  } 

 

+void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned 
long end)
+{ 

+       unsigned long next; 

+       void *p; 

+       pgd_t *pgd_k = pgd_offset_k(vaddr); 

+ 

+       do { 

+               next = pgd_addr_end(vaddr, end); 

+               if (pgd_page_vaddr(*pgd_k) == (unsigned 
long)lm_alias(kasan_early_shadow_pgd_next)) {
+                       p = memblock_alloc(PAGE_SIZE, PAGE_SIZE); 

+                       set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), 
PAGE_TABLE));
+               } 

+       } while (pgd_k++, vaddr = next, vaddr != end); 

+} 

+ 

+void __init kasan_shallow_populate(void *start, void *end) 

+{ 

+       unsigned long vaddr = (unsigned long)start & PAGE_MASK; 

+       unsigned long vend = PAGE_ALIGN((unsigned long)end); 

+ 

+       kasan_shallow_populate_pgd(vaddr, vend); 

+ 

+       local_flush_tlb_all(); 

+} 

+ 

  void __init kasan_init(void) 

  { 

         phys_addr_t _start, _end; 

@@ -206,7 +231,15 @@ void __init kasan_init(void) 

          */ 

         kasan_populate_early_shadow((void *)KASAN_SHADOW_START, 

                                     (void *)kasan_mem_to_shadow((void 
*)
- 
VMALLOC_END));
+ 
VMEMMAP_END));
+       if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) 

+               kasan_shallow_populate( 

+                       (void *)kasan_mem_to_shadow((void 
*)VMALLOC_START),
+                       (void *)kasan_mem_to_shadow((void 
*)VMALLOC_END));
+       else 

+               kasan_populate_early_shadow( 

+                       (void *)kasan_mem_to_shadow((void 
*)VMALLOC_START),
+                       (void *)kasan_mem_to_shadow((void 
*)VMALLOC_END));
 

         /* Populate the linear mapping */ 

         for_each_mem_range(i, &_start, &_end) { 

-- 

2.20.1

Thanks,

Alex

> 
>>> +��� }
>>> +}
>>> +
>>> �void __init kasan_init(void)
>>> �{
>>> ���� phys_addr_t _start, _end;
>>> @@ -90,7 +137,15 @@ void __init kasan_init(void)
>>>
>>> ���� kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
>>> �������������������� (void *)kasan_mem_to_shadow((void *)
>>> -������������������������������� VMALLOC_END));
>>> +������������������������������� VMEMMAP_END));
>>> +��� if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>>> +������� kasan_shallow_populate(
>>> +����������� (void *)kasan_mem_to_shadow((void *)VMALLOC_START),
>>> +����������� (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>>> +��� else
>>> +������� kasan_populate_early_shadow(
>>> +����������� (void *)kasan_mem_to_shadow((void *)VMALLOC_START),
>>> +����������� (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>>>
>>> ���� for_each_mem_range(i, &_start, &_end) {
>>> �������� void *start = (void *)_start; >
>> Thanks, this is on for-next.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
