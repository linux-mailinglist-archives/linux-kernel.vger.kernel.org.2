Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E4415CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhIWLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbhIWLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:35:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:33:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i132so21121018qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggXcEXb/CHUjvrcz3BZioGS0po09zhrTU/EfIgarfj8=;
        b=Zr+iAvq3Izz+Bknz6jq/NMP3bzqVL3tPWWy5j9IrJZtejKXTzS+bvej5zDkJa/BARw
         OaMOUJ9JN96Ypo+a3rGdp/wNwwb9SdiKaEhbjPi6WhJ+xe34CGI+8AN1nXDm+5gmguiO
         yhxYIBFFfb5tCDM2Buf4b6T9J2N7B/9fKd46bbJmnIbx1junWNGFpN0ys6LG6NhxQxng
         anSR57NEdewba8GfOPTlLBYi37jE1Znjhv+bf6+AMgMKZoP9DDD7J0x4Sm9RDswVDa/c
         va4KI3gUHVzLmB7SC2o85M98Z4OuWwoq7XZWqeRGpMz4wVL9Avz6itw71MHz7A5VoUEA
         QW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggXcEXb/CHUjvrcz3BZioGS0po09zhrTU/EfIgarfj8=;
        b=39mLIXkwSZnOKcTZKPk9CkR/a3OLcputX/UkfEnb0dvy1DY7L0NyfRTR3taICUU1bo
         ygvQx7wsbAznwASDm5Xk8oJV4724hcCeQEx3uKjfExyU5hSAtZr7rJuK7P4WkSnhR9bn
         PYqiK0sgAJMuiB6LYrQHsnFHscRcsClSh7FR8wnGk59iwB1eTr3fLR14pZD0nWyK8wfA
         6tEBAH+y/o5I1PcCQVgtaPCdD/uKf9cep/Cj0LSboHoxWCbCvFjoeQqxQSTwD39CbkUD
         b3hp8Mq0GsHsjyYppWWbAmQCNYisVdSUJoTgb8/kKhvjG88PRvyw3KdvWtMrNMKp1WSe
         g+vA==
X-Gm-Message-State: AOAM532efYKsnOyhIyURozb5ZlOnYiU046VnnFrne03q8evirQ8TTjQn
        nmzx4lnD3wtlPn+ynC+DSMlam0+SqHjrjP0IAup8Ww==
X-Google-Smtp-Source: ABdhPJwjnq0YIi1DjP67SfCEf/CgQCwudASkbOVKd7DI2WRtMOeWHML3zagvX0A8OxSJRSUVbi+94ftElSNrvcjvkvM=
X-Received: by 2002:a37:8044:: with SMTP id b65mr4254304qkd.150.1632396813877;
 Thu, 23 Sep 2021 04:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-3-elver@google.com>
In-Reply-To: <20210923104803.2620285-3-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 13:32:57 +0200
Message-ID: <CAG_fn=W+_Dx8TKofckVCUWCiPy_pS01r2AUWBYAS2yEMShmFcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] kfence: move saving stack trace of allocations
 into __kfence_alloc()
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
> Move the saving of the stack trace of allocations into __kfence_alloc(),
> so that the stack entries array can be used outside of
> kfence_guarded_alloc() and we avoid potentially unwinding the stack
> multiple times.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

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
> @@ -187,19 +187,26 @@ static inline unsigned long metadata_to_pageaddr(co=
nst struct kfence_metadata *m
>   * Update the object's metadata state, including updating the alloc/free=
 stacks
>   * depending on the state transition.
>   */
> -static noinline void metadata_update_state(struct kfence_metadata *meta,
> -                                          enum kfence_object_state next)
> +static noinline void
> +metadata_update_state(struct kfence_metadata *meta, enum kfence_object_s=
tate next,
> +                     unsigned long *stack_entries, size_t num_stack_entr=
ies)
>  {
>         struct kfence_track *track =3D
>                 next =3D=3D KFENCE_OBJECT_FREED ? &meta->free_track : &me=
ta->alloc_track;
>
>         lockdep_assert_held(&meta->lock);
>
> -       /*
> -        * Skip over 1 (this) functions; noinline ensures we do not accid=
entally
> -        * skip over the caller by never inlining.
> -        */
> -       track->num_stack_entries =3D stack_trace_save(track->stack_entrie=
s, KFENCE_STACK_DEPTH, 1);
> +       if (stack_entries) {
> +               memcpy(track->stack_entries, stack_entries,
> +                      num_stack_entries * sizeof(stack_entries[0]));
> +       } else {
> +               /*
> +                * Skip over 1 (this) functions; noinline ensures we do n=
ot
> +                * accidentally skip over the caller by never inlining.
> +                */
> +               num_stack_entries =3D stack_trace_save(track->stack_entri=
es, KFENCE_STACK_DEPTH, 1);
> +       }
> +       track->num_stack_entries =3D num_stack_entries;
>         track->pid =3D task_pid_nr(current);
>         track->cpu =3D raw_smp_processor_id();
>         track->ts_nsec =3D local_clock(); /* Same source as printk timest=
amps. */
> @@ -261,7 +268,8 @@ static __always_inline void for_each_canary(const str=
uct kfence_metadata *meta,
>         }
>  }
>
> -static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size,=
 gfp_t gfp)
> +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size,=
 gfp_t gfp,
> +                                 unsigned long *stack_entries, size_t nu=
m_stack_entries)
>  {
>         struct kfence_metadata *meta =3D NULL;
>         unsigned long flags;
> @@ -320,7 +328,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *=
cache, size_t size, gfp_t g
>         addr =3D (void *)meta->addr;
>
>         /* Update remaining metadata. */
> -       metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED);
> +       metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED, stack_entrie=
s, num_stack_entries);
>         /* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
>         WRITE_ONCE(meta->cache, cache);
>         meta->size =3D size;
> @@ -400,7 +408,7 @@ static void kfence_guarded_free(void *addr, struct kf=
ence_metadata *meta, bool z
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
>          * Perform size check before switching kfence_allocation_gate, so=
 that
>          * we don't disable KFENCE without making an allocation.
> @@ -786,7 +797,9 @@ void *__kfence_alloc(struct kmem_cache *s, size_t siz=
e, gfp_t flags)
>         if (!READ_ONCE(kfence_enabled))
>                 return NULL;
>
> -       return kfence_guarded_alloc(s, size, flags);
> +       num_stack_entries =3D stack_trace_save(stack_entries, KFENCE_STAC=
K_DEPTH, 0);
> +
> +       return kfence_guarded_alloc(s, size, flags, stack_entries, num_st=
ack_entries);
>  }
>
>  size_t kfence_ksize(const void *addr)
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
