Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5A3D81C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhG0V1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhG0V1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:27:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D1C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:27:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so37736plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbC4CnAGhIybz0QpeAKp5Yhqb1PUtsv1V9KJ08c/8uk=;
        b=D4x0DCEvQEcRLpMZ3199nKxrfxtCg2Fv17RfK1L+4o/YRZzp6jyDPJtBpX1gqSEEXO
         oy0hVGojwm1E04VeMxSVLETU5XMdNLzXVSpDAQzQjbWJYJ2KpqeX3vbSIZzqWsSnu2De
         r6Z4NRx9X4pc1vXCfuVScEe9TiEd7n2W6WySY1F0CE6vrC5kIHXqJ4rWKKC7dgFYWKYI
         b7db7QI7CY7S8+Uotb9i1ASp76qqF/pCkE422W3iPYgfVhPJL6WQBVzr0y28YROxVQaS
         cMUGTZOY3AMtsSLGttd2MkZrxzOZS51lNC1KJoYKYXZ05YiXwgmT7ktbyPUY+I9dHRpW
         UeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbC4CnAGhIybz0QpeAKp5Yhqb1PUtsv1V9KJ08c/8uk=;
        b=isSl5vfVwlPhirhgYqo0BkJm3ndWAlfw3BIGC66e0NtBtcIskWPJotjyzzFVo4W5CO
         tRDK7lVWPfPSMipgZJ65pRuWqSa1iRRBbXawdXZgVs261tz+B7Pv1TW/aTAyFvbthhrK
         FVRy+vsiizxsZ6FuQ6ovimCqPmgkhcFUnXikwupJZA/ddmS88QwHBd5740/9MtZrON97
         IUDigFbpb8l1fw46cggTEQWDyAaq7MKM61kaJGvim4p2QC6EEJ10pr2gXx+dDEUy7sM3
         W6i0hUaQoKJdX0cazSKaFNj/n5FL+PGGmNdVKL7bphwmknWHE16mB3wh373flJ4h6bzL
         IeeQ==
X-Gm-Message-State: AOAM531zvU8MWuImhyE0iHMEKtjyZiZT8Rv21KvkG9gwl+CZH8ZVd48+
        IVhFXYUXbqZtxE1CPuKiwjB7/PmViW83XArqL0OcVQ==
X-Google-Smtp-Source: ABdhPJxIvqQAc97j6gkS+i1Q92AEuoQQU8+SCR8/1r5vrZ2e4SkBYHJYGnEGNZgq3yh8FMCvp+nHgEFrFvKz5miHy3o=
X-Received: by 2002:a65:6a01:: with SMTP id m1mr25726632pgu.201.1627421221155;
 Tue, 27 Jul 2021 14:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723212353.896343-1-bvanassche@acm.org> <20210723212353.896343-4-bvanassche@acm.org>
In-Reply-To: <20210723212353.896343-4-bvanassche@acm.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Jul 2021 14:26:49 -0700
Message-ID: <CAFd5g45X2WhZD++XjRFi=k0HvLonFDCFdC7zRQ9igVhzXQ5T3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Add support for suite initialization and cleanup
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 2:24 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Yanko Kaneti <yaneti@declera.com>

Please also CC davidgow@google.com, skhan@linuxfoundation.org,
kunit-dev@googlegroups.com, and linux-kselftest@vger.kernel.org for
KUnit changes in the future.

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

This seems pretty sensible.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/test.h |  4 ++++
>  lib/kunit/test.c     | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 24b40e5c160b..a6eef96a409c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -215,6 +215,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
>   * @name:      the name of the test. Purely informational.
> + * @init_suite:        called once per test suite before the test cases.
> + * @exit_suite:        called once per test suite after all test cases.
>   * @init:      called before every test case.
>   * @exit:      called after every test case.
>   * @test_cases:        a null terminated array of test cases.
> @@ -229,6 +231,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  struct kunit_suite {
>         const char name[256];
> +       int (*init_suite)(void);
> +       void (*exit_suite)(void);

I like this idea. Many other unit testing libraries in other languages
have something similar.

I think it probably makes sense to not use any kind of context object
here (as you have done); nevertheless, I still think it is an
appropriate question for the list.

>         int (*init)(struct kunit *test);
>         void (*exit)(struct kunit *test);
>         struct kunit_case *test_cases;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d79ecb86ea57..c271692ced93 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -397,9 +397,19 @@ int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
>         struct kunit_case *test_case;
> +       int res = 0;
>
>         kunit_print_subtest_start(suite);
>
> +       if (suite->init_suite)
> +               res = suite->init_suite();
> +
> +       if (res < 0) {
> +               kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT
> +                         "# Suite initialization failed (%d)\n", res);
> +               goto end;
> +       }
> +
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
>                 test_case->status = KUNIT_SKIPPED;
> @@ -439,6 +449,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                       test.status_comment);
>         }
>
> +       if (suite->exit_suite)
> +               suite->exit_suite();
> +
> +end:
>         kunit_print_subtest_end(suite);
>
>         return 0;
