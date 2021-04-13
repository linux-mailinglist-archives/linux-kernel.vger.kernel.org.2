Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334C135E991
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbhDMXM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348771AbhDMXM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A3C360238;
        Tue, 13 Apr 2021 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618355527;
        bh=theE9w+VmO2/VI5mSH45o6r0hr0DMFTHT8weF9dix0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0LuWHUYpOtZEqB9zMMa7I5H5bKdRPfEy8BDEKIENENB7b+3nkgVW9Tbgq65Z+VbQ
         YIEcyR0qUqG0OQPoJIRbO4EJ9tn268lYbEkIRK0xuNAOUVh/NQbjoRU+DsEmkSk3eZ
         b0jdJRvTaEnrw2SMezZm6KkcMlXy0Ic4SdRw/zCwB7fpWo+hiKY8hU+M+08SwF5l60
         WU2ssACNqOnDQwPoSaS3l/X2KP4ZA27iX91n5MAzgYr4oy9zVHNJSji+SwgwkbW4WD
         1abFBlUnsaKANcU6vvDsW4qN2Ok+KSdXYKdGrB/UMMdEyLdotKGlfbbTKfM3Cf+/HP
         38SWTtx2gD4Jw==
Date:   Tue, 13 Apr 2021 16:12:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, vincenzo.frascino@arm.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bill Wendling <morbo@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: vdso32: drop -no-integrated-as flag
Message-ID: <YHYlQnFRMNdn/CDp@archlinux-ax161>
References: <20210413230609.3114365-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413230609.3114365-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:06:06PM -0700, Nick Desaulniers wrote:
> Clang can assemble these files just fine; this is a relic from the top
> level Makefile conditionally adding this.
> 
> To test building:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
>   defconfig arch/arm64/kernel/vdso32/
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/kernel/vdso32/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 789ad420f16b..7812717f8b79 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -15,7 +15,7 @@ COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
>  
>  CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
>  CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
> -CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
> +CC_COMPAT_CLANG_FLAGS += -Qunused-arguments

Might as well just eliminate '--prefix=' and '--gcc-toolchain=' along
with the variables COMPAT_GCC_TOOLCHAIN_DIR and COMPAT_GCC_TOOLCHAIN
while you are at it, they serve no purpose without '-no-integrated-as'.

>  ifneq ($(COMPAT_GCC_TOOLCHAIN),)
>  CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
>  endif
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
> 
