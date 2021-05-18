Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F63386E06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhERAEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbhERAEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:04:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC53C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:02:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y2so10824146ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMz/zphNmmGURF/lxitDLAzk83DBOjUJRt7dfNy2yaY=;
        b=eY/9ir7JxHasLPNouYJva2WO9FVdixDpt5z7irLXCghbs8EguU8DAQri3Z6icQlrad
         uGOpTezWav3LfkuiqOf4VRfzD40eIE+dXfKCFdMWWOKu2m8Ji8hNedoe+vZcdkQMoq9d
         LIj87mX2OTvgxWXOYmyLRLB6FUuMKH+dWMHkUdZvcpth93ExRY0txwsihy4DSj8rPc+i
         DFL9aom08xDfqZiXeGiCq4Lhu6DoQjjToSGgdyekXLFxkXGFp+eb3XMDcJL+f4g4Pm6y
         WX2ZRAlcLMBs+AGhGUbF8R1xtt+kUwP6oB5VwqbfvI2p5dYer2Mp8h6LAmeB91ZRtrXP
         PufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMz/zphNmmGURF/lxitDLAzk83DBOjUJRt7dfNy2yaY=;
        b=eIfMnB6Sjdc1dhqGDY7VS/ElBx7jEFrkBeA7g64yqYMTv0camz521TAVtBntgGZkEN
         fPKVNJQ9a/bhupCvAMf9k2MrRJmJbRnTdip9U9byiIMN0/y/koqpyCm6G6n0O8pGer6c
         iRJHMQ/kX0GKq5gl/8cHrJCmOQGZ9DMHt8vSYRXQld4Tya0bboypirGSa/bVbsOeWg9Z
         Urs18zX/c9ASRom9xq56p6Q2KFc3lp++DY6WtWOL5cG3IVQhtcQr/a/VIt+9Uzw7HmcC
         yXeBIdr672nJajfsV3QFyIATI0V47WhF9E1HfHOgtVO9T6KnZp3ZNR/D/2rl8bV4cWyV
         CyIw==
X-Gm-Message-State: AOAM533z15OT3honOcPO/pzoOYP/AfzCp+kc0p99IB1vG7bO6a2YM5Ww
        rcnLx8U0AV8y8ipDUnb5lvZhVRU/G/AT/ds04LKdmg==
X-Google-Smtp-Source: ABdhPJx/opWmutzYy1EDEggtb+0ZhPNPLWPxgk4oiV47gBidnclEIhbY+iSKqqJWznz9qpgd3+Jvh3Wq2nuqCEK5uk0=
X-Received: by 2002:a25:c591:: with SMTP id v139mr3326222ybe.511.1621296167996;
 Mon, 17 May 2021 17:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210329221209.1718079-1-ndesaulniers@google.com>
In-Reply-To: <20210329221209.1718079-1-ndesaulniers@google.com>
From:   Jian Cai <jiancai@google.com>
Date:   Mon, 17 May 2021 17:02:37 -0700
Message-ID: <CA+SOCLJJWU0NGbxe139qXYsE5FY44PJnkbWDG0TAGh=Movt2Rw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: test-thumb: fix for LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        David Spickett <david.spickett@linaro.org>,
        Stephen Hines <srhines@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch. It looks good to me, and I double checked  ARM
architecture reference manual for V7 and can confirm the missing
operand in these instructions is not specified as optional.

Reviewed-by: Jian Cai <jiancai@google.com>

On Mon, Mar 29, 2021 at 3:12 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> There's a few instructions that GAS infers operands but Clang doesn't;
> from what I can tell the Arm ARM doesn't say these are optional.
>
> F5.1.257 TBB, TBH T1 Halfword variant
> F5.1.238 STREXD T1 variant
> F5.1.84 LDREXD T1 variant
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1309
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> See:
> https://lore.kernel.org/linux-arm-kernel/CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com/
> for what I'd consider V1. The previous issues with .w suffixes have been
> fixed or have fixes pending in LLVM:
> * BL+DBG:   https://reviews.llvm.org/D97236
> * ORN/ORNS: https://reviews.llvm.org/D99538
> * RSB/RSBS: https://reviews.llvm.org/D99542
> I'd have expected the Arm ARM to use curly braces to denote optional
> operands (see also "F5.1.167 RSB, RSBS (register)" for an example).
>
>  arch/arm/probes/kprobes/test-thumb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
> index 456c181a7bfe..4e11f0b760f8 100644
> --- a/arch/arm/probes/kprobes/test-thumb.c
> +++ b/arch/arm/probes/kprobes/test-thumb.c
> @@ -441,21 +441,21 @@ void kprobe_thumb32_test_cases(void)
>                 "3:     mvn     r0, r0  \n\t"
>                 "2:     nop             \n\t")
>
> -       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,"]",
> +       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,", lsl #1]",
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
> @@ -468,10 +468,10 @@ void kprobe_thumb32_test_cases(void)
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
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
