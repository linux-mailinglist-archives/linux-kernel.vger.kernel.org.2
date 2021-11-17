Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35034546C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhKQNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbhKQNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:02:40 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:59:42 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l8so2659745ilv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FT+WTgntcUcOhdQh68NQbpJcx5eGcrjyuCTdifDbfTc=;
        b=T0SLV5Vak0BHlp3lNiwOfwLSjFJCkWriKOSMmmIlbrUM1s2gKo16l5j4nXES0zNUvP
         qEylCxSqiEXL9J+tsl6PvttSItH+Z3idq5ZXKiqIMzuV+JPT0twEucq23yghkSOZ6hpT
         y7aP26txPNx09jao6zjvsgFLtsJcnnF8fKoifS7187mSv36Aqc0bs54lVUzVaARH/Dbp
         fXH7MwdZAP2x1ZqY7UEajsH4Oe7V96TXqwDV9rxZRiKmRhmRDIbNNQ5wKxAYO6xFZIYy
         psF6nC8032YQAYl/XDc8Kq+F0wdusS0AynCu1wtbPTkA1U/vI+oNGlm+MN9QN5hDosE7
         b8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FT+WTgntcUcOhdQh68NQbpJcx5eGcrjyuCTdifDbfTc=;
        b=bV67BIQ03m8OeP7z76C0fFOACcezZ5UU2nGNLQSbj5gyysIDJTShsW5mpD6D4PWM5E
         AcdrLBc5qygIFyL5guTQZlqOd4mQXIElm5kFAwpTUAFUx0kufarC82ItpaEGJJotDjnM
         UITxbMMu+4zG1CURJEDuMn7peldj2J6HxB4AxVXf58o6hHE+t2cOF7ah+czVCk7uuLSO
         9O2Te38QjsBezRyAMAWUZFmFZIuGcCn2XfwP0LbTBK/qXjX+rZYYkgxuvEEJuBUOG7mK
         kmFlR33n5d7FZJXs2uZHliSP+PKI8cU60IMtBHMKfXSgP5+OT6rIB7nklg1I7WcKms4L
         GMNw==
X-Gm-Message-State: AOAM531j456V5SclI/JKZ6Pcv34RiBEPpx4QNA80JGRuhyvZvm1iqh4z
        eAZYGxWIW580asfb7xTp3KKkWBysmaRHND9XpLw=
X-Google-Smtp-Source: ABdhPJx8YHxYHux/ZSqYkkNgl/dqm48tf7DGiPYZ/9RP5WbW6fvAtvkfIAGLT+gOfzhv83ogUUjrW0TH9lnpP7pap64=
X-Received: by 2002:a05:6e02:1525:: with SMTP id i5mr10012820ilu.81.1637153981523;
 Wed, 17 Nov 2021 04:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20211117110916.97944-1-elver@google.com>
In-Reply-To: <20211117110916.97944-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 17 Nov 2021 13:59:30 +0100
Message-ID: <CA+fCnZcp3dFd3rwpLx6VUi2Yv9uqsWQyQNB6d3X-A7VgTjXUpw@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: add globals left-out-of-bounds test
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:09 PM Marco Elver <elver@google.com> wrote:
>
> Add a test checking that KASAN generic can also detect out-of-bounds
> accesses to the left of globals.
>
> Unfortunately it seems that GCC doesn't catch this (tested GCC 10, 11).
> The main difference between GCC's globals redzoning and Clang's is that
> GCC relies on using increased alignment to producing padding, where
> Clang's redzoning implementation actually adds real data after the
> global and doesn't rely on alignment to produce padding. I believe this
> is the main reason why GCC can't reliably catch globals out-of-bounds in
> this case.
>
> Given this is now a known issue, to avoid failing the whole test suite,
> skip this test case with GCC.
>
> Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Signed-off-by: Marco Elver <elver@google.com>

Hi Marco,

> ---
>  lib/test_kasan.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 67ed689a0b1b..69c32c91420b 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -700,7 +700,7 @@ static void kmem_cache_bulk(struct kunit *test)
>
>  static char global_array[10];
>
> -static void kasan_global_oob(struct kunit *test)
> +static void kasan_global_oob_right(struct kunit *test)
>  {
>         /*
>          * Deliberate out-of-bounds access. To prevent CONFIG_UBSAN_LOCAL_BOUNDS
> @@ -723,6 +723,19 @@ static void kasan_global_oob(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>
> +static void kasan_global_oob_left(struct kunit *test)
> +{
> +       char *volatile array = global_array;
> +       char *p = array - 3;
> +
> +       /*
> +        * GCC is known to fail this test, skip it.
> +        */

Please link the KASAN bugzilla issue here.

> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_CC_IS_CLANG);
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
> +       KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
> +}
> +
>  /* Check that ksize() makes the whole object accessible. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
> @@ -1160,7 +1173,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kmem_cache_oob),
>         KUNIT_CASE(kmem_cache_accounted),
>         KUNIT_CASE(kmem_cache_bulk),
> -       KUNIT_CASE(kasan_global_oob),
> +       KUNIT_CASE(kasan_global_oob_right),
> +       KUNIT_CASE(kasan_global_oob_left),
>         KUNIT_CASE(kasan_stack_oob),
>         KUNIT_CASE(kasan_alloca_oob_left),
>         KUNIT_CASE(kasan_alloca_oob_right),
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

Otherwise:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
