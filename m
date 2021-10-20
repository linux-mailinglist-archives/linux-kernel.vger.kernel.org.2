Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E343463C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:54:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTHyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:54:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DCD2F;
        Wed, 20 Oct 2021 00:52:02 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC533F70D;
        Wed, 20 Oct 2021 00:52:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] arm64: vdso32: drop test for -march=armv8-a
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-3-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fbb4936e-f4b5-47a3-ad3a-b139ab5e3f10@arm.com>
Date:   Wed, 20 Oct 2021 09:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019223646.1146945-3-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/21 12:36 AM, Nick Desaulniers wrote:
> As Arnd points out:
>   gcc-4.8 already supported -march=armv8, and we require gcc-5.1 now, so
>   both this #if/#else construct and the corresponding
>   "cc32-option,-march=armv8-a" check should be obsolete now.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a3UBEJ0Py2ycz=rHfgog8g3mCOeQOwO0Gmp-iz6Uxkapg@mail.gmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

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
> 

-- 
Regards,
Vincenzo
