Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82C360A85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhDONbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:31:34 -0400
Received: from foss.arm.com ([217.140.110.172]:46242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhDONbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:31:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 581A711B3;
        Thu, 15 Apr 2021 06:31:09 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E393F694;
        Thu, 15 Apr 2021 06:31:07 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: vdso32: drop -no-integrated-as flag
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <YHYlQnFRMNdn/CDp@archlinux-ax161>
 <20210414214548.700993-1-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a2ddf4d2-110a-9290-f766-3925e451ddef@arm.com>
Date:   Thu, 15 Apr 2021 14:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210414214548.700993-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/21 10:45 PM, Nick Desaulniers wrote:
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

The patch looks fine, but I have one question: the kernel requires as a minimum
Clang/LLVM version 10.0.1. Did you verify that with that version compat vDSOs
still builds and works correctly?

Otherwise:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

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
> 

-- 
Regards,
Vincenzo
