Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09668434638
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:53:10 -0400
Received: from foss.arm.com ([217.140.110.172]:57054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTHxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:53:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E15A2F;
        Wed, 20 Oct 2021 00:50:54 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0273F70D;
        Wed, 20 Oct 2021 00:50:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] arm64: vdso32: drop the test for dmb ishld
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Biesinger <cbiesinger@google.com>,
        Simon Marchi <simon.marchi@polymtl.ca>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-2-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b38653db-15fe-71b0-9d0c-cbf54c6faf4e@arm.com>
Date:   Wed, 20 Oct 2021 09:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019223646.1146945-2-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/21 12:36 AM, Nick Desaulniers wrote:
> Binutils added support for this instruction in commit
> e797f7e0b2bedc9328d4a9a0ebc63ca7a2dbbebc which shipped in 2.24 (just
> missing the 2.33 release) but was cherry-picked into 2.23 in commit

s/just missing the 2.33 release/just missing the 2.23 release/

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

Otherwise:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

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
> 

-- 
Regards,
Vincenzo
