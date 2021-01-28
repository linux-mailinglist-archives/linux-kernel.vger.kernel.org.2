Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F9308032
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhA1VFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhA1VEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:04:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFE264DDB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611867824;
        bh=JBSZ375WJlziPc8IkBIEWR8IoEzKi9IPQzpDywAMojI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UPJGoyaqhs6dbrUavFs1Gl4t5yvKUjFfHrC3veAfpTI9fGkIQKFtYfy5+612Hv41m
         WQb98DWs0/WXQMRyFf8g0kGrhgGxy0eG1LQyok9nbWmnye5mg0VtI9yDrMppDYuHK5
         JyC+jTNc6H+iaHFFgfWjlGzD519uxod4rlRBs+G4BPnaGgJ+WBk8j8WuhvFhTnYy5N
         EBKED6bxwR5QjV6Rmdi+TZZr/H6APr1txT0n0M+oRna6MgNIMLLAdizT2o2ksvkCje
         ZK+Jh24/szCPGZeI90MnMeLRFE5rza6XrlYEYK/E6Z4y3b2+AW0Vz2UkhCa7uv5lv7
         XSe37Wc7WuaZw==
Received: by mail-ot1-f53.google.com with SMTP id i20so6583924otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:03:43 -0800 (PST)
X-Gm-Message-State: AOAM531ZDCEDPLBDxO1rR+ZN+56uo74C9jqIaIK9dMqkYfA1gAa8P1jX
        //+wPvTUX464VEC5G0tl2tyd7LDGRbg4jbP1syI=
X-Google-Smtp-Source: ABdhPJwANfiDkq45GcQ8TY1kyJCCbFl23aI+w/GzPKk5y1KWtTbpKrhNUrC/31AlqaVbjioA8sRQFJi0KrSe7acf1z4=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr923100otr.90.1611867823223;
 Thu, 28 Jan 2021 13:03:43 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com>
In-Reply-To: <20210128193422.241155-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 28 Jan 2021 22:03:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
Message-ID: <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: rewrite test-[arm|thumb].c in UAL
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Clang's integrated assembler only accepts UAL syntax, rewrite the
> instructions that were changed by RVCTv2.1.
>
> The document "Assembly language changes after RVCTv2.1" was very
> helpful.
>
> This exposed a bug in Clang's integrated assembler, which hopefully will
> land in clang-12, but is required to test this patch with LLVM_IAS=1.
>
> Link: https://developer.arm.com/documentation/dui0473/c/writing-arm-assembly-language/assembly-language-changes-after-rvctv2-1
> Link: https://github.com/ClangBuiltLinux/linux/issues/1271
> Link: https://reviews.llvm.org/D95586
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> * Fix additonal swpvsb case in test-arm.c when __LINUX_ARM_ARCH__ < 6,
>   reported by Arnd.
> * Fix arch/arm/probes/kprobes/test-thumb.c, reported by Arnd.
> * Modify the oneline to note I'm modifying test-*.c.
>
>  arch/arm/probes/kprobes/test-arm.c   | 290 +++++++++++++--------------
>  arch/arm/probes/kprobes/test-thumb.c |  20 +-
>  2 files changed, 155 insertions(+), 155 deletions(-)
>
...
> diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
> index 456c181a7bfe..63277c1006b9 100644
> --- a/arch/arm/probes/kprobes/test-thumb.c
> +++ b/arch/arm/probes/kprobes/test-thumb.c
> @@ -441,21 +441,21 @@ void kprobe_thumb32_test_cases(void)
>                 "3:     mvn     r0, r0  \n\t"
>                 "2:     nop             \n\t")
>
> -       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,"]",
> +       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,", lsl #1]",

Why is this change needed? Are the resulting opcodes equivalent? Does
GAS infer the lsl #1 but Clang doesn't?

>                 "9:                     \n\t"
>                 ".short (2f-1b-4)>>1    \n\t"
>                 ".short (3f-1b-4)>>1    \n\t"
>                 "3:     mvn     r0, r0  \n\t"
>                 "2:     nop             \n\t")
>
> -       TEST_RX("tbh    [pc, r",12, ((9f-(1f+4))>>1)+1,"]",
> +       TEST_RX("tbh    [pc, r",12, ((9f-(1f+4))>>1)+1,", lsl #1]",
>                 "9:                     \n\t"
>                 ".short (2f-1b-4)>>1    \n\t"
>                 ".short (3f-1b-4)>>1    \n\t"
>                 "3:     mvn     r0, r0  \n\t"
>                 "2:     nop             \n\t")
>
> -       TEST_RRX("tbh   [r",1,9f, ", r",14,1,"]",
> +       TEST_RRX("tbh   [r",1,9f, ", r",14,1,", lsl #1]",
>                 "9:                     \n\t"
>                 ".short (2f-1b-4)>>1    \n\t"
>                 ".short (3f-1b-4)>>1    \n\t"
> @@ -468,15 +468,15 @@ void kprobe_thumb32_test_cases(void)
>
>         TEST_UNSUPPORTED("strexb        r0, r1, [r2]")
>         TEST_UNSUPPORTED("strexh        r0, r1, [r2]")
> -       TEST_UNSUPPORTED("strexd        r0, r1, [r2]")
> +       TEST_UNSUPPORTED("strexd        r0, r1, r2, [r2]")
>         TEST_UNSUPPORTED("ldrexb        r0, [r1]")
>         TEST_UNSUPPORTED("ldrexh        r0, [r1]")
> -       TEST_UNSUPPORTED("ldrexd        r0, [r1]")
> +       TEST_UNSUPPORTED("ldrexd        r0, r1, [r1]")
>
>         TEST_GROUP("Data-processing (shifted register) and (modified immediate)")
>
>  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \

What is wrong with these .w suffixes? Shouldn't the assembler accept
these even on instructions that only exist in a wide encoding?

>         TEST_RR(op s"   r1,  r",1, VAL1,", r",2, val, ", lsl #3")               \
>         TEST_RR(op s"   r2,  r",3, VAL1,", r",2, val, ", lsr #4")               \
>         TEST_RR(op s"   r3,  r",3, VAL1,", r",2, val, ", asr #5")               \
> @@ -764,7 +764,7 @@ CONDITION_INSTRUCTIONS(22,
>         TEST("nop.w")
>         TEST("wfi.w")
>         TEST_SUPPORTED("wfe.w")
> -       TEST_UNSUPPORTED("dbg.w #0")
> +       TEST_UNSUPPORTED("dbg   #0")
>
>         TEST_UNSUPPORTED("clrex")
>         TEST_UNSUPPORTED("dsb")
> @@ -790,9 +790,9 @@ CONDITION_INSTRUCTIONS(22,
>         TEST_BB(  "b.w  2b")
>         TEST_BF_X("b.w  2f", SPACE_0x1000)
>
> -       TEST_BF(  "bl.w 2f")
> -       TEST_BB(  "bl.w 2b")
> -       TEST_BB_X("bl.w 2b", SPACE_0x1000)
> +       TEST_BF(  "bl   2f")
> +       TEST_BB(  "bl   2b")
> +       TEST_BB_X("bl   2b", SPACE_0x1000)
>
>         TEST_X( "blx    __dummy_arm_subroutine",
>                 ".arm                           \n\t"
> --
> 2.30.0.365.g02bc693789-goog
>
