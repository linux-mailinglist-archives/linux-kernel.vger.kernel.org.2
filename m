Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF14546D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhKQNH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhKQNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:07:28 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9642C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:04:29 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 7so6181159oip.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQVwuxwEF7Twnep+EJ7g8xvuzr4jtUj3SWg3Cfbdhis=;
        b=liGg1iEPPGLbG4DDHieBsW7IY/rbPGxGqZEmBNhHtDmvF9w/ZZg2JGeimCDddk+omR
         tIJG/vpRh/HOVBAwy5T0IpVl6YOS8BJi62j5nEuMlCrnSxfxXhxlkam7jf1B2LlHf8h3
         ja+x3kmRJleXut4dCQN1rg3xV8pWcNkTNuXVKG2clvoUYxp9Qfqh+wSPdwChGsNS0I71
         9V85IKmLnXsteechcFeE+lWZRVTjJxwJE+FLHaQZa8Put2tHsnaPNPKSSddfhooy7xkX
         qtYwL+kCjJWO4t7oHR0lY6Wm4znk4v84qAk/bg4RXXVG67BKb1L79DwjvRkb6vepamFK
         REuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQVwuxwEF7Twnep+EJ7g8xvuzr4jtUj3SWg3Cfbdhis=;
        b=I8UEtcIJ/FNHwS+IGSG2P2RUMNfW0BlTa3U0DZ5xUGAJL2ZCnL7WryvDK6dzOu/Ws+
         X+9KqIxMGg8THnlix1pmGqwO3qhT3PPHNoTwPi31II6K/nWoBvyWB9dGiLlPsfRYE+eN
         k0gIQEFpM0KrRaI9mjaGAavymySaTLUkJ0G1GJGJR2bC6cUf50z1bfSiXgDz31C4cf2V
         cErjQ5Eh3lDAnICmwv9vxiAWG9GdcPg+rYCjIlF4H6RG3rnU4kW2OuKKPJTAJrhDr7cJ
         MgiZ/nug9DtHw5L0NLkbQ2ugffv9FRqVnMv8LUbDmg8U+zsQj+S33I6MtbdiYFCJBshY
         76/w==
X-Gm-Message-State: AOAM532ke0nThNVyMvB6vkcF0S7v6dJ2KAh8XFTv9iZfQEGYx6rGzcvi
        MJ8KS+qvz/vYbIdLM1ZmRVud1nAtStl7OSN3C6FlBg==
X-Google-Smtp-Source: ABdhPJw5kPCatNefewbxl2yN47Yk2Dxdh+s8FDIPYQfhcAQ6/Csum6NFTKMpxnABqhZYHhdQX9z31pCmKDgqsS+jKK0=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr49706426oib.7.1637154268831;
 Wed, 17 Nov 2021 05:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20211117110916.97944-1-elver@google.com> <CA+fCnZcp3dFd3rwpLx6VUi2Yv9uqsWQyQNB6d3X-A7VgTjXUpw@mail.gmail.com>
In-Reply-To: <CA+fCnZcp3dFd3rwpLx6VUi2Yv9uqsWQyQNB6d3X-A7VgTjXUpw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Nov 2021 14:04:17 +0100
Message-ID: <CANpmjNO3DMUmQGkSggibRYY_XmWzW9fDyVOSRC8AoPzmv+jE2A@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: add globals left-out-of-bounds test
To:     Andrey Konovalov <andreyknvl@gmail.com>
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

On Wed, 17 Nov 2021 at 13:59, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Wed, Nov 17, 2021 at 12:09 PM Marco Elver <elver@google.com> wrote:
> >
> > Add a test checking that KASAN generic can also detect out-of-bounds
> > accesses to the left of globals.
> >
> > Unfortunately it seems that GCC doesn't catch this (tested GCC 10, 11).
> > The main difference between GCC's globals redzoning and Clang's is that
> > GCC relies on using increased alignment to producing padding, where
> > Clang's redzoning implementation actually adds real data after the
> > global and doesn't rely on alignment to produce padding. I believe this
> > is the main reason why GCC can't reliably catch globals out-of-bounds in
> > this case.
> >
> > Given this is now a known issue, to avoid failing the whole test suite,
> > skip this test case with GCC.
> >
> > Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Hi Marco,
>
> > ---
> >  lib/test_kasan.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 67ed689a0b1b..69c32c91420b 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -700,7 +700,7 @@ static void kmem_cache_bulk(struct kunit *test)
> >
> >  static char global_array[10];
> >
> > -static void kasan_global_oob(struct kunit *test)
> > +static void kasan_global_oob_right(struct kunit *test)
> >  {
> >         /*
> >          * Deliberate out-of-bounds access. To prevent CONFIG_UBSAN_LOCAL_BOUNDS
> > @@ -723,6 +723,19 @@ static void kasan_global_oob(struct kunit *test)
> >         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
> >  }
> >
> > +static void kasan_global_oob_left(struct kunit *test)
> > +{
> > +       char *volatile array = global_array;
> > +       char *p = array - 3;
> > +
> > +       /*
> > +        * GCC is known to fail this test, skip it.
> > +        */
>
> Please link the KASAN bugzilla issue here.

I was wondering how to solve the cyclic dependency, because I wanted
to link this patch from the bugzilla.

Now that the bugzilla entry exists, I guess I can add it and then
update bugzilla with link to this patch closing the cycle. :-)

> > +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_CC_IS_CLANG);
> > +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
> > +}
> > +
> >  /* Check that ksize() makes the whole object accessible. */
> >  static void ksize_unpoisons_memory(struct kunit *test)
> >  {
> > @@ -1160,7 +1173,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
> >         KUNIT_CASE(kmem_cache_oob),
> >         KUNIT_CASE(kmem_cache_accounted),
> >         KUNIT_CASE(kmem_cache_bulk),
> > -       KUNIT_CASE(kasan_global_oob),
> > +       KUNIT_CASE(kasan_global_oob_right),
> > +       KUNIT_CASE(kasan_global_oob_left),
> >         KUNIT_CASE(kasan_stack_oob),
> >         KUNIT_CASE(kasan_alloca_oob_left),
> >         KUNIT_CASE(kasan_alloca_oob_right),
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
>
> Otherwise:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Thanks!
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CA%2BfCnZcp3dFd3rwpLx6VUi2Yv9uqsWQyQNB6d3X-A7VgTjXUpw%40mail.gmail.com.
