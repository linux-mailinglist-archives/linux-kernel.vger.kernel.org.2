Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1705413704
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhIUQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhIUQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D2D6109E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632240640;
        bh=bAldkGT1KZhhvTWfYngvRKeHQG7fmSDZj/NQp6bHybE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwB640c5jCmMTPj33qx41CF3mb7yt6f7TqqCaKremz0JlbubTl5kQPuimj7Ibs0yy
         RxM7q2xTwCTWAqOh8sM/1GKpkTDTUP2CvmqhkHiVFsqTYoUM6Aajr/I9gKswSUD5rE
         8YxE5UYymK1mJatMcvY/dMUiw5l0Yx/wDFHrotoeWKECpqHW+PDnSqkVUpa45lJ0m3
         MntQMqKjPO8T5UlfoCLy95Tn0r6Q/MFeWHPo3WS6HOs0WOn21OaO4WBpv8cA2F7bY2
         P/8FR9VinBxs0kQgePDaCjLv1WSGvpJyFNQDtrQgFv8zAMjJGZPxWlFbhpvsbGOMPl
         UwktwWnwkZ3Jw==
Received: by mail-ot1-f42.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso28959490otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:10:40 -0700 (PDT)
X-Gm-Message-State: AOAM531k0ts8ysNNegHoXJVKi/nWEx+yonOpdxf4EB56deBvlyoQHBwb
        Rm4TbPZB+had+mKmJvVDbeXahNFhulH7EQF/1Og=
X-Google-Smtp-Source: ABdhPJzOFpVA+DRmsJCeYWhReP0pe18aXk+Qkb/5jCa9UaD/SAmdRUg+Hn/iydP2iggJxG17VdX91dxeEEhupreuSy8=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr26024727ota.30.1632240639935;
 Tue, 21 Sep 2021 09:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210920233237.90463-1-frederic@kernel.org> <20210920233237.90463-3-frederic@kernel.org>
In-Reply-To: <20210920233237.90463-3-frederic@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Sep 2021 18:10:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH7NRec5edgROQGfA-SCjBFrq8ON3wrJQb+KYFudEQYYw@mail.gmail.com>
Message-ID: <CAMj1kXH7NRec5edgROQGfA-SCjBFrq8ON3wrJQb+KYFudEQYYw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 01:32, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> [fweisbec: rebased against 5.15-rc2. There has been quite some changes
>  on arm64 since then, especially with insn/patching, so some naming may
>  not be relevant anymore]
>

This patch does not include the static_call.c file references to which
are being added below.


> Implement arm64 support for the 'unoptimized' static call variety, which
> routes all calls through a single trampoline that is patched to perform a
> tail call to the selected function.
>
> Since static call targets may be located in modules loaded out of direct
> branching range, we need to use a ADRP/ADD pair to load the branch target
> into R16 and use a branch-to-register (BR) instruction to perform an
> indirect call. Unlike on x86, there is no pressing need on arm64 to avoid
> indirect calls at all cost, but hiding it from the compiler as is done
> here does have some benefits:
> - the literal is located in .rodata, which gives us the same robustness
>   advantage that code patching does;
> - no performance hit on CFI enabled Clang builds that decorate compiler
>   emitted indirect calls with branch target validity checks.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/insn.h        |  2 ++
>  arch/arm64/include/asm/static_call.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/Makefile           |  4 ++--
>  arch/arm64/kernel/patching.c         | 14 +++++++++++---
>  arch/arm64/kernel/vmlinux.lds.S      |  1 +
>  6 files changed, 45 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/include/asm/static_call.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..5b51b359ccda 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -192,6 +192,7 @@ config ARM64
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_REGS_AND_STACK_ACCESS_API
> +       select HAVE_STATIC_CALL
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_FUTEX_CMPXCHG if FUTEX
>         select MMU_GATHER_RCU_TABLE_FREE
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 6b776c8667b2..681c08b170df 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -547,6 +547,8 @@ u32 aarch64_set_branch_offset(u32 insn, s32 offset);
>  s32 aarch64_insn_adrp_get_offset(u32 insn);
>  u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset);
>
> +int aarch64_literal_write(void *addr, u64 literal);
> +
>  bool aarch32_insn_is_wide(u32 insn);
>
>  #define A32_RN_OFFSET  16
> diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
> new file mode 100644
> index 000000000000..665ec2a7cdb2
> --- /dev/null
> +++ b/arch/arm64/include/asm/static_call.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_STATIC_CALL_H
> +#define _ASM_STATIC_CALL_H
> +
> +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)                      \
> +       asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> +           "   .align          3                                       \n" \
> +           "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> +           STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> +           "   hint    34      /* BTI C */                             \n" \
> +           "   adrp    x16, 1f                                         \n" \
> +           "   ldr     x16, [x16, :lo12:1f]                            \n" \
> +           "   cbz     x16, 0f                                         \n" \
> +           "   br      x16                                             \n" \
> +           "0: ret                                                     \n" \
> +           "   .popsection                                             \n" \
> +           "   .pushsection    .rodata, \"a\"                          \n" \
> +           "   .align          3                                       \n" \
> +           "1: .quad           " target "                              \n" \
> +           "   .popsection                                             \n")
> +
> +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                      \
> +       __ARCH_DEFINE_STATIC_CALL_TRAMP(name, #func)
> +
> +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)                       \
> +       __ARCH_DEFINE_STATIC_CALL_TRAMP(name, "0x0")
> +
> +#endif /* _ASM_STATIC_CALL_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 3f1490bfb938..83f03fc1e402 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -28,8 +28,8 @@ obj-y                 := debug-monitors.o entry.o irq.o fpsimd.o              \
>                            return_address.o cpuinfo.o cpu_errata.o              \
>                            cpufeature.o alternative.o cacheinfo.o               \
>                            smp.o smp_spin_table.o topology.o smccc-call.o       \
> -                          syscall.o proton-pack.o idreg-override.o idle.o      \
> -                          patching.o
> +                          syscall.o proton-pack.o static_call.o                \
> +                          idreg-override.o idle.o patching.o
>
>  targets                        += efi-entry.o
>
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 771f543464e0..841c0499eca5 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -66,7 +66,7 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
>         return ret;
>  }
>
> -static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
> +static int __kprobes __aarch64_insn_write(void *addr, void *insn, int size)
>  {
>         void *waddr = addr;
>         unsigned long flags = 0;
> @@ -75,7 +75,7 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
>         raw_spin_lock_irqsave(&patch_lock, flags);
>         waddr = patch_map(addr, FIX_TEXT_POKE0);
>
> -       ret = copy_to_kernel_nofault(waddr, &insn, AARCH64_INSN_SIZE);
> +       ret = copy_to_kernel_nofault(waddr, insn, size);
>
>         patch_unmap(FIX_TEXT_POKE0);
>         raw_spin_unlock_irqrestore(&patch_lock, flags);
> @@ -85,7 +85,15 @@ static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
>
>  int __kprobes aarch64_insn_write(void *addr, u32 insn)
>  {
> -       return __aarch64_insn_write(addr, cpu_to_le32(insn));
> +       __le32 i = cpu_to_le32(insn);
> +
> +       return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
> +}
> +
> +int aarch64_literal_write(void *addr, u64 literal)
> +{
> +       BUG_ON(!IS_ALIGNED((u64)addr, sizeof(u64)));
> +       return __aarch64_insn_write(addr, &literal, sizeof(u64));
>  }
>
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index f6b1a88245db..ceb35c35192c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -161,6 +161,7 @@ SECTIONS
>                         IDMAP_TEXT
>                         HIBERNATE_TEXT
>                         TRAMP_TEXT
> +                       STATIC_CALL_TEXT
>                         *(.fixup)
>                         *(.gnu.warning)
>                 . = ALIGN(16);
> --
> 2.25.1
>
