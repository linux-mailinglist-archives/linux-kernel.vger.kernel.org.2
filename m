Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE19433E113
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCPWDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCPWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:03:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B958C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:03:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o22so30010907oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eecs-berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jQm7Iz274lyno3HwZpTtO0l1/3Okx8EOV1uyCbcNuKU=;
        b=RZ+DrgWJwhadtU9x8TDIjhBWhoCb1fN5h3/TbqcomYvXjAbYOeSkE1cKoBzso6rCV7
         8qE54v/wu3yc3akxtslYp2euez9ISI8jYvb0FlNjHL0RumI8ph18qF8Vw2DF24tJypYR
         VSVunY3MsV8VNHHBRkf/YiK8xZ9aZBr/76Rhm8617Z+wTKt6asxElkJYsJwx+Vm0Kgjq
         nD2If3BXjATKJU0mLszI0sRkeO/CRsUo3gYmVRwagdTOdvBr4ijILv59bwFq8loCjf8C
         BCeThd6fvQviq8FlCdkO8i3PzNUYl/nLM3RPEiSRSdRzQUoPLliTcfRuLDhP7doEIOfy
         IzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQm7Iz274lyno3HwZpTtO0l1/3Okx8EOV1uyCbcNuKU=;
        b=iEL5qVahtmj2WwSmiYSCphys+XmSatl+/paGJmgFvpKj4VYe9yMy+YOrgz3Tpkvd4r
         CS9xEr5juSECbC0fZd1nUk/ONVg3mzDh0+iDmVJt+3kbOjTRTsAbes7kf8wKDEF7L9kA
         Fsbk/y8htdT4rqCABAFK0tTtWs/BuFCp7Dypzhcqlw9ScLCfljSwLDFF9e8fv+0zGNxn
         p6Zw4mp970wde++kJxbg1l/9g+tAId2xz4x0akLDTRxY42grqj42+hgGUyXnrdDQX5t8
         V/EdjWUW38ua0wHr9OdCu9mo6n6MiKCVSK9sdyyCiQpqyDt6oMcsKCxOczX+V9f+QOe1
         NpaA==
X-Gm-Message-State: AOAM532JDGgQJgieqJXz0PpullT3IzgTgJCyCQytOnOEOGBjpAa2DO8D
        crf2634MNs6by+Vmr5f9UvWS1+Qj4jvk8rL9nmI=
X-Google-Smtp-Source: ABdhPJy6r+gUJ0CEOOaC5X2cUxtJWRc0ZZaF/RJISMCpvDEunKbzbHqjF2o4Kb3q3X5JJJXI3e5Xe1VjXGLat6QOR4w=
X-Received: by 2002:a05:6808:6cc:: with SMTP id m12mr540655oih.129.1615932203200;
 Tue, 16 Mar 2021 15:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210316015328.13516-1-liu@jiuyang.me> <20210316034638.16276-1-liu@jiuyang.me>
 <CAAhSdy3eEXtba_ebUnPW_OUHRMKsg+O9sBx_DHAmrkTUCfHXNg@mail.gmail.com>
 <CAPM7DZc+Ysd=VQdzc4_4Np8VAMESBrzD3mhk0ueh92x11bFFNg@mail.gmail.com>
 <CAAhSdy1HYJJDig3Mg1eWaO=zok9G6+hQM1LLbDKMzH-=Fi2dKw@mail.gmail.com>
 <CA++6G0AnGVLbM+1j9K7UU_0p6NfwVAxNkcFr8s1=h+wW4G0z_w@mail.gmail.com>
 <CAAhSdy0nAUW-Y9gFONVLUPZCG-zT2MXKacu+StKKmSro+58k8w@mail.gmail.com> <d4f3f2af-345d-b9a9-6ac5-f4262d0b46c5@ghiti.fr>
In-Reply-To: <d4f3f2af-345d-b9a9-6ac5-f4262d0b46c5@ghiti.fr>
From:   Andrew Waterman <waterman@eecs.berkeley.edu>
Date:   Tue, 16 Mar 2021 15:03:12 -0700
Message-ID: <CA++6G0AysZ3eZ+F1jMxx59aKbj3CyiOSMTkr1RVKuocqmZ6maQ@mail.gmail.com>
Subject: Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Anup Patel <anup@brainfault.org>, Jiuyang Liu <liu@jiuyang.me>,
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

On Tue, Mar 16, 2021 at 5:05 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 3/16/21 =C3=A0 4:40 AM, Anup Patel a =C3=A9crit :
> > On Tue, Mar 16, 2021 at 1:59 PM Andrew Waterman
> > <waterman@eecs.berkeley.edu> wrote:
> >>
> >> On Tue, Mar 16, 2021 at 12:32 AM Anup Patel <anup@brainfault.org> wrot=
e:
> >>>
> >>> On Tue, Mar 16, 2021 at 12:27 PM Jiuyang Liu <liu@jiuyang.me> wrote:
> >>>>
> >>>>> As per my understanding, we don't need to explicitly invalidate loc=
al TLB
> >>>>> in set_pte() or set_pet_at() because generic Linux page table manag=
ement
> >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function a=
fter page
> >>>>> table updates.
> >>>>
> >>>> I witnessed this bug in our micro-architecture: set_pte instruction =
is
> >>>> still in the store buffer, no functions are inserting SFENCE.VMA in
> >>>> the stack below, so TLB cannot witness this modification.
> >>>> Here is my call stack:
> >>>> set_pte
> >>>> set_pte_at
> >>>> map_vm_area
> >>>> __vmalloc_area_node
> >>>> __vmalloc_node_range
> >>>> __vmalloc_node
> >>>> __vmalloc_node_flags
> >>>> vzalloc
> >>>> n_tty_open
> >>>>
>
> I don't find this call stack, what I find is (the other way around):
>
> n_tty_open
> vzalloc
> __vmalloc_node
> __vmalloc_node_range
> __vmalloc_area_node
> map_kernel_range
> -> map_kernel_range_noflush
>     flush_cache_vmap
>
> Which leads to the fact that we don't have flush_cache_vmap callback
> implemented: shouldn't we add the sfence.vma here ? Powerpc does
> something similar with "ptesync" (see below) instruction that seems to
> do the same as sfence.vma.

I was thinking the same thing, but I hadn't yet wrapped my head around
the fact that most architectures don't have something similar.  I'm OK
with following PPC's lead if it appears to be a correct bug fix :)

>
>
> ptesync: "The ptesync instruction after the Store instruction ensures
> that all searches of the Page Table that are performed after the ptesync
> instruction completes will use the value stored"
>
> >>>> I think this is an architecture specific code, so <linux>/mm/* shoul=
d
> >>>> not be modified.
> >>>> And spec requires SFENCE.VMA to be inserted on each modification to
> >>>> TLB. So I added code here.
> >>>
> >>> The generic linux/mm/* already calls the appropriate tlb_flush_xyz()
> >>> function defined in arch/riscv/include/asm/tlbflush.h
> >>>
> >>> Better to have a write-barrier in set_pte().
> >>>
> >>>>
> >>>>> Also, just local TLB flush is generally not sufficient because
> >>>>> a lot of page tables will be used across on multiple HARTs.
> >>>>
> >>>> Yes, this is the biggest issue, in RISC-V Volume 2, Privileged Spec =
v.
> >>>> 20190608 page 67 gave a solution:
> >>>
> >>> This is not an issue with RISC-V privilege spec rather it is more abo=
ut
> >>> placing RISC-V fences at right locations.
> >>>
> >>>> Consequently, other harts must be notified separately when the
> >>>> memory-management data structures have been modified. One approach i=
s
> >>>> to use
> >>>> 1) a local data fence to ensure local writes are visible globally,
> >>>> then 2) an interprocessor interrupt to the other thread,
> >>>> then 3) a local SFENCE.VMA in the interrupt handler of the remote th=
read,
> >>>> and finally 4) signal back to originating thread that operation is
> >>>> complete. This is, of course, the RISC-V analog to a TLB shootdown.
> >>>
> >>> I would suggest trying approach#1.
> >>>
> >>> You can include "asm/barrier.h" here and use wmb() or __smp_wmb()
> >>> in-place of local TLB flush.
> >>
> >> wmb() doesn't suffice to order older stores before younger page-table
> >> walks, so that might hide the problem without actually fixing it.
> >
> > If we assume page-table walks as reads then mb() might be more
> > suitable in this case ??
> >
> > ARM64 also has an explicit barrier in set_pte() implementation. They ar=
e
> > doing "dsb(ishst); isb()" which is an inner-shareable store barrier fol=
lowed
> > by an instruction barrier.
> >
> >>
> >> Based upon Jiuyang's description, it does sound plausible that we are
> >> missing an SFENCE.VMA (or TLB shootdown) somewhere.  But I don't
> >> understand the situation well enough to know where that might be, or
> >> what the best fix is.
> >
> > Yes, I agree but set_pte() doesn't seem to be the right place for TLB
> > shootdown based on set_pte() implementations of other architectures.
>
> I agree as "flushing" the TLB after every set_pte() would be very
> costly, it's better to do it once at the end of the all the updates:
> like in flush_cache_vmap :)
>
> Alex
>
> >
> > Regards,
> > Anup
> >
> >>
> >>
> >>>
> >>>>
> >>>> In general, this patch didn't handle the G bit in PTE, kernel trap i=
t
> >>>> to sbi_remote_sfence_vma. do you think I should use flush_tlb_all?
> >>>>
> >>>> Jiuyang
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> arch/arm/mm/mmu.c
> >>>> void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >>>>                                pte_t *ptep, pte_t pteval)
> >>>> {
> >>>>          unsigned long ext =3D 0;
> >>>>
> >>>>          if (addr < TASK_SIZE && pte_valid_user(pteval)) {
> >>>>                  if (!pte_special(pteval))
> >>>>                          __sync_icache_dcache(pteval);
> >>>>                  ext |=3D PTE_EXT_NG;
> >>>>          }
> >>>>
> >>>>          set_pte_ext(ptep, pteval, ext);
> >>>> }
> >>>>
> >>>> arch/mips/include/asm/pgtable.h
> >>>> static inline void set_pte_at(struct mm_struct *mm, unsigned long ad=
dr,
> >>>>                                pte_t *ptep, pte_t pteval)
> >>>> {
> >>>>
> >>>>          if (!pte_present(pteval))
> >>>>                  goto cache_sync_done;
> >>>>
> >>>>          if (pte_present(*ptep) && (pte_pfn(*ptep) =3D=3D pte_pfn(pt=
eval)))
> >>>>                  goto cache_sync_done;
> >>>>
> >>>>          __update_cache(addr, pteval);
> >>>> cache_sync_done:
> >>>>          set_pte(ptep, pteval);
> >>>> }
> >>>>
> >>>>
> >>>> Also, just local TLB flush is generally not sufficient because
> >>>>> a lot of page tables will be used accross on multiple HARTs.
> >>>>
> >>>>
> >>>> On Tue, Mar 16, 2021 at 5:05 AM Anup Patel <anup@brainfault.org> wro=
te:
> >>>>>
> >>>>> +Alex
> >>>>>
> >>>>> On Tue, Mar 16, 2021 at 9:20 AM Jiuyang Liu <liu@jiuyang.me> wrote:
> >>>>>>
> >>>>>> This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
> >>>>>> specification.
> >>>>>>
> >>>>>> arch/riscv/include/asm/pgtable.h:
> >>>>>> 1. implement pte_user, pte_global and pte_leaf to check correspond
> >>>>>> attribute of a pte_t.
> >>>>>
> >>>>> Adding pte_user(), pte_global(), and pte_leaf() is fine.
> >>>>>
> >>>>>>
> >>>>>> 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privi=
leged
> >>>>>> Spec v. 20190608 page 66 and 67:
> >>>>>> If software modifies a non-leaf PTE, it should execute SFENCE.VMA =
with
> >>>>>> rs1=3Dx0. If any PTE along the traversal path had its G bit set, r=
s2 must
> >>>>>> be x0; otherwise, rs2 should be set to the ASID for which the
> >>>>>> translation is being modified.
> >>>>>> If software modifies a leaf PTE, it should execute SFENCE.VMA with=
 rs1
> >>>>>> set to a virtual address within the page. If any PTE along the tra=
versal
> >>>>>> path had its G bit set, rs2 must be x0; otherwise, rs2 should be s=
et to
> >>>>>> the ASID for which the translation is being modified.
> >>>>>>
> >>>>>> arch/riscv/include/asm/tlbflush.h:
> >>>>>> 1. implement get_current_asid to get current program asid.
> >>>>>> 2. implement local_flush_tlb_asid to flush tlb with asid.
> >>>>>
> >>>>> As per my understanding, we don't need to explicitly invalidate loc=
al TLB
> >>>>> in set_pte() or set_pet_at() because generic Linux page table manag=
ement
> >>>>> (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function a=
fter page
> >>>>> table updates. Also, just local TLB flush is generally not sufficie=
nt because
> >>>>> a lot of page tables will be used accross on multiple HARTs.
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> >>>>>> ---
> >>>>>>   arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++++=
++
> >>>>>>   arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
> >>>>>>   2 files changed, 39 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include=
/asm/pgtable.h
> >>>>>> index ebf817c1bdf4..5a47c60372c1 100644
> >>>>>> --- a/arch/riscv/include/asm/pgtable.h
> >>>>>> +++ b/arch/riscv/include/asm/pgtable.h
> >>>>>> @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
> >>>>>>          return pte_val(pte) & _PAGE_WRITE;
> >>>>>>   }
> >>>>>>
> >>>>>> +static inline int pte_user(pte_t pte)
> >>>>>> +{
> >>>>>> +       return pte_val(pte) & _PAGE_USER;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline int pte_global(pte_t pte)
> >>>>>> +{
> >>>>>> +       return pte_val(pte) & _PAGE_GLOBAL;
> >>>>>> +}
> >>>>>> +
> >>>>>>   static inline int pte_exec(pte_t pte)
> >>>>>>   {
> >>>>>>          return pte_val(pte) & _PAGE_EXEC;
> >>>>>> @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
> >>>>>>          return pte_val(pte) & _PAGE_SPECIAL;
> >>>>>>   }
> >>>>>>
> >>>>>> +static inline int pte_leaf(pte_t pte)
> >>>>>> +{
> >>>>>> +       return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EX=
EC);
> >>>>>> +}
> >>>>>> +
> >>>>>>   /* static inline pte_t pte_rdprotect(pte_t pte) */
> >>>>>>
> >>>>>>   static inline pte_t pte_wrprotect(pte_t pte)
> >>>>>> @@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_struc=
t *mm,
> >>>>>>                  flush_icache_pte(pteval);
> >>>>>>
> >>>>>>          set_pte(ptep, pteval);
> >>>>>> +
> >>>>>> +       if (pte_present(pteval)) {
> >>>>>> +               if (pte_leaf(pteval)) {
> >>>>>> +                       local_flush_tlb_page(addr);
> >>>>>> +               } else {
> >>>>>> +                       if (pte_global(pteval))
> >>>>>> +                               local_flush_tlb_all();
> >>>>>> +                       else
> >>>>>> +                               local_flush_tlb_asid();
> >>>>>> +
> >>>>>> +               }
> >>>>>> +       }
> >>>>>>   }
> >>>>>>
> >>>>>>   static inline void pte_clear(struct mm_struct *mm,
> >>>>>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/includ=
e/asm/tlbflush.h
> >>>>>> index 394cfbccdcd9..1f9b62b3670b 100644
> >>>>>> --- a/arch/riscv/include/asm/tlbflush.h
> >>>>>> +++ b/arch/riscv/include/asm/tlbflush.h
> >>>>>> @@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsigne=
d long addr)
> >>>>>>   {
> >>>>>>          __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "m=
emory");
> >>>>>>   }
> >>>>>> +
> >>>>>> +static inline unsigned long get_current_asid(void)
> >>>>>> +{
> >>>>>> +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID=
_MASK;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline void local_flush_tlb_asid(void)
> >>>>>> +{
> >>>>>> +       unsigned long asid =3D get_current_asid();
> >>>>>> +       __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) :=
 "memory");
> >>>>>> +}
> >>>>>> +
> >>>>>>   #else /* CONFIG_MMU */
> >>>>>>   #define local_flush_tlb_all()                  do { } while (0)
> >>>>>>   #define local_flush_tlb_page(addr)             do { } while (0)
> >>>>>> --
> >>>>>> 2.30.2
> >>>>>>
> >>>>>>
> >>>>>> _______________________________________________
> >>>>>> linux-riscv mailing list
> >>>>>> linux-riscv@lists.infradead.org
> >>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>>>
> >>>>> Regards,
> >>>>> Anup
> >>>
> >>> Regards,
> >>> Anup
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
