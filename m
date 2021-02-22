Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3C320F50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 03:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBVCIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 21:08:00 -0500
Received: from exmail.andestech.com ([60.248.187.195]:61703 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhBVCH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 21:07:57 -0500
X-Greylist: delayed 1687 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2021 21:07:55 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 11M1Y6FL063904
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:34:06 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 11M1WPsm063709;
        Mon, 22 Feb 2021 09:32:25 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Mon, 22 Feb 2021
 09:37:55 +0800
Date:   Mon, 22 Feb 2021 09:37:55 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     Alex Ghiti <alex@ghiti.fr>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Nick Chun-Ming =?utf-8?B?SHUo6IOh5bO76YqYKQ==?= 
        <nickhu@andestech.com>,
        Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "nylon7717@gmail.com" <nylon7717@gmail.com>,
        "glider@google.com" <glider@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH v2 1/1] riscv/kasan: add KASAN_VMALLOC support
Message-ID: <20210222013754.GA7626@andestech.com>
References: <mhng-443fd141-b9a3-4be6-a056-416877f99ea4@palmerdabbelt-glaptop>
 <2b2f3038-3e27-8763-cf78-3fbbfd2100a0@ghiti.fr>
 <4fa97788-157c-4059-ae3f-28ab074c5836@ghiti.fr>
 <e15fbf55-25db-7f91-6feb-fb081ab60cdb@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e15fbf55-25db-7f91-6feb-fb081ab60cdb@ghiti.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 11M1WPsm063709
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex, Palmer

Sorry I missed this message.
On Sun, Feb 21, 2021 at 09:38:04PM +0800, Alex Ghiti wrote:
> Le 2/13/21 à 5:52 AM, Alex Ghiti a écrit :
> > Hi Nylon, Palmer,
> > 
> > Le 2/8/21 à 1:28 AM, Alex Ghiti a écrit :
> >> Hi Nylon,
> >>
> >> Le 1/22/21 à 10:56 PM, Palmer Dabbelt a écrit :
> >>> On Fri, 15 Jan 2021 21:58:35 PST (-0800), nylon7@andestech.com wrote:
> >>>> It references to x86/s390 architecture.
> >>>> >> So, it doesn't map the early shadow page to cover VMALLOC space.
> >>>>
> >>>> Prepopulate top level page table for the range that would otherwise be
> >>>> empty.
> >>>>
> >>>> lower levels are filled dynamically upon memory allocation while
> >>>> booting.
> >>
> >> I think we can improve the changelog a bit here with something like that:
> >>
> >> "KASAN vmalloc space used to be mapped using kasan early shadow page. 
> >> KASAN_VMALLOC requires the top-level of the kernel page table to be 
> >> properly populated, lower levels being filled dynamically upon memory 
> >> allocation at runtime."
> >>
> >>>>
> >>>> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> >>>> Signed-off-by: Nick Hu <nickhu@andestech.com>
> >>>> ---
> >>>>  arch/riscv/Kconfig         |  1 +
> >>>>  arch/riscv/mm/kasan_init.c | 57 +++++++++++++++++++++++++++++++++++++-
> >>>>  2 files changed, 57 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>> index 81b76d44725d..15a2c8088bbe 100644
> >>>> --- a/arch/riscv/Kconfig
> >>>> +++ b/arch/riscv/Kconfig
> >>>> @@ -57,6 +57,7 @@ config RISCV
> >>>>      select HAVE_ARCH_JUMP_LABEL
> >>>>      select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >>>>      select HAVE_ARCH_KASAN if MMU && 64BIT
> >>>> +    select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> >>>>      select HAVE_ARCH_KGDB
> >>>>      select HAVE_ARCH_KGDB_QXFER_PKT
> >>>>      select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> >>>> index 12ddd1f6bf70..4b9149f963d3 100644
> >>>> --- a/arch/riscv/mm/kasan_init.c
> >>>> +++ b/arch/riscv/mm/kasan_init.c
> >>>> @@ -9,6 +9,19 @@
> >>>>  #include <linux/pgtable.h>
> >>>>  #include <asm/tlbflush.h>
> >>>>  #include <asm/fixmap.h>
> >>>> +#include <asm/pgalloc.h>
> >>>> +
> >>>> +static __init void *early_alloc(size_t size, int node)
> >>>> +{
> >>>> +    void *ptr = memblock_alloc_try_nid(size, size,
> >>>> +        __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
> >>>> +
> >>>> +    if (!ptr)
> >>>> +        panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d 
> >>>> from=%llx\n",
> >>>> +            __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
> >>>> +
> >>>> +    return ptr;
> >>>> +}
> >>>>
> >>>>  extern pgd_t early_pg_dir[PTRS_PER_PGD];
> >>>>  asmlinkage void __init kasan_early_init(void)
> >>>> @@ -83,6 +96,40 @@ static void __init populate(void *start, void *end)
> >>>>      memset(start, 0, end - start);
> >>>>  }
> >>>>
> >>>> +void __init kasan_shallow_populate(void *start, void *end)
> >>>> +{
> >>>> +    unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> >>>> +    unsigned long vend = PAGE_ALIGN((unsigned long)end);
> >>>> +    unsigned long pfn;
> >>>> +    int index;
> >>>> +    void *p;
> >>>> +    pud_t *pud_dir, *pud_k;
> >>>> +    pgd_t *pgd_dir, *pgd_k;
> >>>> +    p4d_t *p4d_dir, *p4d_k;
> >>>> +
> >>>> +    while (vaddr < vend) {
> >>>> +        index = pgd_index(vaddr);
> >>>> +        pfn = csr_read(CSR_SATP) & SATP_PPN;
> >>
> >> At this point in the boot process, we know that we use swapper_pg_dir 
> >> so no need to read SATP.
> >>
> >>>> +        pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
> >>
> >> Here, this pgd_dir assignment is overwritten 2 lines below, so no need 
> >> for it.
> >>
> >>>> +        pgd_k = init_mm.pgd + index;
> >>>> +        pgd_dir = pgd_offset_k(vaddr);
> >>
> >> pgd_offset_k(vaddr) = init_mm.pgd + pgd_index(vaddr) so pgd_k == pgd_dir.
> >>
> >>>> +        set_pgd(pgd_dir, *pgd_k);
> >>>> +
> >>>> +        p4d_dir = p4d_offset(pgd_dir, vaddr);
> >>>> +        p4d_k  = p4d_offset(pgd_k, vaddr);
> >>>> +
> >>>> +        vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> >>
> >> Why do you increase vaddr *before* populating the first one ? And 
> >> pud_addr_end does that properly: it returns the next pud address if it 
> >> does not go beyond end address to map.
> >>
> >>>> +        pud_dir = pud_offset(p4d_dir, vaddr);
> >>>> +        pud_k = pud_offset(p4d_k, vaddr);
> >>>> +
> >>>> +        if (pud_present(*pud_dir)) {
> >>>> +            p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> >>>> +            pud_populate(&init_mm, pud_dir, p);
> >>
> >> init_mm is not needed here.
> >>
> >>>> +        }
> >>>> +        vaddr += PAGE_SIZE;
> >>
> >> Why do you need to add PAGE_SIZE ? vaddr already points to the next pud.
> >>
> >> It seems like this patch tries to populate userspace page table 
> >> whereas at this point in the boot process, only swapper_pg_dir is used 
> >> or am I missing something ?
> >>
> >> Thanks,
> >>
> >> Alex
> > 
> > I implemented this morning a version that fixes all the comments I made 
> > earlier. I was able to insert test_kasan_module on both sv39 and sv48 
> > without any modification: set_pgd "goes through" all the unused page 
> > table levels, whereas p*d_populate are noop for unused levels.
> > 
> > If you have any comment, do not hesitate.
> > 
> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> > index adbf94b7e68a..d643b222167c 100644
> > --- a/arch/riscv/mm/kasan_init.c
> > +++ b/arch/riscv/mm/kasan_init.c
> > @@ -195,6 +195,31 @@ static void __init kasan_populate(void *start, void 
> > *end)
> >          memset(start, KASAN_SHADOW_INIT, end - start);
> >   }
> > 
> > 
> > +void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned 
> > long end)
> > +{
> > +       unsigned long next;
> > +       void *p;
> > +       pgd_t *pgd_k = pgd_offset_k(vaddr);
> > +
> > +       do {
> > +               next = pgd_addr_end(vaddr, end);
> > +               if (pgd_page_vaddr(*pgd_k) == (unsigned 
> > long)lm_alias(kasan_early_shadow_pgd_next)) {
> > +                       p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +                       set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), 
> > PAGE_TABLE));
> > +               }
> > +       } while (pgd_k++, vaddr = next, vaddr != end);
> > +}
> > +
> 
> This way of going through the page table seems to be largely used across 
> the kernel (cf KASAN population functions of arm64/x86) so I do think 
> this patch brings value to Nylon and Nick's patch.
> 
> I can propose a real patch if you agree and I'll add a co-developed by 
> Nylon/Nick since this only 'improves' theirs.
> 
> Thanks,
> 
> Alex
>
I agree with your proposal, but when I try your patch that it dosen't work
because `kasan_early_shadow_pgd_next` function wasn't define.

Do you have complete patch? or just I missed some content?
> > +void __init kasan_shallow_populate(void *start, void *end)
> > +{
> > +       unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> > +       unsigned long vend = PAGE_ALIGN((unsigned long)end);
> > +
> > +       kasan_shallow_populate_pgd(vaddr, vend);
> > +
> > +       local_flush_tlb_all();
> > +}
> > +
> >   void __init kasan_init(void)
> >   {
> >          phys_addr_t _start, _end;
> > @@ -206,7 +231,15 @@ void __init kasan_init(void)
> >           */
> >          kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
> >                                      (void *)kasan_mem_to_shadow((void *)
> > - VMALLOC_END));
> > + VMEMMAP_END));
> > +       if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> > +               kasan_shallow_populate(
> > +                       (void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> > +                       (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> > +       else
> > +               kasan_populate_early_shadow(
> > +                       (void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> > +                       (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> > 
> > 
> >          /* Populate the linear mapping */
> >          for_each_mem_range(i, &_start, &_end) {
