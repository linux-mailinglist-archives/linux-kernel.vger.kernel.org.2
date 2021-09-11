Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21A40741B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhIKAFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhIKAFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5AE261153;
        Sat, 11 Sep 2021 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631318671;
        bh=yCxhdTO4zVBxlRD91P2MnCUu/U+frkfv2oBp3ybq6xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgvNMUMUfMw6eDsPbENc2zx481SizT4gBmpkpua4K56SLuSJGW35esxJ5yQEa9r0h
         M/La7//c1BxcXy8P11oQtqk2O6FGL5k7/BnkJRPJ/m2X4Yhm5oyYIoTBlVt2jCzz1H
         1rdYPyXAQsmiZ1CLB07SK+qdkhhObbnLp45QehM2Vs3VKOkZ6KNXtd8/j8bhKKfSaB
         +jV5BI8EXt/S9FJ6NUzXev93OFoLB+/alkZd9XjHJwEJcEcS5QDFBUJMK+rtc+zhJH
         2ZZ1ef7gccLRKMOzYBHD/P3VMddqHa4BTS29yRDEh5dTGwSh5uKEsvNpmOe0EDCSxL
         j0SxVAJU+uKWg==
Date:   Fri, 10 Sep 2021 17:04:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] compiler.h: drop fallback overflow checkers
Message-ID: <YTvyiv6M05Zk/C70@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:39PM -0700, Nick Desaulniers wrote:
> Once upgrading the minimum supported version of GCC to 5.1, we can drop
> the fallback code for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW.
> 
> Effectively a revert of
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and
> add fallback code")
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1438#issuecomment-916745801
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Some comments inline, please carry the tag forward?

> ---
>  include/linux/compiler-clang.h     |  13 ---
>  include/linux/compiler-gcc.h       |   4 -
>  include/linux/overflow.h           | 138 +---------------------------
>  tools/include/linux/compiler-gcc.h |   4 -
>  tools/include/linux/overflow.h     | 140 +----------------------------
>  5 files changed, 6 insertions(+), 293 deletions(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 49b0ac8b6fd3..3c4de9b6c6e3 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -62,19 +62,6 @@
>  #define __no_sanitize_coverage
>  #endif
>  
> -/*
> - * Not all versions of clang implement the type-generic versions
> - * of the builtin overflow checkers. Fortunately, clang implements
> - * __has_builtin allowing us to avoid awkward version
> - * checks. Unfortunately, we don't know which version of gcc clang
> - * pretends to be, so the macro may or may not be defined.
> - */
> -#if __has_builtin(__builtin_mul_overflow) && \
> -    __has_builtin(__builtin_add_overflow) && \
> -    __has_builtin(__builtin_sub_overflow)
> -#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
> -#endif
> -

I am guessing the comment has been stale for a while since we did not
have a minimum version of LLVM when commit f0907827a8a9 ("compiler.h:
enable builtin overflow checkers and add fallback code")?

$ git grep -P "__builtin_(add|mul|sub)_overflow" llvmorg-10.0.1 clang/include/clang/Basic/Builtins.def
llvmorg-10.0.1:clang/include/clang/Basic/Builtins.def:BUILTIN(__builtin_add_overflow, "b.", "nt")
llvmorg-10.0.1:clang/include/clang/Basic/Builtins.def:BUILTIN(__builtin_sub_overflow, "b.", "nt")
llvmorg-10.0.1:clang/include/clang/Basic/Builtins.def:BUILTIN(__builtin_mul_overflow, "b.", "nt")

>  #if __has_feature(shadow_call_stack)
>  # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index cb9217fc60af..3f7f6fa0e051 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -128,10 +128,6 @@
>  #define __no_sanitize_coverage
>  #endif
>  
> -#if GCC_VERSION >= 50100
> -#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
> -#endif
> -
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 0f12345c21fb..4669632bd72b 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -6,12 +6,9 @@
>  #include <linux/limits.h>
>  
>  /*
> - * In the fallback code below, we need to compute the minimum and
> - * maximum values representable in a given type. These macros may also
> - * be useful elsewhere, so we provide them outside the
> - * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
> - *
> - * It would seem more obvious to do something like
> + * We need to compute the minimum and maximum values representable in a given
> + * type. These macros may also be useful elsewhere. It would seem more obvious
> + * to do something like:
>   *
>   * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
>   * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)

The signed and type macros right below this comment can be removed as
they were only used in the !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW case.

Also applies to the tools/ version.

> @@ -54,7 +51,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  	return unlikely(overflow);
>  }
>  
> -#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
>  /*
>   * For simplicity and code hygiene, the fallback code below insists on
>   * a, b and *d having the same type (similar to the min() and max()
> @@ -90,134 +86,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  	__builtin_mul_overflow(__a, __b, __d);	\
>  }))
>  
> -#else
> -
> -
> -/* Checking for unsigned overflow is relatively easy without causing UB. */
> -#define __unsigned_add_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = __a + __b;			\
> -	*__d < __a;				\
> -})
> -#define __unsigned_sub_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = __a - __b;			\
> -	__a < __b;				\
> -})
> -/*
> - * If one of a or b is a compile-time constant, this avoids a division.
> - */
> -#define __unsigned_mul_overflow(a, b, d) ({		\
> -	typeof(a) __a = (a);				\
> -	typeof(b) __b = (b);				\
> -	typeof(d) __d = (d);				\
> -	(void) (&__a == &__b);				\
> -	(void) (&__a == __d);				\
> -	*__d = __a * __b;				\
> -	__builtin_constant_p(__b) ?			\
> -	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
> -	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
> -})
> -
> -/*
> - * For signed types, detecting overflow is much harder, especially if
> - * we want to avoid UB. But the interface of these macros is such that
> - * we must provide a result in *d, and in fact we must produce the
> - * result promised by gcc's builtins, which is simply the possibly
> - * wrapped-around value. Fortunately, we can just formally do the
> - * operations in the widest relevant unsigned type (u64) and then
> - * truncate the result - gcc is smart enough to generate the same code
> - * with and without the (u64) casts.
> - */
> -
> -/*
> - * Adding two signed integers can overflow only if they have the same
> - * sign, and overflow has happened iff the result has the opposite
> - * sign.
> - */
> -#define __signed_add_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = (u64)__a + (u64)__b;		\
> -	(((~(__a ^ __b)) & (*__d ^ __a))	\
> -		& type_min(typeof(__a))) != 0;	\
> -})
> -
> -/*
> - * Subtraction is similar, except that overflow can now happen only
> - * when the signs are opposite. In this case, overflow has happened if
> - * the result has the opposite sign of a.
> - */
> -#define __signed_sub_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = (u64)__a - (u64)__b;		\
> -	((((__a ^ __b)) & (*__d ^ __a))		\
> -		& type_min(typeof(__a))) != 0;	\
> -})
> -
> -/*
> - * Signed multiplication is rather hard. gcc always follows C99, so
> - * division is truncated towards 0. This means that we can write the
> - * overflow check like this:
> - *
> - * (a > 0 && (b > MAX/a || b < MIN/a)) ||
> - * (a < -1 && (b > MIN/a || b < MAX/a) ||
> - * (a == -1 && b == MIN)
> - *
> - * The redundant casts of -1 are to silence an annoying -Wtype-limits
> - * (included in -Wextra) warning: When the type is u8 or u16, the
> - * __b_c_e in check_mul_overflow obviously selects
> - * __unsigned_mul_overflow, but unfortunately gcc still parses this
> - * code and warns about the limited range of __b.
> - */
> -
> -#define __signed_mul_overflow(a, b, d) ({				\
> -	typeof(a) __a = (a);						\
> -	typeof(b) __b = (b);						\
> -	typeof(d) __d = (d);						\
> -	typeof(a) __tmax = type_max(typeof(a));				\
> -	typeof(a) __tmin = type_min(typeof(a));				\
> -	(void) (&__a == &__b);						\
> -	(void) (&__a == __d);						\
> -	*__d = (u64)__a * (u64)__b;					\
> -	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
> -	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
> -	(__b == (typeof(__b))-1 && __a == __tmin);			\
> -})
> -
> -
> -#define check_add_overflow(a, b, d)	__must_check_overflow(		\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_add_overflow(a, b, d),			\
> -			__unsigned_add_overflow(a, b, d)))
> -
> -#define check_sub_overflow(a, b, d)	__must_check_overflow(		\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_sub_overflow(a, b, d),			\
> -			__unsigned_sub_overflow(a, b, d)))
> -
> -#define check_mul_overflow(a, b, d)	__must_check_overflow(		\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_mul_overflow(a, b, d),			\
> -			__unsigned_mul_overflow(a, b, d)))
> -
> -#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> -
>  /** check_shl_overflow() - Calculate a left-shifted value and check overflow
>   *
>   * @a: Value to be shifted
> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index 95c072b70d0e..a590a1dfafd9 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -38,7 +38,3 @@
>  #endif
>  #define __printf(a, b)	__attribute__((format(printf, a, b)))
>  #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
> -
> -#if GCC_VERSION >= 50100
> -#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
> -#endif
> diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
> index 8712ff70995f..dcb0c1bf6866 100644
> --- a/tools/include/linux/overflow.h
> +++ b/tools/include/linux/overflow.h
> @@ -5,12 +5,9 @@
>  #include <linux/compiler.h>
>  
>  /*
> - * In the fallback code below, we need to compute the minimum and
> - * maximum values representable in a given type. These macros may also
> - * be useful elsewhere, so we provide them outside the
> - * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
> - *
> - * It would seem more obvious to do something like
> + * We need to compute the minimum and maximum values representable in a given
> + * type. These macros may also be useful elsewhere. It would seem more obvious
> + * to do something like:
>   *
>   * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
>   * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
> @@ -36,8 +33,6 @@
>  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
>  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
>  
> -
> -#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
>  /*
>   * For simplicity and code hygiene, the fallback code below insists on
>   * a, b and *d having the same type (similar to the min() and max()
> @@ -73,135 +68,6 @@
>  	__builtin_mul_overflow(__a, __b, __d);	\
>  })
>  
> -#else
> -
> -
> -/* Checking for unsigned overflow is relatively easy without causing UB. */
> -#define __unsigned_add_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = __a + __b;			\
> -	*__d < __a;				\
> -})
> -#define __unsigned_sub_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = __a - __b;			\
> -	__a < __b;				\
> -})
> -/*
> - * If one of a or b is a compile-time constant, this avoids a division.
> - */
> -#define __unsigned_mul_overflow(a, b, d) ({		\
> -	typeof(a) __a = (a);				\
> -	typeof(b) __b = (b);				\
> -	typeof(d) __d = (d);				\
> -	(void) (&__a == &__b);				\
> -	(void) (&__a == __d);				\
> -	*__d = __a * __b;				\
> -	__builtin_constant_p(__b) ?			\
> -	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
> -	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
> -})
> -
> -/*
> - * For signed types, detecting overflow is much harder, especially if
> - * we want to avoid UB. But the interface of these macros is such that
> - * we must provide a result in *d, and in fact we must produce the
> - * result promised by gcc's builtins, which is simply the possibly
> - * wrapped-around value. Fortunately, we can just formally do the
> - * operations in the widest relevant unsigned type (u64) and then
> - * truncate the result - gcc is smart enough to generate the same code
> - * with and without the (u64) casts.
> - */
> -
> -/*
> - * Adding two signed integers can overflow only if they have the same
> - * sign, and overflow has happened iff the result has the opposite
> - * sign.
> - */
> -#define __signed_add_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = (u64)__a + (u64)__b;		\
> -	(((~(__a ^ __b)) & (*__d ^ __a))	\
> -		& type_min(typeof(__a))) != 0;	\
> -})
> -
> -/*
> - * Subtraction is similar, except that overflow can now happen only
> - * when the signs are opposite. In this case, overflow has happened if
> - * the result has the opposite sign of a.
> - */
> -#define __signed_sub_overflow(a, b, d) ({	\
> -	typeof(a) __a = (a);			\
> -	typeof(b) __b = (b);			\
> -	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
> -	*__d = (u64)__a - (u64)__b;		\
> -	((((__a ^ __b)) & (*__d ^ __a))		\
> -		& type_min(typeof(__a))) != 0;	\
> -})
> -
> -/*
> - * Signed multiplication is rather hard. gcc always follows C99, so
> - * division is truncated towards 0. This means that we can write the
> - * overflow check like this:
> - *
> - * (a > 0 && (b > MAX/a || b < MIN/a)) ||
> - * (a < -1 && (b > MIN/a || b < MAX/a) ||
> - * (a == -1 && b == MIN)
> - *
> - * The redundant casts of -1 are to silence an annoying -Wtype-limits
> - * (included in -Wextra) warning: When the type is u8 or u16, the
> - * __b_c_e in check_mul_overflow obviously selects
> - * __unsigned_mul_overflow, but unfortunately gcc still parses this
> - * code and warns about the limited range of __b.
> - */
> -
> -#define __signed_mul_overflow(a, b, d) ({				\
> -	typeof(a) __a = (a);						\
> -	typeof(b) __b = (b);						\
> -	typeof(d) __d = (d);						\
> -	typeof(a) __tmax = type_max(typeof(a));				\
> -	typeof(a) __tmin = type_min(typeof(a));				\
> -	(void) (&__a == &__b);						\
> -	(void) (&__a == __d);						\
> -	*__d = (u64)__a * (u64)__b;					\
> -	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
> -	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
> -	(__b == (typeof(__b))-1 && __a == __tmin);			\
> -})
> -
> -
> -#define check_add_overflow(a, b, d)					\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_add_overflow(a, b, d),			\
> -			__unsigned_add_overflow(a, b, d))
> -
> -#define check_sub_overflow(a, b, d)					\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_sub_overflow(a, b, d),			\
> -			__unsigned_sub_overflow(a, b, d))
> -
> -#define check_mul_overflow(a, b, d)					\
> -	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> -			__signed_mul_overflow(a, b, d),			\
> -			__unsigned_mul_overflow(a, b, d))
> -
> -
> -#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> -
>  /**
>   * array_size() - Calculate size of 2-dimensional array.
>   *
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
