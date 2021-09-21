Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50B14131F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhIUKvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIUKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:51:44 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:50:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so6907824ood.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0Bhbgp6QvbcNQHQeE1e8BDMff+79sDxtFoMpFLBCbA=;
        b=pGybIBE1T0fumhSgJ9QQnTmGMSlEqHMmOolVKzFjHHK1o8Z8CC5JnnKh0878JaRIYa
         WCmty6bbgP/NAE/g7BiT3oX04lpA162qPuhHA3Rhi4y4F38PaOs1JefhH/8ZMTeKzdTL
         TOFwM5aaOL1KqAUoSikudmtbELe5y+5+5RYp3piuSEA1JocTg2/AmTwLJpAdK95BVNE3
         m5b0Fnzt94ZnmTMI5Pva1TbrRo/uN1B89We4GrMQPFDLi3upLuCpEwI0JUgDykU/5clj
         yVlMrDmaveW1PxV7p7ouaVFUH3399b9TPBTXVQ2f8ao/sf1t2XDHtGeghxid1EcNCZ74
         dK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0Bhbgp6QvbcNQHQeE1e8BDMff+79sDxtFoMpFLBCbA=;
        b=oAIU88VVQkTWA97mZBZkSi2Ls3n/4c/4O9JMiKrOn9tpzXUgNZQdU+P+CyHobtZ2Mj
         rQTKdIcIi7bm2AiclCRpxAo2WXbBflKTXmLVCCL0t9/Ozh3U06TlYyQHT0BG9RPRTtK9
         5PgUdo9S3RrFVnScoRJS+Rt1FHRRxREbAb3cbKIeo6QsHiO4BdAso4PJ4MM64Cy1yw2k
         OekIKbgnIS1D8jGF2y4ZltMcOZ/EQwlk0tvwnunDg5yHPes9LaV/9ZsWG/6VBi7YBOVJ
         aCpAAHWcbrvPl8qHWhrxXsvYGqXk2LVa/48wWqXNu5hy5doZcFCiZWR2DBnfz4WPX9ZG
         N0YQ==
X-Gm-Message-State: AOAM5308ZoICQekgLWTZHP9CPj2i389h7nayDN+ERNsYjLUWkzFkkQj5
        Ds4EhcjXGc+S9f+JoCuJ5DkVZPQoVKsk2eF64ugSYRB7FV4OHA==
X-Google-Smtp-Source: ABdhPJyzet/+gcVAakjqbNVaqa6LHmmwnx/Dz3hOhTqn8eAIc5FtTl4XLxGQOLEVAgOlLQSOgOZm8S5yQMVKeLOgJmc=
X-Received: by 2002:a4a:52c4:: with SMTP id d187mr9155943oob.53.1632221415456;
 Tue, 21 Sep 2021 03:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com> <20210921101014.1938382-3-elver@google.com>
In-Reply-To: <20210921101014.1938382-3-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 12:50:04 +0200
Message-ID: <CACT4Y+Yt6KjcvOehj6VV=0-W+mGuzh1vOd3dH9DbnPW9h04tQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kfence: move saving stack trace of allocations
 into __kfence_alloc()
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
> Move the saving of the stack trace of allocations into __kfence_alloc(),
> so that the stack entries array can be used outside of
> kfence_guarded_alloc() and we avoid potentially unwinding the stack
> multiple times.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * New patch.
> ---
>  mm/kfence/core.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 249d75b7e5ee..db01814f8ff0 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -187,19 +187,26 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
>   * Update the object's metadata state, including updating the alloc/free stacks
>   * depending on the state transition.
>   */
> -static noinline void metadata_update_state(struct kfence_metadata *meta,
> -                                          enum kfence_object_state next)
> +static noinline void
> +metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state next,
> +                     unsigned long *stack_entries, size_t num_stack_entries)
>  {
>         struct kfence_track *track =
>                 next == KFENCE_OBJECT_FREED ? &meta->free_track : &meta->alloc_track;
>
>         lockdep_assert_held(&meta->lock);
>
> -       /*
> -        * Skip over 1 (this) functions; noinline ensures we do not accidentally
> -        * skip over the caller by never inlining.
> -        */
> -       track->num_stack_entries = stack_trace_save(track->stack_entries, KFENCE_STACK_DEPTH, 1);
> +       if (stack_entries) {
> +               memcpy(track->stack_entries, stack_entries,
> +                      num_stack_entries * sizeof(stack_entries[0]));
> +       } else {
> +               /*
> +                * Skip over 1 (this) functions; noinline ensures we do not
> +                * accidentally skip over the caller by never inlining.
> +                */
> +               num_stack_entries = stack_trace_save(track->stack_entries, KFENCE_STACK_DEPTH, 1);
> +       }
> +       track->num_stack_entries = num_stack_entries;
>         track->pid = task_pid_nr(current);
>         track->cpu = raw_smp_processor_id();
>         track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
> @@ -261,7 +268,8 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
>         }
>  }
>
> -static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp,
> +                                 unsigned long *stack_entries, size_t num_stack_entries)
>  {
>         struct kfence_metadata *meta = NULL;
>         unsigned long flags;
> @@ -320,7 +328,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         addr = (void *)meta->addr;
>
>         /* Update remaining metadata. */
> -       metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED);
> +       metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED, stack_entries, num_stack_entries);
>         /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
>         WRITE_ONCE(meta->cache, cache);
>         meta->size = size;
> @@ -400,7 +408,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>                 memzero_explicit(addr, meta->size);
>
>         /* Mark the object as freed. */
> -       metadata_update_state(meta, KFENCE_OBJECT_FREED);
> +       metadata_update_state(meta, KFENCE_OBJECT_FREED, NULL, 0);
>
>         raw_spin_unlock_irqrestore(&meta->lock, flags);
>
> @@ -742,6 +750,9 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>
>  void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  {
> +       unsigned long stack_entries[KFENCE_STACK_DEPTH];
> +       size_t num_stack_entries;
> +
>         /*
>          * Perform size check before switching kfence_allocation_gate, so that
>          * we don't disable KFENCE without making an allocation.
> @@ -786,7 +797,9 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>         if (!READ_ONCE(kfence_enabled))
>                 return NULL;
>
> -       return kfence_guarded_alloc(s, size, flags);
> +       num_stack_entries = stack_trace_save(stack_entries, KFENCE_STACK_DEPTH, 0);
> +
> +       return kfence_guarded_alloc(s, size, flags, stack_entries, num_stack_entries);
>  }
>
>  size_t kfence_ksize(const void *addr)
> --
> 2.33.0.464.g1972c5931b-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210921101014.1938382-3-elver%40google.com.
