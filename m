Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D334F519
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhC3Xfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhC3Xf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:35:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:35:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so6968042plj.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iio9bfkbnc1SxK2/X30SuOzWV2OwhBK+xWf/cbCgm18=;
        b=eMguBVVUjUStxQbbSCecRmjXn/1ycLVCcXO3Fj3hbhFUaIWmgLIDgz6jyMtmLnKX8s
         41D7SrMYyRX4+BpoXicb+ULiNDptBB3SNKysGq+lKSAA3cblg65X/KWs3Bdr7ZnjUfPd
         9Fx0sJTv2vr36G+YIEWNWyKbBUfSOieWbgus4EfpBhvzBjW7R4DWWCZHyPvU1T5hMilC
         BmsUb9m4CKP8pCgxYRp+6gGjnmLmzYJQyesQHFdYNVgIvQf6SBHSZtrnGomNlXEuHS2r
         /zkFmsK27b7qMa+kPMqZTuHWrps4ZE2uU8RTkWA+T22LivxbskPhmkyxP/L0kdFeU6wH
         XPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iio9bfkbnc1SxK2/X30SuOzWV2OwhBK+xWf/cbCgm18=;
        b=ZqrNJNecJHQ9fFaoxjZ8eo2KGPx2a9R9P5Gnz0IGwnM1dsQfKia0Xiv9H+zcuyXgbU
         aIglobkwcxEyVQ3RmUHsiUQ3MZZu2Uw/VJiZjOC35K3v4M4d3d5IsV6MbjH4gdOuFpEr
         OzUL3EipAYVI++uGK+YPG2Yn6sJ99Ir1c3TzURZeeG6INXDokOQ3ewRbr4UV1L9fzqom
         k7Vj7zLYjC0v2LYrKTJR2knQnY9uuUCGCqRQ11HM6iHyY9s7jqb0iooELW/NBpPIdUhG
         Fj52h570y/BciTXWa95LOHj1JGzDd7AcpmobGZlaT5snvZ084iFvg01pEbOMoT4Y09BQ
         TGxg==
X-Gm-Message-State: AOAM5336obcVg/oRvtSPsMUv+f0pvbvlTdS9958+fXzyxE21UHPMsESC
        86cxDxQIzccO04OjbLbx2F0yLQ==
X-Google-Smtp-Source: ABdhPJz2Vh72yiO2i4LYR9COBFdH6awjEBqeOpekGPPqU1tV8Xv437bpsS9ukm0+C9H78dWn7OvONg==
X-Received: by 2002:a17:90b:201:: with SMTP id fy1mr680343pjb.108.1617147324530;
        Tue, 30 Mar 2021 16:35:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c193sm112939pfc.180.2021.03.30.16.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 16:35:23 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:35:23 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Mar 2021 16:35:21 PDT (-0700)
Subject:     Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
In-Reply-To: <CAPM7DZffiY7gAW738fc1Dm_qfebPL9=yYjNbvazn_8wmBMbMhA@mail.gmail.com>
CC:     waterman@eecs.berkeley.edu, alex@ghiti.fr, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, wangkefeng.wang@huawei.com, zong.li@sifive.com,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liu@jiuyang.me
Message-ID: <mhng-2e100827-b420-46cb-a554-a4e060d67b57@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 19:10:28 PDT (-0700), liu@jiuyang.me wrote:
> Thanks for the review!
>
> I see, after skimming related codes, and implementation of other architecture,
> I also agree this method is too heavy to implement. And there is a potential
> bug, that my patch may introduce two SFENCE.VMA in the related codes:
> flush at set_pte_at and also flush in the upper level of the calling stack.
>
> My two cents is that the original description in spec is a little
> misleading to the
> software side, spec requires each set_pte inserting SFENCE.VMA together,
> while the kernel chooses to maintain set_pte and flush_tlb separately.

This is a common source of confusion, the wording in the spec is a bit 
odd.

> So I think I should add a patch to fix my bug specifically, and
> provide this trunk
> as an inline function to flush tlb after modification to a pte.
>
>> if (pte_present(pteval)) {
>>         if (pte_leaf(pteval)) {
>>                 local_flush_tlb_page(addr);
>>         } else {
>>                 if (pte_global(pteval))
>>                         local_flush_tlb_all();
>>                 else
>>                         local_flush_tlb_asid();
>>
>>        }
>> }
>
> My next patch will become two patches:
> 1. add flush_tlb related codes according to spec(also flush global tlb
> via sbi call if G bit is on)
> 2. add a bug fix for my stack by adding flush in the flush_cache_vmap.
>
> Does this approach sound reasonable?

I'm not really sure if I understand what you're saying on either of 
these.

For #1: as far as I know we're correctly flushing the TLB, but if 
there's some issue then I'd be happy to take a look.

For #2: We don't have (and I don't think we need) a flush_cache_vmap(), 
but I do think we need a flush_cache_vunmap().  Essentially we can 
handle the spurious faults to the vmalloc region (there was a bug fix 
recently, maybe you just don't have it yet), but we do need to flush the 
TLB when unmapping.  I'm not sure if that was just an oversight or if 
I'm missing some other way the flush ends up there, as not a lot of 
architectures flush there.

> Regards,
> Jiuyang
>
> On Tue, 16 Mar 2021 at 09:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> We're trying to avoid this sort of thing, instead relying on the generic kernel
>> functionality to batch up page table modifications before we issue the fences.
>> If you're seeing some specific issue then I'd be happy to try and sort out a
>> fix for it, but this is a bit heavy-handed to use as anything but a last
>> resort.
> On Tue, Mar 16, 2021 at 10:03 PM Andrew Waterman
> <waterman@eecs.berkeley.edu> wrote:
>>
>> On Tue, Mar 16, 2021 at 5:05 AM Alex Ghiti <alex@ghiti.fr> wrote:
>> >
>> > Le 3/16/21 à 4:40 AM, Anup Patel a écrit :
>> > > On Tue, Mar 16, 2021 at 1:59 PM Andrew Waterman
>> > > <waterman@eecs.berkeley.edu> wrote:
>> > >>
>> > >> On Tue, Mar 16, 2021 at 12:32 AM Anup Patel <anup@brainfault.org> wrote:
>> > >>>
>> > >>> On Tue, Mar 16, 2021 at 12:27 PM Jiuyang Liu <liu@jiuyang.me> wrote:
>> > >>>>
>> > >>>>> As per my understanding, we don't need to explicitly invalidate local TLB
>> > >>>>> in set_pte() or set_pet_at() because generic Linux page table management
>> > >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function after page
>> > >>>>> table updates.
>> > >>>>
>> > >>>> I witnessed this bug in our micro-architecture: set_pte instruction is
>> > >>>> still in the store buffer, no functions are inserting SFENCE.VMA in
>> > >>>> the stack below, so TLB cannot witness this modification.
>> > >>>> Here is my call stack:
>> > >>>> set_pte
>> > >>>> set_pte_at
>> > >>>> map_vm_area
>> > >>>> __vmalloc_area_node
>> > >>>> __vmalloc_node_range
>> > >>>> __vmalloc_node
>> > >>>> __vmalloc_node_flags
>> > >>>> vzalloc
>> > >>>> n_tty_open
>> > >>>>
>> >
>> > I don't find this call stack, what I find is (the other way around):
>> >
>> > n_tty_open
>> > vzalloc
>> > __vmalloc_node
>> > __vmalloc_node_range
>> > __vmalloc_area_node
>> > map_kernel_range
>> > -> map_kernel_range_noflush
>> >     flush_cache_vmap
>> >
>> > Which leads to the fact that we don't have flush_cache_vmap callback
>> > implemented: shouldn't we add the sfence.vma here ? Powerpc does
>> > something similar with "ptesync" (see below) instruction that seems to
>> > do the same as sfence.vma.
>>
>> I was thinking the same thing, but I hadn't yet wrapped my head around
>> the fact that most architectures don't have something similar.  I'm OK
>> with following PPC's lead if it appears to be a correct bug fix :)
>>
>> >
>> >
>> > ptesync: "The ptesync instruction after the Store instruction ensures
>> > that all searches of the Page Table that are performed after the ptesync
>> > instruction completes will use the value stored"
>> >
>> > >>>> I think this is an architecture specific code, so <linux>/mm/* should
>> > >>>> not be modified.
>> > >>>> And spec requires SFENCE.VMA to be inserted on each modification to
>> > >>>> TLB. So I added code here.
>> > >>>
>> > >>> The generic linux/mm/* already calls the appropriate tlb_flush_xyz()
>> > >>> function defined in arch/riscv/include/asm/tlbflush.h
>> > >>>
>> > >>> Better to have a write-barrier in set_pte().
>> > >>>
>> > >>>>
>> > >>>>> Also, just local TLB flush is generally not sufficient because
>> > >>>>> a lot of page tables will be used across on multiple HARTs.
>> > >>>>
>> > >>>> Yes, this is the biggest issue, in RISC-V Volume 2, Privileged Spec v.
>> > >>>> 20190608 page 67 gave a solution:
>> > >>>
>> > >>> This is not an issue with RISC-V privilege spec rather it is more about
>> > >>> placing RISC-V fences at right locations.
>> > >>>
>> > >>>> Consequently, other harts must be notified separately when the
>> > >>>> memory-management data structures have been modified. One approach is
>> > >>>> to use
>> > >>>> 1) a local data fence to ensure local writes are visible globally,
>> > >>>> then 2) an interprocessor interrupt to the other thread,
>> > >>>> then 3) a local SFENCE.VMA in the interrupt handler of the remote thread,
>> > >>>> and finally 4) signal back to originating thread that operation is
>> > >>>> complete. This is, of course, the RISC-V analog to a TLB shootdown.
>> > >>>
>> > >>> I would suggest trying approach#1.
>> > >>>
>> > >>> You can include "asm/barrier.h" here and use wmb() or __smp_wmb()
>> > >>> in-place of local TLB flush.
>> > >>
>> > >> wmb() doesn't suffice to order older stores before younger page-table
>> > >> walks, so that might hide the problem without actually fixing it.
>> > >
>> > > If we assume page-table walks as reads then mb() might be more
>> > > suitable in this case ??
>> > >
>> > > ARM64 also has an explicit barrier in set_pte() implementation. They are
>> > > doing "dsb(ishst); isb()" which is an inner-shareable store barrier followed
>> > > by an instruction barrier.
>> > >
>> > >>
>> > >> Based upon Jiuyang's description, it does sound plausible that we are
>> > >> missing an SFENCE.VMA (or TLB shootdown) somewhere.  But I don't
>> > >> understand the situation well enough to know where that might be, or
>> > >> what the best fix is.
>> > >
>> > > Yes, I agree but set_pte() doesn't seem to be the right place for TLB
>> > > shootdown based on set_pte() implementations of other architectures.
>> >
>> > I agree as "flushing" the TLB after every set_pte() would be very
>> > costly, it's better to do it once at the end of the all the updates:
>> > like in flush_cache_vmap :)
>> >
>> > Alex
>> >
>> > >
>> > > Regards,
>> > > Anup
>> > >
>> > >>
>> > >>
>> > >>>
>> > >>>>
>> > >>>> In general, this patch didn't handle the G bit in PTE, kernel trap it
>> > >>>> to sbi_remote_sfence_vma. do you think I should use flush_tlb_all?
>> > >>>>
>> > >>>> Jiuyang
>> > >>>>
>> > >>>>
>> > >>>>
>> > >>>>
>> > >>>> arch/arm/mm/mmu.c
>> > >>>> void set_pte_at(struct mm_struct *mm, unsigned long addr,
>> > >>>>                                pte_t *ptep, pte_t pteval)
>> > >>>> {
>> > >>>>          unsigned long ext = 0;
>> > >>>>
>> > >>>>          if (addr < TASK_SIZE && pte_valid_user(pteval)) {
>> > >>>>                  if (!pte_special(pteval))
>> > >>>>                          __sync_icache_dcache(pteval);
>> > >>>>                  ext |= PTE_EXT_NG;
>> > >>>>          }
>> > >>>>
>> > >>>>          set_pte_ext(ptep, pteval, ext);
>> > >>>> }
>> > >>>>
>> > >>>> arch/mips/include/asm/pgtable.h
>> > >>>> static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>> > >>>>                                pte_t *ptep, pte_t pteval)
>> > >>>> {
>> > >>>>
>> > >>>>          if (!pte_present(pteval))
>> > >>>>                  goto cache_sync_done;
>> > >>>>
>> > >>>>          if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
>> > >>>>                  goto cache_sync_done;
>> > >>>>
>> > >>>>          __update_cache(addr, pteval);
>> > >>>> cache_sync_done:
>> > >>>>          set_pte(ptep, pteval);
>> > >>>> }
>> > >>>>
>> > >>>>
>> > >>>> Also, just local TLB flush is generally not sufficient because
>> > >>>>> a lot of page tables will be used accross on multiple HARTs.
>> > >>>>
>> > >>>>
>> > >>>> On Tue, Mar 16, 2021 at 5:05 AM Anup Patel <anup@brainfault.org> wrote:
>> > >>>>>
>> > >>>>> +Alex
>> > >>>>>
>> > >>>>> On Tue, Mar 16, 2021 at 9:20 AM Jiuyang Liu <liu@jiuyang.me> wrote:
>> > >>>>>>
>> > >>>>>> This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
>> > >>>>>> specification.
>> > >>>>>>
>> > >>>>>> arch/riscv/include/asm/pgtable.h:
>> > >>>>>> 1. implement pte_user, pte_global and pte_leaf to check correspond
>> > >>>>>> attribute of a pte_t.
>> > >>>>>
>> > >>>>> Adding pte_user(), pte_global(), and pte_leaf() is fine.
>> > >>>>>
>> > >>>>>>
>> > >>>>>> 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privileged
>> > >>>>>> Spec v. 20190608 page 66 and 67:
>> > >>>>>> If software modifies a non-leaf PTE, it should execute SFENCE.VMA with
>> > >>>>>> rs1=x0. If any PTE along the traversal path had its G bit set, rs2 must
>> > >>>>>> be x0; otherwise, rs2 should be set to the ASID for which the
>> > >>>>>> translation is being modified.
>> > >>>>>> If software modifies a leaf PTE, it should execute SFENCE.VMA with rs1
>> > >>>>>> set to a virtual address within the page. If any PTE along the traversal
>> > >>>>>> path had its G bit set, rs2 must be x0; otherwise, rs2 should be set to
>> > >>>>>> the ASID for which the translation is being modified.
>> > >>>>>>
>> > >>>>>> arch/riscv/include/asm/tlbflush.h:
>> > >>>>>> 1. implement get_current_asid to get current program asid.
>> > >>>>>> 2. implement local_flush_tlb_asid to flush tlb with asid.
>> > >>>>>
>> > >>>>> As per my understanding, we don't need to explicitly invalidate local TLB
>> > >>>>> in set_pte() or set_pet_at() because generic Linux page table management
>> > >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function after page
>> > >>>>> table updates. Also, just local TLB flush is generally not sufficient because
>> > >>>>> a lot of page tables will be used accross on multiple HARTs.
>> > >>>>>
>> > >>>>>>
>> > >>>>>> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
>> > >>>>>> ---
>> > >>>>>>   arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++++++
>> > >>>>>>   arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
>> > >>>>>>   2 files changed, 39 insertions(+)
>> > >>>>>>
>> > >>>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> > >>>>>> index ebf817c1bdf4..5a47c60372c1 100644
>> > >>>>>> --- a/arch/riscv/include/asm/pgtable.h
>> > >>>>>> +++ b/arch/riscv/include/asm/pgtable.h
>> > >>>>>> @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
>> > >>>>>>          return pte_val(pte) & _PAGE_WRITE;
>> > >>>>>>   }
>> > >>>>>>
>> > >>>>>> +static inline int pte_user(pte_t pte)
>> > >>>>>> +{
>> > >>>>>> +       return pte_val(pte) & _PAGE_USER;
>> > >>>>>> +}
>> > >>>>>> +
>> > >>>>>> +static inline int pte_global(pte_t pte)
>> > >>>>>> +{
>> > >>>>>> +       return pte_val(pte) & _PAGE_GLOBAL;
>> > >>>>>> +}
>> > >>>>>> +
>> > >>>>>>   static inline int pte_exec(pte_t pte)
>> > >>>>>>   {
>> > >>>>>>          return pte_val(pte) & _PAGE_EXEC;
>> > >>>>>> @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
>> > >>>>>>          return pte_val(pte) & _PAGE_SPECIAL;
>> > >>>>>>   }
>> > >>>>>>
>> > >>>>>> +static inline int pte_leaf(pte_t pte)
>> > >>>>>> +{
>> > >>>>>> +       return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC);
>> > >>>>>> +}
>> > >>>>>> +
>> > >>>>>>   /* static inline pte_t pte_rdprotect(pte_t pte) */
>> > >>>>>>
>> > >>>>>>   static inline pte_t pte_wrprotect(pte_t pte)
>> > >>>>>> @@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_struct *mm,
>> > >>>>>>                  flush_icache_pte(pteval);
>> > >>>>>>
>> > >>>>>>          set_pte(ptep, pteval);
>> > >>>>>> +
>> > >>>>>> +       if (pte_present(pteval)) {
>> > >>>>>> +               if (pte_leaf(pteval)) {
>> > >>>>>> +                       local_flush_tlb_page(addr);
>> > >>>>>> +               } else {
>> > >>>>>> +                       if (pte_global(pteval))
>> > >>>>>> +                               local_flush_tlb_all();
>> > >>>>>> +                       else
>> > >>>>>> +                               local_flush_tlb_asid();
>> > >>>>>> +
>> > >>>>>> +               }
>> > >>>>>> +       }
>> > >>>>>>   }
>> > >>>>>>
>> > >>>>>>   static inline void pte_clear(struct mm_struct *mm,
>> > >>>>>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> > >>>>>> index 394cfbccdcd9..1f9b62b3670b 100644
>> > >>>>>> --- a/arch/riscv/include/asm/tlbflush.h
>> > >>>>>> +++ b/arch/riscv/include/asm/tlbflush.h
>> > >>>>>> @@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsigned long addr)
>> > >>>>>>   {
>> > >>>>>>          __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>> > >>>>>>   }
>> > >>>>>> +
>> > >>>>>> +static inline unsigned long get_current_asid(void)
>> > >>>>>> +{
>> > >>>>>> +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
>> > >>>>>> +}
>> > >>>>>> +
>> > >>>>>> +static inline void local_flush_tlb_asid(void)
>> > >>>>>> +{
>> > >>>>>> +       unsigned long asid = get_current_asid();
>> > >>>>>> +       __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
>> > >>>>>> +}
>> > >>>>>> +
>> > >>>>>>   #else /* CONFIG_MMU */
>> > >>>>>>   #define local_flush_tlb_all()                  do { } while (0)
>> > >>>>>>   #define local_flush_tlb_page(addr)             do { } while (0)
>> > >>>>>> --
>> > >>>>>> 2.30.2
>> > >>>>>>
>> > >>>>>>
>> > >>>>>> _______________________________________________
>> > >>>>>> linux-riscv mailing list
>> > >>>>>> linux-riscv@lists.infradead.org
>> > >>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>> > >>>>>
>> > >>>>> Regards,
>> > >>>>> Anup
>> > >>>
>> > >>> Regards,
>> > >>> Anup
>> > >
>> > > _______________________________________________
>> > > linux-riscv mailing list
>> > > linux-riscv@lists.infradead.org
>> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> > >
