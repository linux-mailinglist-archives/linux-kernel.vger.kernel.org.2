Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C633933FD12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhCRCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCRCKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:10:45 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DABBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:10:40 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id j19so1434867uax.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=23/1o2SbntVM2Q/oOXbRaaWD4dojlyGZZac7x5AXb58=;
        b=WP+/1WLxPS1nRHPoTBku/FY2xbXTQ93aEwXkPBAEQ/cMhmabHNOAGPc6rOmLQRoHHt
         S4WrkSvXWs/CQ9pMAZ0NfcrJLnZiNULsZ3iwzRjtlDv8GdRzLqP0YlBxT/R6iDuw9y0N
         JHxs4a0f4PasGKoYoILOpHqeqlpDJI0QmxFUq7RJFXyd19jYF2mdn/j7h/WKTNA7stAh
         qevZhlPYLMYXxNpbNp9TETNxQ8VB8jnyFrImZy7hEqop4CJs3v27yxdVS8duFoevy572
         PgKDK0cwJuitTOTJQcvLEiRsfqEvtXZrIpjQbI9hz0YqkTLK2PSkc3MlGjvXq/AZyegQ
         s5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=23/1o2SbntVM2Q/oOXbRaaWD4dojlyGZZac7x5AXb58=;
        b=uGpyfyW7mYnEBn8CdgDE9uZlXpOzyKg0hODSivqnDJPsLqQV9QHhYj+ssrgj/AsRXu
         ldLT1L2RQt5+yO89n1l4yJbmKQ5unR0IAsoXhBa61fEInR9gaOCpGT+2ycuHsWum8VyS
         WPTx2vP93pMPON31o6FbkiTE/6uR9UGoKQRvgG/kYTc8Hx6gnYSFwAsgxumLW79clr7o
         UBpuoWhb5AtMQJoiqxd03iecARTLdlaxXVFOaON0NPFMA2YrQEJ0Co28XLZ/gc7HqSF4
         Fyes92R37C8o7Ya+UdKzoSN4VO4rB/Ko/bY22EHi+oFmogacQsM4hHJgsD1Geg9Nrw0b
         FijA==
X-Gm-Message-State: AOAM5322AKU4Iy/bKqVZ+OmrLVOgtdQt5MdOD4XS1yGVcDJ3Dt66+vaL
        707yLBsVLYnX0oB42BkRVv7Er+yUuXLw67EhhXwR3w==
X-Google-Smtp-Source: ABdhPJxPp0jtd4wBPt3gAKuETvczdRKKnKseJEzTZ2q3wAIigkFpMbfjE3gMgXqs6EnpOqAE7BGWH5WZLVG0PiPfyYI=
X-Received: by 2002:a9f:3230:: with SMTP id x45mr1148179uad.23.1616033439223;
 Wed, 17 Mar 2021 19:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210316015328.13516-1-liu@jiuyang.me> <20210316034638.16276-1-liu@jiuyang.me>
 <CAAhSdy3eEXtba_ebUnPW_OUHRMKsg+O9sBx_DHAmrkTUCfHXNg@mail.gmail.com>
 <CAPM7DZc+Ysd=VQdzc4_4Np8VAMESBrzD3mhk0ueh92x11bFFNg@mail.gmail.com>
 <CAAhSdy1HYJJDig3Mg1eWaO=zok9G6+hQM1LLbDKMzH-=Fi2dKw@mail.gmail.com>
 <CA++6G0AnGVLbM+1j9K7UU_0p6NfwVAxNkcFr8s1=h+wW4G0z_w@mail.gmail.com>
 <CAAhSdy0nAUW-Y9gFONVLUPZCG-zT2MXKacu+StKKmSro+58k8w@mail.gmail.com>
 <d4f3f2af-345d-b9a9-6ac5-f4262d0b46c5@ghiti.fr> <CA++6G0AysZ3eZ+F1jMxx59aKbj3CyiOSMTkr1RVKuocqmZ6maQ@mail.gmail.com>
In-Reply-To: <CA++6G0AysZ3eZ+F1jMxx59aKbj3CyiOSMTkr1RVKuocqmZ6maQ@mail.gmail.com>
From:   Jiuyang Liu <liu@jiuyang.me>
Date:   Thu, 18 Mar 2021 02:10:28 +0000
Message-ID: <CAPM7DZffiY7gAW738fc1Dm_qfebPL9=yYjNbvazn_8wmBMbMhA@mail.gmail.com>
Subject: Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
To:     Andrew Waterman <waterman@eecs.berkeley.edu>
Cc:     Alex Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

I see, after skimming related codes, and implementation of other architectu=
re,
I also agree this method is too heavy to implement. And there is a potentia=
l
bug, that my patch may introduce two SFENCE.VMA in the related codes:
flush at set_pte_at and also flush in the upper level of the calling stack.

My two cents is that the original description in spec is a little
misleading to the
software side, spec requires each set_pte inserting SFENCE.VMA together,
while the kernel chooses to maintain set_pte and flush_tlb separately.

So I think I should add a patch to fix my bug specifically, and
provide this trunk
as an inline function to flush tlb after modification to a pte.

> if (pte_present(pteval)) {
>         if (pte_leaf(pteval)) {
>                 local_flush_tlb_page(addr);
>         } else {
>                 if (pte_global(pteval))
>                         local_flush_tlb_all();
>                 else
>                         local_flush_tlb_asid();
>
>        }
> }

My next patch will become two patches:
1. add flush_tlb related codes according to spec(also flush global tlb
via sbi call if G bit is on)
2. add a bug fix for my stack by adding flush in the flush_cache_vmap.

Does this approach sound reasonable?

Regards,
Jiuyang

On Tue, 16 Mar 2021 at 09:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> We're trying to avoid this sort of thing, instead relying on the generic =
kernel
> functionality to batch up page table modifications before we issue the fe=
nces.
> If you're seeing some specific issue then I'd be happy to try and sort ou=
t a
> fix for it, but this is a bit heavy-handed to use as anything but a last
> resort.
On Tue, Mar 16, 2021 at 10:03 PM Andrew Waterman
<waterman@eecs.berkeley.edu> wrote:
>
> On Tue, Mar 16, 2021 at 5:05 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >
> > Le 3/16/21 =C3=A0 4:40 AM, Anup Patel a =C3=A9crit :
> > > On Tue, Mar 16, 2021 at 1:59 PM Andrew Waterman
> > > <waterman@eecs.berkeley.edu> wrote:
> > >>
> > >> On Tue, Mar 16, 2021 at 12:32 AM Anup Patel <anup@brainfault.org> wr=
ote:
> > >>>
> > >>> On Tue, Mar 16, 2021 at 12:27 PM Jiuyang Liu <liu@jiuyang.me> wrote=
:
> > >>>>
> > >>>>> As per my understanding, we don't need to explicitly invalidate l=
ocal TLB
> > >>>>> in set_pte() or set_pet_at() because generic Linux page table man=
agement
> > >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function=
 after page
> > >>>>> table updates.
> > >>>>
> > >>>> I witnessed this bug in our micro-architecture: set_pte instructio=
n is
> > >>>> still in the store buffer, no functions are inserting SFENCE.VMA i=
n
> > >>>> the stack below, so TLB cannot witness this modification.
> > >>>> Here is my call stack:
> > >>>> set_pte
> > >>>> set_pte_at
> > >>>> map_vm_area
> > >>>> __vmalloc_area_node
> > >>>> __vmalloc_node_range
> > >>>> __vmalloc_node
> > >>>> __vmalloc_node_flags
> > >>>> vzalloc
> > >>>> n_tty_open
> > >>>>
> >
> > I don't find this call stack, what I find is (the other way around):
> >
> > n_tty_open
> > vzalloc
> > __vmalloc_node
> > __vmalloc_node_range
> > __vmalloc_area_node
> > map_kernel_range
> > -> map_kernel_range_noflush
> >     flush_cache_vmap
> >
> > Which leads to the fact that we don't have flush_cache_vmap callback
> > implemented: shouldn't we add the sfence.vma here ? Powerpc does
> > something similar with "ptesync" (see below) instruction that seems to
> > do the same as sfence.vma.
>
> I was thinking the same thing, but I hadn't yet wrapped my head around
> the fact that most architectures don't have something similar.  I'm OK
> with following PPC's lead if it appears to be a correct bug fix :)
>
> >
> >
> > ptesync: "The ptesync instruction after the Store instruction ensures
> > that all searches of the Page Table that are performed after the ptesyn=
c
> > instruction completes will use the value stored"
> >
> > >>>> I think this is an architecture specific code, so <linux>/mm/* sho=
uld
> > >>>> not be modified.
> > >>>> And spec requires SFENCE.VMA to be inserted on each modification t=
o
> > >>>> TLB. So I added code here.
> > >>>
> > >>> The generic linux/mm/* already calls the appropriate tlb_flush_xyz(=
)
> > >>> function defined in arch/riscv/include/asm/tlbflush.h
> > >>>
> > >>> Better to have a write-barrier in set_pte().
> > >>>
> > >>>>
> > >>>>> Also, just local TLB flush is generally not sufficient because
> > >>>>> a lot of page tables will be used across on multiple HARTs.
> > >>>>
> > >>>> Yes, this is the biggest issue, in RISC-V Volume 2, Privileged Spe=
c v.
> > >>>> 20190608 page 67 gave a solution:
> > >>>
> > >>> This is not an issue with RISC-V privilege spec rather it is more a=
bout
> > >>> placing RISC-V fences at right locations.
> > >>>
> > >>>> Consequently, other harts must be notified separately when the
> > >>>> memory-management data structures have been modified. One approach=
 is
> > >>>> to use
> > >>>> 1) a local data fence to ensure local writes are visible globally,
> > >>>> then 2) an interprocessor interrupt to the other thread,
> > >>>> then 3) a local SFENCE.VMA in the interrupt handler of the remote =
thread,
> > >>>> and finally 4) signal back to originating thread that operation is
> > >>>> complete. This is, of course, the RISC-V analog to a TLB shootdown=
.
> > >>>
> > >>> I would suggest trying approach#1.
> > >>>
> > >>> You can include "asm/barrier.h" here and use wmb() or __smp_wmb()
> > >>> in-place of local TLB flush.
> > >>
> > >> wmb() doesn't suffice to order older stores before younger page-tabl=
e
> > >> walks, so that might hide the problem without actually fixing it.
> > >
> > > If we assume page-table walks as reads then mb() might be more
> > > suitable in this case ??
> > >
> > > ARM64 also has an explicit barrier in set_pte() implementation. They =
are
> > > doing "dsb(ishst); isb()" which is an inner-shareable store barrier f=
ollowed
> > > by an instruction barrier.
> > >
> > >>
> > >> Based upon Jiuyang's description, it does sound plausible that we ar=
e
> > >> missing an SFENCE.VMA (or TLB shootdown) somewhere.  But I don't
> > >> understand the situation well enough to know where that might be, or
> > >> what the best fix is.
> > >
> > > Yes, I agree but set_pte() doesn't seem to be the right place for TLB
> > > shootdown based on set_pte() implementations of other architectures.
> >
> > I agree as "flushing" the TLB after every set_pte() would be very
> > costly, it's better to do it once at the end of the all the updates:
> > like in flush_cache_vmap :)
> >
> > Alex
> >
> > >
> > > Regards,
> > > Anup
> > >
> > >>
> > >>
> > >>>
> > >>>>
> > >>>> In general, this patch didn't handle the G bit in PTE, kernel trap=
 it
> > >>>> to sbi_remote_sfence_vma. do you think I should use flush_tlb_all?
> > >>>>
> > >>>> Jiuyang
> > >>>>
> > >>>>
> > >>>>
> > >>>>
> > >>>> arch/arm/mm/mmu.c
> > >>>> void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > >>>>                                pte_t *ptep, pte_t pteval)
> > >>>> {
> > >>>>          unsigned long ext =3D 0;
> > >>>>
> > >>>>          if (addr < TASK_SIZE && pte_valid_user(pteval)) {
> > >>>>                  if (!pte_special(pteval))
> > >>>>                          __sync_icache_dcache(pteval);
> > >>>>                  ext |=3D PTE_EXT_NG;
> > >>>>          }
> > >>>>
> > >>>>          set_pte_ext(ptep, pteval, ext);
> > >>>> }
> > >>>>
> > >>>> arch/mips/include/asm/pgtable.h
> > >>>> static inline void set_pte_at(struct mm_struct *mm, unsigned long =
addr,
> > >>>>                                pte_t *ptep, pte_t pteval)
> > >>>> {
> > >>>>
> > >>>>          if (!pte_present(pteval))
> > >>>>                  goto cache_sync_done;
> > >>>>
> > >>>>          if (pte_present(*ptep) && (pte_pfn(*ptep) =3D=3D pte_pfn(=
pteval)))
> > >>>>                  goto cache_sync_done;
> > >>>>
> > >>>>          __update_cache(addr, pteval);
> > >>>> cache_sync_done:
> > >>>>          set_pte(ptep, pteval);
> > >>>> }
> > >>>>
> > >>>>
> > >>>> Also, just local TLB flush is generally not sufficient because
> > >>>>> a lot of page tables will be used accross on multiple HARTs.
> > >>>>
> > >>>>
> > >>>> On Tue, Mar 16, 2021 at 5:05 AM Anup Patel <anup@brainfault.org> w=
rote:
> > >>>>>
> > >>>>> +Alex
> > >>>>>
> > >>>>> On Tue, Mar 16, 2021 at 9:20 AM Jiuyang Liu <liu@jiuyang.me> wrot=
e:
> > >>>>>>
> > >>>>>> This patch inserts SFENCE.VMA after modifying PTE based on RISC-=
V
> > >>>>>> specification.
> > >>>>>>
> > >>>>>> arch/riscv/include/asm/pgtable.h:
> > >>>>>> 1. implement pte_user, pte_global and pte_leaf to check correspo=
nd
> > >>>>>> attribute of a pte_t.
> > >>>>>
> > >>>>> Adding pte_user(), pte_global(), and pte_leaf() is fine.
> > >>>>>
> > >>>>>>
> > >>>>>> 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Pri=
vileged
> > >>>>>> Spec v. 20190608 page 66 and 67:
> > >>>>>> If software modifies a non-leaf PTE, it should execute SFENCE.VM=
A with
> > >>>>>> rs1=3Dx0. If any PTE along the traversal path had its G bit set,=
 rs2 must
> > >>>>>> be x0; otherwise, rs2 should be set to the ASID for which the
> > >>>>>> translation is being modified.
> > >>>>>> If software modifies a leaf PTE, it should execute SFENCE.VMA wi=
th rs1
> > >>>>>> set to a virtual address within the page. If any PTE along the t=
raversal
> > >>>>>> path had its G bit set, rs2 must be x0; otherwise, rs2 should be=
 set to
> > >>>>>> the ASID for which the translation is being modified.
> > >>>>>>
> > >>>>>> arch/riscv/include/asm/tlbflush.h:
> > >>>>>> 1. implement get_current_asid to get current program asid.
> > >>>>>> 2. implement local_flush_tlb_asid to flush tlb with asid.
> > >>>>>
> > >>>>> As per my understanding, we don't need to explicitly invalidate l=
ocal TLB
> > >>>>> in set_pte() or set_pet_at() because generic Linux page table man=
agement
> > >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function=
 after page
> > >>>>> table updates. Also, just local TLB flush is generally not suffic=
ient because
> > >>>>> a lot of page tables will be used accross on multiple HARTs.
> > >>>>>
> > >>>>>>
> > >>>>>> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> > >>>>>> ---
> > >>>>>>   arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++=
++++
> > >>>>>>   arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
> > >>>>>>   2 files changed, 39 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/inclu=
de/asm/pgtable.h
> > >>>>>> index ebf817c1bdf4..5a47c60372c1 100644
> > >>>>>> --- a/arch/riscv/include/asm/pgtable.h
> > >>>>>> +++ b/arch/riscv/include/asm/pgtable.h
> > >>>>>> @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
> > >>>>>>          return pte_val(pte) & _PAGE_WRITE;
> > >>>>>>   }
> > >>>>>>
> > >>>>>> +static inline int pte_user(pte_t pte)
> > >>>>>> +{
> > >>>>>> +       return pte_val(pte) & _PAGE_USER;
> > >>>>>> +}
> > >>>>>> +
> > >>>>>> +static inline int pte_global(pte_t pte)
> > >>>>>> +{
> > >>>>>> +       return pte_val(pte) & _PAGE_GLOBAL;
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>   static inline int pte_exec(pte_t pte)
> > >>>>>>   {
> > >>>>>>          return pte_val(pte) & _PAGE_EXEC;
> > >>>>>> @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
> > >>>>>>          return pte_val(pte) & _PAGE_SPECIAL;
> > >>>>>>   }
> > >>>>>>
> > >>>>>> +static inline int pte_leaf(pte_t pte)
> > >>>>>> +{
> > >>>>>> +       return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_=
EXEC);
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>   /* static inline pte_t pte_rdprotect(pte_t pte) */
> > >>>>>>
> > >>>>>>   static inline pte_t pte_wrprotect(pte_t pte)
> > >>>>>> @@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_str=
uct *mm,
> > >>>>>>                  flush_icache_pte(pteval);
> > >>>>>>
> > >>>>>>          set_pte(ptep, pteval);
> > >>>>>> +
> > >>>>>> +       if (pte_present(pteval)) {
> > >>>>>> +               if (pte_leaf(pteval)) {
> > >>>>>> +                       local_flush_tlb_page(addr);
> > >>>>>> +               } else {
> > >>>>>> +                       if (pte_global(pteval))
> > >>>>>> +                               local_flush_tlb_all();
> > >>>>>> +                       else
> > >>>>>> +                               local_flush_tlb_asid();
> > >>>>>> +
> > >>>>>> +               }
> > >>>>>> +       }
> > >>>>>>   }
> > >>>>>>
> > >>>>>>   static inline void pte_clear(struct mm_struct *mm,
> > >>>>>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/incl=
ude/asm/tlbflush.h
> > >>>>>> index 394cfbccdcd9..1f9b62b3670b 100644
> > >>>>>> --- a/arch/riscv/include/asm/tlbflush.h
> > >>>>>> +++ b/arch/riscv/include/asm/tlbflush.h
> > >>>>>> @@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsig=
ned long addr)
> > >>>>>>   {
> > >>>>>>          __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : =
"memory");
> > >>>>>>   }
> > >>>>>> +
> > >>>>>> +static inline unsigned long get_current_asid(void)
> > >>>>>> +{
> > >>>>>> +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_AS=
ID_MASK;
> > >>>>>> +}
> > >>>>>> +
> > >>>>>> +static inline void local_flush_tlb_asid(void)
> > >>>>>> +{
> > >>>>>> +       unsigned long asid =3D get_current_asid();
> > >>>>>> +       __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid)=
 : "memory");
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>   #else /* CONFIG_MMU */
> > >>>>>>   #define local_flush_tlb_all()                  do { } while (0=
)
> > >>>>>>   #define local_flush_tlb_page(addr)             do { } while (0=
)
> > >>>>>> --
> > >>>>>> 2.30.2
> > >>>>>>
> > >>>>>>
> > >>>>>> _______________________________________________
> > >>>>>> linux-riscv mailing list
> > >>>>>> linux-riscv@lists.infradead.org
> > >>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >>>>>
> > >>>>> Regards,
> > >>>>> Anup
> > >>>
> > >>> Regards,
> > >>> Anup
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
