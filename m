Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A0415CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbhIWLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbhIWLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:17:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B02C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:16:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c7so20926563qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WxWyZjqzKABxFGtDm2TtL1V2QPdgvK9G3mFsSj6IZsc=;
        b=piWpDsjgwmWQA7xP9ZDB/Ul8WwCD5xFDxPy//6xIQXw7lceBSflH3FaboHK2447F25
         NUKJq+YksT+uzaJp+nxMyG0edltdwjR+nSzPj+G9hEXnvcoYWaxeRP+jcCJz6S096xx8
         uAH1uinFxJ21t7EljSUxRYVq0G22dTH/RMDTJf7Ml69H+B/Ryge+wk+0FbKdCMSTCNSp
         u5P8ykRg6BfjLlNnSRwgu1CKx2KdkGbuKP2Mf6WFtokWG5Aav7zNBoQ8RE4Xh24GFeZf
         vN6GGxaq6MAcgOE+SNM56oRm+Tx5iKDUm4Qhvb7MZLtDUnWaFi3Bet38/GGXdIk+zYB4
         NwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WxWyZjqzKABxFGtDm2TtL1V2QPdgvK9G3mFsSj6IZsc=;
        b=fCl4EP+aea8udCfZMlRzpBYeNqTuwVo70rvWcP/mGsPZUXMUP7hZJSa70J39ZGgMdK
         KOyWvROT8lwA94OH/Y7+k8nHvHtYLhEMvkyQqDfB7dAU2tqOE7cL6ceF2WBIuv/pGZ8B
         jHvyUQHx6qZDscNbZjsLFA2xpvg8Z0xFiQb10l2ECch7OMyUT/30TXyFvxD0+0hV6CiN
         ffeGSVtxPe3Bgc+Sm941lI7BZHZWJHy1g1samh43X7ULF5nQ+7W633FFZ9mXNxnfMd8T
         1+vaNSml8tcOb6BhK6C6TeXo9n/GUu8WSXZe140jK4rkk7Ekup/06Nes4Zwq2ScmkQR9
         XzlQ==
X-Gm-Message-State: AOAM530vIdJqNlfQHz2kFLcKBdVN1ADRzHSoDlIpSCsQ+ampvok+Wmfa
        2sjvizGBb9pQV7wNL/YxTTq5CsMngMs1B77whlsgmA==
X-Google-Smtp-Source: ABdhPJxhcITZ6PzQs9ROBzrhdAxLv7+4se6IcOOumHFfX27SM6St8HdLOtKgwJByCS5yM/LEWYQpdkgB87oZpvCW9So=
X-Received: by 2002:a37:b483:: with SMTP id d125mr4023411qkf.362.1632395759497;
 Thu, 23 Sep 2021 04:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-2-elver@google.com>
In-Reply-To: <20210923104803.2620285-2-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 13:15:23 +0200
Message-ID: <CAG_fn=Wyd3-yxd3vzX82Q4iTApJr_CsG-gmEq1KenmYYCypP5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kfence: count unexpectedly skipped allocations
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Sep 23, 2021 at 12:48 PM Marco Elver <elver@google.com> wrote:
>
> Maintain a counter to count allocations that are skipped due to being
> incompatible (oversized, incompatible gfp flags) or no capacity.
>
> This is to compute the fraction of allocations that could not be
> serviced by KFENCE, which we expect to be rare.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

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
> @@ -121,6 +123,8 @@ static const char *const counter_names[] =3D {
>         [KFENCE_COUNTER_FREES]          =3D "total frees",
>         [KFENCE_COUNTER_ZOMBIES]        =3D "zombie allocations",
>         [KFENCE_COUNTER_BUGS]           =3D "total bugs",
> +       [KFENCE_COUNTER_SKIP_INCOMPAT]  =3D "skipped allocations (incompa=
tible)",
> +       [KFENCE_COUNTER_SKIP_CAPACITY]  =3D "skipped allocations (capacit=
y)",
>  };
>  static_assert(ARRAY_SIZE(counter_names) =3D=3D KFENCE_COUNTER_COUNT);
>
> @@ -271,8 +275,10 @@ static void *kfence_guarded_alloc(struct kmem_cache =
*cache, size_t size, gfp_t g
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
> @@ -740,8 +746,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t si=
ze, gfp_t flags)
>          * Perform size check before switching kfence_allocation_gate, so=
 that
>          * we don't disable KFENCE without making an allocation.
>          */
> -       if (size > PAGE_SIZE)
> +       if (size > PAGE_SIZE) {
> +               atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
>                 return NULL;
> +       }
>
>         /*
>          * Skip allocations from non-default zones, including DMA. We can=
not
> @@ -749,8 +757,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t si=
ze, gfp_t flags)
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
>          * allocation_gate only needs to become non-zero, so it doesn't m=
ake
> --
> 2.33.0.464.g1972c5931b-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
