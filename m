Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB640742A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhIKAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:13:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CCB461208;
        Sat, 11 Sep 2021 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631319167;
        bh=of31m9USNn0F2OSpITeIKlXCg0CVdcBvK/Ub7sxEVOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvvVA7WpLkJ9+3PWT3MoKPBT3rK+UWXq7C8BK2yCLPe8gIKWIFHgbjw5xwobYOE89
         IhLz8d5pchiWZskoW+0rmfTh28tm8F8K3iCiZLiIWWwDXdmrvaireKTEXoXx1sQAkX
         2Bn0LtAxwJgm6GwWPtSeUN8xEVkL66sGgwtkkskIaWQkB0O/LhvM1Jiv5Xd4UGgFKt
         sIUVvgtNBxx4L36cn1ls/81+i/fIj8w0cH6K5sgafwgbI2dyZNkQ0/qbQdfe/uWLo9
         tjWwuZJeYaodPt94l/FM9H6B7500LmZC3e0to8apC+908Yz4xBUzCoXjI7WtdYNX/c
         QKh0Gr7K79WGw==
Date:   Fri, 10 Sep 2021 17:12:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] compiler-gcc.h: drop checks for older GCC versions
Message-ID: <YTv0elkfY9JIuEVQ@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-10-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-10-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:46PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported default, drop the values we
> don't use.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h       | 4 +---
>  tools/include/linux/compiler-gcc.h | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 3f7f6fa0e051..fd82ce169ce9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -98,10 +98,8 @@
>  
>  #if GCC_VERSION >= 70000
>  #define KASAN_ABI_VERSION 5
> -#elif GCC_VERSION >= 50000
> +#else
>  #define KASAN_ABI_VERSION 4
> -#elif GCC_VERSION >= 40902
> -#define KASAN_ABI_VERSION 3
>  #endif
>  
>  #if __has_attribute(__no_sanitize_address__)
> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index a590a1dfafd9..43d9a46d36f0 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -16,9 +16,7 @@
>  # define __fallthrough __attribute__ ((fallthrough))
>  #endif
>  
> -#if GCC_VERSION >= 40300
> -# define __compiletime_error(message) __attribute__((error(message)))
> -#endif /* GCC_VERSION >= 40300 */
> +#define __compiletime_error(message) __attribute__((error(message)))
>  
>  /* &a[0] degrades to a pointer: a different type from an array */
>  #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
