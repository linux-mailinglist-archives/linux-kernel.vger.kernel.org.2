Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4651E3256E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBYTlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234355AbhBYTgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:36:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D63064F27;
        Thu, 25 Feb 2021 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614281386;
        bh=pjao6kRqK0VYhuK41pYwn+/iPwXCCek5r5Nlw4CqnS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIk98Mwyw4SCY7D8ZsQal3Zzw+0p/n+g4j4H0PD28Wpv633Sih0wXShM1g/LXGY7G
         Rizd/vSpb6hSxw2H3jE9x4Sw7x0SPReMU2I1sXK1wJrnFC+cAieKGhdoi0qBCn+VFc
         M3CfD3ErVGg/PCiZw8stFxPWx25U6y5PMlzUxjV46bxR+Ew2kY+AiPhlx/iJ/LQFKK
         HL/ml8wXSh6XhFYhF6WzsldgSg/5D4SBVQbXUWOgyixfH/toJTgVfPBAey5jJgpM2c
         DSnHHxfmAv3EPHf7G1AdloR1fBm8Xqsr2PYpkK8k+oZEUtnCpgEeY8rf9eo0KV/BOm
         vzi93VfDepxsw==
Date:   Thu, 25 Feb 2021 12:29:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <20210225192941.GA2026@MSI.localdomain>
References: <20210225164513.3667778-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225164513.3667778-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> back to the open-coded version and hoping that the compiler detects it.
> 
> Since all versions of clang support the __builtin_bswap interfaces,
> add back the flags and have the headers pick these up automatically.
> 
> This results in a 4% improvement of compilation speed for arm defconfig.
> 
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-clang.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 6478bff6fcc2..bbfa9ff6a2ec 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -33,6 +33,16 @@
>  #define __no_sanitize_thread
>  #endif
>  
> +/*
> + * sparse (__CHECKER__) pretends to be gcc, but can't do constant
> + * folding in __builtin_bswap*() (yet), so don't set these for it.
> + */
> +#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
> +#define __HAVE_BUILTIN_BSWAP32__
> +#define __HAVE_BUILTIN_BSWAP64__
> +#define __HAVE_BUILTIN_BSWAP16__
> +#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP && !__CHECKER__ */
> +
>  #if __has_feature(undefined_behavior_sanitizer)
>  /* GCC does not have __SANITIZE_UNDEFINED__ */
>  #define __no_sanitize_undefined \
> -- 
> 2.29.2
> 
