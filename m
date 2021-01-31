Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7591D309A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 04:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhAaDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 22:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhAaDAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 22:00:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA46A64E1E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 03:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612062013;
        bh=HXpsLye8DyRJky+GB3F101QLZIqYLcaXw3RurhIpFwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=scyQ9R4DTmwgZTgVcM0Be4mB9mTwLj1zjAhaFnzdza6kCowSEPK0IjYX9IbOunZYr
         GLsq77UbWFxr0olByfafxcvU3yTOxepLYLcldcMO6u0T7XgZARFyZUS/4zK9GAMl9u
         svgQj7D/ctV6A5dhzENjhWEVsF+zzMqtC/2wSDyYoUCQhsifjS/R54YJi6he8Ct417
         iLPrRhO2ID0wn4mk8YIBeTgPQC5wBwOjX6fqQnYBwXfv0daPyJiL1xXqxL92MxEFCo
         bTbk7qcbO2mvHz57rFUJU5iLdnbu2ELfWy++CtISa+JhXoHiuHVVFzuOEIshkHd1UN
         L2k096J1rGtsg==
Received: by mail-ej1-f49.google.com with SMTP id w1so18841303ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 19:00:12 -0800 (PST)
X-Gm-Message-State: AOAM530ch+l8eaIZ2egTBlgweTM/TlPjK76yE43pU3Y1FGYlJuPIUWkq
        ohx+rpiysUvOilpar6+uuH6KrmowyjMMZ6vjkBNCkg==
X-Google-Smtp-Source: ABdhPJxpk9dsud3j/TxMFEZSRuLXCMc52bP54/5QSs+G8uyaBD6iDi5nwqL0iJCs5nOe9BpnTmJIeb1sS1QGai+h8JU=
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr11742341ejn.214.1612062011020;
 Sat, 30 Jan 2021 19:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com> <68D3C593-A88C-4100-90E9-E90F7733344F@gmail.com>
In-Reply-To: <68D3C593-A88C-4100-90E9-E90F7733344F@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 30 Jan 2021 18:59:59 -0800
X-Gmail-Original-Message-ID: <CALCETrVnLe6wf+nD-PDfKQAmJhcQm674iCHPiEWW0kiDucqk9g@mail.gmail.com>
Message-ID: <CALCETrVnLe6wf+nD-PDfKQAmJhcQm674iCHPiEWW0kiDucqk9g@mail.gmail.com>
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:17 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Jan 30, 2021, at 5:07 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Adding Andrew Cooper, who has a distressingly extensive understanding
> > of the x86 PTE magic.
> >
> > On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >>
> >> Currently, using mprotect() to unprotect a memory region or uffd to
> >> unprotect a memory region causes a TLB flush. At least on x86, as
> >> protection is promoted, no TLB flush is needed.
> >>
> >> Add an arch-specific pte_may_need_flush() which tells whether a TLB
> >> flush is needed based on the old PTE and the new one. Implement an x86
> >> pte_may_need_flush().
> >>
> >> For x86, besides the simple logic that PTE protection promotion or
> >> changes of software bits does require a flush, also add logic that
> >> considers the dirty-bit. If the dirty-bit is clear and write-protect is
> >> set, no TLB flush is needed, as x86 updates the dirty-bit atomically
> >> on write, and if the bit is clear, the PTE is reread.
> >>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Yu Zhao <yuzhao@google.com>
> >> Cc: Nick Piggin <npiggin@gmail.com>
> >> Cc: x86@kernel.org
> >> ---
> >> arch/x86/include/asm/tlbflush.h | 44 +++++++++++++++++++++++++++++++++
> >> include/asm-generic/tlb.h       |  4 +++
> >> mm/mprotect.c                   |  3 ++-
> >> 3 files changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> >> index 8c87a2e0b660..a617dc0a9b06 100644
> >> --- a/arch/x86/include/asm/tlbflush.h
> >> +++ b/arch/x86/include/asm/tlbflush.h
> >> @@ -255,6 +255,50 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> >>
> >> extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> >>
> >> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
> >> +{
> >> +       const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
> >> +                                    _PAGE_SOFTW3 | _PAGE_ACCESSED;
> >
> > Why is accessed ignored?  Surely clearing the accessed bit needs a
> > flush if the old PTE is present.
>
> I am just following the current scheme in the kernel (x86):
>
> int ptep_clear_flush_young(struct vm_area_struct *vma,
>                            unsigned long address, pte_t *ptep)
> {
>         /*
>          * On x86 CPUs, clearing the accessed bit without a TLB flush
>          * doesn't cause data corruption. [ It could cause incorrect
>          * page aging and the (mistaken) reclaim of hot pages, but the
>          * chance of that should be relatively low. ]
>          *

If anyone ever implements the optimization of skipping the flush when
unmapping a !accessed page, then this will cause data corruption.

If nothing else, this deserves a nice comment in the new code.

>          * So as a performance optimization don't flush the TLB when
>          * clearing the accessed bit, it will eventually be flushed by
>          * a context switch or a VM operation anyway. [ In the rare
>          * event of it not getting flushed for a long time the delay
>          * shouldn't really matter because there's no real memory
>          * pressure for swapout to react to. ]
>          */
>         return ptep_test_and_clear_young(vma, address, ptep);
> }
>
>
> >
> >> +       const pteval_t enable_mask = _PAGE_RW | _PAGE_DIRTY | _PAGE_GLOBAL;
> >> +       pteval_t oldval = pte_val(oldpte);
> >> +       pteval_t newval = pte_val(newpte);
> >> +       pteval_t diff = oldval ^ newval;
> >> +       pteval_t disable_mask = 0;
> >> +
> >> +       if (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_X86_PAE))
> >> +               disable_mask = _PAGE_NX;
> >> +
> >> +       /* new is non-present: need only if old is present */
> >> +       if (pte_none(newpte))
> >> +               return !pte_none(oldpte);
> >> +
> >> +       /*
> >> +        * If, excluding the ignored bits, only RW and dirty are cleared and the
> >> +        * old PTE does not have the dirty-bit set, we can avoid a flush. This
> >> +        * is possible since x86 architecture set the dirty bit atomically while
> >
> > s/set/sets/
> >
> >> +        * it caches the PTE in the TLB.
> >> +        *
> >> +        * The condition considers any change to RW and dirty as not requiring
> >> +        * flush if the old PTE is not dirty or not writable for simplification
> >> +        * of the code and to consider (unlikely) cases of changing dirty-bit of
> >> +        * write-protected PTE.
> >> +        */
> >> +       if (!(diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask)) &&
> >> +           (!(pte_dirty(oldpte) || !pte_write(oldpte))))
> >> +               return false;
> >
> > This logic seems confusing to me.  Is your goal to say that, if the
> > old PTE was clean and writable and the new PTE is write-protected,
> > then no flush is needed?
>
> Yes.
>
> > If so, I would believe you're right, but I'm
> > not convinced you've actually implemented this.  Also, there may be
> > other things going on that need flushing, e.g. a change of the address
> > or an accessed bit or NX change.
>
> The first part (diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask) is supposed
> to capture changes of address, NX-bit, etc.
>
> The second part is indeed wrong. It should have been:
>  (!pte_dirty(oldpte) || !pte_write(oldpte))
>
> >
> > Also, CET makes this extra bizarre.
>
> I saw something about the not-writeable-and-dirty considered differently. I
> need to have a look, but I am not sure it affects anything.
>

It affects everyone's sanity. I don't yet have an opinion as to
whether it affects correctness :)
