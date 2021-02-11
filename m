Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FAE31862F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBKIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBKIPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:15:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03F5D64DE3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613031312;
        bh=r/jjDkP/cNaixfQFqqhPOP8kZqq6pBJzVaqgRc1huUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIa8kKfK1zurap6Cj4bNg5OT+f4K1O0d7w2XaZhYrl/ykskJIXSUbkYhbjyFkl/4U
         2+WXHR4AnVS4FZVHasPuNX7LswrAtilFLzRW6onTCOnwUMMhfgDoQkZ5tX+wWxgZyy
         U8a8DTLH9QxCrEEll9oEPqlKNkX5UVxD+ih2q478LCfltEvtYRJrHn0vA/Mk3bLp0z
         gcYpRA9wFTNlgAtHlXK6eMPY6CcJIT2RWEpePzaxzBojLjEl/NxYTR8VYfcj7pFajM
         Pi7qSNfEDJh6j6oVCrSf297BIfm7XxDaDp+s7I2IV8vHDMzYDLwqdt+HJM20givpyw
         7camNrEu1aECw==
Received: by mail-ot1-f51.google.com with SMTP id c16so4445683otp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:15:11 -0800 (PST)
X-Gm-Message-State: AOAM530Zwi4S/XYCMNiS6ARM2uHYaO8gowiX1jxYKiaVutdJcf8+hVkO
        JYwslSZbHkgQ8pEmJBylPMqDyb40ycEBD4B12sY=
X-Google-Smtp-Source: ABdhPJyQ0MGNmJd3H0wXbZjO7fG51qJ8ZQFZY17m4UPPaEZrGKPBHHOUNzyIIoNjPzi38oUOwKQqhsbaDbVjyw4Q8CU=
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr4884725otp.77.1613031311336;
 Thu, 11 Feb 2021 00:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20210211025149.3544593-1-ndesaulniers@google.com> <20210211025149.3544593-2-ndesaulniers@google.com>
In-Reply-To: <20210211025149.3544593-2-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Feb 2021 09:15:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH9-1=o+UYU0sdKUF1YGDJYyLDvNKExzqkcrWzLB0NWwg@mail.gmail.com>
Message-ID: <CAMj1kXH9-1=o+UYU0sdKUF1YGDJYyLDvNKExzqkcrWzLB0NWwg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ARM: kprobes: fix UNPREDICTABLE warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Smith <peter.smith@arm.com>,
        Renato Golin <rengolin@systemcall.eu>,
        David Spickett <david.spickett@linaro.org>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 at 03:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> GNU as warns twice for this file:
> Warning: using r15 results in unpredictable behaviour
>
> via the Arm ARM:
> K1.1.1 Overview of the constraints on Armv7 UNPREDICTABLE behaviors
>
>   The term UNPREDICTABLE describes a number of cases where the
>   architecture has a feature that software must not use.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1271
> Link: https://reviews.llvm.org/D95586
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Suggested-by: Peter Smith <peter.smith@arm.com>
> Suggested-by: Renato Golin <rengolin@systemcall.eu>
> Suggested-by: David Spickett <david.spickett@linaro.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

But can we add a bit more context to the commit log, please? It is not
obvious to the casual reader why it is OK to emit UNPREDICTABLE
opcodes, i.e., that these are selftests that aim to ensure that kprobe
never attempts to replace the opcodes in question with a probe, but
that they are not actually executed, or expected to occur in real
code.

> ---
>  arch/arm/probes/kprobes/test-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
> index 977369f1aa48..2543106a203e 100644
> --- a/arch/arm/probes/kprobes/test-arm.c
> +++ b/arch/arm/probes/kprobes/test-arm.c
> @@ -166,10 +166,10 @@ void kprobe_arm_test_cases(void)
>
>         /* Data-processing with PC as a target and status registers updated */
>         TEST_UNSUPPORTED("movs  pc, r1")
> -       TEST_UNSUPPORTED("movs  pc, r1, lsl r2")
> +       TEST_UNSUPPORTED(__inst_arm(0xe1b0f211) "       @movs   pc, r1, lsl r2")
>         TEST_UNSUPPORTED("movs  pc, #0x10000")
>         TEST_UNSUPPORTED("adds  pc, lr, r1")
> -       TEST_UNSUPPORTED("adds  pc, lr, r1, lsl r2")
> +       TEST_UNSUPPORTED(__inst_arm(0xe09ef211) "       @adds   pc, lr, r1, lsl r2")
>         TEST_UNSUPPORTED("adds  pc, lr, #4")
>
>         /* Data-processing with SP as target */
> --
> 2.30.0.478.g8a0d178c01-goog
>
