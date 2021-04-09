Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F53596E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhDIHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhDIHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:55:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291DC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 00:54:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j7so2351492plx.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kygys1FotYF6vId1iZJh0rqTLL6lUngWtZIQrj37xVs=;
        b=NYTalHXqF3V9bf4ymLj617NyjN9UakVIyGiEcIzmkKmZxGh9QDJ3JiK/7Z3yjlgvkn
         a2jibKJZ0/k2EdUIYM4yXunZFAKvusKRlxr7Dl+6OXPvphfGdwB/GcG3kQ80clJPSxBE
         qLgpOq7j9Qpb0SU2ioWmlm1kk02Z0g7rj+ieUcc4ymm6+SIPfP0PnoHrdUbmhuMGdIDm
         n3mYbdikebaiUu4TUqXlpqYdj+SQ12vHMqavFmXnc6YYjYSzKnMUh5yCkV+ZpTzOTyVr
         K83ActadRKvjPCdZKkrr0yZE7qIQlIchmNHJSUXn93/H46skx18FnwU0hJ6m+ySTQC1m
         Ws1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kygys1FotYF6vId1iZJh0rqTLL6lUngWtZIQrj37xVs=;
        b=BarGWTP1CeHsXwgUMV1PxOjcb15QspCon2397eneKlT6wpUYLeZsghDYLmA0vntwhk
         HzH91IWnYOsKhf7VaBr/akWf5YiSVnJFvdfGuB7qwG/4HWLrFqHbADfhuFWqEuYWZIyN
         Nzw/RB2Ru6azfGy0BJXfyqk05oCT5KPZsAqsiBl1+EpIe/CZRRZ7u1guLqGLBVhsBzg+
         Lfeq35fz6nhYaIcIw+tmUDPZsAcbBeYm196IlRlHoLo6uFC6ahy0f9TMWfnQxa4N4c6U
         Rq/pJd6RBWxtAuu2h6zYDjLjiWGrLG0IJIzKaIuy3yoaVu2R0Uw0Omz0Gxre3+YUl/4l
         KScA==
X-Gm-Message-State: AOAM530WyJw9uEgXtBFjWSgOHoQUPAJqdZEXjf0FGbe226zceWe9LLHm
        Q6tPcD55aADhq+/EjREgRNKNJMnQIIe66Ly4Uoi1DQ==
X-Google-Smtp-Source: ABdhPJwLsLojTkctKrz2lsTxhplO0Z6KIihauYTsWtntpu62KrXdmeJL7ccn9TSbRrt3GLCfWj31zNaw0ygZMvtX3Fs=
X-Received: by 2002:a17:902:d918:b029:e9:86d1:75b4 with SMTP id
 c24-20020a170902d918b02900e986d175b4mr8136309plz.80.1617954889243; Fri, 09
 Apr 2021 00:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210331085156.5028-1-glittao@gmail.com> <YGWPdFywfNUl4d3S@elver.google.com>
 <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
 <CANpmjNPhWUsQrG62Z2jchdqzgSOfVYOsD1QDJpRghJwzwRZcQA@mail.gmail.com>
 <11886d4f-8826-0cd6-b5fd-defc65470ed5@suse.cz> <CANpmjNMzB=Cn1so-VU_NwJHX_fqfWatK90npL8EvSNQNGpqc7A@mail.gmail.com>
 <CAGS_qxqY-Jb5DMkcFkDb1c2o+MkdpHSsnoVtPDmAy-wbNPq1tg@mail.gmail.com>
In-Reply-To: <CAGS_qxqY-Jb5DMkcFkDb1c2o+MkdpHSsnoVtPDmAy-wbNPq1tg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 9 Apr 2021 00:54:38 -0700
Message-ID: <CAFd5g44BfUxyS=wxFCWFeD4PYBcmyKa_GaODajS8nc6JZ9OADA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging functionality
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Marco Elver <elver@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        glittao@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 10:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Apr 8, 2021 at 3:30 AM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 6 Apr 2021 at 12:57, Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > >
> > > On 4/1/21 11:24 PM, Marco Elver wrote:
> > > > On Thu, 1 Apr 2021 at 21:04, Daniel Latypov <dlatypov@google.com> wrote:
> > > >> >         }
> > > >> >         #else
> > > >> >         static inline bool slab_add_kunit_errors(void) { return false; }
> > > >> >         #endif
> > > >> >
> > > >> > And anywhere you want to increase the error count, you'd call
> > > >> > slab_add_kunit_errors().
> > > >> >
> > > >> > Another benefit of this approach is that if KUnit is disabled, there is
> > > >> > zero overhead and no additional code generated (vs. the current
> > > >> > approach).
> > > >>
> > > >> The resource approach looks really good, but...
> > > >> You'd be picking up a dependency on
> > > >> https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
> > > >> current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
> > > >> CONFIG_KUNIT=y at the moment.
> > > >> My patch drops the CONFIG_KASAN requirement and opens it up to all tests.
> > > >
> > > > Oh, that's a shame, but hopefully it'll be in -next soon.
> > > >
> > > >> At the moment, it's just waiting another look over from Brendan or David.
> > > >> Any ETA on that, folks? :)
> > > >>
> > > >> So if you don't want to get blocked on that for now, I think it's fine to add:
> > > >>   #ifdef CONFIG_SLUB_KUNIT_TEST
> > > >>   int errors;
> > > >>   #endif
> > > >
> > > > Until kunit fixes setting current->kunit_test, a cleaner workaround
> > > > that would allow to do the patch with kunit_resource, is to just have
> > > > an .init/.exit function that sets it ("current->kunit_test = test;").
> > > > And then perhaps add a note ("FIXME: ...") to remove it once the above
> > > > patch has landed.
> > > >
> > > > At least that way we get the least intrusive change for mm/slub.c, and
> > > > the test is the only thing that needs a 2-line patch to clean up
> > > > later.
> > >
> > > So when testing internally Oliver's new version with your suggestions (thanks
> > > again for those), I got lockdep splats because slab_add_kunit_errors is called
> > > also from irq disabled contexts, and kunit_find_named_resource will call
> > > spin_lock(&test->lock) that's not irq safe. Can we make the lock irq safe? I
> > > tried the change below and it makde the problem go away. If you agree, the
> > > question is how to proceed - make it part of Oliver's patch series and let
> > > Andrew pick it all with eventually kunit team's acks on this patch, or whatnot.
> >
> > From what I can tell it should be fine to make it irq safe (ack for
> > your patch below). Regarding patch logistics, I'd probably add it to
> > the series. If that ends up not working, we'll find out sooner or
> > later.
> >
> > (FYI, the prerequisite patch for current->kunit_test is in -next now.)
>
> Yep.
> There's also two follow-up patches in
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit
>
> >
> > KUnit maintainers, do you have any preferences?
>
> Poked offline and Brendan and David seemed fine either way.
> So probably just include it in this patch series for convenience.
>
> Brendan also mentioned KUnit used to use spin_lock_irqsave/restore()
> but had been told to not use it until necessary.
> See https://lore.kernel.org/linux-kselftest/20181016235120.138227-3-brendanhiggins@google.com/
> So I think there's no objections to the patch itself either.
>
> But I'd wait for Brendan to chime in to confirm.

That's correct. Before KUnit was accepted upstream, early versions of
the patchset used the irqsave/restore versions. I was asked to remove
them until they were necessary, and it looks like that time is now :-)

So yes, I would be happy to see this patch go in. Looks good to me the
way you have it below. Send it out as its own patch in your series and
I will give it a Reviewed-by.

Thanks!

> > > ----8<----
> > >
> > > commit ab28505477892e9824c57ac338c88aec2ec0abce
> > > Author: Vlastimil Babka <vbabka@suse.cz>
> > > Date:   Tue Apr 6 12:28:07 2021 +0200
> > >
> > >     kunit: make test->lock irq safe
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 49601c4b98b8..524d4789af22 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -515,8 +515,9 @@ kunit_find_resource(struct kunit *test,
> > >                     void *match_data)
> > >  {
> > >         struct kunit_resource *res, *found = NULL;
> > > +       unsigned long flags;
> > >
> > > -       spin_lock(&test->lock);
> > > +       spin_lock_irqsave(&test->lock, flags);
> > >
> > >         list_for_each_entry_reverse(res, &test->resources, node) {
> > >                 if (match(test, res, (void *)match_data)) {
> > > @@ -526,7 +527,7 @@ kunit_find_resource(struct kunit *test,
> > >                 }
> > >         }
> > >
> > > -       spin_unlock(&test->lock);
> > > +       spin_unlock_irqrestore(&test->lock, flags);
> > >
> > >         return found;
> > >  }
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index ec9494e914ef..2c62eeb45b82 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -442,6 +442,7 @@ int kunit_add_resource(struct kunit *test,
> > >                        void *data)
> > >  {
> > >         int ret = 0;
> > > +       unsigned long flags;
> > >
> > >         res->free = free;
> > >         kref_init(&res->refcount);
> > > @@ -454,10 +455,10 @@ int kunit_add_resource(struct kunit *test,
> > >                 res->data = data;
> > >         }
> > >
> > > -       spin_lock(&test->lock);
> > > +       spin_lock_irqsave(&test->lock, flags);
> > >         list_add_tail(&res->node, &test->resources);
> > >         /* refcount for list is established by kref_init() */
> > > -       spin_unlock(&test->lock);
> > > +       spin_unlock_irqrestore(&test->lock, flags);
> > >
> > >         return ret;
> > >  }
> > > @@ -515,9 +516,11 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
> > >
> > >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
> > >  {
> > > -       spin_lock(&test->lock);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&test->lock, flags);
> > >         list_del(&res->node);
> > > -       spin_unlock(&test->lock);
> > > +       spin_unlock_irqrestore(&test->lock, flags);
> > >         kunit_put_resource(res);
> > >  }
> > >  EXPORT_SYMBOL_GPL(kunit_remove_resource);
> > > @@ -597,6 +600,7 @@ EXPORT_SYMBOL_GPL(kunit_kfree);
> > >  void kunit_cleanup(struct kunit *test)
> > >  {
> > >         struct kunit_resource *res;
> > > +       unsigned long flags;
> > >
> > >         /*
> > >          * test->resources is a stack - each allocation must be freed in the
> > > @@ -608,9 +612,9 @@ void kunit_cleanup(struct kunit *test)
> > >          * protect against the current node being deleted, not the next.
> > >          */
> > >         while (true) {
> > > -               spin_lock(&test->lock);
> > > +               spin_lock_irqsave(&test->lock, flags);
> > >                 if (list_empty(&test->resources)) {
> > > -                       spin_unlock(&test->lock);
> > > +                       spin_unlock_irqrestore(&test->lock, flags);
> > >                         break;
> > >                 }
> > >                 res = list_last_entry(&test->resources,
> > > @@ -621,7 +625,7 @@ void kunit_cleanup(struct kunit *test)
> > >                  * resource, and this can't happen if the test->lock
> > >                  * is held.
> > >                  */
> > > -               spin_unlock(&test->lock);
> > > +               spin_unlock_irqrestore(&test->lock, flags);
> > >                 kunit_remove_resource(test, res);
> > >         }
> > >  #if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
