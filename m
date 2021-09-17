Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2840FB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbhIQPGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbhIQPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:06:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356FCC061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:04:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso13191935otr.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUsl9Gygs4sNh6RuSqwsUb3ZhWZQ6AtKMQEzioy+07E=;
        b=gJ7zRq/beK3KLLhoNWydhTAeK+mBDZ40FInTX7YNQmzQLIKpS4jag3VW0SE4rCoiV0
         cJihUkiZr2TCWo+uhyzHF+Hl2rG2U/rieNNI0oJjxDMthbSQEOztqvIKeMxh/3Cc7xIp
         GnYPDaqmKNWF2LjY42wil7SqBRRogMKAoLPoTmLh1kShTiWqj8yoNTWMOPieXUR7GJn2
         7mJE/hM4TEJmsOC8OqBmtcWWhQtntfUWwAFQx7VDMPcyxJR8BDWVSLCkqdmw+QlsZZL+
         i44prxdKbCLtOv9D9klnIDcIsFIHNNWoYAy7N+LP+X5jpy+GrANvJjM68hn6OcrSWL/Q
         Nt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUsl9Gygs4sNh6RuSqwsUb3ZhWZQ6AtKMQEzioy+07E=;
        b=N0OTBqeR5RE9tpxOBY+HbDK9QIZXZqKgmILxBvcVC06/rCEFyUIwnpdyacwIShmjD+
         f48tfzpyfK0wH4g5rKYCWz6M623mmHD1eB4fbUhIWGMsj4aF7w1nzmlsH5UqOgZgTGQM
         UPl248FIYd2MURb8sMMdzNryocN+MMhJGixlaaWn09h8dNs9mrntVPfNkfhEkUCdjrEO
         lGfFhWYl7G/5AkSsrI2bREZJ/sQytpoZ1sdukLzvr3/J/b3E0Ax5WvzoByEQe43tI5y5
         c8fKSPZD845PXSuGpR+0SGQJU87InzKRAU9hG22zHLIRFX4qXQKd7dGys9BWIGGClyQ4
         jwzg==
X-Gm-Message-State: AOAM531Od/Ur8CeZmML5hTkvJFrgMvFE64QaaMWUJXIe0Vf9YjYHSGUD
        VaxjcZzN6feU7cQSFg3c4/ruT4RfWQDZMkYvaczOKCoUJS9pQQ==
X-Google-Smtp-Source: ABdhPJx/Uw2GCF3e7xNx6fMMkErYruZFfj8yT4AHxA5luVnO6RHQ7gAmdekrfJmS5Hygdf8YVPKDUXypY1UUpsJuQ1w=
X-Received: by 2002:a9d:135:: with SMTP id 50mr1442954otu.295.1631891078270;
 Fri, 17 Sep 2021 08:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210917110756.1121272-1-elver@google.com> <20210917110756.1121272-2-elver@google.com>
 <CACT4Y+aqfQNv5kjT0uCdgmw9MDYzZGFTXk9XdZ==pZLxRxfG1A@mail.gmail.com>
In-Reply-To: <CACT4Y+aqfQNv5kjT0uCdgmw9MDYzZGFTXk9XdZ==pZLxRxfG1A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Sep 2021 17:04:26 +0200
Message-ID: <CANpmjNNJv4wt0AhnKP4fuLkeMJdPAKB0GVWDj1VvoC3kZ8bGRw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kfence: limit currently covered allocations when pool
 nearly full
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 15:52, Dmitry Vyukov <dvyukov@google.com> wrote:
[...]
> > +/*
> > + * A lossy hash map of allocation stack trace coverage: limits currently covered
> > + * allocations of the same source filling up the pool when close to full.
> > + *
> > + * The required data fits in 64 bits, and therefore we can avoid a per-entry (or
> > + * global) lock by simply storing each entry's data in an atomic64_t.
> > + */
> > +union alloc_covered_entry {
> > +       struct {
> > +               u32 alloc_stack_hash;   /* stack trace hash */
> > +               u32 covered;            /* current coverage count */
> > +       };
> > +       u64 entry;
> > +};
> > +#define ALLOC_COVERED_SIZE (1 << const_ilog2(CONFIG_KFENCE_NUM_OBJECTS | 128)) /* >= 128 */
>
> const_ilog2 rounds down, so for 1023 objects we will have hashtable of
> size 512, or am I missing something? This asking for collisions.
> Hashtable size should be larger than expected population.

That's correct. I wanted to err on the side of allocating more and not
less, if we can afford it. Hence also the choice of lossy hash map.
However, I think if we consider the whole fleet, your proposal below
makes sense and I'll rerun experiments with that and see.

> > +#define ALLOC_COVERED_MASK (ALLOC_COVERED_SIZE - 1)
> > +static atomic64_t alloc_covered[ALLOC_COVERED_SIZE];
> > +/* Stack depth used to determine uniqueness of an allocation. */
> > +#define UNIQUE_ALLOC_STACK_DEPTH 8
> > +/* Pool usage threshold when currently covered allocations are skipped. */
> > +#define SKIP_COVERED_THRESHOLD ((CONFIG_KFENCE_NUM_OBJECTS * 3) / 4) /* 75% */
> > +
> >  /*
> >   * Per-object metadata, with one-to-one mapping of object metadata to
> >   * backing pages (in __kfence_pool).
> > @@ -114,6 +138,7 @@ enum kfence_counter_id {
> >         KFENCE_COUNTER_BUGS,
> >         KFENCE_COUNTER_SKIP_INCOMPAT,
> >         KFENCE_COUNTER_SKIP_CAPACITY,
> > +       KFENCE_COUNTER_SKIP_COVERED,
> >         KFENCE_COUNTER_COUNT,
> >  };
> >  static atomic_long_t counters[KFENCE_COUNTER_COUNT];
> > @@ -125,11 +150,73 @@ static const char *const counter_names[] = {
> >         [KFENCE_COUNTER_BUGS]           = "total bugs",
> >         [KFENCE_COUNTER_SKIP_INCOMPAT]  = "skipped allocations (incompatible)",
> >         [KFENCE_COUNTER_SKIP_CAPACITY]  = "skipped allocations (capacity)",
> > +       [KFENCE_COUNTER_SKIP_COVERED]   = "skipped allocations (covered)",
> >  };
> >  static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
> >
> >  /* === Internals ============================================================ */
> >
> > +static u32 get_alloc_stack_hash(void)
> > +{
> > +       unsigned long stack_entries[UNIQUE_ALLOC_STACK_DEPTH];
> > +       size_t num_entries;
> > +
> > +       num_entries = stack_trace_save(stack_entries, UNIQUE_ALLOC_STACK_DEPTH, 1);
>
> Strictly speaking, if a bad persistent allocation comes from an
> interrupt it may still consume whole pool. We've hit this problem with
> KASAN stackdepot unbounded growth. It's better to do
> filter_irq_stacks() here, see:
> https://elixir.bootlin.com/linux/v5.15-rc1/source/mm/kasan/common.c#L39

Time to move filter_irq_stacks() out of stackdepot, we should not
depend on stackdepot just for filter_irq_stacks(). I'll probably move
it to kernel/stacktrace.c, which seems most appropriate.

> > +       return jhash(stack_entries, num_entries * sizeof(stack_entries[0]), 0);
> > +}
> > +
> > +/*
> > + * Check if the allocation stack trace hash @alloc_stack_hash is contained in
> > + * @alloc_covered and currently covered.
> > + */
> > +static bool alloc_covered_contains(u32 alloc_stack_hash)
> > +{
> > +       union alloc_covered_entry entry;
> > +
> > +       if (!alloc_stack_hash)
> > +               return false;
> > +
> > +       entry.entry = (u64)atomic64_read(&alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK]);
> > +       return entry.alloc_stack_hash == alloc_stack_hash && entry.covered;
> > +}
> > +
> > +/*
> > + * Adds (or subtracts) coverage count to entry corresponding to
> > + * @alloc_stack_hash. If @alloc_stack_hash is not yet contained in
> > + * @alloc_covered, resets (potentially evicting existing) entry.
> > + */
> > +static void alloc_covered_add(u32 alloc_stack_hash, int val)
> > +{
> > +       union alloc_covered_entry old;
> > +       union alloc_covered_entry new;
> > +       atomic64_t *bucket;
> > +
> > +       if (!alloc_stack_hash)
> > +               return;
> > +
> > +       bucket = &alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK];
> > +       old.entry = (u64)atomic64_read(bucket);
> > +       new.alloc_stack_hash = alloc_stack_hash;
> > +       do {
> > +               if (val > 0) {
> > +                       new.covered = old.alloc_stack_hash == alloc_stack_hash
> > +                                       ? old.covered + val     /* increment */
> > +                                       : val;                  /* evict/reset */
>
> I am trying to understand the effects of this eviction policy on the result.
> It seems that it can render the pool overflow protection void.
> Consider, two stacks (ABC, DEF) hash to the same bucket. One
> allocation is frequent and not persistent, another is less frequent
> but almost persistent. The first one will evict the second one, so we
> will always save the second effectively defeating the overflow
> protection.
>
> There are also some interesting effects due to cyclic evictions
> (A->B->A), where we do not count increment, but count decrement.
>
> Have you considered not evicting, but rather simply combining
> allocations with the same hash?

Hmm, good point. It's probably not as bad as a real bloom filter,
because we might successfully remove an entry if all the allocations
that mapped to 1 bucket are freed.

> I.e. doing alloc_covered[hash]++/--.
> It would err on the side of not sampling allocations that are unlucky
> to collide with persistent allocations, but would provide more
> reliable overflow guarantees (at least we continue sampling
> allocations for all other buckets since we have pool capacity).
> FWIW also simpler code.
>
> I am also thinking if collisions can be resolved by adding some salt
> that is generated on boot. Resolving collisions across different
> machines is good enough for KFENCE. Namely, if we have stacks ABC and
> DEF, we hash XABC and XDEF, where X is filled on boot. It should work
> for a good hash function, right? If this works, then the simpler
> alloc_covered[hash]++/-- scheme should work (?).

Good idea, I think I'll introduce a seed for the hash function.

Let me experiment with the simplified version you suggest, and see what I get.

> > +               } else if (old.alloc_stack_hash == alloc_stack_hash && old.covered) {
> > +                       new.covered = old.covered + val;
> > +               } else {
> > +                       /*
> > +                        * Hash mismatch or covered has become zero. The latter
> > +                        * is possible if we race with:
> > +                        *      reset (!= alloc_stack_hash)
> > +                        *       -> reset (== alloc_stack_hash)
> > +                        *        -> decrement
> > +                        */
> > +                       break;
> > +               }
> > +       } while (!atomic64_try_cmpxchg_relaxed(bucket, (s64 *)&old.entry, (s64)new.entry));
> > +}
> > +
> >  static bool kfence_protect(unsigned long addr)
> >  {
> >         return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true));
> > @@ -261,7 +348,8 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
> >         }
> >  }
> >
> > -static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> > +static void *
> > +kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp, u32 alloc_stack_hash)
> >  {
> >         struct kfence_metadata *meta = NULL;
> >         unsigned long flags;
> > @@ -322,6 +410,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >         /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
> >         WRITE_ONCE(meta->cache, cache);
> >         meta->size = size;
> > +       meta->alloc_stack_hash = alloc_stack_hash;
> > +
> >         for_each_canary(meta, set_canary_byte);
> >
> >         /* Set required struct page fields. */
> > @@ -334,6 +424,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >
> >         raw_spin_unlock_irqrestore(&meta->lock, flags);
> >
> > +       alloc_covered_add(alloc_stack_hash, 1);
> > +
> >         /* Memory initialization. */
> >
> >         /*
> > @@ -362,6 +454,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >  static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
> >  {
> >         struct kcsan_scoped_access assert_page_exclusive;
> > +       u32 alloc_stack_hash;
> >         unsigned long flags;
> >
> >         raw_spin_lock_irqsave(&meta->lock, flags);
> > @@ -404,8 +497,13 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
> >         /* Mark the object as freed. */
> >         metadata_update_state(meta, KFENCE_OBJECT_FREED);
> >
> > +       alloc_stack_hash = meta->alloc_stack_hash;
> > +       meta->alloc_stack_hash = 0;
> > +
> >         raw_spin_unlock_irqrestore(&meta->lock, flags);
> >
> > +       alloc_covered_add(alloc_stack_hash, -1);
> > +
> >         /* Protect to detect use-after-frees. */
> >         kfence_protect((unsigned long)addr);
> >
> > @@ -744,6 +842,8 @@ void kfence_shutdown_cache(struct kmem_cache *s)
> >
> >  void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >  {
> > +       u32 alloc_stack_hash;
> > +
> >         /*
> >          * Perform size check before switching kfence_allocation_gate, so that
> >          * we don't disable KFENCE without making an allocation.
> > @@ -788,7 +888,23 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >         if (!READ_ONCE(kfence_enabled))
> >                 return NULL;
> >
> > -       return kfence_guarded_alloc(s, size, flags);
> > +       /*
> > +        * Do expensive check for coverage of allocation in slow-path after
> > +        * allocation_gate has already become non-zero, even though it might
> > +        * mean not making any allocation within a given sample interval.
> > +        *
> > +        * This ensures reasonable allocation coverage when the pool is almost
> > +        * full, including avoiding long-lived allocations of the same source
> > +        * filling up the pool (e.g. pagecache allocations).
> > +        */
> > +       alloc_stack_hash = get_alloc_stack_hash();
>
> Is it possible to unwind the stack only once per allocation? I.e.
> unwind here into a buffer on stack and then pass it down?

I'll investigate how bad it looks if we do that.
