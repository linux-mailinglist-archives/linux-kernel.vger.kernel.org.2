Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525B42E06C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhJNRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJNRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:51:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40275C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:49:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g36so13628986lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaW0/T+S3qtTPwWA2uNkFcxxhKazoJ7rNJxWqIE27NI=;
        b=V6ZjrnV+Fq7DNZ0MCcyJ/VsIfotirCJtUXn4CiavP5HB+HnKnk7fdRVDXKOSb1N40y
         j6M4ylzc2RO0XwRjNoAaQRGDUpEHjNX0hQAKKrcMAVUCdybAqMc84UyFXvge0HnpDE4X
         mUlcEoqYjfEq0s2OFwr3Wt7hut6aVbPtrj2QguEU59goAN6Soy60/QSLwbdeULFMU7gq
         yljbnk6C7Pz8EcZCnmd/X2VKKLzCu2BdJqOsiRMKOv6VePti3Zmmnn7ccJ7VJ9xGbQ6l
         nFaeRqQQki8f4NTlfqbbMW6zDsTCJABYDkaX5eLshUxlvEnypd4b3sjSTwXohsZe2ewI
         RKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaW0/T+S3qtTPwWA2uNkFcxxhKazoJ7rNJxWqIE27NI=;
        b=C8MduHj9k3NdJFyEcd7s10L68Uh6im4cn1VUOmloIxG4dW1wS+BRX0+RHstdHSar6p
         ZxKCqLrtN6tbKBurfs+46+JiXBFmBYB/aH/eGQAKnRovPYuOTbOLVwakIeTh9Wk3Eg7k
         V2EtWifv4kuh0kHy+j9u4ntoreoFTdyD1jjaQ+JCvNqtDTXCNM2HGkAWdVnPtwTFzAFk
         EH0p3wCCcKbK8RycEdpDetnFwVdPzglB184kpgVGHewmQJgHbGBIF3q0Xx7dodyqdge4
         I7T4aqvx6KOTzeD0dKfq4eA9hniu5w/wJHT+79ddWPWVuDuLg9nOxwZ4MdGGq1lnGpQD
         GRIg==
X-Gm-Message-State: AOAM530z/HKZExaeTThbCciDn6dxokH+0z5RgG8ygKEMfbANjFE8AueE
        Xudn6ZMzl9qzuhsfVdkP707zf3NNSQ0Clt6XyKXN0w==
X-Google-Smtp-Source: ABdhPJyYoXpIIRq1W+BTce78krhv5x5xNw/oJLL3kD3o8wffsIZJ1tNTXIDOo27Ws3Ea0GVVAS+gRbMMlD7NUMn3k6k=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr6584550lfu.240.1634233740333;
 Thu, 14 Oct 2021 10:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org> <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
In-Reply-To: <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 10:48:48 -0700
Message-ID: <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 14, 2021 at 03:23:31PM +0200, Miguel Ojeda wrote:
> > `__compiletime_assert` declares a fake `extern` function
> > which appears (to the compiler) to be called when the test fails.
> >
> > Therefore, compilers may emit possibly-uninitialized warnings
> > in some cases, even if it will be an error anyway (for compilers
> > supporting the `error` attribute, e.g. GCC and Clang >= 14)
> > or a link failure (for those that do not, e.g. Clang < 14).
> >
> > Annotating the fake function as `__noreturn` gives them
> > the information they need to avoid the warning,
> > e.g. see https://godbolt.org/z/x1v69jjYY.
> >
> > Link: https://lore.kernel.org/llvm/202110100514.3h9CI4s0-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  include/linux/compiler_types.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index b6ff83a714ca..ca1a66b8cd2f 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -298,7 +298,13 @@ struct ftrace_likely_data {
> >  #ifdef __OPTIMIZE__
> >  # define __compiletime_assert(condition, msg, prefix, suffix)                \
> >       do {                                                            \
> > -             extern void prefix ## suffix(void) __compiletime_error(msg); \
> > +             /*                                                      \
> > +              * __noreturn is needed to give the compiler enough     \
> > +              * information to avoid certain possibly-uninitialized  \
> > +              * warnings (regardless of the build failing).          \
> > +              */                                                     \
> > +             __noreturn extern void prefix ## suffix(void)           \
> > +                     __compiletime_error(msg);                       \
> >               if (!(condition))                                       \
> >                       prefix ## suffix();                             \
> >       } while (0)
>
> Should we not convert this to _Static_assert, now that all supported
> compilers are of recent enough vintage to support that?

It's a good question; I'm pretty sure we had a thread with Rasmus on
the idea a while ago, and IIRC the answer is no.

Basically, we can't convert BUILD_BUG_ON to _Static_assert because
_Static_assert requires integer constant expressions (ICE) while many
expressions passed to BUILD_BUG_ON in the kernel require that
optimizations such as inlining run (they are not ICEs); BUILD_BUG_ON
is more flexible.  So you can't replace the guts of BUILD_BUG_ON
wholesale with _Static_assert (without doing anything else); it would
be preferable for kernel developers to use _Static_assert (I think we
have a macro, static_assert, too) in cases where they have ICEs rather
than BUILD_BUG_ON (though it flips the condition of the expression;
_Static_assert errors if the expression evaluates to false;
BUILD_BUG_ON when true), but I think there's too much muscle memory
around just using BUILD_BUG_ON that if you introduced something new,
folks wouldn't know to use that instead.

Probably a better demonstration would be to try it and observe some of
the spooky failures at build time that result.  We may be able to
separate the macro into two; BUILD_BUG_ON and BUILD_BUG_ON_OPT (or
whatever color bikeshed), where the former uses _Static_assert under
the hood, and the latter uses __attribute__((error)). Then we could go
about converting cases that could not use _Static_assert to use the
new macro, while the old macro is what folks still reach for first.

I'm not sure how worthwhile that yakshave would be, but at least the
front end of the compiler would error sooner in the case of
_Static_assert, FWIW (not much).  But I don't think we can ever
eliminate __attribute__((error)) from the kernel unless we're ok
outright removing asserts that aren't ICEs.  I would not recommend
that.  I would like to see more usage of static_assert, but I'm not
sure how best to promote that, and if it's worth discussing the subtle
distinction between BUILD_BUG_ON vs _Static_assert again and again and
again every time.
-- 
Thanks,
~Nick Desaulniers
