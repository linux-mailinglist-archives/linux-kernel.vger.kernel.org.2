Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD84333CFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhCPIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhCPI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:29:47 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:29:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so3939627ooq.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eecs-berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RL/I6VoQksk6tZvepxCxHZjaVs89qVtD8TJJHOvgjos=;
        b=ajaBzqX00mDZsvZqKd0NK9ANQVI9fDB3ZB+bgobv+aQpZuHt99UF5WA1BwV0ylU6q+
         raPBiwtlw9lo8/wtxrPK4qf8avQXErhnWzF1+Am/EMz9APhTP8VZo8KbZuKurj+TGHKN
         lMRhPTHCjCy2g1Vp3soaDFO4x9j/gNCSJcXbcG6mSgn6nwtQ5FMoNcK546G1FLxx16qQ
         qhIGcTOilWHKJpjbJcRY+pgKHh3wx7HGtt3K6MzNGHETU4Cf5g6Fzjef35PJjmqx7vgi
         uMiPJS7TnshRpqtKJ99dh6LY46KOLvh0AorrRtWpXUmKZfQQVuKJWlCE7/4xicIYZhCK
         MGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RL/I6VoQksk6tZvepxCxHZjaVs89qVtD8TJJHOvgjos=;
        b=ofst7SxhO5/3w/QZJedHmkiXhzbfU1Q++IdMoHe+P5IXFDNhaErzjBwG/Qho5xUcuC
         8vQ+5YVXhosK5yjRZ7nM9MHc3lVHEPq8lLpNymn5WG7V5eTYNwmCChCFBFeraF7k/TIY
         NLRJ3Xo9A5YCenD+Gg7fHeIH+QcZWJscbkBsNegGYdAEd+2rA2uhL57c2qiwjaP4gfMc
         ckHARNEiN/WVDg4icNOg469muCS0ftSOzFfwLPnbJWW7aAXni2FbzfuSUxHj+VrBrYPO
         KdLGyzLiKsazeR7siFqW5bnICewc5sCfzRfHDhS7d5shkp8m9m2FHGb8N8JFjdthGmpt
         eWvg==
X-Gm-Message-State: AOAM530ZJyUaqGoDMyYNtdudbI0i3LAAAVkUQp2FQjjYG0pi9zOSNRUr
        RuGSgo5F4mxRU00XabzoH5jJq/ruTAiJpkX/wYY=
X-Google-Smtp-Source: ABdhPJx5IoJ8nFMoR+oOFHckY59KckpvZS33PI6mJQz8+PdXqOTEa1FddfPx4d3p81IDywgkDgy8zrvDsHMGePi6w5Q=
X-Received: by 2002:a4a:8845:: with SMTP id e5mr2808672ooi.90.1615883386824;
 Tue, 16 Mar 2021 01:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210316015328.13516-1-liu@jiuyang.me> <20210316034638.16276-1-liu@jiuyang.me>
 <CAAhSdy3eEXtba_ebUnPW_OUHRMKsg+O9sBx_DHAmrkTUCfHXNg@mail.gmail.com>
 <CAPM7DZc+Ysd=VQdzc4_4Np8VAMESBrzD3mhk0ueh92x11bFFNg@mail.gmail.com> <CAAhSdy1HYJJDig3Mg1eWaO=zok9G6+hQM1LLbDKMzH-=Fi2dKw@mail.gmail.com>
In-Reply-To: <CAAhSdy1HYJJDig3Mg1eWaO=zok9G6+hQM1LLbDKMzH-=Fi2dKw@mail.gmail.com>
From:   Andrew Waterman <waterman@eecs.berkeley.edu>
Date:   Tue, 16 Mar 2021 01:29:35 -0700
Message-ID: <CA++6G0AnGVLbM+1j9K7UU_0p6NfwVAxNkcFr8s1=h+wW4G0z_w@mail.gmail.com>
Subject: Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
To:     Anup Patel <anup@brainfault.org>
Cc:     Jiuyang Liu <liu@jiuyang.me>, Alexandre Ghiti <alex@ghiti.fr>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:32 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Mar 16, 2021 at 12:27 PM Jiuyang Liu <liu@jiuyang.me> wrote:
> >
> > > As per my understanding, we don't need to explicitly invalidate local TLB
> > > in set_pte() or set_pet_at() because generic Linux page table management
> > > (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function after page
> > > table updates.
> >
> > I witnessed this bug in our micro-architecture: set_pte instruction is
> > still in the store buffer, no functions are inserting SFENCE.VMA in
> > the stack below, so TLB cannot witness this modification.
> > Here is my call stack:
> > set_pte
> > set_pte_at
> > map_vm_area
> > __vmalloc_area_node
> > __vmalloc_node_range
> > __vmalloc_node
> > __vmalloc_node_flags
> > vzalloc
> > n_tty_open
> >
> > I think this is an architecture specific code, so <linux>/mm/* should
> > not be modified.
> > And spec requires SFENCE.VMA to be inserted on each modification to
> > TLB. So I added code here.
>
> The generic linux/mm/* already calls the appropriate tlb_flush_xyz()
> function defined in arch/riscv/include/asm/tlbflush.h
>
> Better to have a write-barrier in set_pte().
>
> >
> > > Also, just local TLB flush is generally not sufficient because
> > > a lot of page tables will be used across on multiple HARTs.
> >
> > Yes, this is the biggest issue, in RISC-V Volume 2, Privileged Spec v.
> > 20190608 page 67 gave a solution:
>
> This is not an issue with RISC-V privilege spec rather it is more about
> placing RISC-V fences at right locations.
>
> > Consequently, other harts must be notified separately when the
> > memory-management data structures have been modified. One approach is
> > to use
> > 1) a local data fence to ensure local writes are visible globally,
> > then 2) an interprocessor interrupt to the other thread,
> > then 3) a local SFENCE.VMA in the interrupt handler of the remote thread,
> > and finally 4) signal back to originating thread that operation is
> > complete. This is, of course, the RISC-V analog to a TLB shootdown.
>
> I would suggest trying approach#1.
>
> You can include "asm/barrier.h" here and use wmb() or __smp_wmb()
> in-place of local TLB flush.

wmb() doesn't suffice to order older stores before younger page-table
walks, so that might hide the problem without actually fixing it.

Based upon Jiuyang's description, it does sound plausible that we are
missing an SFENCE.VMA (or TLB shootdown) somewhere.  But I don't
understand the situation well enough to know where that might be, or
what the best fix is.


>
> >
> > In general, this patch didn't handle the G bit in PTE, kernel trap it
> > to sbi_remote_sfence_vma. do you think I should use flush_tlb_all?
> >
> > Jiuyang
> >
> >
> >
> >
> > arch/arm/mm/mmu.c
> > void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >                               pte_t *ptep, pte_t pteval)
> > {
> >         unsigned long ext = 0;
> >
> >         if (addr < TASK_SIZE && pte_valid_user(pteval)) {
> >                 if (!pte_special(pteval))
> >                         __sync_icache_dcache(pteval);
> >                 ext |= PTE_EXT_NG;
> >         }
> >
> >         set_pte_ext(ptep, pteval, ext);
> > }
> >
> > arch/mips/include/asm/pgtable.h
> > static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >                               pte_t *ptep, pte_t pteval)
> > {
> >
> >         if (!pte_present(pteval))
> >                 goto cache_sync_done;
> >
> >         if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> >                 goto cache_sync_done;
> >
> >         __update_cache(addr, pteval);
> > cache_sync_done:
> >         set_pte(ptep, pteval);
> > }
> >
> >
> > Also, just local TLB flush is generally not sufficient because
> > > a lot of page tables will be used accross on multiple HARTs.
> >
> >
> > On Tue, Mar 16, 2021 at 5:05 AM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > +Alex
> > >
> > > On Tue, Mar 16, 2021 at 9:20 AM Jiuyang Liu <liu@jiuyang.me> wrote:
> > > >
> > > > This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
> > > > specification.
> > > >
> > > > arch/riscv/include/asm/pgtable.h:
> > > > 1. implement pte_user, pte_global and pte_leaf to check correspond
> > > > attribute of a pte_t.
> > >
> > > Adding pte_user(), pte_global(), and pte_leaf() is fine.
> > >
> > > >
> > > > 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privileged
> > > > Spec v. 20190608 page 66 and 67:
> > > > If software modifies a non-leaf PTE, it should execute SFENCE.VMA with
> > > > rs1=x0. If any PTE along the traversal path had its G bit set, rs2 must
> > > > be x0; otherwise, rs2 should be set to the ASID for which the
> > > > translation is being modified.
> > > > If software modifies a leaf PTE, it should execute SFENCE.VMA with rs1
> > > > set to a virtual address within the page. If any PTE along the traversal
> > > > path had its G bit set, rs2 must be x0; otherwise, rs2 should be set to
> > > > the ASID for which the translation is being modified.
> > > >
> > > > arch/riscv/include/asm/tlbflush.h:
> > > > 1. implement get_current_asid to get current program asid.
> > > > 2. implement local_flush_tlb_asid to flush tlb with asid.
> > >
> > > As per my understanding, we don't need to explicitly invalidate local TLB
> > > in set_pte() or set_pet_at() because generic Linux page table management
> > > (<linux>/mm/*) will call the appropriate flush_tlb_xyz() function after page
> > > table updates. Also, just local TLB flush is generally not sufficient because
> > > a lot of page tables will be used accross on multiple HARTs.
> > >
> > > >
> > > > Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> > > > ---
> > > >  arch/riscv/include/asm/pgtable.h  | 27 +++++++++++++++++++++++++++
> > > >  arch/riscv/include/asm/tlbflush.h | 12 ++++++++++++
> > > >  2 files changed, 39 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > > index ebf817c1bdf4..5a47c60372c1 100644
> > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
> > > >         return pte_val(pte) & _PAGE_WRITE;
> > > >  }
> > > >
> > > > +static inline int pte_user(pte_t pte)
> > > > +{
> > > > +       return pte_val(pte) & _PAGE_USER;
> > > > +}
> > > > +
> > > > +static inline int pte_global(pte_t pte)
> > > > +{
> > > > +       return pte_val(pte) & _PAGE_GLOBAL;
> > > > +}
> > > > +
> > > >  static inline int pte_exec(pte_t pte)
> > > >  {
> > > >         return pte_val(pte) & _PAGE_EXEC;
> > > > @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
> > > >         return pte_val(pte) & _PAGE_SPECIAL;
> > > >  }
> > > >
> > > > +static inline int pte_leaf(pte_t pte)
> > > > +{
> > > > +       return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC);
> > > > +}
> > > > +
> > > >  /* static inline pte_t pte_rdprotect(pte_t pte) */
> > > >
> > > >  static inline pte_t pte_wrprotect(pte_t pte)
> > > > @@ -358,6 +373,18 @@ static inline void set_pte_at(struct mm_struct *mm,
> > > >                 flush_icache_pte(pteval);
> > > >
> > > >         set_pte(ptep, pteval);
> > > > +
> > > > +       if (pte_present(pteval)) {
> > > > +               if (pte_leaf(pteval)) {
> > > > +                       local_flush_tlb_page(addr);
> > > > +               } else {
> > > > +                       if (pte_global(pteval))
> > > > +                               local_flush_tlb_all();
> > > > +                       else
> > > > +                               local_flush_tlb_asid();
> > > > +
> > > > +               }
> > > > +       }
> > > >  }
> > > >
> > > >  static inline void pte_clear(struct mm_struct *mm,
> > > > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> > > > index 394cfbccdcd9..1f9b62b3670b 100644
> > > > --- a/arch/riscv/include/asm/tlbflush.h
> > > > +++ b/arch/riscv/include/asm/tlbflush.h
> > > > @@ -21,6 +21,18 @@ static inline void local_flush_tlb_page(unsigned long addr)
> > > >  {
> > > >         __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
> > > >  }
> > > > +
> > > > +static inline unsigned long get_current_asid(void)
> > > > +{
> > > > +       return (csr_read(CSR_SATP) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
> > > > +}
> > > > +
> > > > +static inline void local_flush_tlb_asid(void)
> > > > +{
> > > > +       unsigned long asid = get_current_asid();
> > > > +       __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> > > > +}
> > > > +
> > > >  #else /* CONFIG_MMU */
> > > >  #define local_flush_tlb_all()                  do { } while (0)
> > > >  #define local_flush_tlb_page(addr)             do { } while (0)
> > > > --
> > > > 2.30.2
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > Regards,
> > > Anup
>
> Regards,
> Anup
