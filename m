Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA743429E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhJTAor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTAoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E33B60E90;
        Wed, 20 Oct 2021 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634690552;
        bh=plz2dXACkLeS1ejUloFk0H4fP51t8YwabjFrR4+2SMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZIXFJKuG68ZR5y21h4rcUEV2OZfTkkgH6PpVPPRDSvjSl+XbXoUd23APNOEABFBJ
         IyprQ6Lx/Qf2VgQ/H3YG9FLhtedjiIf4ql26n96M4zKDK7SO7amxec5ReI6kuCvHb5
         QCSmGqh771iCr0DLwxxVKDRC/XDC3jlyu/yGKnquyv5WN3iR8cl+YMQmYbW0z787SP
         clcI0aE9xMATaowktzXwrqKMDmfdl4b+tX/dh962csmjtLSoaCXkHivM1IuXdVxxtl
         0F+SCh7RBmfoAxwQGAlSGsFrU5y9VGZo6qLxbEvuL+DNZBdNhMvFIul4aF4kFMmEzf
         Y6YFu68DA/CDg==
Date:   Tue, 19 Oct 2021 17:42:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christian Biesinger <cbiesinger@google.com>,
        Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH v2 1/4] arm64: vdso32: drop the test for dmb ishld
Message-ID: <YW9l8XWpj4vPnrry@archlinux-ax161>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019223646.1146945-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:36:43PM -0700, Nick Desaulniers wrote:
> Binutils added support for this instruction in commit
> e797f7e0b2bedc9328d4a9a0ebc63ca7a2dbbebc which shipped in 2.24 (just
> missing the 2.33 release) but was cherry-picked into 2.23 in commit

              ^ 2.23, almost :)

> 27a50d6755bae906bc73b4ec1a8b448467f0bea1. Thanks to Christian and Simon
> for helping me with the patch archaeology.
> 
> According to Documentation/process/changes.rst, the minimum supported
> version of binutils is 2.23. Since all supported versions of GAS support
> this instruction, drop the assembler invocation, preprocessor
> flags/guards, and the cross assembler macro that's now unused.
> 
> This also avoids a recursive self reference in a follow up cleanup
> patch.
> 
> Cc: Christian Biesinger <cbiesinger@google.com>
> Cc: Simon Marchi <simon.marchi@polymtl.ca>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I can also see this instruction in llvmorg-10.0.1.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Fix typos (2.33 -> 2.23, 2.34 -> 2.24) as per Christian.
> 
>  arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
>  arch/arm64/kernel/vdso32/Makefile            | 8 --------
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> index 3fd8fd6d8fc2..fb60a88b5ed4 100644
> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -20,7 +20,7 @@
>  
>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>  
> -#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
> +#if __LINUX_ARM_ARCH__ >= 8
>  #define aarch32_smp_mb()	dmb(ish)
>  #define aarch32_smp_rmb()	dmb(ishld)
>  #define aarch32_smp_wmb()	dmb(ishst)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 3dba0c4f8f42..89299a26638b 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -29,8 +29,6 @@ cc32-option = $(call try-run,\
>          $(CC_COMPAT) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
>  cc32-disable-warning = $(call try-run,\
>  	$(CC_COMPAT) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
> -cc32-as-instr = $(call try-run,\
> -	printf "%b\n" "$(1)" | $(CC_COMPAT) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
>  
>  # We cannot use the global flags to compile the vDSO files, the main reason
>  # being that the 32-bit compiler may be older than the main (64-bit) compiler
> @@ -113,12 +111,6 @@ endif
>  VDSO_AFLAGS := $(VDSO_CAFLAGS)
>  VDSO_AFLAGS += -D__ASSEMBLY__
>  
> -# Check for binutils support for dmb ishld
> -dmbinstr := $(call cc32-as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
> -
> -VDSO_CFLAGS += $(dmbinstr)
> -VDSO_AFLAGS += $(dmbinstr)
> -
>  # From arm vDSO Makefile
>  VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
>  VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 
> 
