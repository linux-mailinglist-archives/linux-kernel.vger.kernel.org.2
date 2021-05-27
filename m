Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746439296E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhE0IXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhE0IXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:23:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:22:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so3804660wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AhqvpsgmWy2utZlqk5NzWiQ2z3M3gpksG7TnXtqeGI=;
        b=luW6ubII76vBnT2s6nkHUfGzZJWQrjTCwJ5KYrMuaTV9rpuj7v1ybUL2SylCnFcIpb
         //Gw6xZ3ys9MsL907hsknXI/N5rYDjmwpa3r6fLy8auZCoJFLQiIYVKrGHHVGKg8q5Xg
         tl/MKTR59m6QGA/pY4SnvtHu9QXUPaEhC+PmeUyzHmRUezJF5j1IRwe9aFJ9wnSpUx0H
         IogYsSDK+vO7mLvGPL1i1la00sgwWp1KNW5W/1iqgvC1uF5zZhh+g8yPBPyY7hYm0gDZ
         LpIQE2oGSObRBHBNqEEjieGKSwk0lNKJXvhrIHe9VOaBZ46cv32/Asd0r3MX6GZNjm/o
         qQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AhqvpsgmWy2utZlqk5NzWiQ2z3M3gpksG7TnXtqeGI=;
        b=BpvLH32fn3+4DdfYWRby7hm1ZImvoip39m/Sr8Y/x2nP+QWVgM8SBGpjBcguynBouC
         vhqB3NY4BNvkMdVfzo9Vol3u2PGEfYlF2E22DfK8UdR0xdZ+JqrBvCU+5noCV1Zecy33
         HBml7ZdmPg67B+B/0K2UaZvJpldyQjGrlfwnzbpMbf29CGFPH+VG8tnoMkOjUurxn5QK
         WMCh+0MZrd9VHhOEEf5VjNDjBIF3EVGJTaw2C0JBNcDxPDkuxxrXSmIlabeOYOcyik2E
         pXdXgMSTAI5V48c3XSc+cuU0NbaD2Coj7vGRAxJ10rf3ilVsxtmEkuqRsaC5flwfRcrK
         xd3Q==
X-Gm-Message-State: AOAM531sVQixV/1Rg5RaeAWlOJLR+sZEwKplfWddn+1ptP10ughU6Xb6
        jqNdcDdh2oeBYq8D67RPFV0gYwuyYthd3RUNitZ+/A==
X-Google-Smtp-Source: ABdhPJxPCQalwyeBkXjY/Yb/DJyH/zBayTrgJ3+jS7bW8/5z88RmZqOeU6CNi0ikb2rBvRbsuE4Q+xDChb4Du7thstk=
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr2067742wrx.302.1622103727662;
 Thu, 27 May 2021 01:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <YK4O1DkP1/DKzVU5@elver.google.com>
In-Reply-To: <YK4O1DkP1/DKzVU5@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 May 2021 16:21:56 +0800
Message-ID: <CABVgOS=Tw1NkUfh1pDfo-3stAKqg_Pt0EtM7+rH2Qk6EUw2+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Support skipped tests
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 5:03 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> > The kunit_mark_skipped() macro marks the current test as "skipped", with
> > the provided reason. The kunit_skip() macro will mark the test as
> > skipped, and abort the test.
> >
> > The TAP specification supports this "SKIP directive" as a comment after
> > the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> > spec for details:
> > https://testanything.org/tap-specification.html#directives
> >
> > The 'success' field for KUnit tests is replaced with a kunit_status
> > enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> > 'status_comment' containing information on why a test was skipped.
> >
> > A new 'kunit_status' test suite is added to test this.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> [...]
> >  include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
> >  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
> >  lib/kunit/test.c       | 51 ++++++++++++++++++-------------
> >  3 files changed, 134 insertions(+), 27 deletions(-)
>
> Very nice, thank you.
>
>         Tested-by: Marco Elver <elver@google.com>
>
> , with the below changes to test_kasan.c. If you would like an immediate
> user of kunit_skip(), please feel free to add the below patch to your
> series.
>
> Thanks,
> -- Marco
>

Thanks! I'll add this to the next version.

Cheers,
-- David

> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Wed, 26 May 2021 10:43:12 +0200
> Subject: [PATCH] kasan: test: make use of kunit_skip()
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/test_kasan.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..0a2029d14c91 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> -       if (!IS_ENABLED(config)) {                                      \
> -               kunit_info((test), "skipping, " #config " required");   \
> -               return;                                                 \
> -       }                                                               \
> +       if (!IS_ENABLED(config))                                        \
> +               kunit_skip((test), "Test requires " #config "=y");      \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {                 \
> -       if (IS_ENABLED(config)) {                                       \
> -               kunit_info((test), "skipping, " #config " enabled");    \
> -               return;                                                 \
> -       }                                                               \
> +       if (IS_ENABLED(config))                                         \
> +               kunit_skip((test), "Test requires " #config "=n");      \
>  } while (0)
>
>  static void kmalloc_oob_right(struct kunit *test)
> --
> 2.31.1.818.g46aad6cb9e-goog
>
