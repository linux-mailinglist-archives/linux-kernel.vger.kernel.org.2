Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD8397963
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhFARoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFARoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:44:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 10:42:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o8so20454354ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yD/RqJ6Lx/pv1RbRPxCIzqHlKJgJbvGhxmkXtiq11v4=;
        b=dwDHvH0oW7+GD1xOPWXWUbtzxFGDdaLHC1wu2yhJzI8elng1B+C/UklczCw6nRLZej
         h1pc03qFBqc+EoMDgi/y91UMTscfhq4oZy4/T8Qr2yY4liDH1hw2OL48ItF1axmQEnXX
         mYxyee++yo3tCRYUhdqKDGHTdiCoQd6xGQuZ4P1kFiPNU5l+iJHV0mJeSsMw03SzswPf
         U1T6JEu9S6YzoO5aouaaTGvmJSSMnx4WFWkJ4jrprbZFx0cVHaakRi3OIymn4PqHNZOn
         xF2+hu6lT5/yO0AktWJpfcWJ0SD0dfhx95W2RqQcQLnrtxxrXpCaJ1SQ6+GPF2jFJv64
         LgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yD/RqJ6Lx/pv1RbRPxCIzqHlKJgJbvGhxmkXtiq11v4=;
        b=uWQFEDRjDOPGaiN0j+yb8v0W8jvEGLT6WbkSyDxxddpbfkjq9mNUxSQ+kVSp6PudNP
         ziDsidJLsoWJfQdNcar9Ajv7esQDz05C4ERV1pYykwfsfurROTSs9dJw1gRgyXipDl5X
         g8szxAgNHwPwYSSSg8i2pSZD5yyeY3u4eGzYbhcG7L+4/efR+3MA0gr1MfGMz/pikW1y
         vz77hCKH2qZm1CbnYwj1O+wjb3Y1+tfMq5y+roqLio2GQWAEn5DIWDTglJqRyJYhuIEe
         A7vadKBu3EJQM6R4jZuPfeTqrXcYdvJKR8Kntl90MAOyF9/souC47AygPri6y1yCAv42
         bykQ==
X-Gm-Message-State: AOAM531f2YUuZbpPISLs9inzLElE8mgF8f6iZ3eSAtWW5sXx4kW1EOpC
        njMuaqAaBVQePc0aQkKy69wYzjXOSG1VuVFJDq1FfvRVt4g=
X-Google-Smtp-Source: ABdhPJzbfKt7dKomr/Bnui0SxZ3GZ8PkPRDW7xuOBHLnCRab5GyteM5d3CcFYH5G4cSbOOXOUXU+Pi207ldLl0bmxek=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr22349478ljr.0.1622569372725;
 Tue, 01 Jun 2021 10:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210527162655.3246381-1-elver@google.com>
In-Reply-To: <20210527162655.3246381-1-elver@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 10:42:41 -0700
Message-ID: <CAKwvOdmgZXJB2dV7iG67qHgbDgVTJaH7b3dkpgZyea4ULgQjgA@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: add __no_sanitize_coverage to fix noinstr for
 all architectures
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 9:27 AM Marco Elver <elver@google.com> wrote:
>
> Until now no compiler supported an attribute to disable coverage
> instrumentation as used by KCOV.
>
> To work around this limitation on x86, noinstr functions have their
> coverage instrumentation turned into nops by objtool. However, this
> solution doesn't scale automatically to other architectures, such as
> arm64, which are migrating to use the generic entry code.
>
> Clang [1] and GCC [2] have added support for the attribute recently.
> [1] https://github.com/llvm/llvm-project/commit/280333021e9550d80f5c1152a34e33e81df1e178
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> The changes will appear in Clang 13 and GCC 12.
>
> Add __no_sanitize_coverage for both compilers, and add it to noinstr.
>
> Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
> if the feature is enabled, and therefore we do not require an additional
> defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is
> always true) to avoid adding redundant attributes to functions if KCOV
> is off. That being said, compilers that support the attribute will not
> generate errors/warnings if the attribute is redundantly used; however,
> where possible let's avoid it as it reduces preprocessed code size and
> associated compile-time overheads.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> v2:
> * Implement __has_feature(coverage_sanitizer) in Clang
>   (https://reviews.llvm.org/D103159) and use instead of version check.
> * Add Peter's Ack.
> ---
>  include/linux/compiler-clang.h | 11 +++++++++++
>  include/linux/compiler-gcc.h   |  6 ++++++
>  include/linux/compiler_types.h |  2 +-
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index adbe76b203e2..e15eebfa8e5d 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -45,6 +45,17 @@
>  #define __no_sanitize_undefined
>  #endif
>
> +/*
> + * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
> + * with no_sanitize("coverage"). Prior versions of Clang support coverage
> + * instrumentation, but cannot be queried for support by the preprocessor.

I'm not against a version check for supporting older releases (in
addition to the cleaner feature check, since the feature check was
non-existent); we can clean it up someday when clang-13 is the
minimally supported version.  Would having an additional version check
help support existing/older releases here?

> + */
> +#if __has_feature(coverage_sanitizer)
> +#define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
> +#else
> +#define __no_sanitize_coverage
> +#endif
> +
>  /*
>   * Not all versions of clang implement the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 5d97ef738a57..cb9217fc60af 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -122,6 +122,12 @@
>  #define __no_sanitize_undefined
>  #endif
>
> +#if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
> +#define __no_sanitize_coverage __attribute__((no_sanitize_coverage))
> +#else
> +#define __no_sanitize_coverage
> +#endif
> +
>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d29bda7f6ebd..cc2bee7f0977 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,7 +210,7 @@ struct ftrace_likely_data {
>  /* Section for code which can't be instrumented at all */
>  #define noinstr                                                                \
>         noinline notrace __attribute((__section__(".noinstr.text")))    \
> -       __no_kcsan __no_sanitize_address
> +       __no_kcsan __no_sanitize_address __no_sanitize_coverage
>
>  #endif /* __KERNEL__ */
>
> --
> 2.31.1.818.g46aad6cb9e-goog
>


-- 
Thanks,
~Nick Desaulniers
