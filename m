Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6737535FECA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhDOASL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhDOASK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8894161158;
        Thu, 15 Apr 2021 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618445868;
        bh=3tKMa9OM+j6Bp1Khy/F8FqbFzD18WEmNIoiuFi/JtKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syL0Jg0utGBRZBybe+TlxsYLruJttWQPS3KodBhGYTmFhOxLBy7HCOYsUGA7hJJAk
         +KQ6D+gMhVEwcTHQQ9MusEiaNHp2fKjuIzrJ1RU1eBePvEQoPQ9+exI1ZLrm910wY8
         yhH6gUih86XWrEc8xcPH+lOcP22yfK77rOXyugn010ajAax2gMSAzzzuDsARSDfruG
         IhTfA+z7djVb5vkjsf5Qf6a5UEu5wnGqWUm7wx791xySsAyDO6pi1XApOBCDy4eWoE
         kI/kqMBvpf75A0wpI/lioCIRXlJR54xBtLt4zgnEVE3GKDF9jeNi2xUxoNqcN5d64p
         kh5NRBo3fvjqw==
Date:   Wed, 14 Apr 2021 17:17:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, vincenzo.frascino@arm.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: vdso32: drop -no-integrated-as flag
Message-ID: <YHeGJzhIhSFJLprr@archlinux-ax161>
References: <YHYlQnFRMNdn/CDp@archlinux-ax161>
 <20210414214548.700993-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414214548.700993-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:45:45PM -0700, Nick Desaulniers wrote:
> Clang can assemble these files just fine; this is a relic from the top
> level Makefile conditionally adding this. We no longer need --prefix,
> --gcc-toolchain, or -Qunused-arguments flags either with this change, so
> remove those too.
> 
> To test building:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
>   defconfig arch/arm64/kernel/vdso32/
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes V1 -> V2:
> * Remove --prefix, --gcc-toolchain, COMPAT_GCC_TOOLCHAIN, and
>   COMPAT_GCC_TOOLCHAIN_DIR as per Nathan.
> * Credit Nathan with Suggested-by tag.
> * Remove -Qunused-arguments.
> * Update commit message.
> 
>  arch/arm64/kernel/vdso32/Makefile | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 789ad420f16b..3dba0c4f8f42 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -10,15 +10,7 @@ include $(srctree)/lib/vdso/Makefile
>  
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
> -COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
> -COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
> -
>  CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> -CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
> -CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
> -ifneq ($(COMPAT_GCC_TOOLCHAIN),)
> -CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
> -endif
>  
>  CC_COMPAT ?= $(CC)
>  CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
> 
