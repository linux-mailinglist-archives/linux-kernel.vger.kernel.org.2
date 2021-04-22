Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E336798B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhDVFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDVFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:53:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12103C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:52:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m7so39615375ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdGMkI9TGwXlU6z5h6cFrk4sNZEl6jH28J5xJfUfohc=;
        b=grtyIGRCq8GeZXFKc+5NDCuphq69TNdSOxX0J4jsRhiSbfK7O2IdP2HkLn1XK+jRYp
         e0lzfNr4Npxloev11ezIrXjWn94FxoIlPz1zZ7+M230PTlqyGBLOAkF/HKRX5aAHys+4
         SKqBeYNyA/ftwXMu4Y6Ieal1KjI8qJPCFERwpQXKRL22/jC/TatZJyCRQbbOdUe/agWC
         8UJhy1pKQYpe7EO1dtOFBdBxGOpYfWXhx0aSWY1zcJgbfN2aRSifKS7EUvv9ICSe0OzW
         q3Ku2vfqBto14DUtNORxUv05N1PaEboopbFRk8dNZwoQfqB+OTvBxmLJgqW7sDHbxqqA
         zoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdGMkI9TGwXlU6z5h6cFrk4sNZEl6jH28J5xJfUfohc=;
        b=qs79yD+qfgubiQcIywe8qJbIegxOkAe0ihL+sX+/M2cay/rUyQbLisZfb+EojKqbg/
         j06OulztlW35oBIwTK6+lRHmhA3BXJtLhfnsvIi3mfUVZ+zHzso3WWzQ4Dh+gE4ab0fJ
         IuX4CUvGq3rTS6A+pw0kYpM1Rv4MRwq5YKl4MaEY5fJa/l6nVQ9R0Zot6jbr75BgVLkR
         5Cdcg6qEEU2Ax1r8i4sBs/loabH/90TsRliydCIzhVCygSnKJIGIUnZhyidKk9VGOVt3
         Xreh8crjfASmmovW0l8TbgNJp91PSVrql32U9OX34nuDSEiNddSoAIAz1Oy8Ibr3DU9C
         fZHg==
X-Gm-Message-State: AOAM530NbU/eRpaSOL8XOAbvvATkJEuk3p2VvZNWcYEP3JzTkvouSSOP
        JgW8Fi/G5LW0jc3fBSGzVCZ0Qc/I6DkYTr6dsA8H3w==
X-Google-Smtp-Source: ABdhPJwvWTYxTlk4IvCfUQEIf1sf5sPIA1JBr9l53MABGRGKiDvbUTMDUNC+NOtfj41XAHbFkZO/7L2iZyNDKj+58wY=
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr1346786ljj.490.1619070771358;
 Wed, 21 Apr 2021 22:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183210.2557462-1-dlatypov@google.com>
In-Reply-To: <20210421183210.2557462-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Apr 2021 13:52:39 +0800
Message-ID: <CABVgOSnGC=15FXcRz0CKYTgY=-vFxWCWBGqLg7uGCNs8wgW2Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
To:     Daniel Latypov <dlatypov@google.com>
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

On Thu, Apr 22, 2021 at 2:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Add in:
> * kunit_kmalloc_array() and wire up kunit_kmalloc() to be a special
> case of it.
> * kunit_kcalloc() for symmetry with kunit_kzalloc()
>
> This should using KUnit more natural by making it more similar to the
> existing *alloc() APIs.
>
> And while we shouldn't necessarily be writing unit tests where overflow
> should be a concern, it can't hurt to be safe.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This seems like a good addition to me: a bug and a couple of useless
asides below.

Apart from the "kzalloc"/"kcalloc" confusion in the comment below, this is
Reviewed-by: David Gow <davidgow@google.com>

-- David

>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++----
>  lib/kunit/test.c     | 22 ++++++++++++----------
>  2 files changed, 44 insertions(+), 14 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 49601c4b98b8..7fa0de4af977 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -577,16 +577,30 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
>  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
>
>  /**
> - * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
> + * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
>   * @test: The test context object.
> + * @n: number of elements.
>   * @size: The size in bytes of the desired memory.
>   * @gfp: flags passed to underlying kmalloc().
>   *
> - * Just like `kmalloc(...)`, except the allocation is managed by the test case
> + * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
>   * and is automatically cleaned up after the test case concludes. See &struct
>   * kunit_resource for more information.
>   */
> -void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
> +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
> +
> +/**
> + * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
> + * @test: The test context object.
> + * @size: The size in bytes of the desired memory.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * See kmalloc() and kunit_kmalloc_array() for more information.
> + */
> +static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> +{
> +       return kunit_kmalloc_array(test, 1, size, gfp);

Do we want to implement kunit_kmalloc() in terms of kunit_kmalloc_array()?
It's interestingly backwards given that kmalloc_array() is implemented
in terms of kmalloc().
The other option would be to have each kunit_* function wrap the
actual function that's called, but that would introduce a lot of code
duplication for a very small performance benefit.

I'm happy with it the way it is now that I've looked through the
implementations, but I was a little uneasy at first that some of these
functions might not actually call the function they're theoretically
wrapping.

> +}
>
>  /**
>   * kunit_kfree() - Like kfree except for allocations managed by KUnit.
> @@ -601,13 +615,27 @@ void kunit_kfree(struct kunit *test, const void *ptr);
>   * @size: The size in bytes of the desired memory.
>   * @gfp: flags passed to underlying kmalloc().
>   *
> - * See kzalloc() and kunit_kmalloc() for more information.
> + * See kzalloc() and kunit_kmalloc_array() for more information.
>   */
>  static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>  {
>         return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
>  }
>
> +/**
> + * kunit_kzalloc() - Just like kunit_kmalloc_array(), but zeroes the allocation.

The function is called kunit_kcalloc(), but the documentation comment
calls it kunit_kzalloc().
Copy + paste error from above?

> + * @test: The test context object.
> + * @n: number of elements.
> + * @size: The size in bytes of the desired memory.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * See kcalloc() and kunit_kmalloc_array() for more information.
> + */
> +static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
> +{
> +       return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
> +}
> +
>  void kunit_cleanup(struct kunit *test);
>
>  void kunit_log_append(char *log, const char *fmt, ...);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ec9494e914ef..052fccf69eef 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -540,41 +540,43 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
>  }
>  EXPORT_SYMBOL_GPL(kunit_destroy_resource);
>
> -struct kunit_kmalloc_params {
> +struct kunit_kmalloc_array_params {
> +       size_t n;

It's worth noting that we never actually use this after the resource
is created. kmalloc_array() discards 'n' after the overflow check and
multiply anyway.

Of course, we don't need 'size' either, and we were already tracking
that. I guess it's just an overhead of the resource system, so nothing
worth actually changing here.



>         size_t size;
>         gfp_t gfp;
>  };
>
> -static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> +static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
>  {
> -       struct kunit_kmalloc_params *params = context;
> +       struct kunit_kmalloc_array_params *params = context;
>
> -       res->data = kmalloc(params->size, params->gfp);
> +       res->data = kmalloc_array(params->n, params->size, params->gfp);
>         if (!res->data)
>                 return -ENOMEM;
>
>         return 0;
>  }
>
> -static void kunit_kmalloc_free(struct kunit_resource *res)
> +static void kunit_kmalloc_array_free(struct kunit_resource *res)
>  {
>         kfree(res->data);
>  }
>
> -void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>  {
> -       struct kunit_kmalloc_params params = {
> +       struct kunit_kmalloc_array_params params = {
>                 .size = size,
> +               .n = n,
>                 .gfp = gfp
>         };
>
>         return kunit_alloc_resource(test,
> -                                   kunit_kmalloc_init,
> -                                   kunit_kmalloc_free,
> +                                   kunit_kmalloc_array_init,
> +                                   kunit_kmalloc_array_free,
>                                     gfp,
>                                     &params);
>  }
> -EXPORT_SYMBOL_GPL(kunit_kmalloc);
> +EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
>
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
>
> base-commit: 16fc44d6387e260f4932e9248b985837324705d8
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
