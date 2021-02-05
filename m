Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514B3109D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhBELHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBELEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:04:39 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE90C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:03:56 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id u16so3195425qvo.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Dzx9gLy1AWGjOyMHLVJYimF5ScaTGae4vgn7lsHel9w=;
        b=n8x9YSEnc5c43G6iBbwFf8Kb32ciP0nS2gcMWiEYJuHopcPkhVl8qGcoRaTTc6DV1c
         q+/Qy+CRPV8AclaxJ43KhcWroRdWhVCS+xEwTscocAJr1tXtUXS/U5ANz+8b6piGD7rf
         21RBOvgNJoK3KXIpO5W989Oyh+2l7B8C7cWXlnQbD3bJG5AnWdPX2PLR0djpvifllAKI
         hBn0eJ9BnwCuk0dkajy6VAzoEpUAC1LYpnal1ArGwdnl9QWQTU9uklng5FcLnzcQCYHE
         MfkPabJUiCIOy3DhosQzc40Ebw4crBlS1iHSfo8XgVfDeLgt44fLtcy03LvefQdCNcpV
         s2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Dzx9gLy1AWGjOyMHLVJYimF5ScaTGae4vgn7lsHel9w=;
        b=MBkOW/ANZtEqCKhXsxyCPZjuv1pSzrK3h86c9dWF6RqpZ0JrPZd6EHSkKnb3/SlEGO
         MqrnALi77erm+CsR67gyklmvt//wmyC4bwSOxMvYaXM4RbB5SZDtZgQue0qsMAB+EXM7
         XHUBghoZW6niOtTEgXOYs2D35tiXQC5a/raaW4QGtZiFxNtlon/RNGFUpTM8xQL75CaK
         WdMa0pRlUsvjmNLF8mGsyflTmHjDKDHNxCWnsQLTIE5Av1R8fx0ZovfJnwvV78/9yw9I
         CDOgHm+LNRNEsEow+7d5bFZtV8sxagdo4p5MtVkfhOYGiyP05aedPR4ZW4eMIO7cdJBM
         voqQ==
X-Gm-Message-State: AOAM5331vyYCoJTMdmbH6rBCd17Jf9imfEipXBITsLi19ap5vNLVB+vo
        pcq09bHAFFlj7C0eRUO8ZvOSR019NUpds61EeNGc4416GxMD+w==
X-Google-Smtp-Source: ABdhPJxYUkTMzcopHHvrVjtcA8Ro+IZQ9rsTB4SDwJ8lPxeukDHoSSa2rYhQA/NOOmUqRQ3XCBiXCbJ9352XfRFyxQA=
X-Received: by 2002:a05:6214:2a9:: with SMTP id m9mr3802754qvv.20.1612523035333;
 Fri, 05 Feb 2021 03:03:55 -0800 (PST)
MIME-Version: 1.0
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 5 Feb 2021 12:03:44 +0100
Message-ID: <CAFULd4agX8oOyoHWVu=HKNcegVJNuv2Z6JKwg4mZqUESSWTuVw@mail.gmail.com>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack switching
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The effort to make the ASM entry code slim and unified moved the irq stack
> switching out of the low level ASM code so that the whole return from
> interrupt work and state handling can be done in C and the ASM code just
> handles the low level details of entry and exit.
>
> This ended up being a suboptimal implementation for various reasons
> (including tooling). The main pain points are:
>
>  - The indirect call which is expensive thanks to retpoline
>
>  - The inability to stay on the irq stack for softirq processing on return
>    from interrupt
>
>  - The fact that the stack switching code ends up being an easy to target
>    exploit gadget.
>
> Prepare for inlining the stack switching logic into the C entry points by
> providing a ASM macro which contains the guts of the switching mechanism:
>
>   1) Store RSP at the top of the irq stack
>   2) Switch RSP to the irq stack
>   3) Invoke code
>   4) Pop the original RSP back
>
> Document the unholy asm() logic while at it to reduce the amount of head
> scratching required a half year from now.

#define __call_on_irqstack(func, asm_call, constr...) \
+{ \
+ register void *tos asm("r11"); \
+ \
+ tos = ((void *)__this_cpu_read(hardirq_stack_ptr)); \
+ \
+ asm_inline volatile( \
+ "movq %%rsp, (%[__tos]) \n" \
+ "movq %[__tos], %%rsp \n" \
+ \
+ asm_call \
+ \
+ "popq %%rsp \n" \
+ \
+ : "+r" (tos) IRQSTACK_CALL_CONSTRAINT \

Please note that GCC documents "U" register constraint that can be
used here instead of declaring hard register in the variable
declaration:

    'U'
         The call-clobbered integer registers.

+ : [__func] "i" (func), [__tos] "r" (tos) constr \

There is no need to declare "tos" as read operand again, it is already
declared above as readwrite (+) operand.

Considering that (according to the above documentation) it is
necessary to list all input registers that pass function arguments,
the compiler is free to allocate any remaining register from "U"
register class, not only r11. Using an earlyclobber modifier prevents
the compiler from allocating a register that carries input argument,
so:

: [__tos] "+&U" (tos) IRQSTACK_CALL_CONSTRAINT \
: [__func] "i" (func) constr \

could be used.

Also note that functions with variable arguments pass information
about the number of vector registers used in %rax, so %rax should be
listed as input argument in this case. But this should be of no issue
here.

Uros.

+ : "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", \
+  "memory" \
+ ); \
