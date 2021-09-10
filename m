Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405E407416
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhIJX5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIJX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 270AC6052B;
        Fri, 10 Sep 2021 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631318158;
        bh=DNbYPXmd3IEaN88m25hO+5ZGRjkmqcd4V/ITcTDtlJ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZthXR82/C9yEorBA8YiAX0b2E2fFmoJkua0IZVv/q72g2apayUeTCMDZEL+8Dy9g4
         LDII2t6/ey5bAQgqpVdbft6M8C4dsR2cWvqFwwL5xxxJCj0iU2cuNOyUCiJ2TgKvZs
         QXFeAzkv62k9eEuqzlUtXlcMRV8qh2PuGwMTmRWq4CJds1gcSvvKs9WYrlOK4ApSYm
         Leuo6iDnpBV4ATweXcRxEY5j0C0YHlIhAvmtB0Ew9bZRZ0KTVlE9XIyfBQwsYqioen
         GXiIuzme6LkBFx6fIxiLoYrkQJIPT0d4jcOrDOOzH3MNucVYhLoXIYX6nsfgppHP1L
         aotqFKwOA3R3Q==
Subject: Re: [PATCH 01/10] Documentation: raise minimum supported version of
 GCC to 5.1
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-2-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <cb42c578-d037-3297-d0c2-ab107b7a838f@kernel.org>
Date:   Fri, 10 Sep 2021 16:55:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910234047.1019925-2-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2021 4:40 PM, Nick Desaulniers wrote:
> commit fad7cd3310db ("nbd: add the check to prevent overflow in
> __nbd_ioctl()")
> 
> raised an issue from the fallback helpers added in
> 
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
> 
> Specifically, the helpers for checking whether the results of a
> multiplication overflowed (__unsigned_mul_overflow,
> __signed_add_overflow) use the division operator when
> !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> operands on 32b hosts.

"hosts" -> "targets" or "architectures"?

It might be worth putting the error that Stephen found here?

> Also, because the macro is type agnostic, it is very difficult to write
> a similarly type generic macro that dispatches to one of:
> * div64_s64
> * div64_u64
> * div_s64
> * div_u64
> 
> Raising the minimum supported versions allows us to remove all of the
> fallback helpers for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW, instead
> dispatching the compiler builtins.
> 
> arm64 has already raised the minimum supported GCC version to 5.1, do
> this for all targets now. See the link below for the previous
> discussion.
> 
> Link: https://lore.kernel.org/all/20210909182525.372ee687@canb.auug.org.au/
> Link: https://lore.kernel.org/lkml/CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1438
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   Documentation/process/changes.rst | 2 +-
>   scripts/min-tool-version.sh       | 8 +-------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index d3a8557b66a1..e35ab74a0f80 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
>   ====================== ===============  ========================================
>           Program        Minimal version       Command to check the version
>   ====================== ===============  ========================================
> -GNU C                  4.9              gcc --version
> +GNU C                  5.1              gcc --version
>   Clang/LLVM (optional)  10.0.1           clang --version
>   GNU make               3.81             make --version
>   binutils               2.23             ld -v
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 319f92104f56..4edc708baa63 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -17,13 +17,7 @@ binutils)
>   	echo 2.23.0
>   	;;
>   gcc)
> -	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
> -	# https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
> -	if [ "$SRCARCH" = arm64 ]; then
> -		echo 5.1.0
> -	else
> -		echo 4.9.0
> -	fi
> +	echo 5.1.0
>   	;;
>   icc)
>   	# temporary
> 
