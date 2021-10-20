Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7E4342A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJTAqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTAqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:46:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9992260FC2;
        Wed, 20 Oct 2021 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634690637;
        bh=V4ph25lcqZI+SXf9l4Jn+tmIyHyFXeQV6USdcgKzILo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXKg7H+2O9ebtqUXEQiwuP/ASR/7fX4uSbKPsxWNeildN8Ggq3dOv2DsIk0wEZNJn
         0Qum17SoRf2DzkOVKd9gRWQhk7/+jXZxr957GJTvMKqDrmENweY5f1+O9gZhcjn8rk
         4mTAOLlB2qfJfkXXYK5fcxqzGjSbgP4YALfwRzflxH9Q+XN4isCmeq1VkwgEKoEYm7
         /fSOOINtb25AxtlLtwCbl5TbQl0s859Z+GhjTP6br4qg4bWMrf7RBpfajH5yfLG80i
         IZ424L7YP5lEJNnOCrsEfA5Q8XQ+nU1+AjHuhA6HMiZeW2/pR3v0RsPG5YRsBnRzYS
         HF3WLlrEmtMTQ==
Date:   Tue, 19 Oct 2021 17:43:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] arm64: vdso32: drop test for -march=armv8-a
Message-ID: <YW9mRwwaUmKW8hmL@archlinux-ax161>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019223646.1146945-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:36:44PM -0700, Nick Desaulniers wrote:
> As Arnd points out:
>   gcc-4.8 already supported -march=armv8, and we require gcc-5.1 now, so
>   both this #if/#else construct and the corresponding
>   "cc32-option,-march=armv8-a" check should be obsolete now.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a3UBEJ0Py2ycz=rHfgog8g3mCOeQOwO0Gmp-iz6Uxkapg@mail.gmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/include/asm/vdso/compat_barrier.h | 7 -------
>  arch/arm64/kernel/vdso32/Makefile            | 8 +-------
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> index fb60a88b5ed4..3ac35f4a667c 100644
> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -20,16 +20,9 @@
>  
>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>  
> -#if __LINUX_ARM_ARCH__ >= 8
>  #define aarch32_smp_mb()	dmb(ish)
>  #define aarch32_smp_rmb()	dmb(ishld)
>  #define aarch32_smp_wmb()	dmb(ishst)
> -#else
> -#define aarch32_smp_mb()	dmb(ish)
> -#define aarch32_smp_rmb()	aarch32_smp_mb()
> -#define aarch32_smp_wmb()	dmb(ishst)
> -#endif
> -
>  
>  #undef smp_mb
>  #undef smp_rmb
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 89299a26638b..1407516e041e 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -65,13 +65,7 @@ endif
>  # From arm vDSO Makefile
>  VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
>  VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
> -
> -
> -# Try to compile for ARMv8. If the compiler is too old and doesn't support it,
> -# fall back to v7. There is no easy way to check for what architecture the code
> -# is being compiled, so define a macro specifying that (see arch/arm/Makefile).
> -VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
> -                                   -march=armv7-a -D__LINUX_ARM_ARCH__=7)
> +VDSO_CAFLAGS += -march=armv8-a
>  
>  VDSO_CFLAGS := $(VDSO_CAFLAGS)
>  VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 
> 
