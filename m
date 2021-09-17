Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7640F89C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhIQNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbhIQNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:00:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79652C0613DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:58:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n27so13920171oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0q9dMDiPL7l1Xvh/pCQyuBurf5KBV4txXHcebk3J7o=;
        b=ohm9YZmHRMwJytXYWGsib848qv2LuXyfVNj9Rfnwh4O/AnsOZuhEpoKTBsRnAOSe27
         rhuyFk06DuhpGHFvguVRPECEWimf0x1ipOriE1T6yIf+H2fOpigyuJFHWtQAapj06rFI
         vBRWqICiQ9/HifxhnF1CAKmJbTo0Y+DddrHt36tVt1LOlreMPPXM5vwVBki0BoLSNkVz
         GlxEWd04wa5ieQYw1IyJ0vUnYqcJNm8BZRF2PoPzeof0gkgJAd4qxR2Tp3mSc9IrHSvr
         tYe66phQ6IA/lCym2y8btng9z4KycuKjxq8CmIg66NOksUmP5Jherl+in69QTI1d5UXp
         YOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0q9dMDiPL7l1Xvh/pCQyuBurf5KBV4txXHcebk3J7o=;
        b=4OQYq+KKp8a+L4x/9uiOq4afBllMque2l2xQLJagJbZ3sA7lZ3PuFSk9M+ZNAkcNdc
         pw0rJ53vysS6LxmJTIH4+jodx2x0UMwUT35zH/QZKM6GEJrl5hiLqyhwwMXvYt1FRfZw
         DbcM6KXYxsqH5mwOb7iFtDCNVc0519CahpmUw8VTOUXlVwFCdNjboSbEpJ6/4TdL6bw0
         zyyqAKLwDc2RDAiGoS/V3SBsFgGqpjMYzU9TLe9V2s9nPS6PL/LTairydea4bKndONY7
         udI+5kqvxXAo9nezck3HRlK9QkXfVvTSyNpYWiehlLtBWbEAB3tRss/iUDuBCoGmVOFe
         P92g==
X-Gm-Message-State: AOAM530Wta8AUT1xVaFAz0rauPPEpGnMamf9nT8BQXguhqi9weL3RI2a
        9holzZMZB2C14cOIlWe4/6q8rTCfRFPsPu3CBk+D5g==
X-Google-Smtp-Source: ABdhPJx6EkYfCT+AGBJzBynZrLClpn/6DUBafoMvuALv1yPubMRpPuqh+A8pH396wzHAoSzKRM7gxkBmSHJRKElQk+s=
X-Received: by 2002:aca:1109:: with SMTP id 9mr3759856oir.109.1631883522559;
 Fri, 17 Sep 2021 05:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210917110756.1121272-1-elver@google.com>
In-Reply-To: <20210917110756.1121272-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 14:58:30 +0200
Message-ID: <CACT4Y+Zzxo19YH-tFOPHGJ25zP=pdjSSjzjQNZTG62bCjZgz3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kfence: count unexpectedly skipped allocations
To:     Marco Elver <elver@google.com>
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

On Fri, 17 Sept 2021 at 13:08, 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Maintain a counter to count allocations that are skipped due to being
> incompatible (oversized, incompatible gfp flags) or no capacity.
>
> This is to compute the fraction of allocations that could not be
> serviced by KFENCE, which we expect to be rare.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kfence/core.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 7a97db8bc8e7..2755800f3e2a 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -112,6 +112,8 @@ enum kfence_counter_id {
>         KFENCE_COUNTER_FREES,
>         KFENCE_COUNTER_ZOMBIES,
>         KFENCE_COUNTER_BUGS,
> +       KFENCE_COUNTER_SKIP_INCOMPAT,
> +       KFENCE_COUNTER_SKIP_CAPACITY,
>         KFENCE_COUNTER_COUNT,
>  };
>  static atomic_long_t counters[KFENCE_COUNTER_COUNT];
> @@ -121,6 +123,8 @@ static const char *const counter_names[] = {
>         [KFENCE_COUNTER_FREES]          = "total frees",
>         [KFENCE_COUNTER_ZOMBIES]        = "zombie allocations",
>         [KFENCE_COUNTER_BUGS]           = "total bugs",
> +       [KFENCE_COUNTER_SKIP_INCOMPAT]  = "skipped allocations (incompatible)",
> +       [KFENCE_COUNTER_SKIP_CAPACITY]  = "skipped allocations (capacity)",
>  };
>  static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
>
> @@ -272,7 +276,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         }
>         raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
>         if (!meta)
> -               return NULL;
> +               goto no_capacity;
>
>         if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
>                 /*
> @@ -289,7 +293,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>                 list_add_tail(&meta->list, &kfence_freelist);
>                 raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
>
> -               return NULL;
> +               goto no_capacity;

Do we expect this case to be so rare that we don't care?
Strictly speaking it's not no_capacity. So if I see large no_capacity
numbers, the first question I will have is: is it really no_capacity,
or some other case that we mixed together?



>         }
>
>         meta->addr = metadata_to_pageaddr(meta);
> @@ -349,6 +353,10 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCS]);
>
>         return addr;
> +
> +no_capacity:
> +       atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_CAPACITY]);
> +       return NULL;
>  }
>
>  static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
> @@ -740,8 +748,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>          * Perform size check before switching kfence_allocation_gate, so that
>          * we don't disable KFENCE without making an allocation.
>          */
> -       if (size > PAGE_SIZE)
> +       if (size > PAGE_SIZE) {
> +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
>                 return NULL;
> +       }
>
>         /*
>          * Skip allocations from non-default zones, including DMA. We cannot
> @@ -749,8 +759,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>          * properties (e.g. reside in DMAable memory).
>          */
>         if ((flags & GFP_ZONEMASK) ||
> -           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
> +           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32))) {
> +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
>                 return NULL;
> +       }
>
>         /*
>          * allocation_gate only needs to become non-zero, so it doesn't make
> --
> 2.33.0.464.g1972c5931b-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210917110756.1121272-1-elver%40google.com.
