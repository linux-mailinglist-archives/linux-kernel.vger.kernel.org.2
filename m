Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B6419992
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhI0Qqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhI0Qqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:46:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:44:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q205so23591842iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3afHWxb3kZ/OBbD2P2v0BW/3UVr4lp+hZszZfZMoqnM=;
        b=YFb3YHPlvqMGABm06Nrb9D8FF3CL3lK6eTgE0u3e8e/H0rkF55EQgv/EysjcOLgv5o
         f40WqSlBJnvfevQuSNwocFxjhs0Lo04823sZ9UNEl3sLcCO7NwM7WmWxQgbX6p319qvq
         PKCxoWcv6PJOJrBv1/6pRqN2S4TpZlqrzByLuIRuhgaz7tzEx/ll1vuQnpTiZOefILVO
         iy2PYPyBmavU1XXhmOx3AFIEZ0Vkqif4JlLC4yCqvkyy4W7Rb6OPKqVR+KFHDdCd67zY
         fpJPNOiJ8GsvB1DEK5GJxzSXRzK+AeDAmZrcxgomYhSjGyrF2kYkdHdHA3PAxW9shm4b
         ivig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3afHWxb3kZ/OBbD2P2v0BW/3UVr4lp+hZszZfZMoqnM=;
        b=utQkyjSGb2htAcs2yEVrX/elnoIPvkS1eXIvx1KoSqtdZPH10BhIhYpMOdpR4pnc/D
         F0lfwH/o9AJxR2H1GsV3q97pHcGm3WyyYc3M1UO+F4HFffv2wAgbaqDKHz1ymRx2t0tG
         uW0Orjp2fq48xcBDNDU8dSqt2PzDiv+R8VsEgA4ll3DLGEYVlI9CW7hUE0YV0RgwAiGj
         5NdAhBZTsQdnEC063KNk3LWOUcFvvGKthSvAV3tD7kV/eopbjHmwrRmII5s+XTkuSlJL
         ZX5cTav8g7K+zgv0vHwEeuHOrw8Yx7QYH1o2YGI8wY/3y57dkw3WuUaNplkfCqonw8kf
         JyLg==
X-Gm-Message-State: AOAM531R2bmA7jhd61KSyukUk5phHi6/a3yfgAiucRFyqk7UvGUsaGM3
        8i3ffY7ztI+MsjGL3aLzy5iDUvGjSd3Dmuxwo5CbxM1b5Gg=
X-Google-Smtp-Source: ABdhPJziSwpxRdKl1q7z6s6mCaEDU3LaSK7L9tU7unIXibm4ZX1vaNjkj10wIvKktvEN8Epf8trD70EWtj2I+BRq/3o=
X-Received: by 2002:a5d:8d04:: with SMTP id p4mr509722ioj.52.1632761098194;
 Mon, 27 Sep 2021 09:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <YUZBkZhQsF5SlcLb@marsc.168.1.7> <CAGS_qxrtD7wJ8oTcyMdYjUZubiJwD7CO+YFDy8ohho5jLeNa8g@mail.gmail.com>
 <YU943oP0ERX1Xh3Q@marsc.168.1.7>
In-Reply-To: <YU943oP0ERX1Xh3Q@marsc.168.1.7>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 27 Sep 2021 09:44:46 -0700
Message-ID: <CAGS_qxooHU+7SW9_GbvV2w2QAr3daBJcybx0zMqVFp3f3azrGg@mail.gmail.com>
Subject: Re: [PATCH] kunit: mock: add support for function mocks with no parameters
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     brendanhiggins@google.com, andy.li@unisoc.com,
        andersonreisrosa@gmail.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[2]
On Sat, Sep 25, 2021 at 12:30 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi Daniel,
>
> Thanks for your review.
>
> On 09/21, Daniel Latypov wrote:
> > On Sat, Sep 18, 2021 at 12:44 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Function mocks defined with DEFINE_FUNCTION_MOCK(...) do not support
> > > empty parameters list due to strict function prototypes enforcement
> > > (-Werror=strict-prototypes). Add support for function mocks with no
> > > parameters by adding checks to declare strict function prototypes when
> > > an empty param list is provided.
> > > Further, add an expectation to test that the generated code works.
> > >
> > > Co-developed-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > > Signed-off-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >
> > Meta: kunit/alpha/master isn't really maintained anymore.
> > I think David and myself having some commits from this year might give
> > the wrong impression.
> > But all of my patches in 2021 were to make it easier to get people to
> > *move away* from kunit/alpha/master ;)
>
> We can't submit it upstream because the mock stuff isn't there yet.
> By the way, as nothing from mocking is upstream and kunit/alpha/master is
> being frozen somewhat, what tree/branch should we base our work on if we
> decide to develop more on the mocking framework?
> I recall the branch with the POC for mocking was at
> https://kunit-review.googlesource.com/c/linux/+/1114
> Should we use this branch to base future work on mocking?
> Or will the mocking framework be discontinued?

All the mocking stuff is in limbo at the moment.
The v2 of the class mocking RFC was sent out Oct 2020,
https://lore.kernel.org/linux-kselftest/20201012222050.999431-1-dlatypov@google.com/

Until we have user interest in mocking support, that RFC will likely
just sit there.
Or maybe we scrap it and just introduce the functionality piece by piece.

There's https://kunit.dev/mocking.html which talks about how one can
implement mocking on their own, or (better yet) write fakes while
leveraging KUnit.
If we start seeing adoption of that, we can start factoring out
functionality into shared code as needed, e.g. support for saying a
mock should be called N times, then maybe gradually the parameter
matchers and return values, etc.

I missed it, but I know David and Brendan talked a bit about this in
their recent LPC talk, https://youtu.be/Y_minEhZNm8?t=15905

>
> Sorry for asking so many questions. We just want to help to enhance KUnit.

No worries, and we really appreciate it.

> We can work on something else besides mocking if it makes more sense to the
> project.

Mocking doesn't feel like an area where we can expect to see progress right now.
In terms of other KUnit features we know would be useful now, I think
it's mostly just [1] and [2], which hopefully will land in 5.16.

I think right now we probably need more tests written to have a better
idea of what else we could/should do.
Partly because of that, David is trying to get the ball rolling on
testing ext4. We're also hopeful that it'll be easier to add tests if
adjacent code is already tested (sharing fakes, conventions, ability
to copy-paste, etc.).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33
[2] https://lore.kernel.org/linux-kselftest/20210909001037.2842954-1-dlatypov@google.com/


>
> >
> > We sort of don't want to encourage anyone new from using it, see
> > https://kunit.dev/third_party/stable_kernel/index.html
> > That said, it's useful to have it around as a reference, and this
> > patch makes it more useful, so:
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> > This looks reasonable to me, minor nit about the added test case below.
>
> Thanks. We'll send a v2 in case Brendan decides to pick these changes up.
>
> >
> > I think only Brendan could manually apply this and push it.
> > It would be a bit easier to go through the process of pushing it to
> > gerrit at https://kunit-review.googlesource.com/
> > I'd wait on Brendan to chime in on what he'd like to do (or if he'd
> > rather not have any new changes).
> >
> > > ---
> > > We noted that the proposed changes added a few checkpatch errors.
> > > However, as checkpatch reported the same errors for other macros at
> > > params.h, we didn't spend a lot of time trying to find a fix for them.
> > >
> > > We hope this may solve Bugzilla Bug 205495
> > > https://bugzilla.kernel.org/show_bug.cgi?id=205495
> > >
> > >  include/test/mock.h    |  2 +-
> > >  include/test/params.h  | 12 +++++++++++-
> > >  test/mock-macro-test.c |  6 ++++++
> > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/test/mock.h b/include/test/mock.h
> > > index 8b8031c13b2a..c46c90abc12a 100644
> > > --- a/include/test/mock.h
> > > +++ b/include/test/mock.h
> > > @@ -640,7 +640,7 @@ int mock_in_sequence(struct KUNIT_T *test, struct mock_expectation *first, ...);
> > >                                   return_type,                                 \
> > >                                   RETURN,                                      \
> > >                                   param_types...)                              \
> > > -               return_type name(PARAM_LIST_FROM_TYPES(param_types))           \
> > > +               return_type name(FUNC_PARAM_LIST_FROM_TYPES(param_types))      \
> > >                 {                                                              \
> > >                         struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
> > >                                                         handle_index);         \
> > > diff --git a/include/test/params.h b/include/test/params.h
> > > index 50d54035175d..ca4689dd0576 100644
> > > --- a/include/test/params.h
> > > +++ b/include/test/params.h
> > > @@ -264,6 +264,11 @@
> > >                                not_used,                                       \
> > >                                args)
> > >
> > > +#define FUNC_PARAM_LIST_FROM_TYPES(args...)                                   \
> > > +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> > > +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> > > +               (PARAM_LIST_FROM_TYPES(args))
> > > +
> > >  #define PRODUCE_TYPE_NAME(context, type, index) #type
> > >  #define TYPE_NAMES_FROM_TYPES(handle_index, args...)                          \
> > >                 FOR_EACH_PARAM(PRODUCE_TYPE_NAME,                              \
> > > @@ -282,12 +287,17 @@
> > >                 IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
> > >                 IF(IS_NOT_EQUAL(index, ctrl_index))(                           \
> > >                                 struct mock_param_matcher *arg##index)
> > > -#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> > > +#define MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args...)           \
> > >                 FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,                        \
> > >                                FILTER_NONE,                                    \
> > >                                ctrl_index,                                     \
> > >                                args)
> > >
> > > +#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> > > +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> > > +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> > > +               (MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args))
> > > +
> > >  #define PRODUCE_ARG(context, type, index) arg##index
> > >  #define ARG_NAMES_FROM_TYPES(ctrl_index, args...)                             \
> > >                 FOR_EACH_PARAM(PRODUCE_ARG,                                    \
> > > diff --git a/test/mock-macro-test.c b/test/mock-macro-test.c
> > > index 14da7ebe752d..91a926558551 100644
> > > --- a/test/mock-macro-test.c
> > > +++ b/test/mock-macro-test.c
> > > @@ -59,6 +59,8 @@ DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
> > >
> > >  DEFINE_FUNCTION_MOCK(add, RETURNS(int), PARAMS(int, int));
> > >
> > > +DEFINE_FUNCTION_MOCK(no_param, RETURNS(int), PARAMS());
> > > +
> > >  struct mock_macro_context {
> > >         struct MOCK(test_struct) *mock_test_struct;
> > >         struct MOCK(void) *mock_void_ptr;
> > > @@ -217,7 +219,11 @@ static void mock_macro_test_generated_function_code_works(struct KUNIT_T *test)
> > >         handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
> > >         handle->action = int_return(test, 7);
> > >
> > > +       handle = EXPECT_CALL(no_param());
> > > +       handle->action = int_return(test, 0);
> > > +
> > >         EXPECT_EQ(test, 7, add(4, 3));
> > > +       EXPECT_EQ(test, 0, no_param());
> > >  }
> >
> > I think this test case would be a bit more readable if restructured as
> >    219          handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
> >    220          handle->action = int_return(test, 7);
> >    221          EXPECT_EQ(test, 7, add(4, 3));
> >    222
> >    223          handle = EXPECT_CALL(no_param());
> >    224          handle->action = int_return(test, 0);
> >    225          EXPECT_EQ(test, 0, no_param());
> >
> > I might also further suggest using a different return value than 0.
> > Some frameworks return 0-values by default when there's no specified
> > action, in which case this EXPECT_EQ() would pass even if we didn't
> > specify `int_return(test, 0)`.
> > That's not how KUnit works, so it's not actually relevant.
> >
> > >
> > >  static int mock_macro_test_init(struct KUNIT_T *test)
> > > --
> > > 2.33.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YUZBkZhQsF5SlcLb%40marsc.168.1.7.
