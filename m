Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9D39B468
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFDH6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:58:07 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42802 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhFDH6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:58:06 -0400
Received: by mail-oi1-f172.google.com with SMTP id v142so8534069oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FYrxsp7/ivfFHEEK/eqHTg8vJEKdX7/HfrYwN3SLOs=;
        b=MyR/FzU2TNuIHZtDQdid9elF/xS26/4llLMlykWzcujobZIfmo003Ns1fEPRdWPMQ+
         Uf1XVcy8Yc4oS0Qc4X5m03S3dT5xnlclH978U6XDdp7qsuwlQDYLGe5dekvh4py5Zk+I
         l/BxkUs8oB0Np/s6X5lHmhI4VKQLBXeYpYvbujsWzgmZ4T4tQViTuJCm/6prtcncJqvP
         +hNs1lmAwdfNxc8ETZBvuof89/PGU3vINTutYZCidL8XKNwOEgJEn7Jvgvy9NE93T21p
         K5SmNuBpGyz3JaFaIlWwqTXTc/rdHriLL7n/L9+0hC5e5igkvmBq85tv6KZoW1NeBFf7
         pdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FYrxsp7/ivfFHEEK/eqHTg8vJEKdX7/HfrYwN3SLOs=;
        b=WauPpXoHY7pss8Q7PoDSBzWHALFi18DBrFqVd3p3voQxpEgmaMpWSQq16MSvgFTkdK
         lTueMP/eCnH+Q+dzdgAjQhL/exMkcxzv8rhPQt+QDcsAd+D70MEzXfYrd2lByKvCEk7y
         GYmf34PSfuL+6O4jDmJt0PDerV0kJgO441T/jUwG3iIcv0zM36Um8Dtl14wiojJiXNwR
         wmJE2O8hAdbjfGjFRqq3AjOqBJ49oYBBmFxgISKxSmxkBq7UC//mYzsAs0ir1IZxZJGi
         Ie3o4zBUfCOz8s8FYFfuYTLUxl3ED1JJFlJ0FPTtB5HLcOC58HFG9QmshmanOEp1lUr5
         eHtw==
X-Gm-Message-State: AOAM532HMw+EiQ+KBaWGGAcPgxytIxDlT7KPGQX160SFg61ezYqEc6gD
        9tOTWmwWg+N275aiDuPiwlsR/3QY0TQ6CgmJryMvtw==
X-Google-Smtp-Source: ABdhPJyOCtRh6aY5+tiJWRSuMUVCd2UX/ifdxi5+fpDXHVHthv8Mm92k/LSEigvQ8RyI4LlX3MshVP5wdIVikkAIFNw=
X-Received: by 2002:a05:6808:10d4:: with SMTP id s20mr2243065ois.70.1622793320658;
 Fri, 04 Jun 2021 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210604052548.1889909-1-davidgow@google.com>
In-Reply-To: <20210604052548.1889909-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Jun 2021 09:55:09 +0200
Message-ID: <CANpmjNP3kK=YWEacvPr5RRen4YkSKL9akLn06Eq6H+azqSGimA@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
To:     David Gow <davidgow@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 07:26, 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
> compare fail_data.report_expected and fail_data.report_found. This
> always gave a somewhat useless error message on failure, but the
> addition of extra compile-time checking with READ_ONCE() has caused it
> to get much longer, and be truncated before anything useful is displayed.
>
> Instead, just check fail_data.report_found by hand (we've just test
> report_expected to 'true'), and print a better failure message with
> KUNIT_FAIL()
>
> Beforehand, a failure in:
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
> would looked like:
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
> ---
>
> Stumbled across this because the vmalloc_oob test is failing (i.e.,
> KASAN isn't picking up an error) under qemu on my system, and the
> message above was horrifying. (I'll file a Bugzilla bug for the test
> failure today.)
>
> Cheers,
> -- David
>
>  lib/test_kasan.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..deda13c9d9ff 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -98,9 +98,11 @@ static void kasan_test_exit(struct kunit *test)
>         barrier();                                                      \
>         expression;                                                     \
>         barrier();                                                      \
> -       KUNIT_EXPECT_EQ(test,                                           \
> -                       READ_ONCE(fail_data.report_expected),           \

What do we have fail_data.report_expected for? Could we remove it now?
I think it's unused now.

> -                       READ_ONCE(fail_data.report_found));             \
> +       if (READ_ONCE(fail_data.report_found) == false) {               \

if (!READ_ONCE(fail_data.report_found)) {
?

> +               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "  \
> +                               "expected in \"" #expression            \
> +                                "\", but none occurred");              \
> +       }                                                               \

Thanks,
-- Marco
