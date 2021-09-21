Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0777B4131EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhIUKuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhIUKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:50:13 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78806C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:48:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w206so17444968oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQD0VoNg7df5hqKOKWbdHthbGkqzCUgLIjjPJbYxGXM=;
        b=nuqlgHgSMTyLv6y4qN8SY2nIPYd8eecIjOrHYK1ewfaO7W1MrHPEkP6cJLV60AAA5u
         QQ41nhZIf7zu2rg1UmSkqyJGAOUxxrZromPHfUU9B/8RAe51h2lw/ymbCUHm6HOE/sgC
         L1PXUnTaJo6qfL9sHX1yEkO/Ch8xcVMXJI2Pz9mEvVLBVa7q2kg1Jq8ManhkOheqMXg8
         6wj5H3B9uF52UM/sVrcR3ffqTc5Zk6tAGJW4sMfO46oBSzysTp4dyW7DfAvF3Xb+h4Nc
         4Ag3uC/baYuuuOIro+VOfgY9NqK+P+DZhT4CKimpvnQMmlluCrP6Nubn2NL2+RVm/lYW
         F7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQD0VoNg7df5hqKOKWbdHthbGkqzCUgLIjjPJbYxGXM=;
        b=OIQuNNxx3HVaU9hXWVSa1UMubaFXZSUVms2Kxr+KsjsbuqhtJuMS+3oZjE9/wyJB5Z
         xnKeJt+z6zHUbtCQeMMDYnOaABsDeYzN0mktqqYqhlfF5mtKc3ZG1C2rcDhLjBOyJ5XT
         ZmEwwWhUAdAxfLG0GXrGgsQwKCzLoawd9PCWsJJUyv5gsswHfTskxknjhTiInd5sdRa6
         5JPycTYQj0eRfIqQ6wv8eSBYt2kPxVwtb56pzqCMFr2vYcvadgyVqoeM+vkwjsqxmYPT
         56oUl8xKnjM5+ECMipQQj1piT5Dlf8RQbDfPjqpWEWkAfIOiiMpRGnZiGto2lGR+gdiv
         l+kw==
X-Gm-Message-State: AOAM531E/tDL9ErJF3P9DF8QkptmOd5hCUviBVDimV8etgrVUu2hwTDb
        bNRNfhR8ca1MOo5HVGegIk3HEkXNxSrb5uAel4ymVA==
X-Google-Smtp-Source: ABdhPJwg7XAXBq5dllDW/UAm8CdazqwHn56tKUi/wY3c0Ee1vloEjtXJVU8X3FAfRDN4PzqakoW+PrD8utwFQZpnIFk=
X-Received: by 2002:a54:4005:: with SMTP id x5mr3064072oie.160.1632221324643;
 Tue, 21 Sep 2021 03:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com> <20210921101014.1938382-2-elver@google.com>
In-Reply-To: <20210921101014.1938382-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 12:48:33 +0200
Message-ID: <CACT4Y+bJ=i=i5eecERcAWMcZuYtU1587WEpRa=SH+bGvmoCayA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kfence: count unexpectedly skipped allocations
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

On Tue, 21 Sept 2021 at 12:10, Marco Elver <elver@google.com> wrote:
>
> Maintain a counter to count allocations that are skipped due to being
> incompatible (oversized, incompatible gfp flags) or no capacity.
>
> This is to compute the fraction of allocations that could not be
> serviced by KFENCE, which we expect to be rare.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * Do not count deadlock-avoidance skips.
> ---
>  mm/kfence/core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 7a97db8bc8e7..249d75b7e5ee 100644
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
> @@ -271,8 +275,10 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>                 list_del_init(&meta->list);
>         }
>         raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> -       if (!meta)
> +       if (!meta) {
> +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_CAPACITY]);
>                 return NULL;
> +       }
>
>         if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
>                 /*
> @@ -740,8 +746,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
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
> @@ -749,8 +757,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
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
