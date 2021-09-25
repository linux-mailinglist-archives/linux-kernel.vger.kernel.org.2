Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A135341842E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhIYTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhIYTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 15:32:19 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A6C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 12:30:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a13so12807836qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTCmkPmhr+t+y0GLNezAX14aN0pAWXpQp+mL89lNQ1c=;
        b=Dvfzm5qLzs3iEJAw7xJ/Y7LjTnW6U1N5Hy2mcQA7MSje03l8ZecVEBFHvo5h5vomt6
         +ZJAP3beYn3TWdI7jsJSD7moWlwjLghimzyYIvsY/24LXyhJiL9rimSkJH4bMBQuNb5j
         JiWsqW0lwx0J/wM2x1KLPVo3eaIQYNsbgOB3vv5NnhEShsEKqVP+M9Ndnk0NKipQbVsR
         RtSWLsxJ3bnHgvobPu+ImlUlAa/FQEehvIsJzBpLCM2CKAe9TkSoJUrvx3DXvLjIh5C0
         vkw46EToJbgQ1sFNBEbzXn68hj56ByO9I8sTSMCNaeRcGfFo8GFnZTkTlE1VrLSiO7kA
         R+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTCmkPmhr+t+y0GLNezAX14aN0pAWXpQp+mL89lNQ1c=;
        b=dzaBu83vkRCyvOFQ4RaUFI/vr/Sbc/E1tI62HX5Tdtp4mGaDOxR+wk5iGcPctlrkBC
         RuB0nEaQrlDs2ZSRadDABtxiOO6uG3D6wV9J3rER5ik5LywR6qkLP8pN6/uBniX2G4PO
         /XP6sbHRA2CwmlESOX38BI1YDKkXkS9kVd2fppro7FZVxTxtKAzT3L9CbQQkW/CkA/G2
         ynwP1Pd1gWDIjdjHr7A05p0IvLmQ+kFTaidmYYSJILSwjvAKD0tBG5jB77jJAYFdtqtN
         YJdTdlhhjfWV0ajnxnHYHIiJ1alOXQoIzwvENIzmo97TqqFqT6J9OqpafulYXdA3IFBH
         kRxQ==
X-Gm-Message-State: AOAM5324UsGGNhZc4DggZfIczj21sqPBIiitMweeLqa0gOnBMH9ejg81
        V3hcKal+ekku7RhcDYz9a34=
X-Google-Smtp-Source: ABdhPJzs4NNIDylJLj2tPBIIDafJlDj1EAm5c7UF2ARhIt28lIXVNBIeMr8Rar5hg27NzRedS90pSw==
X-Received: by 2002:ac8:6893:: with SMTP id m19mr11121085qtq.116.1632598242823;
        Sat, 25 Sep 2021 12:30:42 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:95c:7f00:4a55:391d:16ef:6119])
        by smtp.gmail.com with ESMTPSA id k17sm7549880qtx.67.2021.09.25.12.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 12:30:42 -0700 (PDT)
Date:   Sat, 25 Sep 2021 16:30:38 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, andy.li@unisoc.com,
        andersonreisrosa@gmail.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH] kunit: mock: add support for function mocks with no
 parameters
Message-ID: <YU943oP0ERX1Xh3Q@marsc.168.1.7>
References: <YUZBkZhQsF5SlcLb@marsc.168.1.7>
 <CAGS_qxrtD7wJ8oTcyMdYjUZubiJwD7CO+YFDy8ohho5jLeNa8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxrtD7wJ8oTcyMdYjUZubiJwD7CO+YFDy8ohho5jLeNa8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your review.

On 09/21, Daniel Latypov wrote:
> On Sat, Sep 18, 2021 at 12:44 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Function mocks defined with DEFINE_FUNCTION_MOCK(...) do not support
> > empty parameters list due to strict function prototypes enforcement
> > (-Werror=strict-prototypes). Add support for function mocks with no
> > parameters by adding checks to declare strict function prototypes when
> > an empty param list is provided.
> > Further, add an expectation to test that the generated code works.
> >
> > Co-developed-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > Signed-off-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> Meta: kunit/alpha/master isn't really maintained anymore.
> I think David and myself having some commits from this year might give
> the wrong impression.
> But all of my patches in 2021 were to make it easier to get people to
> *move away* from kunit/alpha/master ;)

We can't submit it upstream because the mock stuff isn't there yet.
By the way, as nothing from mocking is upstream and kunit/alpha/master is
being frozen somewhat, what tree/branch should we base our work on if we
decide to develop more on the mocking framework?
I recall the branch with the POC for mocking was at
https://kunit-review.googlesource.com/c/linux/+/1114
Should we use this branch to base future work on mocking?
Or will the mocking framework be discontinued?

Sorry for asking so many questions. We just want to help to enhance KUnit.
We can work on something else besides mocking if it makes more sense to the
project.

> 
> We sort of don't want to encourage anyone new from using it, see
> https://kunit.dev/third_party/stable_kernel/index.html
> That said, it's useful to have it around as a reference, and this
> patch makes it more useful, so:
> 
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> This looks reasonable to me, minor nit about the added test case below.

Thanks. We'll send a v2 in case Brendan decides to pick these changes up.

> 
> I think only Brendan could manually apply this and push it.
> It would be a bit easier to go through the process of pushing it to
> gerrit at https://kunit-review.googlesource.com/
> I'd wait on Brendan to chime in on what he'd like to do (or if he'd
> rather not have any new changes).
> 
> > ---
> > We noted that the proposed changes added a few checkpatch errors.
> > However, as checkpatch reported the same errors for other macros at
> > params.h, we didn't spend a lot of time trying to find a fix for them.
> >
> > We hope this may solve Bugzilla Bug 205495
> > https://bugzilla.kernel.org/show_bug.cgi?id=205495
> >
> >  include/test/mock.h    |  2 +-
> >  include/test/params.h  | 12 +++++++++++-
> >  test/mock-macro-test.c |  6 ++++++
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/test/mock.h b/include/test/mock.h
> > index 8b8031c13b2a..c46c90abc12a 100644
> > --- a/include/test/mock.h
> > +++ b/include/test/mock.h
> > @@ -640,7 +640,7 @@ int mock_in_sequence(struct KUNIT_T *test, struct mock_expectation *first, ...);
> >                                   return_type,                                 \
> >                                   RETURN,                                      \
> >                                   param_types...)                              \
> > -               return_type name(PARAM_LIST_FROM_TYPES(param_types))           \
> > +               return_type name(FUNC_PARAM_LIST_FROM_TYPES(param_types))      \
> >                 {                                                              \
> >                         struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
> >                                                         handle_index);         \
> > diff --git a/include/test/params.h b/include/test/params.h
> > index 50d54035175d..ca4689dd0576 100644
> > --- a/include/test/params.h
> > +++ b/include/test/params.h
> > @@ -264,6 +264,11 @@
> >                                not_used,                                       \
> >                                args)
> >
> > +#define FUNC_PARAM_LIST_FROM_TYPES(args...)                                   \
> > +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> > +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> > +               (PARAM_LIST_FROM_TYPES(args))
> > +
> >  #define PRODUCE_TYPE_NAME(context, type, index) #type
> >  #define TYPE_NAMES_FROM_TYPES(handle_index, args...)                          \
> >                 FOR_EACH_PARAM(PRODUCE_TYPE_NAME,                              \
> > @@ -282,12 +287,17 @@
> >                 IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
> >                 IF(IS_NOT_EQUAL(index, ctrl_index))(                           \
> >                                 struct mock_param_matcher *arg##index)
> > -#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> > +#define MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args...)           \
> >                 FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,                        \
> >                                FILTER_NONE,                                    \
> >                                ctrl_index,                                     \
> >                                args)
> >
> > +#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)                    \
> > +               IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)                       \
> > +               IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))                         \
> > +               (MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args))
> > +
> >  #define PRODUCE_ARG(context, type, index) arg##index
> >  #define ARG_NAMES_FROM_TYPES(ctrl_index, args...)                             \
> >                 FOR_EACH_PARAM(PRODUCE_ARG,                                    \
> > diff --git a/test/mock-macro-test.c b/test/mock-macro-test.c
> > index 14da7ebe752d..91a926558551 100644
> > --- a/test/mock-macro-test.c
> > +++ b/test/mock-macro-test.c
> > @@ -59,6 +59,8 @@ DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
> >
> >  DEFINE_FUNCTION_MOCK(add, RETURNS(int), PARAMS(int, int));
> >
> > +DEFINE_FUNCTION_MOCK(no_param, RETURNS(int), PARAMS());
> > +
> >  struct mock_macro_context {
> >         struct MOCK(test_struct) *mock_test_struct;
> >         struct MOCK(void) *mock_void_ptr;
> > @@ -217,7 +219,11 @@ static void mock_macro_test_generated_function_code_works(struct KUNIT_T *test)
> >         handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
> >         handle->action = int_return(test, 7);
> >
> > +       handle = EXPECT_CALL(no_param());
> > +       handle->action = int_return(test, 0);
> > +
> >         EXPECT_EQ(test, 7, add(4, 3));
> > +       EXPECT_EQ(test, 0, no_param());
> >  }
> 
> I think this test case would be a bit more readable if restructured as
>    219          handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
>    220          handle->action = int_return(test, 7);
>    221          EXPECT_EQ(test, 7, add(4, 3));
>    222
>    223          handle = EXPECT_CALL(no_param());
>    224          handle->action = int_return(test, 0);
>    225          EXPECT_EQ(test, 0, no_param());
> 
> I might also further suggest using a different return value than 0.
> Some frameworks return 0-values by default when there's no specified
> action, in which case this EXPECT_EQ() would pass even if we didn't
> specify `int_return(test, 0)`.
> That's not how KUnit works, so it's not actually relevant.
> 
> >
> >  static int mock_macro_test_init(struct KUNIT_T *test)
> > --
> > 2.33.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YUZBkZhQsF5SlcLb%40marsc.168.1.7.
