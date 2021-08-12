Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17273EA11B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhHLI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhHLI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC46C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so6894460otd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gv+4JbEnb1Tuank6FYqN4BwpsesLnaVYrFHSVUYTt60=;
        b=jTu6zz6RUb1gbBqdMULl0qErX83W6gUXly1h3vhVvFu9Qi4nyg3wT+fiRHGZ8UPxX+
         KuC1lhJ4WS8UYXJyDfNpxu3RZ4E6E1fogIsGws4Gc3pGBXl+k5DX2BsfzWtASzN1J5ES
         n63vfFcZdAyEHwx7pehw1VInh+a3EYF5+ThCsQK349DkGtXdP5lQcfTiTpJRVwKcTiRH
         wyVa9cSYC9aA7vk04ifhkEJEo8Qd7xZCcNR1p96fF5I9eAuHM701Z+891PWpJK3UpOs7
         fGVlvVuW4Sx6JoQ+n9kyEbqzLXpsXrb8yEvCR6EYB0GaMGaJvRyIGyolJ2qEx0nxzTW2
         TfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gv+4JbEnb1Tuank6FYqN4BwpsesLnaVYrFHSVUYTt60=;
        b=uBDI5F8JlwveNrgCuZWIvI5Tgr0chstv1oidVywYEaEm+8j8K4a1y5qNHecTjUFvtC
         6+eq4DiX2hsrB3XxhnR3bvXGBcrxxjKQA3fn9me1pDtX7OFNjovrohC9QCgmluNRpszZ
         wneYbPeJNNDXvEF2a2NYLVfsYULofzmbjoqT0SZQABPfkFVAKqnFlQGMNZ/uHpw+CdHT
         Ep5vaBN+lwLi+c1J7bqXNZcsJVh878m1pVfbxeOKgy/fWHa3A4LfAXVx1KJShUpUR/LB
         MPrRbwnTdO4EvpluQnrrfrgZqWBUoIR5k1lb0+B4by9bLya7MK7hpdNDmBcbTefH8viK
         E1zg==
X-Gm-Message-State: AOAM533ruhZDBAbRYPx0JqlE2Av2dZYDmk26bnrrds3GF/AhxWAnvBxc
        ODAr8U60GZW3mvQqZa61OwxTqyHTm965HeK3gdLUxA==
X-Google-Smtp-Source: ABdhPJxC6z46EVSjUnWZESNoiJFqfWOMsZN5vFYH5kfIu3dDzTdL4gB0Yf/2z7qKhMk1qomj4Ll/2I33poS8NXT0Fv0=
X-Received: by 2002:a9d:6f99:: with SMTP id h25mr2624406otq.17.1628758642497;
 Thu, 12 Aug 2021 01:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <c3cd2a383e757e27dd9131635fc7d09a48a49cf9.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <c3cd2a383e757e27dd9131635fc7d09a48a49cf9.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:57:11 +0200
Message-ID: <CANpmjNM6hn8UrozaptUacuNJ7EtsprDJWDmOk-F6BaNZ6Hgchg@mail.gmail.com>
Subject: Re: [PATCH 2/8] kasan: test: avoid writing invalid memory
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Multiple KASAN tests do writes past the allocated objects or writes to
> freed memory. Turn these writes into reads to avoid corrupting memory.
> Otherwise, these tests might lead to crashes with the HW_TAGS mode, as it
> neither uses quarantine nor redzones.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

although if you need a write primitive somewhere that doesn't corrupt
memory, you could use atomic_add() or atomic_or() of 0. Although
technically that's a read-modify-write. For generic mode one issue is
that these are explicitly instrumented and not through the compiler,
which is only a problem if you're testing the compiler emits the right
instrumentation.


> ---
>  lib/test_kasan.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 1bc3cdd2957f..c82a82eb5393 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -167,7 +167,7 @@ static void kmalloc_node_oob_right(struct kunit *test)
>         ptr = kmalloc_node(size, GFP_KERNEL, 0);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
>         kfree(ptr);
>  }
>
> @@ -203,7 +203,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         kfree(ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void kmalloc_pagealloc_invalid_free(struct kunit *test)
> @@ -237,7 +237,7 @@ static void pagealloc_oob_right(struct kunit *test)
>         ptr = page_address(pages);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
>         free_pages((unsigned long)ptr, order);
>  }
>
> @@ -252,7 +252,7 @@ static void pagealloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         free_pages((unsigned long)ptr, order);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void kmalloc_large_oob_right(struct kunit *test)
> @@ -514,7 +514,7 @@ static void kmalloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         kfree(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, *(ptr + 8) = 'x');
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
>  }
>
>  static void kmalloc_uaf_memset(struct kunit *test)
> @@ -553,7 +553,7 @@ static void kmalloc_uaf2(struct kunit *test)
>                 goto again;
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]);
>         KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>
>         kfree(ptr2);
> @@ -700,7 +700,7 @@ static void ksize_unpoisons_memory(struct kunit *test)
>         ptr[size] = 'x';
>
>         /* This one must. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[real_size] = 'y');
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size]);
>
>         kfree(ptr);
>  }
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/c3cd2a383e757e27dd9131635fc7d09a48a49cf9.1628709663.git.andreyknvl%40gmail.com.
