Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF643521A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDAVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDAVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:24:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE78C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:24:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so3349065otq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0lNND0HV6YpmDvNBpdxNkFf2/SfSlXhkdI6Kpj/xns=;
        b=E/UxQ1lGJQpxazQTiwKeC5yiB6dFRaWo9vi/vWvDSWNwnbHxte+6GFMKkpRhsZU0Dx
         PH4DS43QWRHY3/LtpjuxHBr65DgM/z7FqVbCTmuFHSMW2HLltKDQ0SJ2A55QzFjqKjy8
         KTxrQ625LSCOC6x0gIo69W8MgWWr47501N4BsG5cRLgi4vGbZtJXVFmnePjwxajk7xAi
         n5TuDT4AawVzLxj27fu6BiKV7ZkW71zbyVrNx5oUBWwoKvF9PP8V5gJ9W+ek9e/aUy9X
         xVsD+Ho8BME6DlQ68aqawc54GqouwOHPDu0H5KBSGWIKXhwjV1TED++M9fvYZQwWlWPD
         TWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0lNND0HV6YpmDvNBpdxNkFf2/SfSlXhkdI6Kpj/xns=;
        b=FWQF32+OoVjxoTmtDjvS/fuME2ygnQecTGxRJzTHSpoV9Xt9f6tWyVfoWbgCWylrOv
         XVvwExSbIlZMLw9HWn1ZIWEIqlViaVUEiX4239Ocr00VrWmDuSm/EtGuWDx6T/EOOWcp
         ss0ohivckmGzqzgB+HECTB0CjrWFUawLLAIQdrRw9dUtPYSFF+M58DwmWbehtxuuma2e
         rowJaoLrrcme9Nfh68LaybZeRvAeciwWWxISxRyDeBT0pMjg3+8gUOFXrQcSiCWYNfkp
         vYptviqHsa+lfAAfus4Vt0Wi5Z60wUNOy8LG0KhIrX+Pq4DPtU5e1Q9Fy+3+2D8hxoT1
         C4UQ==
X-Gm-Message-State: AOAM5314hbuUvNqZ7fEhPbQDT+lsWuRQAI0eftX/Ihb8jM8M056hxkLD
        q0cpKQVC2Gq005oxV99xegI8V2GEBUDpyr5Ra9OIkw==
X-Google-Smtp-Source: ABdhPJxLl6Lv9qEblE1Z3Tl33FCBxoYUWizRywN+OE0WOCtECeRu4FyQjf5wDN4JKxB8jzi3KCqhVff4W5BFOElecw0=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr8828319otq.251.1617312284641;
 Thu, 01 Apr 2021 14:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210331085156.5028-1-glittao@gmail.com> <YGWPdFywfNUl4d3S@elver.google.com>
 <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
In-Reply-To: <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 1 Apr 2021 23:24:32 +0200
Message-ID: <CANpmjNPhWUsQrG62Z2jchdqzgSOfVYOsD1QDJpRghJwzwRZcQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging functionality
To:     Daniel Latypov <dlatypov@google.com>
Cc:     glittao@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 at 21:04, Daniel Latypov <dlatypov@google.com> wrote:
...
> > > --- a/include/linux/slub_def.h
> > > +++ b/include/linux/slub_def.h
> > > @@ -133,6 +133,8 @@ struct kmem_cache {
> > >       unsigned int usersize;          /* Usercopy region size */
> > >
> > >       struct kmem_cache_node *node[MAX_NUMNODES];
> > > +
> > > +     int errors;                     /* Number of errors in cache */
> >
> > So, I think it's bad design to add a new field 'errors', just for the
> > test. This will increase kmem_cache size for all builds, which is
> > unnecessary.
> >
> > Is there use to retrieve 'errors' elsewhere?
> >
> > While you could guard this with #ifdef CONFIG_SLUB_DEBUG or so, there's
> > a better design option if this is just for the KUnit test's benefit: use
> > kunit_resource.
> >
> > The way it'd work is that for each test (you can add a common init
> > function) you add a named resource, in this case just an 'int' I guess,
> > that slab would be able to retrieve if this test is being run.
> >
> > In the test somewhere, you could add something like this:
> >
> >
> >         static struct kunit_resource resource;
> >         static int slab_errors;
> >
> >         ..........
> >
> >         static int test_init(struct kunit *test)
> >         {
> >                 slab_errors = 0;
> >                 kunit_add_named_resource(test, NULL, NULL, &resource,
> >                                          "slab_errors", &slab_errors);
> >                 return 0;
> >         }
> >
> >         ...... tests now check slab_errors .....
> >
> > and then in slub.c you'd have:
> >
> >         #if IS_ENABLED(CONFIG_KUNIT)
> >         static bool slab_add_kunit_errors(void)
> >         {
> >                 struct kunit_resource *resource;
> >
> >                 if (likely(!current->kunit_test))
> >                         return false;
> >                 resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
> >                 if (!resource)
> >                         return false;
> >                 (*(int *)resource->data)++;
> >                 kunit_put_resource(resource);

      return true;

was missing.

> >         }
> >         #else
> >         static inline bool slab_add_kunit_errors(void) { return false; }
> >         #endif
> >
> > And anywhere you want to increase the error count, you'd call
> > slab_add_kunit_errors().
> >
> > Another benefit of this approach is that if KUnit is disabled, there is
> > zero overhead and no additional code generated (vs. the current
> > approach).
>
> The resource approach looks really good, but...
> You'd be picking up a dependency on
> https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
> current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
> CONFIG_KUNIT=y at the moment.
> My patch drops the CONFIG_KASAN requirement and opens it up to all tests.

Oh, that's a shame, but hopefully it'll be in -next soon.

> At the moment, it's just waiting another look over from Brendan or David.
> Any ETA on that, folks? :)
>
> So if you don't want to get blocked on that for now, I think it's fine to add:
>   #ifdef CONFIG_SLUB_KUNIT_TEST
>   int errors;
>   #endif

Until kunit fixes setting current->kunit_test, a cleaner workaround
that would allow to do the patch with kunit_resource, is to just have
an .init/.exit function that sets it ("current->kunit_test = test;").
And then perhaps add a note ("FIXME: ...") to remove it once the above
patch has landed.

At least that way we get the least intrusive change for mm/slub.c, and
the test is the only thing that needs a 2-line patch to clean up
later.

Thanks,
-- Marco
