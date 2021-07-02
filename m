Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6923F3B9FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhGBLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhGBLYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FDE5613F4;
        Fri,  2 Jul 2021 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625224935;
        bh=NAwtCL2bEeXmRZrt0BC0gPfCUoaxfOcDVf4HdonjzPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGiQKFEpmAppwMG1AQ9lOE5jAJ3UNX1yNVdynm0Sc0CFEZX59bJdveQXQ6i+4mhcM
         KrPSBGgueAVmXwIVK/f3pTNzj+Xhdnt1z8dePxQsupvavSlGn6jEGjafU25A/n4dZZ
         oHKc17gVj+76hPCtreciV9gwWPI3qCLeYeuMdICzf407UDCw4oX/u26EEjrBtHPVeB
         iqvdly/7UgMbr4I9pJXAMgurt/67Ly/UP2Ww+CdAIcJG4huvHFEPHaSHMgqwGp+AbR
         QaGkS1W7aPWCWEobhbiyF5XleJ03SLyIe5gg5xWzs6q+frTPxEThJOcaMOjL5HUUBf
         zv95HkMfoqXNg==
Date:   Fri, 2 Jul 2021 12:22:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
Message-ID: <20210702112210.GA11084@willie-the-truck>
References: <20210701235505.1792711-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701235505.1792711-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 04:55:05PM -0700, Nick Desaulniers wrote:
> We get constant feedback that the command line invocation of make is too
> long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
> target triple, or is an absolute path outside of $PATH, but it's mostly
> redundant for a given ARCH.
> 
> If CROSS_COMPILE is not set, simply set --target=aarch64-linux for
> CLANG_FLAGS, KBUILD_CFLAGS, and KBUILD_AFLAGS.
> 
> Previously, we'd cross compile via:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linxu-gnu make LLVM=1 LLVM_IAS=1
> Now:
> $ ARCH=arm64 make LLVM=1 LLVM_IAS=1
> 
> We can drop gnu from the triple, but dropping linux from the triple
> produces different .config files for the above invocations for the
> defconfig target.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1399
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7bc37d0a1b68..016873fddcc3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -34,6 +34,17 @@ $(warning LSE atomics not supported by binutils)
>    endif
>  endif
>  
> +ifneq ($(LLVM),)
> +ifneq ($(LLVM_IAS),)
> +ifeq ($(CROSS_COMPILE),)
> +CLANG_TARGET	:=--target=aarch64-linux
> +CLANG_FLAGS	+= $(CLANG_TARGET)
> +KBUILD_CFLAGS	+= $(CLANG_TARGET)
> +KBUILD_AFLAGS	+= $(CLANG_TARGET)

Do we need to do anything extra for the linker here? I can't see how we
avoid picking up the host copy.

> +endif
> +endif
> +endif

Have you tested the compat vDSO with this change? I think we'll just end
up passing two --target options, which is hopefully ok, but thought I'd
better check.

Will
