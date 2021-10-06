Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E704247F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhJFUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhJFUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:34:28 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 13:32:36 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t11so4111783ilf.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVNksAJFkBNnt0Itxo70/XTASUaBIQQiHVWmEPi7rxo=;
        b=RFoOw8QExdkGjA0wn1/2YVuVQUbUfz/hRVOoZLQ6vlu07nA1YMNcUtlg181gUhmgGj
         ANPIav51r7JYTLqVcJvRGOlUOnOTWoGz4UCxVJ4cZCdOuKJHiPXp9lTFoOzHHV9a5oiu
         zrvCmZt9/FvemSwpszyQdBnzu/RxVM7NI4nGLe3seL6OPZaeLwAvhbyUuv675BanK1oG
         JtmiNlInrscS/tUq1C3wThQgUvjJm1nM75r6QfX6Xj0PT1lpZ8tzaXBPV1y8BcwphK90
         Sb5tcmoUTaiU49fUxDRs8TbXPeErLsa92OkxOpswCJoXyLarj+SIq2STZbR3/Ba8xp/d
         gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVNksAJFkBNnt0Itxo70/XTASUaBIQQiHVWmEPi7rxo=;
        b=ibYKNs/dKjZz7kOq0ZcCt4CIsK8WsJGiEHF36bo7lvoGLBe59AynJx/FvFZHg7laI+
         wIGz8//PLdygQHqica4pWO8lU/eREua+ClYd2J4L3N+h59/JhYUkoYsT9tdBFCtevPgB
         jP7EO3OmM7pv1e+/rTq9ZUJeJqcr32Y9X5/GI/f8t2nxrDXBbwp+wq2Hmu1+lirfR7P/
         A3N8OEC1E9FvLrJdWCX2OdAlfhBpV6h7RZFamZhItjNzOHK2SXmOPwoxv3DZYuhex8wA
         7WzC5NvMviw4TVmGK8dY74CNtLAFRK3yIuKbivQEJgTVD8uIUhlsMfqUuuX5uFEdHq2u
         04wQ==
X-Gm-Message-State: AOAM530FnWTNIvZBaSnQGqQ4NdLQf4lqL/bjNIM1WkGfP2rDO3Kd3nc2
        gISPBBriCPJrSUcvTA1LaQxERqqiNbAzhON/++MBoQ==
X-Google-Smtp-Source: ABdhPJzzxRZmUdYUtBAhBxJNdmbWg0ZnTg8SLkNRfVXpL8VlqmDAYxWZUZmyk677RKIQ5RASHpmhOwk8hvEvb3KhjRM=
X-Received: by 2002:a92:b301:: with SMTP id p1mr185432ilh.10.1633552355347;
 Wed, 06 Oct 2021 13:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071112.2206942-1-davidgow@google.com>
In-Reply-To: <20211006071112.2206942-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 6 Oct 2021 13:32:24 -0700
Message-ID: <CAGS_qxodEp+HwWJCEaz39T-QEOxhev5a0KjLx+nUfbuM-ZLOcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Report test parameter results as (K)TAP subtests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 12:11 AM David Gow <davidgow@google.com> wrote:
>
> Currently, the results for individial parameters in a parameterised test
> are simply output as (K)TAP diagnostic lines. However, the plan was
> always[1] to make these (K)TAP subtests when kunit_tool supported them.
>
> With [2], these are now supported. (v5 will print out an error about the
> missing plan line, but this can safely be ignored, and will hopefully be
> changed). As a result, individual test parameter results are parsed,

Hmm, I'd rather not condition users to ignore warnings.
It's possible we can get this all fixed up in time for 5.16, but we
have quite a bit we're trying to get in already, so I'm not sure.


> displayed in the formatted results, and counted for test statistics.
>
> [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f246b847024e..02a9fdadcae2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         test.param_value = test_case->generate_params(NULL, param_desc);
> +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                                 "# Subtest: %s", test_case->name);
>                 }
>
>                 do {
> @@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 }
>
>                                 kunit_log(KERN_INFO, &test,
> -                                         KUNIT_SUBTEST_INDENT
> -                                         "# %s: %s %d - %s",
> -                                         test_case->name,
> +                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                                         "%s %d - %s",
>                                           kunit_status_to_ok_not_ok(test.status),
>                                           test.param_index + 1, param_desc);
>
> --
> 2.33.0.800.g4c38ced690-goog
>
