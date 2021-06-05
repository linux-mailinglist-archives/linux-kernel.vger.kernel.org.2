Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A005739CBB4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 01:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFEX10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 19:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFEX10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 19:27:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198DC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 16:25:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d13so2030807edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InZrcKArztFFxV4PZAOd+BMerw3Nx/ldUFLAqxjEv+o=;
        b=E4P2pFnlMgiwJU5mxDRYrN0XWkIpgL+YycUPvjkuFJc5n/KonnC2NV9jThjF/iWVgP
         lWsFJpVUncG0OEoD2/D2SqC7Bic9lPsJZtkBYco2XLmPdE0ha+xO9kbTDa6xWAifgKSO
         VFqCdgwSbYfwChmOIBbMDbrTmIayGCKZHfldU1/cjJJbnZZYhlWomeJUxTkYn6XtZb8S
         q6ZrhDP8M8l1/BXI88Pz/fkThou3M25gZtaRB1kT8xj+2jP4bcGOEZV+Vgp9AKd3Nk2j
         tlHWCa9qrYKALAh8+SspxDoFnBTgoGVv+AFRzzClPAU4+7aEsLvRu+7nXAnnzF2ML/oF
         ieKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InZrcKArztFFxV4PZAOd+BMerw3Nx/ldUFLAqxjEv+o=;
        b=F/PV077Ee2O2w9LGpY0qMBIwvLygeMZG8p5D51K7l3LMPQYYJBlrvIgGP92I/3+ptJ
         IqVPLrOrURzqKTjGGNhFKe2kZptPjYjv7YaNPnaE965U2PqsMNc25CUnwL6B3fnf/MP9
         kX4plFWcSAI2DkDOp2zct+4GK5OV+DWcaq98lEgk9vMlzzrqV2Kf11J5a0smezoH5hDn
         z8sFjsE3CT3IeQ/ha5jX4GVKtCwXjn4Mo/OgxchTnzT0iV9PzorCTMk91NsXo0nreYPY
         0b472ztgxS3oGBdYV/1N1otxwNtXRIrGUA9izsm0YdUhZIWOqJgqWlXVbjjTb2sZCuPT
         jaYw==
X-Gm-Message-State: AOAM530H4cbeMrnWB86JcKhhQynEurFypl6zRpLDM4pH+igBCQp82vjc
        rujo0aNeDabMSRDjRr8Nu7VpbqL/f8my+1M0D/c=
X-Google-Smtp-Source: ABdhPJyjW2xbxlX6vvJPM7+7/KbsRtaBrbCuxJt6eMpGbsknrpscDZ/XiT5xkh+DWrq7XzycqbdHV8zG7MElUQqS0rE=
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr12403960edc.168.1622935524421;
 Sat, 05 Jun 2021 16:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605034821.2098034-1-davidgow@google.com>
In-Reply-To: <20210605034821.2098034-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 6 Jun 2021 02:25:13 +0300
Message-ID: <CA+fCnZdAmVoGjTEQBoKQF0x_NtUau0jydSnF8bYHwDGRNFddHw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
To:     David Gow <davidgow@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 6:48 AM 'David Gow' via kasan-dev
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
> Signed-off-by: David Gow <davidgow@google.com>

Hi David,

Please also update the failure message in Documentation/dev-tools/kasan.rst.

Thank you!

> ---
> Changes since v1:
> https://groups.google.com/g/kasan-dev/c/CbabdwoXGlE
> - Remove fail_data.report_expected now that it's unused.
> - Use '!' instead of '== false' in the comparison.
> - Minor typo fixes in the commit message.
>
> The test failure being used as an example is tracked in:
> https://bugzilla.kernel.org/show_bug.cgi?id=213335
>
> Cheers,
> -- David
>
>  include/linux/kasan.h |  1 -
>  lib/test_kasan.c      | 11 +++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
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
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210605034821.2098034-1-davidgow%40google.com.
