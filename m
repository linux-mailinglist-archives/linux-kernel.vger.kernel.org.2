Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025834329F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJRXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJRXBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC38E61206;
        Mon, 18 Oct 2021 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634597933;
        bh=oQS1gnif76R1Tzpn5qPUeGsIeSV8pSPk8uD/hVEsKRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBsOIiczEOKh8+V3rI/Vtv/nngXPsECA/IsvhIO/z7DoLRDYSm2V6eIpitoCaXfTr
         hWby6hERmCjV5AkB31V4gXjLFOWhXOtt7LS3s+e8ux6VCYaTACKTS8k/Rou/nc4mOB
         MLVOhYv6CryM/DwwPwP+PQWKCs55YI+2ZhTyrEDqeN24i0qZf3pTokbwIErhOhJla4
         X6mwMyXJKpKWQbkAzKwCqWYRzIo2GbZHhTHzbG6lSaU7/kmapA1moP+3vrI2Ep3ogO
         M/FCooJ+NNJPN2LDf7OHWrsYUrzxeaKaW1rYTrFP+F+wBtXMtBimJLmo6kH9bNlGZh
         //S3JdVh0J4pg==
Date:   Mon, 18 Oct 2021 15:58:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 3/3] arm64: vdso32: require CROSS_COMPILE_COMPAT for
 gcc+bfd
Message-ID: <YW38KOA8ct12F7IG@archlinux-ax161>
References: <20211012234606.91717-1-ndesaulniers@google.com>
 <20211012234606.91717-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012234606.91717-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 04:46:06PM -0700, Nick Desaulniers wrote:
> Similar to
> commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")
> There really is no point in setting --target based on
> $CROSS_COMPILE_COMPAT for clang when the integrated assembler is being
> used.

It might be nice to mention commit ef94340583ee ("arm64: vdso32: drop
-no-integrated-as flag") here, as that is what flipped on the integrated
assembler for this Makefile (and it cannot be turned off).

> Allows COMPAT_VDSO to be selected without setting $CROSS_COMPILE_COMPAT
> when using clang and lld together.
> 
> Before:
> $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 defconfig
> $ grep CONFIG_COMPAT_VDSO .config
> CONFIG_COMPAT_VDSO=y
> $ ARCH=arm64 make -j72 LLVM=1 defconfig
> $ grep CONFIG_COMPAT_VDSO .config
> $
> 
> After:
> $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 defconfig
> $ grep CONFIG_COMPAT_VDSO .config
> CONFIG_COMPAT_VDSO=y
> $ ARCH=arm64 make -j72 LLVM=1 defconfig
> $ grep CONFIG_COMPAT_VDSO .config
> CONFIG_COMPAT_VDSO=y
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Modulo these two nits, this works for me too.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/Kconfig                |  3 ++-
>  arch/arm64/kernel/vdso32/Makefile | 17 +++++------------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..7b28dad2fb80 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1264,7 +1264,8 @@ config KUSER_HELPERS
>  
>  config COMPAT_VDSO
>  	bool "Enable vDSO for 32-bit applications"
> -	depends on !CPU_BIG_ENDIAN && "$(CROSS_COMPILE_COMPAT)" != ""
> +	depends on !CPU_BIG_ENDIAN
> +	depends on CC_IS_CLANG && LD_IS_LLD || "$(CROSS_COMPILE_COMPAT)" != ""

It works fine as is but it might be nice to add parentheses around the
new condition for ease of understanding.

>  	select GENERIC_COMPAT_VDSO
>  	default y
>  	help
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index d24b12318f4c..376261d3791f 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -10,18 +10,15 @@ include $(srctree)/lib/vdso/Makefile
>  
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
> -CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> -
>  CC_COMPAT ?= $(CC)
> -CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
> -
> -ifneq ($(LLVM),)
> -LD_COMPAT ?= $(LD)
> +CC_COMPAT += --target=arm-linux-gnueabi
>  else
> -LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)ld
> +CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  endif
> +
> +ifeq ($(CONFIG_LD_IS_LLD), y)
> +LD_COMPAT ?= $(LD)
>  else
> -CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)ld
>  endif
>  
> @@ -44,10 +41,6 @@ VDSO_CPPFLAGS += $(LINUXINCLUDE)
>  # Common C and assembly flags
>  # From top-level Makefile
>  VDSO_CAFLAGS = $(VDSO_CPPFLAGS)
> -ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
> -VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> -endif
> -
>  VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
>  ifdef CONFIG_DEBUG_INFO
>  VDSO_CAFLAGS += -g
> -- 
> 2.33.0.882.g93a45727a2-goog
> 
> 
