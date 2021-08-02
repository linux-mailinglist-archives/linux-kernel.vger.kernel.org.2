Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DF3DE0AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhHBU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHBU3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:29:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C577610A8;
        Mon,  2 Aug 2021 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627936178;
        bh=ARh9DG4tmIsdrfUtUTPBkpcqMfcJVlCT5toIiYasvPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TX40QJ9dwI2EgMqrYCge7MFeyMWOcZvO5Noztf2D6DAXlAtwAWisLF3hgaz04HbCj
         iXNjxejwW6eyNbTzNZft0w7sK2wfKxFaNu2MxBROGxltUUdFta8fjBJlDpntD9URP6
         rmHKP0V/JckHQzBePnr98wf8ZM3UJVC8dDEpwgqMwlMVUKudwcwf0yob0vRsJHeRDW
         9o/Oop5xbrACDKfDnKv6N2xm9pL3Ou3vNr6erXw9mUdlmo8MnZ2wC4+zslNcTv7mG9
         P6qAZ/HErMbjhqhdTr2HCbZUpDY7c72/YOYDLheGXz1KpHgTSk43rrLFxmYrJ/IvVH
         koo5g8srn89QA==
Subject: Re: [PATCH v2] compiler_attributes.h: move
 __compiletime_{error|warning}
To:     Nick Desaulniers <ndesaulniers@google.com>,
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
        clang-built-linux@googlegroups.com
References: <20210802202326.1817503-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <1847b77a-093a-ce59-5c3b-1a21d3bb66c7@kernel.org>
Date:   Mon, 2 Aug 2021 13:29:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802202326.1817503-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2021 1:23 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One comment below, please carry my tag forward in further revisions 
unless they are significant.

> ---
> Changes v1 -> v2:
> * Use __warning__ rather than warning in __has_attribute check, as per
>    Nathan.
> * Don't sort existing __GCC4_has_attribute_* defines.
> 
>   include/linux/compiler-gcc.h        |  3 ---
>   include/linux/compiler_attributes.h | 24 ++++++++++++++++++++++++
>   include/linux/compiler_types.h      |  6 ------
>   3 files changed, 24 insertions(+), 9 deletions(-)
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
> index 67c5667f8042..fb08b843ab47 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -30,6 +30,7 @@
>   # define __GCC4_has_attribute___assume_aligned__      1
>   # define __GCC4_has_attribute___copy__                0
>   # define __GCC4_has_attribute___designated_init__     0
> +# define __GCC4_has_attribute___error__               1
>   # define __GCC4_has_attribute___externally_visible__  1
>   # define __GCC4_has_attribute___no_caller_saved_registers__ 0
>   # define __GCC4_has_attribute___noclone__             1
> @@ -39,6 +40,7 @@
>   # define __GCC4_has_attribute___no_sanitize_undefined__ 1
>   # define __GCC4_has_attribute___no_sanitize_coverage__ 0
>   # define __GCC4_has_attribute___fallthrough__         0
> +# define __GCC4_has_attribute___warning__             1
>   #endif
>   
>   /*
> @@ -138,6 +140,17 @@
>   # define __designated_init
>   #endif
>   
> +/*
> + * Optional: only supported since clang >= 13.0

Are you planning on petitioning for D106030 to be applied to 
release/13.x when it is merged into main? If not, this should be updated 
to 14.0.0 since that is main's current version.

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
> @@ -299,6 +312,17 @@
>    */
>   #define __must_check                    __attribute__((__warn_unused_result__))
>   
> +/*
> + * Optional: only supported since clang >= 13.0
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warning-function-attribute
> + */
> +#if __has_attribute(__warning__)
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
