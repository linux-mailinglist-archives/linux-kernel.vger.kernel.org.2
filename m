Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850A935052A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCaQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:59:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:59:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w70so20712909oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZftGjdCUXY+05ORZ/0TVog0hvFmuHoMzmlE5jZV4Tc=;
        b=lPsNsAflRfDN9BHED2vwwFOhw6hY9W+aG2jWeG92q3sTTD0vmhelOEiJ37ORNAjO4o
         cgN9/6Z2jFRZ4WnsPLjTjuMR0RdkzgFp0XboTwL0Coefeg40oPx15GrNbNI9yn69E7pp
         arVK1k5JOmR5MgUmdtnh/+rZhNiPjSp196y6w4XsjBqH9DaTIup3A+sSi/7j3D/jHKyD
         fnkm7XqhBMlWJTExdkAIUdJl99hBWBvB3LKKiIGksSuNjl/iwUkDzmIY6Lw95v3ER5gl
         E+TygSzkCxcNGlWLBRCjaD6vI7ITcfvSmXTltqn7qBpwi6Af8cfnU2Z569Yd3YXo4RjO
         FCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZftGjdCUXY+05ORZ/0TVog0hvFmuHoMzmlE5jZV4Tc=;
        b=plw6EjRLjvVCCGb+0S4LSMGQyphFQ/OROdo+1MX79xos+qaTe/M/MW4Mrng/Tpzm7X
         DTCExtFDEZQnmV329QJb3EUD1dYBmX+0MInx8GGU+Z2TwrSTZyS2CUbRpmdMbLm09D9R
         +EARnAnKqUAWFHQ2XeE5sMlHA5xrJ6Ku8icrSClUJnowIsDMwTg4nI4xJVyv9/K5ildY
         gAf21wbEp0E0IQi+lfi7+wKpwWSnNCo9LR61TKyqgQp6B4H7UCZ3ojAmN75pMLLQo2p2
         BoKzlgszoKgAxeShvYeOden+2Rg/FW/g3xAN580JR653cwW/pFQTloGXspkxQb2/x46c
         eQSg==
X-Gm-Message-State: AOAM533uhikkveKn7PQGUudtVwfH5xFVv+Kj2bTl3x+/2MxkXSGPI01p
        FwEBaXW05CiqXNLM1Tss14NABT0LNGrpDBZSpQ0Hxw==
X-Google-Smtp-Source: ABdhPJwCjLKSSi1/qdcV75GsJNcLlMA0Fv+O5DpIf5jWkUTXDpgz4chaMVhWYqj39CXKRF8meV4oldegxoKwO6Jr3VU=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr2893534oif.121.1617209944150;
 Wed, 31 Mar 2021 09:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <48079c52cc329fbc52f4386996598d58022fb872.1617207873.git.andreyknvl@google.com>
In-Reply-To: <48079c52cc329fbc52f4386996598d58022fb872.1617207873.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 31 Mar 2021 18:58:52 +0200
Message-ID: <CANpmjNMpT0rYKfywkGvqLy8tk3iP6wAuGxHpHVJA77+EG4c5Gg@mail.gmail.com>
Subject: Re: [PATCH] kasan: detect false-positives in tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 at 18:25, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently, KASAN-KUnit tests can check that a particular annotated part
> of code causes a KASAN report. However, they do not check that no unwanted
> reports happen between the annotated parts.
>
> This patch implements these checks.
>
> It is done by setting report_data.report_found to false in
> kasan_test_init() and at the end of KUNIT_EXPECT_KASAN_FAIL() and then
> checking that it remains false at the beginning of
> KUNIT_EXPECT_KASAN_FAIL() and in kasan_test_exit().
>
> kunit_add_named_resource() call is moved to kasan_test_init(), and the
> value of fail_data.report_expected is kept as false in between
> KUNIT_EXPECT_KASAN_FAIL() annotations for consistency.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  lib/test_kasan.c | 49 +++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index d77c45edc7cd..bf9225002a7e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -54,6 +54,10 @@ static int kasan_test_init(struct kunit *test)
>
>         multishot = kasan_save_enable_multi_shot();
>         kasan_set_tagging_report_once(false);
> +       fail_data.report_found = false;
> +       fail_data.report_expected = false;
> +       kunit_add_named_resource(test, NULL, NULL, &resource,
> +                                       "kasan_data", &fail_data);
>         return 0;
>  }
>
> @@ -61,6 +65,7 @@ static void kasan_test_exit(struct kunit *test)
>  {
>         kasan_set_tagging_report_once(true);
>         kasan_restore_multi_shot(multishot);
> +       KUNIT_EXPECT_FALSE(test, fail_data.report_found);
>  }
>
>  /**
> @@ -78,28 +83,30 @@ static void kasan_test_exit(struct kunit *test)
>   * fields, it can reorder or optimize away the accesses to those fields.
>   * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
>   * expression to prevent that.
> + *
> + * In between KUNIT_EXPECT_KASAN_FAIL checks, fail_data.report_found is kept as
> + * false. This allows detecting KASAN reports that happen outside of the checks
> + * by asserting !fail_data.report_found at the start of KUNIT_EXPECT_KASAN_FAIL
> + * and in kasan_test_exit.
>   */
> -#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {         \
> -       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))                   \
> -               migrate_disable();                              \
> -       WRITE_ONCE(fail_data.report_expected, true);            \
> -       WRITE_ONCE(fail_data.report_found, false);              \
> -       kunit_add_named_resource(test,                          \
> -                               NULL,                           \
> -                               NULL,                           \
> -                               &resource,                      \
> -                               "kasan_data", &fail_data);      \
> -       barrier();                                              \
> -       expression;                                             \
> -       barrier();                                              \
> -       KUNIT_EXPECT_EQ(test,                                   \
> -                       READ_ONCE(fail_data.report_expected),   \
> -                       READ_ONCE(fail_data.report_found));     \
> -       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                 \
> -               if (READ_ONCE(fail_data.report_found))          \
> -                       kasan_enable_tagging();                 \
> -               migrate_enable();                               \
> -       }                                                       \
> +#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {                 \
> +       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))                           \
> +               migrate_disable();                                      \
> +       KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));    \
> +       WRITE_ONCE(fail_data.report_expected, true);                    \
> +       barrier();                                                      \
> +       expression;                                                     \
> +       barrier();                                                      \
> +       KUNIT_EXPECT_EQ(test,                                           \
> +                       READ_ONCE(fail_data.report_expected),           \
> +                       READ_ONCE(fail_data.report_found));             \
> +       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                         \
> +               if (READ_ONCE(fail_data.report_found))                  \
> +                       kasan_enable_tagging();                         \
> +               migrate_enable();                                       \
> +       }                                                               \
> +       WRITE_ONCE(fail_data.report_found, false);                      \
> +       WRITE_ONCE(fail_data.report_expected, false);                   \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
