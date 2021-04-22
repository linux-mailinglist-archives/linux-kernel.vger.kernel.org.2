Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6C36872C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhDVT1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhDVT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:27:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:26:56 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l19so34941973ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBG70xpgE0nxYlRE9dLDLJ0bfKjzKgRx+8AVp41HgW8=;
        b=kEXuX9EEmT6mYjMkHFCvcbXqbmNHBC/izD8SgpGMA7TIkOs80wd9ptpLg2LB+hRyuj
         Toe34f9xHnGx3T5U/UidwyTrIWVmQ0iQ0cXmaEjvIN3VbxD5mbMinIUUxBXCmKm0Pkio
         GiRJl5n9grm+nNI9jq1gfCBjmWL85ehDde+uIOy/YZd81bvyTac0ystVuq6FalNRMGCR
         mIPlPin6QiM3rpsjHWfDcOeMd4xXFDyZCSCpkzANcrwAj/B1w5kCOzAwA4lOOcq+oXnI
         o5BYyBRzX/8F7zi/OhgjcPip9qh46s6nU22CfMs8UJt5/+fpmYTWJSzqKIPlNN8eq3lS
         hKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBG70xpgE0nxYlRE9dLDLJ0bfKjzKgRx+8AVp41HgW8=;
        b=lvhKesjT/Xnu4L2xggA8SCrHryy5lUi3w7lNJ2B9bXoZbbZNqTRPVqZh5DTbPzh0nw
         6v1Xc6AsWAPquPuLdF0EPkKbm7ygEBk+UYeMevKBZwjdf7oXCof3b+C7kJ674IALJLLf
         4ELRip0mMtk7BmBiMkKVeoOLP2zEYZpGlavnO9D1MrPCexdFYwlBKTSlnA+7sfd+46Qg
         CKjeBhw6P9tl4h05xLkzW8I335kIEeau/6FRn9wJNVtKfd9hm56Yxr03F2QmUWdGNdua
         yyyPyY8nvaQsk4LVXCVXwFamA9ZwVJVkerM7egmLWib9j5gqIp2s3kLWwu1SKu+dasXt
         k/jQ==
X-Gm-Message-State: AOAM530yPZdxz9vtXKYI7rELAHxJ38ZK+R9TCHRhsm9BxY33eLBln4oS
        qwRjlR1q+6bj6NNrfl6Yksd9/SIitnFVvmZMz6XpAA==
X-Google-Smtp-Source: ABdhPJwDnzLFeaMM3vjCSO3lZp7gcjwlzFJbkZbWJ0eVtVzU5k1Yg7tmuQq8lpaKfnSxiGBG64eQ1u51TtuwpUIFjTU=
X-Received: by 2002:a92:6011:: with SMTP id u17mr29418ilb.274.1619119616029;
 Thu, 22 Apr 2021 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183210.2557462-1-dlatypov@google.com> <CABVgOSnGC=15FXcRz0CKYTgY=-vFxWCWBGqLg7uGCNs8wgW2Dw@mail.gmail.com>
In-Reply-To: <CABVgOSnGC=15FXcRz0CKYTgY=-vFxWCWBGqLg7uGCNs8wgW2Dw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 22 Apr 2021 12:26:44 -0700
Message-ID: <CAGS_qxr16JNasdZvqtBOcUZKhadWN8U85WHTWTM=iFxQsqWTpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:52 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Apr 22, 2021 at 2:32 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Add in:
> > * kunit_kmalloc_array() and wire up kunit_kmalloc() to be a special
> > case of it.
> > * kunit_kcalloc() for symmetry with kunit_kzalloc()
> >
> > This should using KUnit more natural by making it more similar to the
> > existing *alloc() APIs.
> >
> > And while we shouldn't necessarily be writing unit tests where overflow
> > should be a concern, it can't hurt to be safe.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This seems like a good addition to me: a bug and a couple of useless
> asides below.

"bug" = the kzalloc/kcalloc mixup in doc comments?
Not sure if I'm overlooking one of your replies.

>
> Apart from the "kzalloc"/"kcalloc" confusion in the comment below, this is
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> >  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++----
> >  lib/kunit/test.c     | 22 ++++++++++++----------
> >  2 files changed, 44 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 49601c4b98b8..7fa0de4af977 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -577,16 +577,30 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
> >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
> >
> >  /**
> > - * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
> > + * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
> >   * @test: The test context object.
> > + * @n: number of elements.
> >   * @size: The size in bytes of the desired memory.
> >   * @gfp: flags passed to underlying kmalloc().
> >   *
> > - * Just like `kmalloc(...)`, except the allocation is managed by the test case
> > + * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
> >   * and is automatically cleaned up after the test case concludes. See &struct
> >   * kunit_resource for more information.
> >   */
> > -void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
> > +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
> > +
> > +/**
> > + * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
> > + * @test: The test context object.
> > + * @size: The size in bytes of the desired memory.
> > + * @gfp: flags passed to underlying kmalloc().
> > + *
> > + * See kmalloc() and kunit_kmalloc_array() for more information.
> > + */
> > +static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +{
> > +       return kunit_kmalloc_array(test, 1, size, gfp);
>
> Do we want to implement kunit_kmalloc() in terms of kunit_kmalloc_array()?
> It's interestingly backwards given that kmalloc_array() is implemented
> in terms of kmalloc().

I didn't want to have the checked multiply in test.c, and figured the
little bit of extra indirection probably won't hurt.
(Insert hopes about sufficiently smart compilers optimizing out some of it).

> The other option would be to have each kunit_* function wrap the
> actual function that's called, but that would introduce a lot of code
> duplication for a very small performance benefit.
>
> I'm happy with it the way it is now that I've looked through the
> implementations, but I was a little uneasy at first that some of these
> functions might not actually call the function they're theoretically
> wrapping.
>
> > +}
> >
> >  /**
> >   * kunit_kfree() - Like kfree except for allocations managed by KUnit.
> > @@ -601,13 +615,27 @@ void kunit_kfree(struct kunit *test, const void *ptr);
> >   * @size: The size in bytes of the desired memory.
> >   * @gfp: flags passed to underlying kmalloc().
> >   *
> > - * See kzalloc() and kunit_kmalloc() for more information.
> > + * See kzalloc() and kunit_kmalloc_array() for more information.
> >   */
> >  static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> >  {
> >         return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
> >  }
> >
> > +/**
> > + * kunit_kzalloc() - Just like kunit_kmalloc_array(), but zeroes the allocation.
>
> The function is called kunit_kcalloc(), but the documentation comment
> calls it kunit_kzalloc().
> Copy + paste error from above?

Good catch, fixed.

>
> > + * @test: The test context object.
> > + * @n: number of elements.
> > + * @size: The size in bytes of the desired memory.
> > + * @gfp: flags passed to underlying kmalloc().
> > + *
> > + * See kcalloc() and kunit_kmalloc_array() for more information.
> > + */
> > +static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
> > +{
> > +       return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
> > +}
> > +
> >  void kunit_cleanup(struct kunit *test);
> >
> >  void kunit_log_append(char *log, const char *fmt, ...);
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index ec9494e914ef..052fccf69eef 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -540,41 +540,43 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> >
> > -struct kunit_kmalloc_params {
> > +struct kunit_kmalloc_array_params {
> > +       size_t n;
>
> It's worth noting that we never actually use this after the resource
> is created. kmalloc_array() discards 'n' after the overflow check and
> multiply anyway.
>
> Of course, we don't need 'size' either, and we were already tracking
> that. I guess it's just an overhead of the resource system, so nothing
> worth actually changing here.

Ack, yeah, we don't need any of these params after the allocation
happens, including gfp.
But we're not "tracking it:, I don't think?

The _free() function calls `kfree(res->data)`, so we're only keeping
around the pointer itself while the resource is alive.
The context object is only around for the init call.

It's also an object on the stack that goes out of scope after we
return from kunit_kmalloc_array(), so I think we'd have a bug if we
were trying to keep it around.

>
>
>
> >         size_t size;
> >         gfp_t gfp;
> >  };
> >
> > -static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> > +static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
> >  {
> > -       struct kunit_kmalloc_params *params = context;
> > +       struct kunit_kmalloc_array_params *params = context;
> >
> > -       res->data = kmalloc(params->size, params->gfp);
> > +       res->data = kmalloc_array(params->n, params->size, params->gfp);
> >         if (!res->data)
> >                 return -ENOMEM;
> >
> >         return 0;
> >  }
> >
> > -static void kunit_kmalloc_free(struct kunit_resource *res)
> > +static void kunit_kmalloc_array_free(struct kunit_resource *res)
> >  {
> >         kfree(res->data);
> >  }
> >
> > -void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
> >  {
> > -       struct kunit_kmalloc_params params = {
> > +       struct kunit_kmalloc_array_params params = {
> >                 .size = size,
> > +               .n = n,
> >                 .gfp = gfp
> >         };
> >
> >         return kunit_alloc_resource(test,
> > -                                   kunit_kmalloc_init,
> > -                                   kunit_kmalloc_free,
> > +                                   kunit_kmalloc_array_init,
> > +                                   kunit_kmalloc_array_free,
> >                                     gfp,
> >                                     &params);
> >  }
> > -EXPORT_SYMBOL_GPL(kunit_kmalloc);
> > +EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
> >
> >  void kunit_kfree(struct kunit *test, const void *ptr)
> >  {
> >
> > base-commit: 16fc44d6387e260f4932e9248b985837324705d8
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
> >
