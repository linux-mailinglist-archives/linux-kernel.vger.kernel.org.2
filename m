Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F12376122
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhEGH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhEGH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:29:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680EC061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:28:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id di13so9067017edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gIRV9p376yzYOkVLAM08wQ8Qd0j1vezQFGSOL7bIPg=;
        b=Hjd19bs6E8MXnI2GtquNirlemBMll7SfU+KUqj54EJK5w37nAxnhCMFhAU0QjzzNoE
         duT+zjhLzfKaEZDv675QrmotFHyCF6J+Tozi17yt843ctjlkPn7hU2tN+wIS16lBxcIr
         IkFu9uQr9Pq59OCHVRCJi4W2C/GrIypg1xnDOmzKmtAejc1/RSaedabcgFh20MMtNYGG
         905XfNEhy8VrqasgkNYZEMQ2vFR/jyc8ffJ1XX+bDu3kZ+Bjrhibb+R646oTOIB3OBIS
         /szeb0hvpqHZpS2wO4YbdMankOLRRO6pAzzxgFuC1sArBHkx/a0VvIHjK9PmAfPzecg0
         8pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gIRV9p376yzYOkVLAM08wQ8Qd0j1vezQFGSOL7bIPg=;
        b=moluo5agXNgGnTbBmTAjkaTtvzkAg9RUK2nO0Lmt270/UibDcuvNgC/wvJE/3WxrP/
         uAYHJVeAYf4xGAF3zr5K2g/E39sWbuqN1dZokut6feoVPT4Bs1Mxq//yJgMzua3W7weE
         kCAUKIEN52OnqkG5ZGLGUCSbz1a9k4Ehu90/jMcYAARydUL7XDZGC+dC62+SuM84FbOo
         BXTo1k9trhjQXRnacJIAwD2YVeGMrRKl2eLH0O5DrW8KQ1K3A1BqUN0j/+WKBW42XgnU
         5SEReB3wEwlixUQyjkejT71eK9PE71sCzbZg3T6znMox2egnD+DSvmQuSFOG8T3Kme0A
         OutQ==
X-Gm-Message-State: AOAM531GbvcqMgP+bYb3HyhhClttM3P30WfMDDCicZlDUh/mSUBkNcWZ
        TKaaFqJ/BbDbAuGgnX8hWoe9WCdUwU9C26WKqX5Vqw==
X-Google-Smtp-Source: ABdhPJyc6YmfDBFmiWx6v1sbxsopbrXCkiZ3HrnWCEtm5TDo18dpNiu7ml4MOzzRESfE6dwE3J43g7IaikoUdxPWAGU=
X-Received: by 2002:aa7:c382:: with SMTP id k2mr9947529edq.189.1620372501833;
 Fri, 07 May 2021 00:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com> <20210507050908.1008686-2-davidgow@google.com>
In-Reply-To: <20210507050908.1008686-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 7 May 2021 00:28:10 -0700
Message-ID: <CAGS_qxqOCUAKx7+0DBnsThVWskqPejq6oHzr4F+nvJALU+F1zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Assign strings to 'const char*' in STREQ assertions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
>
> Currently, the KUNIT_EXPECT_STREQ() and related macros assign both
> string arguments to variables of their own type (via typeof()). This
> seems to be to prevent the macro argument from being evaluated multiple
> times.
>
> However, yhis doesn't work if one of these is a fixed-length character
nit: if you ever send a v2 of this patch, s/yhis/this

> array, rather than a character pointer, as (for example) char[16] will
> always allocate a new string.
>
> By always using 'const char*' (the type strcmp expects), we're always
> just taking a pointer to the string, which works even with character
> arrays.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I'm very happy to see this patch.
This makes code that looks obviously correct actually work.

Somewhat tangential: there are several casts that are no longer needed
after this in the docs.
I think the following gets rid of all of them. Should it perhaps go in
a chain with this patch?
I.e. if the first one is too controversial and we want to go ahead
split this patch off from it.

diff --git a/Documentation/dev-tools/kunit/usage.rst
b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df5..756747417a19 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -465,10 +465,9 @@ fictitious example for ``sha1sum(1)``

 .. code-block:: c

-       /* Note: the cast is to satisfy overly strict type-checking. */
        #define TEST_SHA1(in, want) \
                sha1sum(in, out); \
-               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want,
"sha1sum(%s)", in);
+               KUNIT_EXPECT_STREQ_MSG(test, out, want, "sha1sum(%s)", in);

        char out[40];
        TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
@@ -507,7 +506,7 @@ In some cases, it can be helpful to write a
*table-driven test* instead, e.g.
        };
        for (i = 0; i < ARRAY_SIZE(cases); ++i) {
                sha1sum(cases[i].str, out);
-               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].sha1,
+               KUNIT_EXPECT_STREQ_MSG(test, out, cases[i].sha1,
                                      "sha1sum(%s)", cases[i].str);
        }

@@ -568,7 +567,7 @@ Reusing the same ``cases`` array from above, we
can write the test as a
                struct sha1_test_case *test_param = (struct
sha1_test_case *)(test->param_value);

                sha1sum(test_param->str, out);
-               KUNIT_EXPECT_STREQ_MSG(test, (char *)out, test_param->sha1,
+               KUNIT_EXPECT_STREQ_MSG(test, out, test_param->sha1,
                                      "sha1sum(%s)", test_param->str);

        }

> ---
>  include/kunit/test.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 4c56ffcb7403..b68c61348121 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1128,8 +1128,8 @@ do {                                                                             \
>                                    fmt,                                        \
>                                    ...)                                        \
>  do {                                                                          \
> -       typeof(left) __left = (left);                                          \
> -       typeof(right) __right = (right);                                       \
> +       const char *__left = (left);                                           \
> +       const char *__right = (right);                                 \
>                                                                                \
>         KUNIT_ASSERTION(test,                                                  \
>                         strcmp(__left, __right) op 0,                          \
> --
> 2.31.1.607.g51e8a6a459-goog
>
