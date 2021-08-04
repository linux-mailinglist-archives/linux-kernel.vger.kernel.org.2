Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B703E06E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhHDRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbhHDRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:44:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9808C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:44:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e5so3495014ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUstlCoh+2aM8Zpt2rSiAfcrFKDdb2fKerSE3mu7PMQ=;
        b=lH1AfSZljYu5+AikNsNHnegzMGq8pqgxEeyC/rx2HRagTBVjeVtcfEC1LRRyYNpxfJ
         jmGluXzNvHUy0vOZaDC7/n1Lv/nEudsc5aaSenJU7VzTGXjCNfFF4fcJxRS0gu7SGrUz
         6DxbMfUi+YDmNL3gwemuZt6Wdf/7VQ2xsAerOlRuFUkRxzEiWOu2zOvY3x/oCMvkMrKB
         D051+SU771uryE1kJDQkuNOwRkWl0138lFUVY4MXlz40sBoPDCuu4Siv+b61iWjaWTUf
         44uO+osCCTJ/iABXK1P1smvrCAc7IBg9xaPe3g+akH7UrYAcnj/Krj+FXnWOEjWAVqps
         mj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUstlCoh+2aM8Zpt2rSiAfcrFKDdb2fKerSE3mu7PMQ=;
        b=j3XXbtdplBg5X9Iq7zEqTJv9RNmVYG/RmTPxtvd5CGhnM5fmoV0xfil40uMpD22QqI
         pDHtoA31K6f7KSGRzy/AecIvrTKsPDMVMxpx2P87++4TANEIDOkJiR4/TZiTIGQxJ/Ss
         /0iXpW198amS7P+qiNsyjW+7muw2m2dx6e+Y8TPc2Jwy4IJ62z3ij+dTJvhUhQj7xaq5
         21gXRhNmtrmKlvmxotUAPhg0/2ogaDNiveOswZ3HsIfqBYHRvo1OM1yyTDg7IPgN+b8z
         5bEs4fhRHqyT5m3rhksvoFd/7ewBiJEBo/ZVeGGPqX/+0cFCFz1enDxxLFnVNgNV1DEx
         KjqQ==
X-Gm-Message-State: AOAM532CCiDEFVBO8QboVsthFWLtshbVVNXJTdmUugMoexgVwqAPcbOm
        UYvaaR3ulL3yKoO7659nsLGlhhScDyoSVyRtua3QUw==
X-Google-Smtp-Source: ABdhPJzBNHYo6ASYwr7NV7FD74o063BHObDX+jEUof6u+3aLQbNhzK3q8MsU8iMFAfTKjLV9YB0b4zM0ZTtMBHIesjQ=
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr399147ljp.116.1628099042748;
 Wed, 04 Aug 2021 10:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210802202326.1817503-1-ndesaulniers@google.com> <1847b77a-093a-ce59-5c3b-1a21d3bb66c7@kernel.org>
In-Reply-To: <1847b77a-093a-ce59-5c3b-1a21d3bb66c7@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Aug 2021 10:43:51 -0700
Message-ID: <CAKwvOd=F_OexmHctcW6x7d6up8+zOb5-iLWU9-Ji1dv9-S3F+A@mail.gmail.com>
Subject: Re: [PATCH v2] compiler_attributes.h: move __compiletime_{error|warning}
To:     Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 1:29 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 8/2/2021 1:23 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> > I'm working on adding support for __attribute__((__error__(""))) and
> > __attribute__((__warning__(""))) to Clang. To make use of these in
> > __compiletime_error and __compiletime_warning (as used by BUILD_BUG and
> > friends) for newer clang and detect/fallback for older versions of
> > clang, move these to compiler_attributes.h and guard them with
> > __has_attribute preprocessor guards.
> >
> > Link: https://reviews.llvm.org/D106030
> > Link: https://bugs.llvm.org/show_bug.cgi?id=16428
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1173
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> One comment below, please carry my tag forward in further revisions
> unless they are significant.
>
> > ---
> > Changes v1 -> v2:
> > * Use __warning__ rather than warning in __has_attribute check, as per
> >    Nathan.
> > * Don't sort existing __GCC4_has_attribute_* defines.
> >
> >   include/linux/compiler-gcc.h        |  3 ---
> >   include/linux/compiler_attributes.h | 24 ++++++++++++++++++++++++
> >   include/linux/compiler_types.h      |  6 ------
> >   3 files changed, 24 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index cb9217fc60af..21c36b69eb06 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -43,9 +43,6 @@
> >
> >   #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> >
> > -#define __compiletime_warning(message) __attribute__((__warning__(message)))
> > -#define __compiletime_error(message) __attribute__((__error__(message)))
> > -
> >   #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
> >   #define __latent_entropy __attribute__((latent_entropy))
> >   #endif
> > diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> > index 67c5667f8042..fb08b843ab47 100644
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -30,6 +30,7 @@
> >   # define __GCC4_has_attribute___assume_aligned__      1
> >   # define __GCC4_has_attribute___copy__                0
> >   # define __GCC4_has_attribute___designated_init__     0
> > +# define __GCC4_has_attribute___error__               1
> >   # define __GCC4_has_attribute___externally_visible__  1
> >   # define __GCC4_has_attribute___no_caller_saved_registers__ 0
> >   # define __GCC4_has_attribute___noclone__             1
> > @@ -39,6 +40,7 @@
> >   # define __GCC4_has_attribute___no_sanitize_undefined__ 1
> >   # define __GCC4_has_attribute___no_sanitize_coverage__ 0
> >   # define __GCC4_has_attribute___fallthrough__         0
> > +# define __GCC4_has_attribute___warning__             1
> >   #endif
> >
> >   /*
> > @@ -138,6 +140,17 @@
> >   # define __designated_init
> >   #endif
> >
> > +/*
> > + * Optional: only supported since clang >= 13.0
>
> Are you planning on petitioning for D106030 to be applied to
> release/13.x when it is merged into main? If not, this should be updated
> to 14.0.0 since that is main's current version.

Ah, I forgot the release/13.x branch was cut before I sent this.  I'd
rather this feature "ride the trains" so that it gets more soak time.

Miguel, would you like a v3 updating the comment above (and the
comment below) to s/13.0/14.0/g, or can you simply fold that change
into this one when applying it?

>
> > + *
> > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-error-function-attribute
> > + */
> > +#if __has_attribute(__error__)
> > +# define __compiletime_error(msg)       __attribute__((__error__(msg)))
> > +#else
> > +# define __compiletime_error(msg)
> > +#endif
> > +
> >   /*
> >    * Optional: not supported by clang
> >    *
> > @@ -299,6 +312,17 @@
> >    */
> >   #define __must_check                    __attribute__((__warn_unused_result__))
> >
> > +/*
> > + * Optional: only supported since clang >= 13.0
> > + *
> > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
> > + */
> > +#if __has_attribute(__warning__)
> > +# define __compiletime_warning(msg)     __attribute__((__warning__(msg)))
> > +#else
> > +# define __compiletime_warning(msg)
> > +#endif
> > +
> >   /*
> >    *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
> >    *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index e4ea86fc584d..b6ff83a714ca 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -294,12 +294,6 @@ struct ftrace_likely_data {
> >   #ifndef __compiletime_object_size
> >   # define __compiletime_object_size(obj) -1
> >   #endif
> > -#ifndef __compiletime_warning
> > -# define __compiletime_warning(message)
> > -#endif
> > -#ifndef __compiletime_error
> > -# define __compiletime_error(message)
> > -#endif
> >
> >   #ifdef __OPTIMIZE__
> >   # define __compiletime_assert(condition, msg, prefix, suffix)               \
> >



-- 
Thanks,
~Nick Desaulniers
