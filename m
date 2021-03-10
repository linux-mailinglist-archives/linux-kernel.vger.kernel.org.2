Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36DE3347CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhCJTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:19:18 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39083 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCJTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:18:58 -0500
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6273DFF803;
        Wed, 10 Mar 2021 19:18:52 +0000 (UTC)
Subject: Re: [PATCH v2] riscv: Improve KASAN_VMALLOC support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <mhng-a1ab9e7a-d992-4432-badc-02cc788b1ace@penguin>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <7db28eaf-f556-8ca5-e6b9-b932d4e786e2@ghiti.fr>
Date:   Wed, 10 Mar 2021 14:18:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <mhng-a1ab9e7a-d992-4432-badc-02cc788b1ace@penguin>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/9/21 à 9:37 PM, Palmer Dabbelt a écrit :
> On Fri, 26 Feb 2021 10:01:54 PST (-0800), alex@ghiti.fr wrote:
>> When KASAN vmalloc region is populated, there is no userspace process and
>> the page table in use is swapper_pg_dir, so there is no need to read
>> SATP. Then we can use the same scheme used by kasan_populate_p*d
>> functions to go through the page table, which harmonizes the code.
>>
>> In addition, make use of set_pgd that goes through all unused page table
>> levels, contrary to p*d_populate functions, which makes this function 
>> work
>> whatever the number of page table levels.
>>
>> And finally, make sure the writes to swapper_pg_dir are visible using
>> an sfence.vma.
> 
> So I think this is actually a bug: without the fence we could get a 
> kasan-related fault at any point (as the mappings might not be visible 
> yet), and if we get one when inside do_page_fault() (or while holding a 
> lock it wants) we'll end up deadlocking against ourselves.  That'll 
> probably never happen in practice, but it'd still be good to get the 
> fence onto fixes. The rest are cleanups, they're for for-next (and 
> should probably be part of your sv48 series, if you need to re-spin it 
> -- I'll look at that next).

I only talked about sv48 support in the changelog as it explains why I 
replaced p*d_populate functions for set_p*d, this is not directly linked 
to the sv48 patchset, this is just a bonus that it works for both :)

> 
> LMK if you want to split this up, or if you want me to do it.  Either way,

I'll split it up: one patch for the cleanup and one patch for the fix.

> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks,

Alex

> 
> Thanks!
> 
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>
>> Changes in v2:
>> - Quiet kernel test robot warnings about missing prototypes by declaring
>>   the introduced functions as static.
>>
>>  arch/riscv/mm/kasan_init.c | 61 +++++++++++++-------------------------
>>  1 file changed, 20 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> index e3d91f334b57..aaa3bdc0ffc0 100644
>> --- a/arch/riscv/mm/kasan_init.c
>> +++ b/arch/riscv/mm/kasan_init.c
>> @@ -11,18 +11,6 @@
>>  #include <asm/fixmap.h>
>>  #include <asm/pgalloc.h>
>>
>> -static __init void *early_alloc(size_t size, int node)
>> -{
>> -    void *ptr = memblock_alloc_try_nid(size, size,
>> -        __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
>> -
>> -    if (!ptr)
>> -        panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d 
>> from=%llx\n",
>> -            __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
>> -
>> -    return ptr;
>> -}
>> -
>>  extern pgd_t early_pg_dir[PTRS_PER_PGD];
>>  asmlinkage void __init kasan_early_init(void)
>>  {
>> @@ -155,38 +143,29 @@ static void __init kasan_populate(void *start, 
>> void *end)
>>      memset(start, KASAN_SHADOW_INIT, end - start);
>>  }
>>
>> -void __init kasan_shallow_populate(void *start, void *end)
>> +static void __init kasan_shallow_populate_pgd(unsigned long vaddr, 
>> unsigned long end)
>>  {
>> -    unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>> -    unsigned long vend = PAGE_ALIGN((unsigned long)end);
>> -    unsigned long pfn;
>> -    int index;
>> +    unsigned long next;
>>      void *p;
>> -    pud_t *pud_dir, *pud_k;
>> -    pgd_t *pgd_dir, *pgd_k;
>> -    p4d_t *p4d_dir, *p4d_k;
>> -
>> -    while (vaddr < vend) {
>> -        index = pgd_index(vaddr);
>> -        pfn = csr_read(CSR_SATP) & SATP_PPN;
>> -        pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
>> -        pgd_k = init_mm.pgd + index;
>> -        pgd_dir = pgd_offset_k(vaddr);
>> -        set_pgd(pgd_dir, *pgd_k);
>> -
>> -        p4d_dir = p4d_offset(pgd_dir, vaddr);
>> -        p4d_k  = p4d_offset(pgd_k, vaddr);
>> -
>> -        vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
>> -        pud_dir = pud_offset(p4d_dir, vaddr);
>> -        pud_k = pud_offset(p4d_k, vaddr);
>> -
>> -        if (pud_present(*pud_dir)) {
>> -            p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>> -            pud_populate(&init_mm, pud_dir, p);
>> +    pgd_t *pgd_k = pgd_offset_k(vaddr);
>> +
>> +    do {
>> +        next = pgd_addr_end(vaddr, end);
>> +        if (pgd_page_vaddr(*pgd_k) == (unsigned 
>> long)lm_alias(kasan_early_shadow_pmd)) {
>> +            p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +            set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>>          }
>> -        vaddr += PAGE_SIZE;
>> -    }
>> +    } while (pgd_k++, vaddr = next, vaddr != end);
>> +}
>> +
>> +static void __init kasan_shallow_populate(void *start, void *end)
>> +{
>> +    unsigned long vaddr = (unsigned long)start & PAGE_MASK;
>> +    unsigned long vend = PAGE_ALIGN((unsigned long)end);
>> +
>> +    kasan_shallow_populate_pgd(vaddr, vend);
>> +
>> +    local_flush_tlb_all();
>>  }
>>
>>  void __init kasan_init(void)
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
