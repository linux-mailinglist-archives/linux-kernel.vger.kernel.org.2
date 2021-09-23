Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCA415FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhIWN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbhIWNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B78C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:24:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w17so6100882qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9u6DpipKdkYxzryu97JGWR+FHzvdxp/0hUwzm5Xllkg=;
        b=E4bTKRFTb159AyUy1ADkq1t30860DD6V83n0AegZv0pIeGtHY2W60aJxmf1LwLJZkk
         VSZXyuB45jKsVPqmPMwtYasxUyDjWaJS1FGljRpOn8EmyV/5LKmur+mBjoWAt+t7vmfv
         8arLrZW/MWjTJqolFPk/286QUNJxCvFLtgO25SeFHlh7HUjdOGv6tKZUpPTvn4dQj5f+
         2JUZxRxfgdBK3nABSd5CZ5wFndoJswjusWXeH5IwIcPUkf3QSaN66ctpY+XWL4XDO6Op
         mK/V5/kmeGMKKIvJry9ieP332oGEI+gQEf7/HrG2JT9U1CiWy1g8JNI6n3SwcUffH7Mo
         N4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9u6DpipKdkYxzryu97JGWR+FHzvdxp/0hUwzm5Xllkg=;
        b=hp93b/4Si44BSQ/PrY/4d8m4VdiIVhC4syvh/0/vqCTwnrafnuh4u50STDsKnOM/tJ
         GiCmQDjBvnPbAf3VeUa6mnYtMt4I2Ge4G02LdRQv7U0VtAD78yOBsmNb3DuRx/oyyFvs
         EgwmOHQSHjUVNIwA+dvewPH7gmWI6n2Uaja+I+7uR/ja7Zk7XdDvCa8ikgLQ/v1F77IS
         6mJrGejKNMmZDPhiQ9Y0cNwQEWuASBVpoaE4K26bg5YfV/nNKUkdfeTmsmxA7wVRd0ym
         sczlP5o34uCDSmMFBeLzx+mxEVDCsvjhEa99+MsbNvaNbjqu7k3GM7rR0sDLnQ+WYy1X
         Opbg==
X-Gm-Message-State: AOAM532Cvrf8LY+hcqlfFx61MWkUZHEdaTplhwsF4S2dGt6UiWT9q0ZS
        Q/NG92IfvxsSiCQ/7yNOs2I+3NgWktRilK44rWB67w==
X-Google-Smtp-Source: ABdhPJzqpKIivVlP6DdxD5Jl1mNsz6f2a00ynXFo7GNT0Jt/BQmpTBCkaUO5P6OFQfYnWxXIgq8vTWCLgvIDy6ho6Xc=
X-Received: by 2002:ac8:560b:: with SMTP id 11mr4779099qtr.319.1632403456468;
 Thu, 23 Sep 2021 06:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-4-elver@google.com>
 <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 15:23:39 +0200
Message-ID: <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] kfence: limit currently covered allocations when
 pool nearly full
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 1:19 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 23 Sept 2021 at 12:48, Marco Elver <elver@google.com> wrote:
> >
> > One of KFENCE's main design principles is that with increasing uptime,
> > allocation coverage increases sufficiently to detect previously
> > undetected bugs.
> >
> > We have observed that frequent long-lived allocations of the same
> > source (e.g. pagecache) tend to permanently fill up the KFENCE pool
> > with increasing system uptime, thus breaking the above requirement.
> > The workaround thus far had been increasing the sample interval and/or
> > increasing the KFENCE pool size, but is no reliable solution.
> >
> > To ensure diverse coverage of allocations, limit currently covered
> > allocations of the same source once pool utilization reaches 75%
> > (configurable via `kfence.skip_covered_thresh`) or above. The effect is
> > retaining reasonable allocation coverage when the pool is close to full=
.
> >
> > A side-effect is that this also limits frequent long-lived allocations
> > of the same source filling up the pool permanently.
> >
> > Uniqueness of an allocation for coverage purposes is based on its
> > (partial) allocation stack trace (the source). A Counting Bloom filter
> > is used to check if an allocation is covered; if the allocation is
> > currently covered, the allocation is skipped by KFENCE.
> >
> > Testing was done using:
> >
> >         (a) a synthetic workload that performs frequent long-lived
> >             allocations (default config values; sample_interval=3D1;
> >             num_objects=3D63), and
> >
> >         (b) normal desktop workloads on an otherwise idle machine where
> >             the problem was first reported after a few days of uptime
> >             (default config values).
> >
> > In both test cases the sampled allocation rate no longer drops to zero
> > at any point. In the case of (b) we observe (after 2 days uptime) 15%
> > unique allocations in the pool, 77% pool utilization, with 20% "skipped
> > allocations (covered)".
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

>
> > ---
> > v3:
> > * Remove unneeded !alloc_stack_hash checks.
> > * Remove unneeded meta->alloc_stack_hash=3D0 in kfence_guarded_free().
> >
> > v2:
> > * Switch to counting bloom filter to guarantee currently covered
> >   allocations being skipped.
> > * Use a module param for skip_covered threshold.
> > * Use kfence pool address as hash entropy.
> > * Use filter_irq_stacks().
> > ---
> >  mm/kfence/core.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++-
> >  mm/kfence/kfence.h |   2 +
> >  2 files changed, 103 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index db01814f8ff0..58a0f6f1acc5 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -11,11 +11,13 @@
> >  #include <linux/bug.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/irq_work.h>
> > +#include <linux/jhash.h>
> >  #include <linux/kcsan-checks.h>
> >  #include <linux/kfence.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/list.h>
> >  #include <linux/lockdep.h>
> > +#include <linux/log2.h>
> >  #include <linux/memblock.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/random.h>
> > @@ -82,6 +84,10 @@ static const struct kernel_param_ops sample_interval=
_param_ops =3D {
> >  };
> >  module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_s=
ample_interval, 0600);
> >
> > +/* Pool usage% threshold when currently covered allocations are skippe=
d. */
> > +static unsigned long kfence_skip_covered_thresh __read_mostly =3D 75;
> > +module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ul=
ong, 0644);
> > +
> >  /* The pool of pages used for guard pages and objects. */
> >  char *__kfence_pool __ro_after_init;
> >  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
> > @@ -105,6 +111,25 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
> >  /* Gates the allocation, ensuring only one succeeds in a given period.=
 */
> >  atomic_t kfence_allocation_gate =3D ATOMIC_INIT(1);
> >
> > +/*
> > + * A Counting Bloom filter of allocation coverage: limits currently co=
vered
> > + * allocations of the same source filling up the pool.
> > + *
> > + * Assuming a range of 15%-85% unique allocations in the pool at any p=
oint in

Where do these 85% come from?

> > + * time, the below parameters provide a probablity of 0.02-0.33 for fa=
lse
> > + * positive hits respectively:
> > + *
> > + *     P(alloc_traces) =3D (1 - e^(-HNUM * (alloc_traces / SIZE)) ^ HN=
UM
> > + */
> > +#define ALLOC_COVERED_HNUM     2
> > +#define ALLOC_COVERED_SIZE     (1 << (const_ilog2(CONFIG_KFENCE_NUM_OB=
JECTS) + 2))
> > +#define ALLOC_COVERED_HNEXT(h) (1664525 * (h) + 1013904223)

Unless we are planning to change these primes, can you use
next_pseudo_random32() instead?


> > +#define ALLOC_COVERED_MASK     (ALLOC_COVERED_SIZE - 1)
> > +static atomic_t alloc_covered[ALLOC_COVERED_SIZE];
> > +
> > +/* Stack depth used to determine uniqueness of an allocation. */
> > +#define UNIQUE_ALLOC_STACK_DEPTH 8UL
> > +
> >  /* Statistics counters for debugfs. */
> >  enum kfence_counter_id {
> >         KFENCE_COUNTER_ALLOCATED,
> > @@ -114,6 +139,7 @@ enum kfence_counter_id {
> >         KFENCE_COUNTER_BUGS,
> >         KFENCE_COUNTER_SKIP_INCOMPAT,
> >         KFENCE_COUNTER_SKIP_CAPACITY,
> > +       KFENCE_COUNTER_SKIP_COVERED,
> >         KFENCE_COUNTER_COUNT,
> >  };
> >  static atomic_long_t counters[KFENCE_COUNTER_COUNT];
> > @@ -125,11 +151,60 @@ static const char *const counter_names[] =3D {
> >         [KFENCE_COUNTER_BUGS]           =3D "total bugs",
> >         [KFENCE_COUNTER_SKIP_INCOMPAT]  =3D "skipped allocations (incom=
patible)",
> >         [KFENCE_COUNTER_SKIP_CAPACITY]  =3D "skipped allocations (capac=
ity)",
> > +       [KFENCE_COUNTER_SKIP_COVERED]   =3D "skipped allocations (cover=
ed)",
> >  };
> >  static_assert(ARRAY_SIZE(counter_names) =3D=3D KFENCE_COUNTER_COUNT);
> >
> >  /* =3D=3D=3D Internals =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >
> > +static inline bool should_skip_covered(void)
> > +{
> > +       unsigned long thresh =3D (CONFIG_KFENCE_NUM_OBJECTS * kfence_sk=
ip_covered_thresh) / 100;
> > +
> > +       return atomic_long_read(&counters[KFENCE_COUNTER_ALLOCATED]) > =
thresh;
> > +}
> > +
> > +static u32 get_alloc_stack_hash(unsigned long *stack_entries, size_t n=
um_entries)
> > +{
> > +       /* Some randomness across reboots / different machines. */
> > +       u32 seed =3D (u32)((unsigned long)__kfence_pool >> (BITS_PER_LO=
NG - 32));
> > +
> > +       num_entries =3D min(num_entries, UNIQUE_ALLOC_STACK_DEPTH);
> > +       num_entries =3D filter_irq_stacks(stack_entries, num_entries);
> > +       return jhash(stack_entries, num_entries * sizeof(stack_entries[=
0]), seed);
> > +}
> > +
> > +/*
> > + * Adds (or subtracts) count @val for allocation stack trace hash
> > + * @alloc_stack_hash from Counting Bloom filter.
> > + */
> > +static void alloc_covered_add(u32 alloc_stack_hash, int val)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ALLOC_COVERED_HNUM; i++) {
> > +               atomic_add(val, &alloc_covered[alloc_stack_hash & ALLOC=
_COVERED_MASK]);
> > +               alloc_stack_hash =3D ALLOC_COVERED_HNEXT(alloc_stack_ha=
sh);
> > +       }
> > +}
> > +
> > +/*
> > + * Returns true if the allocation stack trace hash @alloc_stack_hash i=
s
> > + * currently contained (non-zero count) in Counting Bloom filter.
> > + */
> > +static bool alloc_covered_contains(u32 alloc_stack_hash)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ALLOC_COVERED_HNUM; i++) {
> > +               if (!atomic_read(&alloc_covered[alloc_stack_hash & ALLO=
C_COVERED_MASK]))
> > +                       return false;
> > +               alloc_stack_hash =3D ALLOC_COVERED_HNEXT(alloc_stack_ha=
sh);
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  static bool kfence_protect(unsigned long addr)
> >  {
> >         return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PA=
GE_SIZE), true));
> > @@ -269,7 +344,8 @@ static __always_inline void for_each_canary(const s=
truct kfence_metadata *meta,
> >  }
> >
> >  static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t siz=
e, gfp_t gfp,
> > -                                 unsigned long *stack_entries, size_t =
num_stack_entries)
> > +                                 unsigned long *stack_entries, size_t =
num_stack_entries,
> > +                                 u32 alloc_stack_hash)
> >  {
> >         struct kfence_metadata *meta =3D NULL;
> >         unsigned long flags;
> > @@ -332,6 +408,8 @@ static void *kfence_guarded_alloc(struct kmem_cache=
 *cache, size_t size, gfp_t g
> >         /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
> >         WRITE_ONCE(meta->cache, cache);
> >         meta->size =3D size;
> > +       meta->alloc_stack_hash =3D alloc_stack_hash;
> > +
> >         for_each_canary(meta, set_canary_byte);
> >
> >         /* Set required struct page fields. */
> > @@ -344,6 +422,8 @@ static void *kfence_guarded_alloc(struct kmem_cache=
 *cache, size_t size, gfp_t g
> >
> >         raw_spin_unlock_irqrestore(&meta->lock, flags);
> >
> > +       alloc_covered_add(alloc_stack_hash, 1);
> > +
> >         /* Memory initialization. */
> >
> >         /*
> > @@ -412,6 +492,8 @@ static void kfence_guarded_free(void *addr, struct =
kfence_metadata *meta, bool z
> >
> >         raw_spin_unlock_irqrestore(&meta->lock, flags);
> >
> > +       alloc_covered_add(meta->alloc_stack_hash, -1);
> > +
> >         /* Protect to detect use-after-frees. */
> >         kfence_protect((unsigned long)addr);
> >
> > @@ -752,6 +834,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t s=
ize, gfp_t flags)
> >  {
> >         unsigned long stack_entries[KFENCE_STACK_DEPTH];
> >         size_t num_stack_entries;
> > +       u32 alloc_stack_hash;
> >
> >         /*
> >          * Perform size check before switching kfence_allocation_gate, =
so that
> > @@ -799,7 +882,23 @@ void *__kfence_alloc(struct kmem_cache *s, size_t =
size, gfp_t flags)
> >
> >         num_stack_entries =3D stack_trace_save(stack_entries, KFENCE_ST=
ACK_DEPTH, 0);
> >
> > -       return kfence_guarded_alloc(s, size, flags, stack_entries, num_=
stack_entries);
> > +       /*
> > +        * Do expensive check for coverage of allocation in slow-path a=
fter
> > +        * allocation_gate has already become non-zero, even though it =
might
> > +        * mean not making any allocation within a given sample interva=
l.
> > +        *
> > +        * This ensures reasonable allocation coverage when the pool is=
 almost
> > +        * full, including avoiding long-lived allocations of the same =
source
> > +        * filling up the pool (e.g. pagecache allocations).
> > +        */
> > +       alloc_stack_hash =3D get_alloc_stack_hash(stack_entries, num_st=
ack_entries);
> > +       if (should_skip_covered() && alloc_covered_contains(alloc_stack=
_hash)) {
> > +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_COVERED])=
;
> > +               return NULL;
> > +       }
> > +
> > +       return kfence_guarded_alloc(s, size, flags, stack_entries, num_=
stack_entries,
> > +                                   alloc_stack_hash);
> >  }
> >
> >  size_t kfence_ksize(const void *addr)
> > diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> > index c1f23c61e5f9..2a2d5de9d379 100644
> > --- a/mm/kfence/kfence.h
> > +++ b/mm/kfence/kfence.h
> > @@ -87,6 +87,8 @@ struct kfence_metadata {
> >         /* Allocation and free stack information. */
> >         struct kfence_track alloc_track;
> >         struct kfence_track free_track;
> > +       /* For updating alloc_covered on frees. */
> > +       u32 alloc_stack_hash;
> >  };
> >
> >  extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECT=
S];
> > --
> > 2.33.0.464.g1972c5931b-goog
> >



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
