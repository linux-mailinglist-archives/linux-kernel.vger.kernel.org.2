Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0B309EF2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhAaUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhAaUdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:33:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6065364E29
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612125148;
        bh=YSejjiCQYb6LknDEqwJa4TaQ624HDCCFGdHF3R6s90Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vOk0/sEDH3PIvbeE4LIzumohy5s+fhKcJlARZRx2SbqZS1k98ib0tRait7nIcLtXh
         W6rqBCAhb8IpKN7TY3nz6+7OYfw/GzSSkd2/WGrjnFpBw9bURWN7gD/89mUsfyTTCU
         OY7eoya90KKC7JMHX3JVicmkXgiOL5mjcXPOe7AJoSUd14eGvJXCbUIYhNCb4JALYq
         cRGa9ohapVUlBzdavx26w4gtp94UsyrKFc0EjLL7keXvmcD/XbYVjrXHEelEwjJ0kD
         EbwOpEYzEUOa94uHShTfXx2IE5+wSsKZDWD5SDXFufmudQ7H03QZBMS/EmEMqvOXyh
         E+e1IwdNHOTIw==
Received: by mail-ej1-f54.google.com with SMTP id i8so4664283ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:32:28 -0800 (PST)
X-Gm-Message-State: AOAM533eCaqV1IukjzaXd1B/HcihS5kaUMJrlUeuOuimoZX3ZbA19XAl
        DbiOp82DKtFiFkTfXkaLQAWoP60xpZOve5c1Li3xew==
X-Google-Smtp-Source: ABdhPJxTdNegKWYNeyWfYoY/gnWURbV1JO3Zf7q06D1o6dENT5MiXDdak+r522ho+dHmTajGQ3m4+d2u4l8rMmyyeWU=
X-Received: by 2002:a17:906:3f89:: with SMTP id b9mr14177953ejj.204.1612125146901;
 Sun, 31 Jan 2021 12:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-9-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-9-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Jan 2021 12:32:15 -0800
X-Gmail-Original-Message-ID: <CALCETrUqoG9fhXLGbLomK-QrcSOhLDhJhQi5E=Y3FXNvYCzBcQ@mail.gmail.com>
Message-ID: <CALCETrUqoG9fhXLGbLomK-QrcSOhLDhJhQi5E=Y3FXNvYCzBcQ@mail.gmail.com>
Subject: Re: [RFC 08/20] mm: store completed TLB generation
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Nadav Amit <namit@vmware.com>
>
> To detect deferred TLB flushes in fine granularity, we need to keep
> track on the completed TLB flush generation for each mm.
>
> Add logic to track for each mm the tlb_gen_completed, which tracks the
> completed TLB generation. It is the arch responsibility to call
> mark_mm_tlb_gen_done() whenever a TLB flush is completed.
>
> Start the generation numbers from 1 instead of 0. This would allow later
> to detect whether flushes of a certain generation were completed.

Can you elaborate on how this helps?

I think you should document that tlb_gen_completed only means that no
outdated TLB entries will be observably used.  In the x86
implementation it's possible for older TLB entries to still exist,
unused, in TLBs of cpus running other mms.

How does this work with arch_tlbbatch_flush()?

>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/mm/tlb.c         | 10 ++++++++++
>  include/asm-generic/tlb.h | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h  | 15 ++++++++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 7ab21430be41..d17b5575531e 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -14,6 +14,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/cache.h>
>  #include <asm/apic.h>
> +#include <asm/tlb.h>
>
>  #include "mm_internal.h"
>
> @@ -915,6 +916,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>         if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
>                 flush_tlb_others(mm_cpumask(mm), info);
>
> +       /* Update the completed generation */
> +       mark_mm_tlb_gen_done(mm, new_tlb_gen);
> +
>         put_flush_tlb_info();
>         put_cpu();
>  }
> @@ -1147,6 +1151,12 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>
>         cpumask_clear(&batch->cpumask);
>
> +       /*
> +        * We cannot call mark_mm_tlb_gen_done() since we do not know which
> +        * mm's should be flushed. This may lead to some unwarranted TLB
> +        * flushes, but not to correction problems.
> +        */
> +
>         put_cpu();
>  }
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 517c89398c83..427bfcc6cdec 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -513,6 +513,39 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  }
>  #endif
>
> +#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
> +
> +/*
> + * Helper function to update a generation to have a new value, as long as new
> + * value is greater or equal to gen.
> + */

I read this a couple of times, and I don't understand it.  How about:

Helper function to atomically set *gen = max(*gen, new_gen)

> +static inline void tlb_update_generation(atomic64_t *gen, u64 new_gen)
> +{
> +       u64 cur_gen = atomic64_read(gen);
> +
> +       while (cur_gen < new_gen) {
> +               u64 old_gen = atomic64_cmpxchg(gen, cur_gen, new_gen);
> +
> +               /* Check if we succeeded in the cmpxchg */
> +               if (likely(cur_gen == old_gen))
> +                       break;
> +
> +               cur_gen = old_gen;
> +       };
> +}
> +
> +
> +static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
> +{
> +       /*
> +        * Update the completed generation to the new generation if the new
> +        * generation is greater than the previous one.
> +        */
> +       tlb_update_generation(&mm->tlb_gen_completed, gen);
> +}
> +
> +#endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
> +
>  /*
>   * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
>   * and set corresponding cleared_*.
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2035ac319c2b..8a5eb4bfac59 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -571,6 +571,13 @@ struct mm_struct {
>                  * This is not used on Xen PV.
>                  */
>                 atomic64_t tlb_gen;
> +
> +               /*
> +                * TLB generation which is guarnateed to be flushed, including

guaranteed

> +                * all the PTE changes that were performed before tlb_gen was
> +                * incremented.
> +                */

I will defer judgment to future patches before I believe that this isn't racy :)

> +               atomic64_t tlb_gen_completed;
>  #endif
>         } __randomize_layout;
>
> @@ -690,7 +697,13 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>  #ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
>  static inline void init_mm_tlb_gen(struct mm_struct *mm)
>  {
> -       atomic64_set(&mm->tlb_gen, 0);
> +       /*
> +        * Start from generation of 1, so default generation 0 will be
> +        * considered as flushed and would not be regarded as an outstanding
> +        * deferred invalidation.
> +        */

Aha, this makes sense.

> +       atomic64_set(&mm->tlb_gen, 1);
> +       atomic64_set(&mm->tlb_gen_completed, 1);
>  }
>
>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
> --
> 2.25.1
>
