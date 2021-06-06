Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A445939CE7D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFFJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:59:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37EC061766;
        Sun,  6 Jun 2021 02:57:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k25so16074585eja.9;
        Sun, 06 Jun 2021 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC1rujwsbQmamgvNRPbIbF24joJdDinHk/7XHINbO0c=;
        b=gyHuPdhrqs1nAEgo+2CUlprqYA6IqLUsOzM9pbCzxHuCGVEOeGLmEg2CLmVGFaxQv8
         HmQZEMruYVJ2c/4aCgVBt0KwGGyLzuaNBqFQ7ZUZtwNXs19PadfrC8WXiLEVpK6RZV9B
         4fOON9I2Ke0/ivAOva3Z/whL7pmhULW37oqI2l2+7qGdPCk58RZgymqR3Xjonys0LAZI
         wg9cdBShDdiTNQGxl6v8GPJLsbLZDEAnLXUrZYAj0MGA9L0Oom0jgP47p//zQuQHS0b6
         GUAys5kfBOQuKxPmRVdYhu6ZW99NeqCaG9aObEwnl1CEoZ/Ps2SpEbkkPy3Z9JCBAzdP
         aQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC1rujwsbQmamgvNRPbIbF24joJdDinHk/7XHINbO0c=;
        b=OgHfZyOrixb/QS02+We7g2lhxt/TL4cm6wDC+e8Q8OvNIaald+B5HFIWP5+4x8eZHo
         xQZPLJBnkTOGI/8dQliST6Zd9+yBIuG8fBL3VJa/iiQMZHBpSBRliNCVm1P1Ms4oK5Lh
         ml4/gvc5d+Nr7/A5AE0by0zBNo/vsq+5NuQMlcRyOVD6m1SI4/lk0jVcKxgYxqO2VSQa
         3v+Rh3Lf3xshbq0AwB6bktIfE/xk6GdEbXQdrpvV+nYR/h3xfYtGOQJUvTWPEfKn1R/8
         vfh5fU9PtoCcQylHqQIjpzvOf79MCWSKBJp1xaZeKbW2dWL+/ZXuvborIH1EsFvZJtAL
         76ug==
X-Gm-Message-State: AOAM530pmg8E+niQX87objfeJCIKn22tsRN0Kj9L6ATdDpcsmsjhrOC4
        zuivPyRPVVYB7Fuk/yIweAxDADHlDnrxHW9HSAc=
X-Google-Smtp-Source: ABdhPJz/B97tCo3o8tyDcj8HCJtfE7Xn7BasTjOrPAd3ULHuk1y1okmOxGHc1xRASfOhgbRy+VtZAgG6tJTB8nPG8dI=
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr12949705ejb.227.1622973424580;
 Sun, 06 Jun 2021 02:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210606005531.165954-1-davidgow@google.com>
In-Reply-To: <20210606005531.165954-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 6 Jun 2021 12:56:53 +0300
Message-ID: <CA+fCnZdzki-0vMgbsjrXBz7Uqwh+vo9L6tXCAfiyMpVjV3tV=g@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
To:     David Gow <davidgow@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 3:55 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
> compare fail_data.report_expected and fail_data.report_found. This
> always gave a somewhat useless error message on failure, but the
> addition of extra compile-time checking with READ_ONCE() has caused it
> to get much longer, and be truncated before anything useful is displayed.
>
> Instead, just check fail_data.report_found by hand (we've just set
> report_expected to 'true'), and print a better failure message with
> KUNIT_FAIL(). Because of this, report_expected is no longer used
> anywhere, and can be removed.
>
> Beforehand, a failure in:
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
> would have looked like:
> [22:00:34] [FAILED] vmalloc_oob
> [22:00:34]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:991
> [22:00:34]     Expected ({ do { extern void __compiletime_assert_705(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}_ONCE()."))); if (!((sizeof(fail_data.report_expected) == sizeof(char) || sizeof(fail_data.repp
> [22:00:34]     not ok 45 - vmalloc_oob
>
> With this change, it instead looks like:
> [22:04:04] [FAILED] vmalloc_oob
> [22:04:04]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:993
> [22:04:04]     KASAN failure expected in "((volatile char *)area)[3100]", but none occurred
> [22:04:04]     not ok 45 - vmalloc_oob
>
> Also update the example failure in the documentation to reflect this.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v2:
> https://lkml.org/lkml/2021/6/4/1264
> - Update the example error in the documentation
>
> Changes since v1:
> https://groups.google.com/g/kasan-dev/c/CbabdwoXGlE
> - Remove fail_data.report_expected now that it's unused.
> - Use '!' instead of '== false' in the comparison.
> - Minor typo fixes in the commit message.
>
> The test failure being used as an example is tracked in:
> https://bugzilla.kernel.org/show_bug.cgi?id=213335
>
>
>
>  Documentation/dev-tools/kasan.rst |  9 ++++-----
>  include/linux/kasan.h             |  1 -
>  lib/test_kasan.c                  | 11 +++++------
>  3 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index d3f335ffc751..83ec4a556c19 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -447,11 +447,10 @@ When a test fails due to a failed ``kmalloc``::
>
>  When a test fails due to a missing KASAN report::
>
> -        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
> -        Expected kasan_data->report_expected == kasan_data->report_found, but
> -        kasan_data->report_expected == 1
> -        kasan_data->report_found == 0
> -        not ok 28 - kmalloc_double_kzfree
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:974
> +        KASAN failure expected in "kfree_sensitive(ptr)", but none occurred
> +        not ok 44 - kmalloc_double_kzfree
> +
>
>  At the end the cumulative status of all KASAN tests is printed. On success::
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b1678a61e6a7..18cd5ec2f469 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -17,7 +17,6 @@ struct task_struct;
>
>  /* kasan_data struct is used in KUnit tests for KASAN expected failures */
>  struct kunit_kasan_expectation {
> -       bool report_expected;
>         bool report_found;
>  };
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..44e08f4d9c52 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -55,7 +55,6 @@ static int kasan_test_init(struct kunit *test)
>         multishot = kasan_save_enable_multi_shot();
>         kasan_set_tagging_report_once(false);
>         fail_data.report_found = false;
> -       fail_data.report_expected = false;
>         kunit_add_named_resource(test, NULL, NULL, &resource,
>                                         "kasan_data", &fail_data);
>         return 0;
> @@ -94,20 +93,20 @@ static void kasan_test_exit(struct kunit *test)
>             !kasan_async_mode_enabled())                                \
>                 migrate_disable();                                      \
>         KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));    \
> -       WRITE_ONCE(fail_data.report_expected, true);                    \
>         barrier();                                                      \
>         expression;                                                     \
>         barrier();                                                      \
> -       KUNIT_EXPECT_EQ(test,                                           \
> -                       READ_ONCE(fail_data.report_expected),           \
> -                       READ_ONCE(fail_data.report_found));             \
> +       if (!READ_ONCE(fail_data.report_found)) {                       \
> +               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "  \
> +                               "expected in \"" #expression            \
> +                                "\", but none occurred");              \
> +       }                                                               \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                         \
>                 if (READ_ONCE(fail_data.report_found))                  \
>                         kasan_enable_tagging_sync();                    \
>                 migrate_enable();                                       \
>         }                                                               \
>         WRITE_ONCE(fail_data.report_found, false);                      \
> -       WRITE_ONCE(fail_data.report_expected, false);                   \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> --
> 2.32.0.rc1.229.g3e70b5a671-goog

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
