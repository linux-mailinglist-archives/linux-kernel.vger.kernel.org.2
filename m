Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C63413A77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhIUTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhIUTDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:03:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:02:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n71so96302iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oi/NDvAtmUSqkH+uyfZUH/z7ONIIO9SqqTDiQctf10s=;
        b=IjC339s1ep6EBgC7CAW8TXjYRWGW5hjcYkPwX4A2lpkEF04U7YQIrAsIZwnI8+laEf
         Otg8MB15H3LNByPVwR6Rfqv3E6wAqpT366P/JDD81HwyUBfonUvWfKV1qI1W4nz/acGT
         3zskWoInixnxLXwGxXMoSMtcObqVRFbp7/CAGAf8XAW6TSqNLHqFOH0h1g0DQwjQJiCw
         OYmF30UvEkrGQGB16ZqFckIE0+0vAMWsf/Ke+GGbKwNnJbv0gId6Svx75tzl9eiZDFOM
         vjEp/WpVy5FFC93gRYdgMu8xHiNBDWY2MQsEwV6D1K1AJOm3Ol2Em8V8hrq+yFs1Zk/A
         4y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi/NDvAtmUSqkH+uyfZUH/z7ONIIO9SqqTDiQctf10s=;
        b=3GaSROiTxBhLk34+a/jFV9hLYJDo81hCIiAS6TFCDs3zDlu90Bj1eEJPAyiS+WzpVK
         XqAfS93GSrBp/BOKG12L4kALZi2Q2ZcIO7RB/aYj/lgiAqjfE/webuxp7Bg7Z+/Yu7Yn
         JJwR9x1RIAqjBlvB0Q+vvXQntOOC8F05ssufx0zvizPv/WKbArGyKYwgZxkQS5xSiqMT
         N0pj5L1Jg531dhEobLEisTyN0okfetOBBQK+H5SHwb6o4e1pa3y76Q0v138264E8aeyh
         ssvaddI57ZGJUR5MrI8B2adC/ZaZEcQPXxU4wrVOQWvgpX+YA9em6J/gTGFGpMWbZt5y
         /46A==
X-Gm-Message-State: AOAM5322PkC3DyNtaocBNauSHEuMDYkmslImYGlsonf0GyxA4qgfORTA
        P9VaiE9HvIzk9BomlwHamvYrLZNNRPBt44NEZZtzic5tL5K9mw==
X-Google-Smtp-Source: ABdhPJzLBaqoM4mjMC56EVs1Tu6+bBSLjWtWVEmclWWClVAx/Wmok9A+HnVXGT6+03xHz0kyqK7Uh2x87arxUBXTdQg=
X-Received: by 2002:a5d:84d2:: with SMTP id z18mr1300646ior.52.1632250924313;
 Tue, 21 Sep 2021 12:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <YUZBkZhQsF5SlcLb@marsc.168.1.7>
In-Reply-To: <YUZBkZhQsF5SlcLb@marsc.168.1.7>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 21 Sep 2021 12:01:52 -0700
Message-ID: <CAGS_qxrtD7wJ8oTcyMdYjUZubiJwD7CO+YFDy8ohho5jLeNa8g@mail.gmail.com>
Subject: Re: [PATCH] kunit: mock: add support for function mocks with no parameters
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     brendanhiggins@google.com, andy.li@unisoc.com,
        andersonreisrosa@gmail.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:44 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Function mocks defined with DEFINE_FUNCTION_MOCK(...) do not support
> empty parameters list due to strict function prototypes enforcement
> (-Werror=strict-prototypes). Add support for function mocks with no
> parameters by adding checks to declare strict function prototypes when
> an empty param list is provided.
> Further, add an expectation to test that the generated code works.
>
> Co-developed-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> Signed-off-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Meta: kunit/alpha/master isn't really maintained anymore.
I think David and myself having some commits from this year might give
the wrong impression.
But all of my patches in 2021 were to make it easier to get people to
*move away* from kunit/alpha/master ;)

We sort of don't want to encourage anyone new from using it, see
https://kunit.dev/third_party/stable_kernel/index.html
That said, it's useful to have it around as a reference, and this
patch makes it more useful, so:

Reviewed-by: Daniel Latypov <dlatypov@google.com>
This looks reasonable to me, minor nit about the added test case below.

I think only Brendan could manually apply this and push it.
It would be a bit easier to go through the process of pushing it to
gerrit at https://kunit-review.googlesource.com/
I'd wait on Brendan to chime in on what he'd like to do (or if he'd
rather not have any new changes).

> ---
> We noted that the proposed changes added a few checkpatch errors.
> However, as checkpatch reported the same errors for other macros at
> params.h, we didn't spend a lot of time trying to find a fix for them.
>
> We hope this may solve Bugzilla Bug 205495
> https://bugzilla.kernel.org/show_bug.cgi?id=205495
>
>  include/test/mock.h    |  2 +-
>  include/test/params.h  | 12 +++++++++++-
>  test/mock-macro-test.c |  6 ++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/test/mock.h b/include/test/mock.h
> index 8b8031c13b2a..c46c90abc12a 100644
> --- a/include/test/mock.h
> +++ b/include/test/mock.h
> @@ -640,7 +640,7 @@ int mock_in_sequence(struct KUNIT_T *test, struct mock_expectation *first, ...);
>                                   return_type,                                 \
>                                   RETURN,                                      \
>                                   param_types...)                              \
> -               return_type name(PARAM_LIST_FROM_TYPES(param_types))           \
> +               return_type name(FUNC_PARAM_LIST_FROM_TYPES(param_types))      \
>                 {                                                              \
>                         struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
>                                                         handle_index);         \
> diff --git a/include/test/params.h b/include/test/params.h
> index 50d54035175d..ca4689dd0576 100644
> --- a/include/test/params.h
> +++ b/include/test/params.h
> @@ -264,6 +264,11 @@
>                                not_used,                                       \
>                                args)
>
> +#define FUNC_PARAM_LIST_FROM_TYPES(args...)                                   \
> +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> +               (PARAM_LIST_FROM_TYPES(args))
> +
>  #define PRODUCE_TYPE_NAME(context, type, index) #type
>  #define TYPE_NAMES_FROM_TYPES(handle_index, args...)                          \
>                 FOR_EACH_PARAM(PRODUCE_TYPE_NAME,                              \
> @@ -282,12 +287,17 @@
>                 IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
>                 IF(IS_NOT_EQUAL(index, ctrl_index))(                           \
>                                 struct mock_param_matcher *arg##index)
> -#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> +#define MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args...)           \
>                 FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,                        \
>                                FILTER_NONE,                                    \
>                                ctrl_index,                                     \
>                                args)
>
> +#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> +               (MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args))
> +
>  #define PRODUCE_ARG(context, type, index) arg##index
>  #define ARG_NAMES_FROM_TYPES(ctrl_index, args...)                             \
>                 FOR_EACH_PARAM(PRODUCE_ARG,                                    \
> diff --git a/test/mock-macro-test.c b/test/mock-macro-test.c
> index 14da7ebe752d..91a926558551 100644
> --- a/test/mock-macro-test.c
> +++ b/test/mock-macro-test.c
> @@ -59,6 +59,8 @@ DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
>
>  DEFINE_FUNCTION_MOCK(add, RETURNS(int), PARAMS(int, int));
>
> +DEFINE_FUNCTION_MOCK(no_param, RETURNS(int), PARAMS());
> +
>  struct mock_macro_context {
>         struct MOCK(test_struct) *mock_test_struct;
>         struct MOCK(void) *mock_void_ptr;
> @@ -217,7 +219,11 @@ static void mock_macro_test_generated_function_code_works(struct KUNIT_T *test)
>         handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
>         handle->action = int_return(test, 7);
>
> +       handle = EXPECT_CALL(no_param());
> +       handle->action = int_return(test, 0);
> +
>         EXPECT_EQ(test, 7, add(4, 3));
> +       EXPECT_EQ(test, 0, no_param());
>  }

I think this test case would be a bit more readable if restructured as
   219          handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
   220          handle->action = int_return(test, 7);
   221          EXPECT_EQ(test, 7, add(4, 3));
   222
   223          handle = EXPECT_CALL(no_param());
   224          handle->action = int_return(test, 0);
   225          EXPECT_EQ(test, 0, no_param());

I might also further suggest using a different return value than 0.
Some frameworks return 0-values by default when there's no specified
action, in which case this EXPECT_EQ() would pass even if we didn't
specify `int_return(test, 0)`.
That's not how KUnit works, so it's not actually relevant.

>
>  static int mock_macro_test_init(struct KUNIT_T *test)
> --
> 2.33.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YUZBkZhQsF5SlcLb%40marsc.168.1.7.
