Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386C42478C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhJFTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhJFTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:55:34 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0911C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:53:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id w10so3997326ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke7yEH2hK5KBpYKWsUTNu4WMWbcJmQ9TH0O3bOJ/VYY=;
        b=dzKYbeud7sCM0spGW62HJMMmtxBf0MQfKr3Tyoz4yKGuesPabkWla81xfS9BSUGzhY
         hBHgBbX1C7LASi+dSrbGWnOb42WKA291fAUYIL+OlFJvqAWWIE5JRyPS3+npng1aQr+n
         oS+HDuI1XExDXGbIgaXimJQFUSC//7AjUoMl4Wm6hPsVxKBWNqRva6r8W6OlY2qhBGkR
         GThXFaFIw2kch3ZScb5tSvlgGKOLvNgjIwbdl2D0XZnIu+fPT9GXyYmKUjK0E5VuMPev
         rr34ymFeD3acwAyif3H7GRN357K2Iz1/WuG51zO7XzrKzVF6TxbjlDpMkva9nSKhNWyu
         Lv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke7yEH2hK5KBpYKWsUTNu4WMWbcJmQ9TH0O3bOJ/VYY=;
        b=jr7v/Ul3IdC7Oj1Xoo9Fs1nk4HWxq4Le6VcQqG/WELqVUT2/KCZKicndjiwShuiqDe
         1bnjl5+YYOW6dhJzWlQsyUNO436O04ievPP12C/UNoSKQYGZAmELdQZ6zdm9y0GL5zAS
         FLsK+EmCRtv9h6x5g3ZTRXDK3bJT/4/WudzC3VwE9xN4zCac6LUk95J7lv7gS1mdWY8y
         FSVJpIMVsBUAVcpQxXXB7rut7S7gne5ZchzKCHxmHJJwKwEdGCiCuvMYHJVxo57dlSlV
         jzEkI0m+X819OldBpYMPWVdFxdFxL6CPeMIoTiMyyE8w8TWMwXxVRXaYV28dY3eiZB/l
         VUCA==
X-Gm-Message-State: AOAM5304u2j7a3wIMH7F53WBth/zpSDlHSoL1i6tBSBQv7beBbl/I9OS
        WsC35OqvVx5f1kkNvrmbeSUjgkIjom/Ko0LcMlA9JQ==
X-Google-Smtp-Source: ABdhPJxj7YM6zAhj3AQS4Q/zgfQhrgo26Y9VqawaYzjMzEgFaAJKMhiYKDICb4tFIkvfF/WUJrUGvUG4TP28XNINk9w=
X-Received: by 2002:a05:6e02:1c4e:: with SMTP id d14mr34205ilg.121.1633550021310;
 Wed, 06 Oct 2021 12:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211006044111.2147359-1-davidgow@google.com>
In-Reply-To: <20211006044111.2147359-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 6 Oct 2021 12:53:29 -0700
Message-ID: <CAGS_qxqFULDPy65kk9=H23RJk+BWr+dsUD9fBnm3pQn2zU9KcQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Reset suite count after running tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 9:41 PM David Gow <davidgow@google.com> wrote:
>
> There are some KUnit tests (KFENCE, Thunderbolt) which, for various
> reasons, do not use the kunit_test_suite() macro and end up running
> before the KUnit executor runs its tests. This means that their results
> are printed separately, and they aren't included in the suite count used
> by the executor.
>
> This causes the executor output to be invalid TAP, however, as the suite
> numbers used are no-longer 1-based, and don't match the test plan.
> kunit_tool, therefore, prints a large number of warnings.
>
> While it'd be nice to fix the tests to run in the executor, in the
> meantime, reset the suite counter to 1 in __kunit_test_suites_exit.
> Not only does this fix the executor, it means that if there are multiple
> calls to __kunit_test_suites_init() across different tests, they'll each
> get their own numbering.
>
> kunit_tool likes this better: even if it's lacking the results for those
> tests which don't use the executor (due to the lack of TAP header), the
> output for the other tests is valid.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I had been hoping we could pass in a kunit_context object of sorts to
__kunit_test_suites_init() and exit.
That feels like that would be the right place to store this counter in
the future.

But that's currently blocked on the aforementioned tests going outside
the executor and using these funcs directly.
So for now, this seems like the simplest and most sensible fix.

I wonder if we should add a TODO about the counter...
But eh, it was already a static variable before, so this isn't really
increasing the hackiness too much.

> ---
>  lib/kunit/test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f246b847024e..3bd741e50a2d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -190,10 +190,10 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>
> +static size_t kunit_suite_counter = 1;
> +
>  static void kunit_print_subtest_end(struct kunit_suite *suite)
>  {
> -       static size_t kunit_suite_counter = 1;
> -
>         kunit_print_ok_not_ok((void *)suite, false,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
> @@ -583,6 +583,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
>
>         for (i = 0; suites[i] != NULL; i++)
>                 kunit_exit_suite(suites[i]);
> +
> +       kunit_suite_counter = 1;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>
> --
> 2.33.0.800.g4c38ced690-goog
>
