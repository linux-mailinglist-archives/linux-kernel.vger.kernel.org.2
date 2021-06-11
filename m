Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8EE3A3DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhFKIbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhFKIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:31:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A5C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:29:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso2387008oto.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf8gmgxDEja2VX8BBJ31GggEPRL+26RHGowvXy4R87Q=;
        b=IdfGgzEbPKbtaowN3D+j5bQFqjvkGUSfOIepWudnKs2bo2YBN3oZpOiJu/UIDvRFGR
         c8WnxZJNuw+QHrZW6sp+8u/KPiXcWM68Mz7A3Y7/mlAm8/AWbr9paPos3hB6xB/zCBfc
         Gnk+iS/PX9wvJGyooNf/qZXWpc7j2WEhsV5C8Y44pfY+QslbFI38BN/1TGAhXLqRlf4S
         i199sL4ijBidTs35uMg23a5G2KR46eUDOffO5JR5eSE5UURH6MH+P3gNrOh5/MTr3POI
         ETotYEGUPVt1V8JbIwVqIqzurwaHAO337N1vSsT5RfQgAkmBuP3rVvkZDJxp2dEvoxe0
         e4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf8gmgxDEja2VX8BBJ31GggEPRL+26RHGowvXy4R87Q=;
        b=rG8m2K+rUff6SFy1dDK0C4hes1tb6wIo0tFNtOq+RYclffvQqbOcxF8ybZREPbMRCf
         v74Xg5wsDMAggOVwQdjVo+3trwUVJkqkr7lpbjltGTlL8UqQss92cxhPtC5IeKxRSFnx
         gxg40p+W2T/0V6OBaNoe+PwxcgTOB/xU2WtI1/Di/s6DhtoYjiDcHuzxhSFs0tWktWqg
         M0+GaUbvKech6TXlDDtPjwPe2psTawB7X+PPnsbVItxyZZiJsRcbm2iyqSDOE+8sov55
         4tFE6fElMSQ167CqC5ozINeTDZ942y+cyxHYZwU1YyS2bXd4XRVaFNlrRGJd6D2jDNNv
         BD9A==
X-Gm-Message-State: AOAM532E3NFWzyQfT/iV0Gb3T7iaV20JdLVH8a1zCNORB3kd8JmfVDBD
        roRflPd5T7ye2GqgwvGTV3nc+X8qaBn6GI3SW5CIoEN3rHIXVw==
X-Google-Smtp-Source: ABdhPJxoMOWFgmPb10tQ9a1JSiVR87YNN9CB1LgjYZ9UZsVv9BU90+wEqcXnPGuGFnbHAhyjPn0M8PhFdUuF3pk37ZM=
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr2145347otg.233.1623400173600;
 Fri, 11 Jun 2021 01:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210611035725.1248874-1-davidgow@google.com>
In-Reply-To: <20210611035725.1248874-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Jun 2021 10:29:22 +0200
Message-ID: <CANpmjNOvLz=71PXSi+LGvKZ+9b_rfY1+wp8HfeyZa8u2QZURcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix result propagation for parameterised tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 at 05:57, David Gow <davidgow@google.com> wrote:
>
> When one parameter of a parameterised test failed, its failure would be
> propagated to the overall test, but not to the suite result (unless it
> was the last parameter).
>
> This is because test_case->success was being reset to the test->success
> result after each parameter was used, so a failing test's result would
> be overwritten by a non-failing result. The overall test result was
> handled in a third variable, test_result, but this was disacarded after
> the status line was printed.
>
> Instead, just propagate the result after each parameter run.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")

Reviewed-by: Marco Elver <elver@google.com>

Would Cc: stable be appropriate?

Thanks,
-- Marco

> ---
>
> This is fixing quite a serious bug where some test suites would appear
> to succeed even if some of their component tests failed. It'd be nice to
> get this into kunit-fixes ASAP.
>
> (This will require a rework of some of the skip tests work, for which
> I'll send out a new version soon.)
>
> Cheers,
> -- David
>
>  lib/kunit/test.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 2f6cc0123232..17973a4a44c2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -376,7 +376,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         context.test_case = test_case;
>         kunit_try_catch_run(try_catch, &context);
>
> -       test_case->success = test->success;
> +       test_case->success &= test->success;
>  }
>
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -388,7 +388,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> -               bool test_success = true;
> +               test_case->success = true;
>
>                 if (test_case->generate_params) {
>                         /* Get initial param. */
> @@ -398,7 +398,6 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 do {
>                         kunit_run_case_catch_errors(suite, test_case, &test);
> -                       test_success &= test_case->success;
>
>                         if (test_case->generate_params) {
>                                 if (param_desc[0] == '\0') {
> @@ -420,7 +419,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         }
>                 } while (test.param_value);
>
> -               kunit_print_ok_not_ok(&test, true, test_success,
> +               kunit_print_ok_not_ok(&test, true, test_case->success,
>                                       kunit_test_case_num(suite, test_case),
>                                       test_case->name);
>         }
> --
> 2.32.0.272.g935e593368-goog
>
