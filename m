Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1630AD31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBAQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhBAQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:55:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B662F64EFA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612198443;
        bh=R2deLGQWM21T1Z1lsTRnK0sy5WgkBjHWzAzXwxs1sTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VvchYXcnbt6NXdW63BfRi48sG/8zBTxEKByh0SmV3Mdg3i++SyHzOg/ssFVdThqqj
         1+WdRwaK9WEGxu52JBOG94swSWruTdzw9mv4w81V3bzvBohGjAyUHKv8NLF4J9Sr5n
         64U31lTX74ZmWtt3u8ijcSF/rbHgtykWW++Ql//agV6W15ADj4pVW/RvaKHmqM2vqo
         UaFkEnF/A1auKzwUl0v+Ir3exWV1x8Q6wVRRU+n8h5mvIKibBJO26/joP1WM9VT5UQ
         bXDWO193uXfJbMJSxuk4coIWbGMI2jPZiqclawhWpa164wVAh0wwB0lkqTTQkYkPzn
         AC7w7syzNDXRg==
Received: by mail-ej1-f49.google.com with SMTP id kg20so25477325ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:54:02 -0800 (PST)
X-Gm-Message-State: AOAM531Hai4H9M5qxLEM5juGOhE/lBb2CgioIa0xXS/XqoxSDA933avl
        MU+b/xKyd0OPTNw+PEbtzJPf8NU80Mfg5Wr4mx5tPQ==
X-Google-Smtp-Source: ABdhPJyM8RJY1t5s1JqqVoEOT7KAUP76uRrjVcEcLGl8MkAZ0dRMe7ueAwXYhz/VK0W5zRgC+GhG2RX9vrt1mUK70ls=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr18580966ejq.101.1612198441106;
 Mon, 01 Feb 2021 08:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-9-namit@vmware.com>
 <CALCETrUqoG9fhXLGbLomK-QrcSOhLDhJhQi5E=Y3FXNvYCzBcQ@mail.gmail.com> <17B9FE7B-1C92-4890-9B04-B129178C1184@vmware.com>
In-Reply-To: <17B9FE7B-1C92-4890-9B04-B129178C1184@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 08:53:49 -0800
X-Gmail-Original-Message-ID: <CALCETrXZVxqKqryi0xJ+qTLQgHx6XeF_MGbL3qi_5MzygFTJSA@mail.gmail.com>
Message-ID: <CALCETrXZVxqKqryi0xJ+qTLQgHx6XeF_MGbL3qi_5MzygFTJSA@mail.gmail.com>
Subject: Re: [RFC 08/20] mm: store completed TLB generation
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 11:28 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jan 31, 2021, at 12:32 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote=
:
> >> From: Nadav Amit <namit@vmware.com>
> >>
> >> To detect deferred TLB flushes in fine granularity, we need to keep
> >> track on the completed TLB flush generation for each mm.
> >>
> >> Add logic to track for each mm the tlb_gen_completed, which tracks the
> >> completed TLB generation. It is the arch responsibility to call
> >> mark_mm_tlb_gen_done() whenever a TLB flush is completed.
> >>
> >> Start the generation numbers from 1 instead of 0. This would allow lat=
er
> >> to detect whether flushes of a certain generation were completed.
> >
> > Can you elaborate on how this helps?
>
> I guess it should have gone to patch 15.
>
> The relevant code it interacts with is in read_defer_tlb_flush_gen(). It
> allows to use a single check to see =E2=80=9Coutdated=E2=80=9D deferred T=
LB gen. Initially
> tlb->defer_gen is zero. We are going to do inc_mm_tlb_gen() both on the
> first time we defer TLB entries and whenever we see mm_gen is newer than
> tlb->defer_gen:
>
> +       mm_gen =3D atomic64_read(&mm->tlb_gen);
> +
> +       /*
> +        * This condition checks for both first deferred TLB flush and fo=
r other
> +        * TLB pending or executed TLB flushes after the last table that =
we
> +        * updated. In the latter case, we are going to skip a generation=
, which
> +        * would lead to a full TLB flush. This should therefore not caus=
e
> +        * correctness issues, and should not induce overheads, since any=
how in
> +        * TLB storms it is better to perform full TLB flush.
> +        */
> +       if (mm_gen !=3D tlb->defer_gen) {
> +               VM_BUG_ON(mm_gen < tlb->defer_gen);
> +
> +               tlb->defer_gen =3D inc_mm_tlb_gen(mm);
> +       }
>
>
> >
> > I think you should document that tlb_gen_completed only means that no
> > outdated TLB entries will be observably used.  In the x86
> > implementation it's possible for older TLB entries to still exist,
> > unused, in TLBs of cpus running other mms.
>
> You mean entries that be later flushed during switch_mm_irqs_off(), right=
? I
> think that overall my comments need some work. Yes.

That's exactly what I mean.

>
> > How does this work with arch_tlbbatch_flush()?
>
> completed_gen is not updated by arch_tlbbatch_flush(), since I couldn=E2=
=80=99t find
> a way to combine them. completed_gen might not catch up with tlb_gen in t=
his
> case until another TLB flush takes place. I do not see correctness issue,
> but it might result in redundant TLB flush.

Please at least document this.

FWIW, arch_tlbbatch_flush() is gross.  I'm not convinced it's really
supportable with proper broadcast invalidation. I suppose we could
remove it or explicitly track the set of mms that need flushing.

>
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
> >> arch/x86/mm/tlb.c         | 10 ++++++++++
> >> include/asm-generic/tlb.h | 33 +++++++++++++++++++++++++++++++++
> >> include/linux/mm_types.h  | 15 ++++++++++++++-
> >> 3 files changed, 57 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> >> index 7ab21430be41..d17b5575531e 100644
> >> --- a/arch/x86/mm/tlb.c
> >> +++ b/arch/x86/mm/tlb.c
> >> @@ -14,6 +14,7 @@
> >> #include <asm/nospec-branch.h>
> >> #include <asm/cache.h>
> >> #include <asm/apic.h>
> >> +#include <asm/tlb.h>
> >>
> >> #include "mm_internal.h"
> >>
> >> @@ -915,6 +916,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsi=
gned long start,
> >>        if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> >>                flush_tlb_others(mm_cpumask(mm), info);
> >>
> >> +       /* Update the completed generation */
> >> +       mark_mm_tlb_gen_done(mm, new_tlb_gen);
> >> +
> >>        put_flush_tlb_info();
> >>        put_cpu();
> >> }
> >> @@ -1147,6 +1151,12 @@ void arch_tlbbatch_flush(struct arch_tlbflush_u=
nmap_batch *batch)
> >>
> >>        cpumask_clear(&batch->cpumask);
> >>
> >> +       /*
> >> +        * We cannot call mark_mm_tlb_gen_done() since we do not know =
which
> >> +        * mm's should be flushed. This may lead to some unwarranted T=
LB
> >> +        * flushes, but not to correction problems.
> >> +        */
> >> +
> >>        put_cpu();
> >> }
> >>
> >> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> >> index 517c89398c83..427bfcc6cdec 100644
> >> --- a/include/asm-generic/tlb.h
> >> +++ b/include/asm-generic/tlb.h
> >> @@ -513,6 +513,39 @@ static inline void tlb_end_vma(struct mmu_gather =
*tlb, struct vm_area_struct *vm
> >> }
> >> #endif
> >>
> >> +#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
> >> +
> >> +/*
> >> + * Helper function to update a generation to have a new value, as lon=
g as new
> >> + * value is greater or equal to gen.
> >> + */
> >
> > I read this a couple of times, and I don't understand it.  How about:
> >
> > Helper function to atomically set *gen =3D max(*gen, new_gen)
> >
> >> +static inline void tlb_update_generation(atomic64_t *gen, u64 new_gen=
)
> >> +{
> >> +       u64 cur_gen =3D atomic64_read(gen);
> >> +
> >> +       while (cur_gen < new_gen) {
> >> +               u64 old_gen =3D atomic64_cmpxchg(gen, cur_gen, new_gen=
);
> >> +
> >> +               /* Check if we succeeded in the cmpxchg */
> >> +               if (likely(cur_gen =3D=3D old_gen))
> >> +                       break;
> >> +
> >> +               cur_gen =3D old_gen;
> >> +       };
> >> +}
> >> +
> >> +
> >> +static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen=
)
> >> +{
> >> +       /*
> >> +        * Update the completed generation to the new generation if th=
e new
> >> +        * generation is greater than the previous one.
> >> +        */
> >> +       tlb_update_generation(&mm->tlb_gen_completed, gen);
> >> +}
> >> +
> >> +#endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
> >> +
> >> /*
> >>  * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->=
end,
> >>  * and set corresponding cleared_*.
> >> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >> index 2035ac319c2b..8a5eb4bfac59 100644
> >> --- a/include/linux/mm_types.h
> >> +++ b/include/linux/mm_types.h
> >> @@ -571,6 +571,13 @@ struct mm_struct {
> >>                 * This is not used on Xen PV.
> >>                 */
> >>                atomic64_t tlb_gen;
> >> +
> >> +               /*
> >> +                * TLB generation which is guarnateed to be flushed, i=
ncluding
> >
> > guaranteed
> >
> >> +                * all the PTE changes that were performed before tlb_=
gen was
> >> +                * incremented.
> >> +                */
> >
> > I will defer judgment to future patches before I believe that this isn'=
t racy :)
>
> Fair enough. Thanks for the review.
>
