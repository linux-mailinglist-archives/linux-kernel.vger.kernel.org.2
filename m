Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A76413242
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhIULGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhIULGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:06:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:05:15 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s69so21617076oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siq9DNizf2XNhKgFT5Nc6HavLskG3clXTf/qLqUtPik=;
        b=E/Dz5Uem/y3Kd7IFC1ttc1B8ZhayLMSpND3mSr7CA0oZ51eEyjc9IV9VenlOv3odG1
         XpDfzdjWPy8JoZeI2uzfF1y6Im1cXu7fO6P4u2kbsuXCWOKf5uroW7jkySeQREBQlUHd
         jEvJREyAl0PYl/5CEzwb1RZFjxTId+iwyw0C6GBKa5QE72ldDvK3FVnOSSsDT9Oil35v
         mqRcsarEkgSIZmLUXSLG/TgQ/eCsc+bdpSg/lp7eRHXX0Su6tX6nXmMsaRo0KtR6A4B/
         g2MFj3qj8eUIJHJb2h/B8b2d0XSMs77OgS7BcHcxjKwLUh1tibAyYoMQMH5B2t1g59fX
         72ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siq9DNizf2XNhKgFT5Nc6HavLskG3clXTf/qLqUtPik=;
        b=JaD3X7iJ4HZTLnjxxMBUtPQuoCGs0oEWoTRntci14iV4OpNPP2wHO4Osg0yaCTYBh9
         zhQlCxf/0p0wIE01WE1U307k4/ndd2ssFTYX3VBvdzAMA4izP3i4D0AKbhHPT4un4bL6
         EIuEYZYFjLOR71MPMxP/nFfKZuipjajjeGQ20Uon9DCgl9YUCvvHggRspKpHLwZxEy1N
         1fFO3qIF5okqpWjmzGrfAf2fIZApPQY8rcWXUjWHKxsc1+tolfVspHqJ5wwRLXJ8xojl
         4tia/yO1W7TDM/ksuePeFXkAj9YpD+8nn8DSLDT9wg10PdhvQjV3xW1LDltOmQaHpZpR
         lCYw==
X-Gm-Message-State: AOAM5310cow0XiMkEGjuqNcI/lmTg/WTZs3orHsAHe4LNgMcVNt9OGWP
        VKSO7aLgysrpiQYgAyifaSX32skSRW79vUTJpyfP2g==
X-Google-Smtp-Source: ABdhPJxHG/9SD+46VSnNM10Txg+CAxEiNqmBb4Y8pBzRiqKkJAp/gDI+Dpt8svJhBKdScdtrTJ/9M6uWanTZw581bKI=
X-Received: by 2002:aca:3083:: with SMTP id w125mr3073078oiw.109.1632222314447;
 Tue, 21 Sep 2021 04:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com> <20210921101014.1938382-4-elver@google.com>
In-Reply-To: <20210921101014.1938382-4-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 13:05:03 +0200
Message-ID: <CACT4Y+Z6Rss3+oiN5bcKHYeQgG=nZ9VDqwrhOS4VUZ=_a5NoBw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kfence: limit currently covered allocations when
 pool nearly full
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 12:10, 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> One of KFENCE's main design principles is that with increasing uptime,
> allocation coverage increases sufficiently to detect previously
> undetected bugs.
>
> We have observed that frequent long-lived allocations of the same
> source (e.g. pagecache) tend to permanently fill up the KFENCE pool
> with increasing system uptime, thus breaking the above requirement.
> The workaround thus far had been increasing the sample interval and/or
> increasing the KFENCE pool size, but is no reliable solution.
>
> To ensure diverse coverage of allocations, limit currently covered
> allocations of the same source once pool utilization reaches 75%
> (configurable via `kfence.skip_covered_thresh`) or above. The effect is
> retaining reasonable allocation coverage when the pool is close to full.
>
> A side-effect is that this also limits frequent long-lived allocations
> of the same source filling up the pool permanently.
>
> Uniqueness of an allocation for coverage purposes is based on its
> (partial) allocation stack trace (the source). A Counting Bloom filter
> is used to check if an allocation is covered; if the allocation is
> currently covered, the allocation is skipped by KFENCE.
>
> Testing was done using:
>
>         (a) a synthetic workload that performs frequent long-lived
>             allocations (default config values; sample_interval=1;
>             num_objects=63), and
>
>         (b) normal desktop workloads on an otherwise idle machine where
>             the problem was first reported after a few days of uptime
>             (default config values).
>
> In both test cases the sampled allocation rate no longer drops to zero
> at any point. In the case of (b) we observe (after 2 days uptime) 15%
> unique allocations in the pool, 77% pool utilization, with 20% "skipped
> allocations (covered)".
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Switch to counting bloom filter to guarantee currently covered
>   allocations being skipped.
> * Use a module param for skip_covered threshold.
> * Use kfence pool address as hash entropy.
> * Use filter_irq_stacks().
> ---
>  mm/kfence/core.c   | 113 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/kfence/kfence.h |   2 +
>  2 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index db01814f8ff0..9b3fb30f24c3 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -11,11 +11,13 @@
>  #include <linux/bug.h>
>  #include <linux/debugfs.h>
>  #include <linux/irq_work.h>
> +#include <linux/jhash.h>
>  #include <linux/kcsan-checks.h>
>  #include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
> +#include <linux/log2.h>
>  #include <linux/memblock.h>
>  #include <linux/moduleparam.h>
>  #include <linux/random.h>
> @@ -82,6 +84,10 @@ static const struct kernel_param_ops sample_interval_param_ops = {
>  };
>  module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_interval, 0600);
>
> +/* Pool usage% threshold when currently covered allocations are skipped. */
> +static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
> +module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
> +
>  /* The pool of pages used for guard pages and objects. */
>  char *__kfence_pool __ro_after_init;
>  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
> @@ -105,6 +111,25 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
>  /* Gates the allocation, ensuring only one succeeds in a given period. */
>  atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
>
> +/*
> + * A Counting Bloom filter of allocation coverage: limits currently covered
> + * allocations of the same source filling up the pool.
> + *
> + * Assuming a range of 15%-85% unique allocations in the pool at any point in
> + * time, the below parameters provide a probablity of 0.02-0.33 for false
> + * positive hits respectively:
> + *
> + *     P(alloc_traces) = (1 - e^(-HNUM * (alloc_traces / SIZE)) ^ HNUM
> + */
> +#define ALLOC_COVERED_HNUM     2
> +#define ALLOC_COVERED_SIZE     (1 << (const_ilog2(CONFIG_KFENCE_NUM_OBJECTS) + 2))
> +#define ALLOC_COVERED_HNEXT(h) (1664525 * (h) + 1013904223)
> +#define ALLOC_COVERED_MASK     (ALLOC_COVERED_SIZE - 1)
> +static atomic_t alloc_covered[ALLOC_COVERED_SIZE];
> +
> +/* Stack depth used to determine uniqueness of an allocation. */
> +#define UNIQUE_ALLOC_STACK_DEPTH 8UL
> +
>  /* Statistics counters for debugfs. */
>  enum kfence_counter_id {
>         KFENCE_COUNTER_ALLOCATED,
> @@ -114,6 +139,7 @@ enum kfence_counter_id {
>         KFENCE_COUNTER_BUGS,
>         KFENCE_COUNTER_SKIP_INCOMPAT,
>         KFENCE_COUNTER_SKIP_CAPACITY,
> +       KFENCE_COUNTER_SKIP_COVERED,
>         KFENCE_COUNTER_COUNT,
>  };
>  static atomic_long_t counters[KFENCE_COUNTER_COUNT];
> @@ -125,11 +151,66 @@ static const char *const counter_names[] = {
>         [KFENCE_COUNTER_BUGS]           = "total bugs",
>         [KFENCE_COUNTER_SKIP_INCOMPAT]  = "skipped allocations (incompatible)",
>         [KFENCE_COUNTER_SKIP_CAPACITY]  = "skipped allocations (capacity)",
> +       [KFENCE_COUNTER_SKIP_COVERED]   = "skipped allocations (covered)",
>  };
>  static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
>
>  /* === Internals ============================================================ */
>
> +static inline bool should_skip_covered(void)
> +{
> +       unsigned long thresh = (CONFIG_KFENCE_NUM_OBJECTS * kfence_skip_covered_thresh) / 100;
> +
> +       return atomic_long_read(&counters[KFENCE_COUNTER_ALLOCATED]) > thresh;
> +}
> +
> +static u32 get_alloc_stack_hash(unsigned long *stack_entries, size_t num_entries)
> +{
> +       /* Some randomness across reboots / different machines. */
> +       u32 seed = (u32)((unsigned long)__kfence_pool >> (BITS_PER_LONG - 32));
> +
> +       num_entries = min(num_entries, UNIQUE_ALLOC_STACK_DEPTH);
> +       num_entries = filter_irq_stacks(stack_entries, num_entries);
> +       return jhash(stack_entries, num_entries * sizeof(stack_entries[0]), seed);
> +}
> +
> +/*
> + * Adds (or subtracts) count @val for allocation stack trace hash
> + * @alloc_stack_hash from Counting Bloom filter.
> + */
> +static void alloc_covered_add(u32 alloc_stack_hash, int val)
> +{
> +       int i;
> +
> +       if (!alloc_stack_hash)
> +               return;

Nice!
I like the hash seed, non-evicting cache and that threshold become a
command line parameter.

This check is the only place I don't understand. What's special about
alloc_stack_hash == 0? I see that even double-free's won't call this
with 0.


> +       for (i = 0; i < ALLOC_COVERED_HNUM; i++) {
> +               atomic_add(val, &alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK]);
> +               alloc_stack_hash = ALLOC_COVERED_HNEXT(alloc_stack_hash);
> +       }
> +}
> +
> +/*
> + * Returns true if the allocation stack trace hash @alloc_stack_hash is
> + * currently contained (non-zero count) in Counting Bloom filter.
> + */
> +static bool alloc_covered_contains(u32 alloc_stack_hash)
> +{
> +       int i;
> +
> +       if (!alloc_stack_hash)
> +               return false;
> +
> +       for (i = 0; i < ALLOC_COVERED_HNUM; i++) {
> +               if (!atomic_read(&alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK]))
> +                       return false;
> +               alloc_stack_hash = ALLOC_COVERED_HNEXT(alloc_stack_hash);
> +       }
> +
> +       return true;
> +}
> +
>  static bool kfence_protect(unsigned long addr)
>  {
>         return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true));
> @@ -269,7 +350,8 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
>  }
>
>  static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp,
> -                                 unsigned long *stack_entries, size_t num_stack_entries)
> +                                 unsigned long *stack_entries, size_t num_stack_entries,
> +                                 u32 alloc_stack_hash)
>  {
>         struct kfence_metadata *meta = NULL;
>         unsigned long flags;
> @@ -332,6 +414,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
>         WRITE_ONCE(meta->cache, cache);
>         meta->size = size;
> +       meta->alloc_stack_hash = alloc_stack_hash;
> +
>         for_each_canary(meta, set_canary_byte);
>
>         /* Set required struct page fields. */
> @@ -344,6 +428,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>
>         raw_spin_unlock_irqrestore(&meta->lock, flags);
>
> +       alloc_covered_add(alloc_stack_hash, 1);
> +
>         /* Memory initialization. */
>
>         /*
> @@ -368,6 +454,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
>  {
>         struct kcsan_scoped_access assert_page_exclusive;
> +       u32 alloc_stack_hash;
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&meta->lock, flags);
> @@ -410,8 +497,13 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>         /* Mark the object as freed. */
>         metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
>
> +       alloc_stack_hash = meta->alloc_stack_hash;
> +       meta->alloc_stack_hash = 0;
> +
>         raw_spin_unlock_irqrestore(&meta->lock, flags);
>
> +       alloc_covered_add(alloc_stack_hash, -1);
> +
>         /* Protect to detect use-after-frees. */
>         kfence_protect((unsigned long)addr);
>
> @@ -752,6 +844,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  {
>         unsigned long stack_entries[KFENCE_STACK_DEPTH];
>         size_t num_stack_entries;
> +       u32 alloc_stack_hash;
>
>         /*
>          * Perform size check before switching kfence_allocation_gate, so that
> @@ -799,7 +892,23 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>
>         num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 0);
>
> -       return kfence_guarded_alloc(s, size, flags, stack_entries, num_stack_entries);
> +       /*
> +        * Do expensive check for coverage of allocation in slow-path after
> +        * allocation_gate has already become non-zero, even though it might
> +        * mean not making any allocation within a given sample interval.
> +        *
> +        * This ensures reasonable allocation coverage when the pool is almost
> +        * full, including avoiding long-lived allocations of the same source
> +        * filling up the pool (e.g. pagecache allocations).
> +        */
> +       alloc_stack_hash = get_alloc_stack_hash(stack_entries, num_stack_entries);
> +       if (should_skip_covered() && alloc_covered_contains(alloc_stack_hash)) {
> +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_COVERED]);
> +               return NULL;
> +       }
> +
> +       return kfence_guarded_alloc(s, size, flags, stack_entries, num_stack_entries,
> +                                   alloc_stack_hash);
>  }
>
>  size_t kfence_ksize(const void *addr)
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index c1f23c61e5f9..2a2d5de9d379 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -87,6 +87,8 @@ struct kfence_metadata {
>         /* Allocation and free stack information. */
>         struct kfence_track alloc_track;
>         struct kfence_track free_track;
> +       /* For updating alloc_covered on frees. */
> +       u32 alloc_stack_hash;
>  };
>
>  extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> --
> 2.33.0.464.g1972c5931b-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210921101014.1938382-4-elver%40google.com.
