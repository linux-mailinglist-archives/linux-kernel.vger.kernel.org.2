Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5843D155
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhJ0TCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhJ0TCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:02:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:00:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e144so4991957iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXKCRvYW+G/U3lCt5Bb406ecBZvxMrSVY/Zc9yEqb98=;
        b=JzW/KRnOs36+qiUImtSUHxPTHogPFxD/HyvIaGOpbyqDP6UWSNjZESlNnNXdG7qc5r
         AOJvgF/J0F2v8NdyUM12Ek/0kcHtSCoWu+9psXlZgl3FfrIYxAMmmSxStB4ilq2L8ikc
         0DCCVMyvRYI4Mx9kTv2gUUgUORl3/jSUAhEPAxbhKIaUnkBSBA3ERg6Uu7V4l/TcebPs
         CMMTrLHzggpXA+tyFPDCrLNZwkr8hPpltgN+vF5CZaJpU+K5YILQR8VuxCGyHQw0X8Z2
         fY48qUx1qErXd7uz1QwwT3ML5p10B2ZC9yx1KqX2egWksVNV/+GpsF/R+pvj0HSkc081
         h2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXKCRvYW+G/U3lCt5Bb406ecBZvxMrSVY/Zc9yEqb98=;
        b=1djpz7auh909jgmtHBs0mZOER/1mSlMJ3wPDUZc6XY0w4W8NLH4bj6V/GJOb53l1Jq
         gfCPAUBxqRqt2HbmLqFbC5GSmTMdo8v4JdX2apEgbZK0skpDojq6HM/dwmymdel7FiSW
         oogwnUOm6FvPObSX+l7ISXMahJx/ILWW8riBnJQ53Oa2Y1dzktjXed9Q6u/c4M+7vvAc
         AJfNmXl7QjUPzS1N+aJ04fpIjN8uDR13w3HVBkeB/76FL4CGQenJ/a/uH64DOyTgwDXA
         /L5Psn2eceJDG/mvT3CgQKxcFML/85k/zLO0LaLKA2+eUXzeLOqRkvtPkpGAXMY+PlKN
         IcWw==
X-Gm-Message-State: AOAM531MeajUwtUYlo4YRfB05sAVMxkEDA+Ihx8XRckzPe9dcqwAkfND
        dfB8isyfO8n+nfC4AXDZ8Y1M7rBanNfdN/CEA5VmXA==
X-Google-Smtp-Source: ABdhPJxLBNMYnPhlvTfJ3h65LeVfM2OrbYYAMCXnwzpGjtBk+VleJKFtur6a+yaGJ4iS8fBHLaAPxgfPIb/Ybswfaik=
X-Received: by 2002:a02:a907:: with SMTP id n7mr15849878jam.96.1635361207311;
 Wed, 27 Oct 2021 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com> <20211027013702.2039566-3-davidgow@google.com>
In-Reply-To: <20211027013702.2039566-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 27 Oct 2021 11:59:55 -0700
Message-ID: <CAGS_qxqbJd+8U4TQCusmcNND0vdUCF2EJqBqXhtx3NBt4KAAGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: Don't crash if no parameters are generated
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

On Tue, Oct 26, 2021 at 6:37 PM David Gow <davidgow@google.com> wrote:
>
> It's possible that a parameterised test could end up with zero
> parameters. At the moment, the test function will nevertheless be called
> with NULL as the parameter. Instead, don't try to run the test code, and
> just mark the test as SKIPped.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bd741e50a2d..e028d98e4f5b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -500,7 +500,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>         kunit_print_subtest_start(suite);
>
>         kunit_suite_for_each_test_case(suite, test_case) {
> -               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               /* The initial param value is nonzero, as we want
> +                * non-parametrised tests to run once.
> +                */
> +               struct kunit test = { .param_value = (void *)-1, .param_index = 0 };

(Not a strong preference)

Hmm, I'd slightly prefer we don't set a dummy value of -1 for this.
I personally think something like this is a bit less subtle:

/* Run non-parameterised tests once */
while (!test_case->generate_param || test.param_value) {

  if (!test_case->generate_param) break;
}

Alternatively, we don't need to share the loop

if (!test_case->generate_param) {
  kunit_run_case_catch_errors(suite, test_case, &test);
  kunit_update_stats(&param_stats, test.status);
} else while (test_param.value) {
   kunit_run_case_catch_errors(suite, test_case, &test);
   kunit_update_stats(&param_stats, test.status);
   /* print subtest and advance next param */
}

}


>                 struct kunit_result_stats param_stats = { 0 };
>                 test_case->status = KUNIT_SKIPPED;
>
> @@ -510,7 +513,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         test.param_value = test_case->generate_params(NULL, param_desc);
>                 }
>
> -               do {
> +               while (test.param_value) {
>                         kunit_run_case_catch_errors(suite, test_case, &test);
>
>                         if (test_case->generate_params) {
> @@ -530,11 +533,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 param_desc[0] = '\0';
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
> -                       }
> +                       } else
> +                               test.param_value = NULL;
>
>                         kunit_update_stats(&param_stats, test.status);
>
> -               } while (test.param_value);
> +               }
>
>                 kunit_print_test_stats(&test, param_stats);
>
> --
> 2.33.0.1079.g6e70778dc9-goog
>
