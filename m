Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD84347A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:10:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 117F2ED1;
        Wed, 20 Oct 2021 02:07:54 -0700 (PDT)
Received: from [10.57.74.74] (unknown [10.57.74.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83A23F70D;
        Wed, 20 Oct 2021 02:07:51 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: vdso32: require CROSS_COMPILE_COMPAT for
 gcc+bfd
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-5-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <94eccd0b-ea36-25af-8140-fa6209a0b222@arm.com>
Date:   Wed, 20 Oct 2021 11:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019223646.1146945-5-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/21 12:36 AM, Nick Desaulniers wrote:
> Similar to
> commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")
> There really is no point in setting --target based on
> $CROSS_COMPILE_COMPAT for clang when the integrated assembler is being
> used, since
> commit ef94340583ee ("arm64: vdso32: drop -no-integrated-as flag").
> 
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
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
> Changes v1 -> v2:
> * Cite ef94340583ee as per Nathan.
> * Add parens to Kconfig expression as per Nathan.
> * Pick up Nathan's RB, TB, and SB tags.
> 
>  arch/arm64/Kconfig                |  3 ++-
>  arch/arm64/kernel/vdso32/Makefile | 17 +++++------------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..f0f2c95aa4c8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1264,7 +1264,8 @@ config KUSER_HELPERS
>  
>  config COMPAT_VDSO
>  	bool "Enable vDSO for 32-bit applications"
> -	depends on !CPU_BIG_ENDIAN && "$(CROSS_COMPILE_COMPAT)" != ""
> +	depends on !CPU_BIG_ENDIAN
> +	depends on (CC_IS_CLANG && LD_IS_LLD) || "$(CROSS_COMPILE_COMPAT)" != ""
>  	select GENERIC_COMPAT_VDSO
>  	default y
>  	help
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index e478cebb9891..c8fec493a450 100644
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
> @@ -45,10 +42,6 @@ VDSO_CPPFLAGS += $(LINUXINCLUDE)
>  # Common C and assembly flags
>  # From top-level Makefile
>  VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
> -ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
> -VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> -endif
> -
>  VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
>  ifdef CONFIG_DEBUG_INFO
>  VDSO_CAFLAGS += -g
> 

-- 
Regards,
Vincenzo
