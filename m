Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2250E3D020C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhGTS0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGTS0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF9B610CC;
        Tue, 20 Jul 2021 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626808045;
        bh=WMo95Y55AP84nUJieHpxfyEBbYQum2UWMIvwyot869I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mcBrK9R8Hc2ggHoesbjgyspHIVZZ+tL3u+ibDzu00G/vRLlfgNZudgVQ3/s7mpYxv
         DbLY0ZiWUJtfdSHAKupv4/2NXuCqDjcUF+m/qS5iu8isAeESuHVXxnRVx3F369mGFQ
         qrUjwbbSQatobNT28zs5xVKBb4Vq/0CoBJGjit0pRzPvfbBxAbIttjhFpK4O3lMRpM
         MfRkg/PyEcSEEDCSa6BnFkwVpkGXMNGAU8TeJJQIEWezdT7BQEdIjzvYlcb1bXbc0C
         naJbK2yGdWqIZFnTgTZYfChPaPobfHgrFkiGDZFJRE1JoNG7RHHgzmn5nYgp4XHVfU
         ouVor7jn5u2Lg==
Subject: Re: [PATCH] compiler_attributes.h: move __compiletime_{error|warning}
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210720180441.2893919-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7c7d1639-7997-265e-aa77-ebe3d2fa05e6@kernel.org>
Date:   Tue, 20 Jul 2021 12:07:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720180441.2893919-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2021 11:04 AM, Nick Desaulniers wrote:
> I'm working on adding support for __attribute__((__error__(""))) and
> __attribute__((__warning__(""))) to Clang. To make use of these in
> __compiletime_error and __compiletime_warning (as used by BUILD_BUG and
> friends) for newer clang and detect/fallback for older versions of
> clang, move these to compiler_attributes.h and guard them with
> __has_attribute preprocessor guards.
> 
> Link: https://reviews.llvm.org/D106030
> Link: https://bugs.llvm.org/show_bug.cgi?id=16428
> Link: https://github.com/ClangBuiltLinux/linux/issues/1173
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Note that this feature hasn't landed yet in clang! I expect it to land
> in clang-13 though soon. We can still move this in anticipation of the
> feature landing, though perhaps the versions might not be precise if it
> slips to clang-14 (though I don't anticipate that).
> 
>   include/linux/compiler-gcc.h        |  3 ---
>   include/linux/compiler_attributes.h | 30 ++++++++++++++++++++++++++---
>   include/linux/compiler_types.h      |  6 ------
>   3 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index cb9217fc60af..21c36b69eb06 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -43,9 +43,6 @@
>   
>   #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>   
> -#define __compiletime_warning(message) __attribute__((__warning__(message)))
> -#define __compiletime_error(message) __attribute__((__error__(message)))
> -
>   #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>   #define __latent_entropy __attribute__((latent_entropy))
>   #endif
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 2487be0e7199..5f474b593425 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -30,14 +30,16 @@
>   # define __GCC4_has_attribute___assume_aligned__      1
>   # define __GCC4_has_attribute___copy__                0
>   # define __GCC4_has_attribute___designated_init__     0
> +# define __GCC4_has_attribute___error__               1
>   # define __GCC4_has_attribute___externally_visible__  1
> +# define __GCC4_has_attribute___fallthrough__         0
>   # define __GCC4_has_attribute___no_caller_saved_registers__ 0
> -# define __GCC4_has_attribute___noclone__             1
>   # define __GCC4_has_attribute___no_profile_instrument_function__ 0
> -# define __GCC4_has_attribute___nonstring__           0
>   # define __GCC4_has_attribute___no_sanitize_address__ 1
>   # define __GCC4_has_attribute___no_sanitize_undefined__ 1
> -# define __GCC4_has_attribute___fallthrough__         0
> +# define __GCC4_has_attribute___noclone__             1
> +# define __GCC4_has_attribute___nonstring__           0
> +# define __GCC4_has_attribute___warning__             1
>   #endif
>   
>   /*
> @@ -137,6 +139,17 @@
>   # define __designated_init
>   #endif
>   
> +/*
> + * Optional: only supported since clang >= 13.0
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-error-function-attribute
> + */
> +#if __has_attribute(__error__)
> +# define __compiletime_error(msg)       __attribute__((__error__(msg)))
> +#else
> +# define __compiletime_error(msg)
> +#endif
> +
>   /*
>    * Optional: not supported by clang
>    *
> @@ -298,6 +311,17 @@
>    */
>   #define __must_check                    __attribute__((__warn_unused_result__))
>   
> +/*
> + * Optional: only supported since clang >= 13.0
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
> + */
> +#if __has_attribute(warning)

Should this be

#if __has_attribute(__warning__)

?

> +# define __compiletime_warning(msg)     __attribute__((__warning__(msg)))
> +#else
> +# define __compiletime_warning(msg)
> +#endif
> +
>   /*
>    *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
>    *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e4ea86fc584d..b6ff83a714ca 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -294,12 +294,6 @@ struct ftrace_likely_data {
>   #ifndef __compiletime_object_size
>   # define __compiletime_object_size(obj) -1
>   #endif
> -#ifndef __compiletime_warning
> -# define __compiletime_warning(message)
> -#endif
> -#ifndef __compiletime_error
> -# define __compiletime_error(message)
> -#endif
>   
>   #ifdef __OPTIMIZE__
>   # define __compiletime_assert(condition, msg, prefix, suffix)		\
> 
