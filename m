Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6B40F8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhIQNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhIQNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:10:07 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:08:45 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id u15-20020a4a970f000000b0029aed4b0e4eso1198195ooi.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQPtyu3eXHipP/z9ZsA4RP4v90HOcQfM654JXLLWBSI=;
        b=DgjGrVN0LY2hcHrUNSF7ZfTwhuuXo4rOZy+HYIQWCynjn9i+u9JzrolU8wCb20uE23
         fcq89ytCl5R3miUY04GGIgBJJYgL0zSaw0bbymjm/lbeykJcNdRItL0lUWHgiVDDwEtE
         cw/Z9uvlzUsXp9CSpp99FVmRHiFdr+nq/VgCw+9Da4gynMfrRr06gPEd2fyyHxdqFb2H
         NrWyszOdBCUDcN1AVCIiWGWSgjQ8yBv9UEJBeB/Wx0gcLKbJRT/vdMLmNwAvSYhet7Xm
         NitVbqpZ8CYQN1j3w1omrfCWwZKvNv89iM3+101ITtkKYcScVzdo/F+NrMQJb0p1JDNR
         G9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQPtyu3eXHipP/z9ZsA4RP4v90HOcQfM654JXLLWBSI=;
        b=dpDO9QkxJ6c4F3G48UuHoqQQbSNZ7FSmmBfKT49IHpVUee6FM+aArq4NBMHAAdtrCQ
         vxWkTouda7a8I5FM/GAwgKenVtslAv9t7xVwjHLZVV+U1ujRJm/4/F3CIPWKwfTALvXf
         sUSilXor9/DU6WrZu5VUKb1LI/B7ntZyrICah76bvzcCsBCCHDeF3cQIyQN8gJr6ZqRJ
         zrVwNPwEdFC+2IiK1PRnraeuxReM5E0tpkHq69oJDV12AZy6vnzVChvwjQY/OhiHe5td
         QoVtzyPBCd21JwDBZxzsMgTHJMeq/Dy+JsRH5NBNjg3b7GlHGmQD53uwLqtK+pvHSHY3
         5KIg==
X-Gm-Message-State: AOAM532r5akqFEewkcuQBropNIOoTbUKbLZZ08kVBJqTffKd46SG4e9+
        173ya/pqof8lZGqLV0AocP0EgjtCzxCE6fAyXsAVOw==
X-Google-Smtp-Source: ABdhPJxhZldjLi7OfHoZmx054VDDIW8lgj+X0CyxuBy9pta6eOV0YOjX/4zRCuCk5+pCGzMaA46meM9uXLEFAQW+diQ=
X-Received: by 2002:a4a:7648:: with SMTP id w8mr9019980ooe.0.1631884124392;
 Fri, 17 Sep 2021 06:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210917110756.1121272-1-elver@google.com> <CACT4Y+Zzxo19YH-tFOPHGJ25zP=pdjSSjzjQNZTG62bCjZgz3w@mail.gmail.com>
In-Reply-To: <CACT4Y+Zzxo19YH-tFOPHGJ25zP=pdjSSjzjQNZTG62bCjZgz3w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Sep 2021 15:08:32 +0200
Message-ID: <CANpmjNMWX1QYKHmK4opxPH92QhF+HL5E9=5b1Tx_9g0LStio-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] kfence: count unexpectedly skipped allocations
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

On Fri, 17 Sept 2021 at 14:58, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, 17 Sept 2021 at 13:08, 'Marco Elver' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Maintain a counter to count allocations that are skipped due to being
> > incompatible (oversized, incompatible gfp flags) or no capacity.
> >
> > This is to compute the fraction of allocations that could not be
> > serviced by KFENCE, which we expect to be rare.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  mm/kfence/core.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 7a97db8bc8e7..2755800f3e2a 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -112,6 +112,8 @@ enum kfence_counter_id {
> >         KFENCE_COUNTER_FREES,
> >         KFENCE_COUNTER_ZOMBIES,
> >         KFENCE_COUNTER_BUGS,
> > +       KFENCE_COUNTER_SKIP_INCOMPAT,
> > +       KFENCE_COUNTER_SKIP_CAPACITY,
> >         KFENCE_COUNTER_COUNT,
> >  };
> >  static atomic_long_t counters[KFENCE_COUNTER_COUNT];
> > @@ -121,6 +123,8 @@ static const char *const counter_names[] = {
> >         [KFENCE_COUNTER_FREES]          = "total frees",
> >         [KFENCE_COUNTER_ZOMBIES]        = "zombie allocations",
> >         [KFENCE_COUNTER_BUGS]           = "total bugs",
> > +       [KFENCE_COUNTER_SKIP_INCOMPAT]  = "skipped allocations (incompatible)",
> > +       [KFENCE_COUNTER_SKIP_CAPACITY]  = "skipped allocations (capacity)",
> >  };
> >  static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
> >
> > @@ -272,7 +276,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >         }
> >         raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> >         if (!meta)
> > -               return NULL;
> > +               goto no_capacity;
> >
> >         if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
> >                 /*
> > @@ -289,7 +293,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >                 list_add_tail(&meta->list, &kfence_freelist);
> >                 raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> >
> > -               return NULL;
> > +               goto no_capacity;
>
> Do we expect this case to be so rare that we don't care?
> Strictly speaking it's not no_capacity. So if I see large no_capacity
> numbers, the first question I will have is: is it really no_capacity,
> or some other case that we mixed together?

Hmm, true. I think we can just ignore counting this -- I'd expect some
bug-storm for this to become likely, at which point the system is in a
pretty bad state anyway (and we see bug counts increasing).

I'll remove this one.

>
>
> >         }
> >
> >         meta->addr = metadata_to_pageaddr(meta);
> > @@ -349,6 +353,10 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
> >         atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCS]);
> >
> >         return addr;
> > +
> > +no_capacity:
> > +       atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_CAPACITY]);
> > +       return NULL;
> >  }
> >
> >  static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
> > @@ -740,8 +748,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >          * Perform size check before switching kfence_allocation_gate, so that
> >          * we don't disable KFENCE without making an allocation.
> >          */
> > -       if (size > PAGE_SIZE)
> > +       if (size > PAGE_SIZE) {
> > +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
> >                 return NULL;
> > +       }
> >
> >         /*
> >          * Skip allocations from non-default zones, including DMA. We cannot
> > @@ -749,8 +759,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >          * properties (e.g. reside in DMAable memory).
> >          */
> >         if ((flags & GFP_ZONEMASK) ||
> > -           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
> > +           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32))) {
> > +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
> >                 return NULL;
> > +       }
> >
> >         /*
> >          * allocation_gate only needs to become non-zero, so it doesn't make
> > --
> > 2.33.0.464.g1972c5931b-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210917110756.1121272-1-elver%40google.com.
