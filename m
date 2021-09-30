Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BA41DDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbhI3PmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbhI3PmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:42:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64044C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:40:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p4so6223410qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rk528hO09V+xXN91B1hSKF0BEg5FNswtyGgnAwkONyI=;
        b=dESEuhyj1diuaN43mBYsQwKIqX9naWqnpqhhKA68G4OUlo0DTHbw8y2pY1FHxAFrzV
         nKSEL/1ki6qdHnNHPQNHYMzWLFD2L0w566kHcOkJmc4x+jGhRppQEqFU8y1gcn/S1WVS
         ecRwi6mmAz76ki1wey175nI40Fe6rqjoqPXb7XLIUTm5Ka8JHIav7eQ9Jp00o5DnN7Ix
         t/6BJKFAdciaAQ+LSO1dyfmJS2hysC5icO3MQg0XPd3tz+ab7gseuKOloQzRMiTrL/ml
         KQyFkfa0riIFzD58eRGM8c7k/GaNhhbqOEBANk9WCZ7n5/LdQmn2Ii7hmmm9Lu/Y6jnI
         arzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rk528hO09V+xXN91B1hSKF0BEg5FNswtyGgnAwkONyI=;
        b=U9HyOJLZimurOV1+Txl9YwVXLZsk5fCZdIA4fVnkoqEJ+WnwTKDUqVCY+vJHSfrdr8
         IBz4PRT4AJCxeQkFBQHJQF+/9XTYIPWCOP9POerxRukNPGkH3/QqLyRo7qVikqADOWn4
         BH4f60QdncyOaEK8yEn+XCFM0NeK1Fw+KJqLjHIPrNj+Jylwivk7BGoQesjvvbQ6VZq7
         3l3Cc13rcfqI8xNpAxbHnmarAIgc8BBxUx4Ki6BOFvcx6SJ8r5V2aPTIF165AKP5iSYH
         WzJ74W/IwHU51sDv9Es2m126cp22rVbyLgUuAJUvMWlzqYPnSLqSdI+peIUJB9rEbRuD
         qwIQ==
X-Gm-Message-State: AOAM531xPxjMxLbAfWhZPu9YC5+cjW+wVPZ9ofdg2HHXnguBINPmOona
        NTFQL/yYLYW/7qUDIf3aEZ44uDosZv+Jpv/naClBKA==
X-Google-Smtp-Source: ABdhPJzBGOZXzCYT4XeV0yIPPzwV2eSqndWZYNRTuD9L7l0NpYMXXlDP51xyW1i8PBJ4zHLByvZv05hQceNyE07kd2M=
X-Received: by 2002:a37:5446:: with SMTP id i67mr5480440qkb.502.1633016421262;
 Thu, 30 Sep 2021 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210930153706.2105471-1-elver@google.com>
In-Reply-To: <20210930153706.2105471-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Sep 2021 17:39:44 +0200
Message-ID: <CAG_fn=XmtwrqdDwMmKeiJCwKWBEFphfgBHYq0FPOjCZm-mV2+w@mail.gmail.com>
Subject: Re: [PATCH] kfence: shorten critical sections of alloc/free
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 5:37 PM Marco Elver <elver@google.com> wrote:
>
> Initializing memory and setting/checking the canary bytes is relatively
> expensive, and doing so in the meta->lock critical sections extends the
> duration with preemption and interrupts disabled unnecessarily.
>
> Any reads to meta->addr and meta->size in kfence_guarded_alloc() and
> kfence_guarded_free() don't require locking meta->lock as long as the
> object is removed from the freelist: only kfence_guarded_alloc() sets
> meta->addr and meta->size after removing it from the freelist,  which
> requires a preceding kfence_guarded_free() returning it to the list or
> the initial state.
>
> Therefore move reads to meta->addr and meta->size, including expensive
> memory initialization using them, out of meta->lock critical sections.
>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kfence/core.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index b61ef93d9f98..802905b1c89b 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -309,12 +309,19 @@ static inline bool set_canary_byte(u8 *addr)
>  /* Check canary byte at @addr. */
>  static inline bool check_canary_byte(u8 *addr)
>  {
> +       struct kfence_metadata *meta;
> +       unsigned long flags;
> +
>         if (likely(*addr =3D=3D KFENCE_CANARY_PATTERN(addr)))
>                 return true;
>
>         atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> -       kfence_report_error((unsigned long)addr, false, NULL, addr_to_met=
adata((unsigned long)addr),
> -                           KFENCE_ERROR_CORRUPTION);
> +
> +       meta =3D addr_to_metadata((unsigned long)addr);
> +       raw_spin_lock_irqsave(&meta->lock, flags);
> +       kfence_report_error((unsigned long)addr, false, NULL, meta, KFENC=
E_ERROR_CORRUPTION);
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
>         return false;
>  }
>
> @@ -324,8 +331,6 @@ static __always_inline void for_each_canary(const str=
uct kfence_metadata *meta,
>         const unsigned long pageaddr =3D ALIGN_DOWN(meta->addr, PAGE_SIZE=
);
>         unsigned long addr;
>
> -       lockdep_assert_held(&meta->lock);
> -
>         /*
>          * We'll iterate over each canary byte per-side until fn() return=
s
>          * false. However, we'll still iterate over the canary bytes to t=
he
> @@ -414,8 +419,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *=
cache, size_t size, gfp_t g
>         WRITE_ONCE(meta->cache, cache);
>         meta->size =3D size;
>         meta->alloc_stack_hash =3D alloc_stack_hash;
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
>
> -       for_each_canary(meta, set_canary_byte);
> +       alloc_covered_add(alloc_stack_hash, 1);
>
>         /* Set required struct page fields. */
>         page =3D virt_to_page(meta->addr);
> @@ -425,11 +431,8 @@ static void *kfence_guarded_alloc(struct kmem_cache =
*cache, size_t size, gfp_t g
>         if (IS_ENABLED(CONFIG_SLAB))
>                 page->s_mem =3D addr;
>
> -       raw_spin_unlock_irqrestore(&meta->lock, flags);
> -
> -       alloc_covered_add(alloc_stack_hash, 1);
> -
>         /* Memory initialization. */
> +       for_each_canary(meta, set_canary_byte);
>
>         /*
>          * We check slab_want_init_on_alloc() ourselves, rather than lett=
ing
> @@ -454,6 +457,7 @@ static void kfence_guarded_free(void *addr, struct kf=
ence_metadata *meta, bool z
>  {
>         struct kcsan_scoped_access assert_page_exclusive;
>         unsigned long flags;
> +       bool init;
>
>         raw_spin_lock_irqsave(&meta->lock, flags);
>
> @@ -481,6 +485,13 @@ static void kfence_guarded_free(void *addr, struct k=
fence_metadata *meta, bool z
>                 meta->unprotected_page =3D 0;
>         }
>
> +       /* Mark the object as freed. */
> +       metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
> +       init =3D slab_want_init_on_free(meta->cache);
> +       raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +       alloc_covered_add(meta->alloc_stack_hash, -1);
> +
>         /* Check canary bytes for memory corruption. */
>         for_each_canary(meta, check_canary_byte);
>
> @@ -489,16 +500,9 @@ static void kfence_guarded_free(void *addr, struct k=
fence_metadata *meta, bool z
>          * data is still there, and after a use-after-free is detected, w=
e
>          * unprotect the page, so the data is still accessible.
>          */
> -       if (!zombie && unlikely(slab_want_init_on_free(meta->cache)))
> +       if (!zombie && unlikely(init))
>                 memzero_explicit(addr, meta->size);
>
> -       /* Mark the object as freed. */
> -       metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
> -
> -       raw_spin_unlock_irqrestore(&meta->lock, flags);
> -
> -       alloc_covered_add(meta->alloc_stack_hash, -1);
> -
>         /* Protect to detect use-after-frees. */
>         kfence_protect((unsigned long)addr);
>
> --
> 2.33.0.685.g46640cef36-goog
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
