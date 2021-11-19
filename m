Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA14570C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhKSOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhKSOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:39:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:36:17 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z26so12980199iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3UlTJrvd9wmoZcXID/TPD0zD7tHGOLcuQUqvmY9UHk=;
        b=kSPHLFXVWfzWglKACW4IQ1sWePw7oEXzQO7hndWLP7OmApguWnkuYU8/Xwa2yDY2vN
         wmz57OvC4RYDxzYNroeOA03UauNZtu0lV7xl0UP/fxOESZK6jWV3dOZET1VMTNnNVQ6M
         YhdOnt+eqp3r8+fm93rXsDAEwJKl5+cqgbJF10+UBaUiGkxxnOZLtMhxIQkGlO9gmoRr
         ZczfEabzLHmT+EzHPY3YczhJIqWMOLLmntpR3SI+1RluJN5TbYKZF7jaAhu1rpC6FXMA
         W1XgHWS9Dp9HozuvF9yU+PEcRIYA0Bj+GOPdavzRWpwYI8ML2rmCIUpABDBCbBddZPiw
         4SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3UlTJrvd9wmoZcXID/TPD0zD7tHGOLcuQUqvmY9UHk=;
        b=NJ6bJvjOn9JOYqkMPQ8hHjcwhggtwySC8eVHgxcLc8t4fyDQUEF5WWwaRfueDhmVWr
         K6qVucjsl56p8A7OkwCajb06X6UfOesmqmqOw1jjGhKEUuT6aUGVzgFHV6XfkmK25mjT
         dfGPF258mY6i1geIQHiJbNkgufxJtLHHw7RkgyErpWIv0IqK/et2uKyxO1SOCZ3VLRKG
         haVBTbdU3O1ERy162bfjltgpNfnE5iqRynNCLCTjjAdCVCPqohiAF8N+EVsWVoUT5fVN
         o1SSxoe+aQcm8yYheyjFt+dE1B4FdLYGjkb71McrwpeBqP5O7WwRZa1UiLGLESpnxSj0
         je5A==
X-Gm-Message-State: AOAM531ZditjmVt/AC53JLU25iYDufn6FMP/OB6Uw++ySFa7kPJ+M+4x
        o5r6R9/a185XCfu+YCVuJXc952I3f4vN87BAJROP9jpWU1g=
X-Google-Smtp-Source: ABdhPJxYIb29H5/N4PP6Hk1ou+ayTZqWgvtG3irnnOOFXkfqXb5bbtUNRsJProIfPntAcGTGiAojHNXwON3406kEx3Q=
X-Received: by 2002:a05:6638:2257:: with SMTP id m23mr28211802jas.17.1637332577526;
 Fri, 19 Nov 2021 06:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20211119142219.1519617-1-elver@google.com> <20211119142219.1519617-2-elver@google.com>
In-Reply-To: <20211119142219.1519617-2-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 19 Nov 2021 15:36:06 +0100
Message-ID: <CA+fCnZdKLrniF4ru8G5=hkm4M6YYm3RJz6wFcNqD2hPC8Trj-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: test: add test case for double-kmem_cache_destroy()
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 3:22 PM Marco Elver <elver@google.com> wrote:
>
> Add a test case for double-kmem_cache_destroy() detection.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/test_kasan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 40f7274297c1..4da4b214ed06 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -866,6 +866,16 @@ static void kmem_cache_invalid_free(struct kunit *test)
>         kmem_cache_destroy(cache);
>  }
>
> +static void kmem_cache_double_destroy(struct kunit *test)
> +{
> +       struct kmem_cache *cache;
> +
> +       cache = kmem_cache_create("test_cache", 200, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +       kmem_cache_destroy(cache);
> +       KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
> +}
> +
>  static void kasan_memchr(struct kunit *test)
>  {
>         char *ptr;
> @@ -1183,6 +1193,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(ksize_uaf),
>         KUNIT_CASE(kmem_cache_double_free),
>         KUNIT_CASE(kmem_cache_invalid_free),
> +       KUNIT_CASE(kmem_cache_double_destroy),
>         KUNIT_CASE(kasan_memchr),
>         KUNIT_CASE(kasan_memcmp),
>         KUNIT_CASE(kasan_strings),
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
