Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F93D0387
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhGTUVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhGTUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:16:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:57:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e14so151221ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGJYYazS743AEBk88eE6aQ56aSrR7u08nsjaB6UbOnw=;
        b=A5CJjufGqYLlF2YS6wvzK/UpqtWyO5njHBqvhGOY/Hzj0cO2+wkZ7YdgZy79iUR1xI
         FNqoKsPTdmug9vL++ZNzYKBffEIKs6JJk7rgCenQi3ZNbPug0MJzi6ZBCbgYIeZak1W3
         jXQ7nZJ16kKiex5h1y01T+k+l21IcwaxSaNSDpb2QxgNtff/SnnA97TS6iQqlnvuHz8n
         WfBVSxWSMDr3I4PBtCvIhNDvf33f9tORskBfDc/yCvP3GycKtbQFcYve69MFL8Shg8G7
         HzcN4bVgnYtCkEdXcvKwwXQYWTl6kXcIT1/JcxopnMdQf+YbWaHETCbCK6oGO5zN67S3
         TC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGJYYazS743AEBk88eE6aQ56aSrR7u08nsjaB6UbOnw=;
        b=X+seA4e6V0frCc2MvIoL37djsi+RNx+n+kkkAIx+ZF48ZfqQ5ohyfHU+4Osk9QjJDZ
         SkBnNzNTUw/0+RgnnCcLzDTLgJTWdlbIoMEGX+Wx8rqZLPkFnWxma2PLdNMp+FxI0InI
         s4uynPdTbJ8aTbey0NKKIV39jXzGIsY0LL/VRJEMD6i62mJ3NyvXRCE65/41o2k3MbSJ
         +upy+RQG5m4spAf2UQ+OkrcK3dq4aAjuvn3X/SGq416noHNXV+JvLwLZHfp8r0kQ4gtp
         Vv6CVFHsrn5F1UgfN8KmGJ5hmjtPjMiYpW7Qe8dxUO8Jfu/Kz/7RT9OnL6DvwPwU1UIQ
         DJuA==
X-Gm-Message-State: AOAM5315AcdqIB58leiZUP7WQ4r68AXyweqtqitr2R9wxz77ld0zPeBx
        mnsc9bUcD6nhSAI08tac5q2X5z1LMAH3i1Cz0dFaZQ==
X-Google-Smtp-Source: ABdhPJxJ4JqlOmu/mxpZMan1qIWhOtgy4QyOdmXtxmGGxQPGchK4e42msZpFq77B5ASiLHkwedhUNCunvtW8hLHPJSc=
X-Received: by 2002:a2e:a784:: with SMTP id c4mr3189657ljf.479.1626814621392;
 Tue, 20 Jul 2021 13:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210720180441.2893919-1-ndesaulniers@google.com> <7c7d1639-7997-265e-aa77-ebe3d2fa05e6@kernel.org>
In-Reply-To: <7c7d1639-7997-265e-aa77-ebe3d2fa05e6@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jul 2021 13:56:51 -0700
Message-ID: <CAKwvOd=Lh4mLjcNKLn_-s2249zpuEY_ijC6sijRY9QaWSNVvYA@mail.gmail.com>
Subject: Re: [PATCH] compiler_attributes.h: move __compiletime_{error|warning}
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:07 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 7/20/2021 11:04 AM, Nick Desaulniers wrote:
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
> > ---
> > Note that this feature hasn't landed yet in clang! I expect it to land
> > in clang-13 though soon. We can still move this in anticipation of the
> > feature landing, though perhaps the versions might not be precise if it
> > slips to clang-14 (though I don't anticipate that).
> >
> >   include/linux/compiler-gcc.h        |  3 ---
> >   include/linux/compiler_attributes.h | 30 ++++++++++++++++++++++++++---
> >   include/linux/compiler_types.h      |  6 ------
> >   3 files changed, 27 insertions(+), 12 deletions(-)
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
> > index 2487be0e7199..5f474b593425 100644
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -30,14 +30,16 @@
> >   # define __GCC4_has_attribute___assume_aligned__      1
> >   # define __GCC4_has_attribute___copy__                0
> >   # define __GCC4_has_attribute___designated_init__     0
> > +# define __GCC4_has_attribute___error__               1
> >   # define __GCC4_has_attribute___externally_visible__  1
> > +# define __GCC4_has_attribute___fallthrough__         0
> >   # define __GCC4_has_attribute___no_caller_saved_registers__ 0
> > -# define __GCC4_has_attribute___noclone__             1
> >   # define __GCC4_has_attribute___no_profile_instrument_function__ 0
> > -# define __GCC4_has_attribute___nonstring__           0
> >   # define __GCC4_has_attribute___no_sanitize_address__ 1
> >   # define __GCC4_has_attribute___no_sanitize_undefined__ 1
> > -# define __GCC4_has_attribute___fallthrough__         0
> > +# define __GCC4_has_attribute___noclone__             1
> > +# define __GCC4_has_attribute___nonstring__           0
> > +# define __GCC4_has_attribute___warning__             1
> >   #endif
> >
> >   /*
> > @@ -137,6 +139,17 @@
> >   # define __designated_init
> >   #endif
> >
> > +/*
> > + * Optional: only supported since clang >= 13.0
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
> > @@ -298,6 +311,17 @@
> >    */
> >   #define __must_check                    __attribute__((__warn_unused_result__))
> >
> > +/*
> > + * Optional: only supported since clang >= 13.0
> > + *
> > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
> > + */
> > +#if __has_attribute(warning)
>
> Should this be
>
> #if __has_attribute(__warning__)
>
> ?

Yes. :-X

>
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
