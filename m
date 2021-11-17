Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FB45418B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhKQHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhKQHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:03:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D05C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:00:47 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s139so4241095oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmHhPvzXYRq4QxQbLd7/J2OjVDAM7gnWOdWR2WZAeoU=;
        b=MqfKvny131SOomjGJL858hbl1u6rrS2cG4NdbqI55M8U5C4TKJeplMf2SBOKkE21NC
         SOWLLuexJFf7+ky/Q09+Y8LkRhNibWBlgtMs0lAQJubCH8+oQsKZTVbnr+Hhs/Rg4Nds
         vUou7Mxiki5uYYEAcOREAjw9phCURauTt5DAqDR1CE9/aFyLQwOkKxrOl9lelzO2wgF4
         37sR5VUrGJrtNdMqvH8lBgVFsRNwT9dF3TFAJnMItjeE9kZmIH7sm690iZesgZR2oLSS
         Ak3FcPIYiA9quKULT7sTaCeP2inaDUB/hv96ZYVUhy8OhMWw+gs0boJNbqAxjeJNRDOr
         r7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmHhPvzXYRq4QxQbLd7/J2OjVDAM7gnWOdWR2WZAeoU=;
        b=Tz8UZl6zVz4j7AradAcmB/EW6BIFgNuNY4LgRGTuTzc4LJMVDQMj4pFLQHtbaaR6u4
         4kL4KNn9pAB4ba0mG4h3An6ZKu2+sTvYswxjR2N1ymwNXczblzlFlZKRuIzpjiDT5qOZ
         0FFA1tJSjC7Sz7c9IQChyY/PwlTNjtT5dXMybuc7AUD1m4V22/3EcOR1K0GD1XWIyB2g
         PnH/bTpdN8TAopNwAO40uCNfpgZJiDlxf0Scc1DC5DSrIm9e522ZRNPJe3QIOsQAqrtv
         6NWlU5t95E2t2/jV4jiuTT/66QS7cRVZIlGS9cNZM8KDtAo73LqkwbM5xi+by2HIQE9N
         hfUg==
X-Gm-Message-State: AOAM532b9WzmkkWPrPS/SYP7m6SCtqGqoLO6S5GGCKqIHx/cUFVcxXxF
        9v+aVW9TLt+ONKcALnSythvZEqOcwJHkkZ+2YyqT3g==
X-Google-Smtp-Source: ABdhPJy46zdowgx7i+k5t0OSYtgOmSgrusV3KffgbNewBAPjKcBA/xOn34Whjp399ZQ98icEeO7oDD9lusulVyQy5r8=
X-Received: by 2002:aca:af50:: with SMTP id y77mr1173117oie.134.1637132446743;
 Tue, 16 Nov 2021 23:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20211116004111.3171781-1-keescook@chromium.org>
In-Reply-To: <20211116004111.3171781-1-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Nov 2021 08:00:00 +0100
Message-ID: <CANpmjNMdUJj3YZ6Bb-pDmcwe73axzuVpvQs_WNcQLnKBE-0Agw@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Silence intentional read overflow warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 01:41, Kees Cook <keescook@chromium.org> wrote:
> As done in commit d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
> for __write_overflow warnings, also silence some more cases that trip
> the __read_overflow warnings seen in 5.16-rc1[1]:
>
> In file included from /kisskb/src/include/linux/string.h:253,
>                  from /kisskb/src/include/linux/bitmap.h:10,
>                  from /kisskb/src/include/linux/cpumask.h:12,
>                  from /kisskb/src/include/linux/mm_types_task.h:14,
>                  from /kisskb/src/include/linux/mm_types.h:5,
>                  from /kisskb/src/include/linux/page-flags.h:13,
>                  from /kisskb/src/arch/arm64/include/asm/mte.h:14,
>                  from /kisskb/src/arch/arm64/include/asm/pgtable.h:12,
>                  from /kisskb/src/include/linux/pgtable.h:6,
>                  from /kisskb/src/include/linux/kasan.h:29,
>                  from /kisskb/src/lib/test_kasan.c:10:
> In function 'memcmp',
>     inlined from 'kasan_memcmp' at /kisskb/src/lib/test_kasan.c:897:2:
> /kisskb/src/include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   263 |                         __read_overflow();
>       |                         ^~~~~~~~~~~~~~~~~
> In function 'memchr',
>     inlined from 'kasan_memchr' at /kisskb/src/lib/test_kasan.c:872:2:
> /kisskb/src/include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   277 |                 __read_overflow();
>       |                 ^~~~~~~~~~~~~~~~~
>
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/14660585/log/
>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Fixes: d73dad4eb5ad ("kasan: test: bypass __alloc_size checks")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Marco Elver <elver@google.com>

Thanks for the quick fix!

> ---
>  lib/test_kasan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 67ed689a0b1b..0643573f8686 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -869,6 +869,7 @@ static void kasan_memchr(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_ptr_result = memchr(ptr, '1', size + 1));
>
> @@ -894,6 +895,7 @@ static void kasan_memcmp(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         memset(arr, 0, sizeof(arr));
>
> +       OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_int_result = memcmp(ptr, arr, size+1));
>         kfree(ptr);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20211116004111.3171781-1-keescook%40chromium.org.
