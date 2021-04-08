Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D235809F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhDHKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:30:12 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD9C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 03:30:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so382565ooa.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5Jk69Eodvn8mB9Y/1oitzOjfLDng5NAhnlUtQRke6o=;
        b=hhrXI6/8Law1BByCC2ndfnbNBuU9E2RLS86u6jXlcb67cAtrHqCmzuLBSijXi099RH
         oRmddHnwgRQWw21f+rYzsYyrwexvANN5UH2Jj3FqL6XcNc5hXSYN9RdW7GdGrAPOBys8
         AAnIEEgXB+IQ1A3ea8uCpy951WnPuUHjWV+XyhK7QJltvXup56NsEze+MQh4Udp2L0bu
         7E/rgINuinGyVu5U3AwIojJ362vhmbp0Ry0d8d4fZ4m+08jVKM3cg1Duq6rGWq1rb7xs
         fy+2gDezoRoU3zaQ/sTnynWZH2hcBoT23aHuKRxS4+GyS8bG9wwOFPibE2Me46QieAn8
         9A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5Jk69Eodvn8mB9Y/1oitzOjfLDng5NAhnlUtQRke6o=;
        b=q5+eeqUtBlSkvESHQS2NrZ3dv2DGIabxGJOg2alKvMGcgy+yyhrzGS+9VQ4wJbwsCI
         +QXYwDvthCzvki4DG0jq0YeWwwQOF1GZdiPVHkdeRalhkCA/uWnrLpGSg4xuSedzNtUL
         cA1hPALRov2szWAlsoNo2Cu2OpQYqDAz1qL7aEaaYFC5WzLDEh9Lr+VXvehupEXMfS2v
         PLq5cqTJAZqk4r12bYXsjgWkETaLqrKEk9HJroWLC9IZmqHomUzJ/jqAafFrnXheJK8z
         vLkRhAsmNlsiZnj/3AlVOi913jifwZXQy/6nFvLUWpi+VLwqLjV8Zs65qrGsTfEKPt13
         xKhg==
X-Gm-Message-State: AOAM533+TV/Pux8Xe7Mpvl0HbvQeNLP5Cwzpkf9Opz6qNmRxYIs9wFNM
        9rX9zoURCbUnYQzIZ29Qd9YPWbs6H1qr8HvGJf0q2w==
X-Google-Smtp-Source: ABdhPJxu1iJpsLan+Jp9cwaurMcGWnf7sM8GOfKTaxtbFbX//ta2pm+21tpuXx4BUhPvMkEiRXwgF30QQ4dg5BYEuS8=
X-Received: by 2002:a4a:d0ce:: with SMTP id u14mr6895828oor.36.1617877800640;
 Thu, 08 Apr 2021 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210331085156.5028-1-glittao@gmail.com> <YGWPdFywfNUl4d3S@elver.google.com>
 <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
 <CANpmjNPhWUsQrG62Z2jchdqzgSOfVYOsD1QDJpRghJwzwRZcQA@mail.gmail.com> <11886d4f-8826-0cd6-b5fd-defc65470ed5@suse.cz>
In-Reply-To: <11886d4f-8826-0cd6-b5fd-defc65470ed5@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Apr 2021 12:29:49 +0200
Message-ID: <CANpmjNMzB=Cn1so-VU_NwJHX_fqfWatK90npL8EvSNQNGpqc7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging functionality
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Daniel Latypov <dlatypov@google.com>, glittao@gmail.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 12:57, Vlastimil Babka <vbabka@suse.cz> wrote:
>
>
> On 4/1/21 11:24 PM, Marco Elver wrote:
> > On Thu, 1 Apr 2021 at 21:04, Daniel Latypov <dlatypov@google.com> wrote:
> >> >         }
> >> >         #else
> >> >         static inline bool slab_add_kunit_errors(void) { return false; }
> >> >         #endif
> >> >
> >> > And anywhere you want to increase the error count, you'd call
> >> > slab_add_kunit_errors().
> >> >
> >> > Another benefit of this approach is that if KUnit is disabled, there is
> >> > zero overhead and no additional code generated (vs. the current
> >> > approach).
> >>
> >> The resource approach looks really good, but...
> >> You'd be picking up a dependency on
> >> https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
> >> current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
> >> CONFIG_KUNIT=y at the moment.
> >> My patch drops the CONFIG_KASAN requirement and opens it up to all tests.
> >
> > Oh, that's a shame, but hopefully it'll be in -next soon.
> >
> >> At the moment, it's just waiting another look over from Brendan or David.
> >> Any ETA on that, folks? :)
> >>
> >> So if you don't want to get blocked on that for now, I think it's fine to add:
> >>   #ifdef CONFIG_SLUB_KUNIT_TEST
> >>   int errors;
> >>   #endif
> >
> > Until kunit fixes setting current->kunit_test, a cleaner workaround
> > that would allow to do the patch with kunit_resource, is to just have
> > an .init/.exit function that sets it ("current->kunit_test = test;").
> > And then perhaps add a note ("FIXME: ...") to remove it once the above
> > patch has landed.
> >
> > At least that way we get the least intrusive change for mm/slub.c, and
> > the test is the only thing that needs a 2-line patch to clean up
> > later.
>
> So when testing internally Oliver's new version with your suggestions (thanks
> again for those), I got lockdep splats because slab_add_kunit_errors is called
> also from irq disabled contexts, and kunit_find_named_resource will call
> spin_lock(&test->lock) that's not irq safe. Can we make the lock irq safe? I
> tried the change below and it makde the problem go away. If you agree, the
> question is how to proceed - make it part of Oliver's patch series and let
> Andrew pick it all with eventually kunit team's acks on this patch, or whatnot.

From what I can tell it should be fine to make it irq safe (ack for
your patch below). Regarding patch logistics, I'd probably add it to
the series. If that ends up not working, we'll find out sooner or
later.

(FYI, the prerequisite patch for current->kunit_test is in -next now.)

KUnit maintainers, do you have any preferences?

> ----8<----
>
> commit ab28505477892e9824c57ac338c88aec2ec0abce
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Tue Apr 6 12:28:07 2021 +0200
>
>     kunit: make test->lock irq safe
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 49601c4b98b8..524d4789af22 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -515,8 +515,9 @@ kunit_find_resource(struct kunit *test,
>                     void *match_data)
>  {
>         struct kunit_resource *res, *found = NULL;
> +       unsigned long flags;
>
> -       spin_lock(&test->lock);
> +       spin_lock_irqsave(&test->lock, flags);
>
>         list_for_each_entry_reverse(res, &test->resources, node) {
>                 if (match(test, res, (void *)match_data)) {
> @@ -526,7 +527,7 @@ kunit_find_resource(struct kunit *test,
>                 }
>         }
>
> -       spin_unlock(&test->lock);
> +       spin_unlock_irqrestore(&test->lock, flags);
>
>         return found;
>  }
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ec9494e914ef..2c62eeb45b82 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -442,6 +442,7 @@ int kunit_add_resource(struct kunit *test,
>                        void *data)
>  {
>         int ret = 0;
> +       unsigned long flags;
>
>         res->free = free;
>         kref_init(&res->refcount);
> @@ -454,10 +455,10 @@ int kunit_add_resource(struct kunit *test,
>                 res->data = data;
>         }
>
> -       spin_lock(&test->lock);
> +       spin_lock_irqsave(&test->lock, flags);
>         list_add_tail(&res->node, &test->resources);
>         /* refcount for list is established by kref_init() */
> -       spin_unlock(&test->lock);
> +       spin_unlock_irqrestore(&test->lock, flags);
>
>         return ret;
>  }
> @@ -515,9 +516,11 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
>
>  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
>  {
> -       spin_lock(&test->lock);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&test->lock, flags);
>         list_del(&res->node);
> -       spin_unlock(&test->lock);
> +       spin_unlock_irqrestore(&test->lock, flags);
>         kunit_put_resource(res);
>  }
>  EXPORT_SYMBOL_GPL(kunit_remove_resource);
> @@ -597,6 +600,7 @@ EXPORT_SYMBOL_GPL(kunit_kfree);
>  void kunit_cleanup(struct kunit *test)
>  {
>         struct kunit_resource *res;
> +       unsigned long flags;
>
>         /*
>          * test->resources is a stack - each allocation must be freed in the
> @@ -608,9 +612,9 @@ void kunit_cleanup(struct kunit *test)
>          * protect against the current node being deleted, not the next.
>          */
>         while (true) {
> -               spin_lock(&test->lock);
> +               spin_lock_irqsave(&test->lock, flags);
>                 if (list_empty(&test->resources)) {
> -                       spin_unlock(&test->lock);
> +                       spin_unlock_irqrestore(&test->lock, flags);
>                         break;
>                 }
>                 res = list_last_entry(&test->resources,
> @@ -621,7 +625,7 @@ void kunit_cleanup(struct kunit *test)
>                  * resource, and this can't happen if the test->lock
>                  * is held.
>                  */
> -               spin_unlock(&test->lock);
> +               spin_unlock_irqrestore(&test->lock, flags);
>                 kunit_remove_resource(test, res);
>         }
>  #if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
