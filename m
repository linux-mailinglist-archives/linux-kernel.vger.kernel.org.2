Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696B7310BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBEN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:28:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBENZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:25:05 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612531452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/3yerF5L2cPlk596EcDC37nOUSMAy2bZjQXckOvPDo=;
        b=jvcCedn6AGpR05lGyWRA1Ec4bWfResJEOuuw0/6uc8jF9bV6cKYrExyn6LOFKRescj8kP8
        2aGAb5estwj6R1SdQsrbdnbYxYNfR5Pm74U/fdYTks2ohhvjq7PrEV6UbO/L6dnYo5KuGX
        5+mw/27dTHbC+8sZvKgDZS+5kAL1bi6GI1fBZDIxrIrCit+2aa3NqqQ6zpShvlpG6G960j
        7/bL6rhdHFZ9wRFjthT+K2lplJSz+dfN3HEy9KeVjFUl93iQ+h2AVY4+YpdLj0DfpsiyTa
        BUeEGLadkfyLn9jorxmycFgU7fihOCUukAtVJwz7YR4xD+JDctAdcDCXLs1rDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612531452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/3yerF5L2cPlk596EcDC37nOUSMAy2bZjQXckOvPDo=;
        b=F2kO42cknuUiT4eiffaA/G6qVzh8Mn10m7GKC+ErmlbFQxMspEs7b1a80rFvZ9Hg9mOj9A
        idoRfKJpAeyoyOBw==
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack switching
In-Reply-To: <CAFULd4agX8oOyoHWVu=HKNcegVJNuv2Z6JKwg4mZqUESSWTuVw@mail.gmail.com>
References: <CAFULd4agX8oOyoHWVu=HKNcegVJNuv2Z6JKwg4mZqUESSWTuVw@mail.gmail.com>
Date:   Fri, 05 Feb 2021 14:24:12 +0100
Message-ID: <87wnvm8x6r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros,

On Fri, Feb 05 2021 at 12:03, Uros Bizjak wrote:

can you please fix your mail client to generate at least the 'In-Reply-to:'
header? Lacking that header breaks threading on lore:

        https://lore.kernel.org/lkml/20210204204903.350275743@linutronix.de/

Your mail is missing there. Ideally it also emits 'References'.

> #define __call_on_irqstack(func, asm_call, constr...) \
> +{ \
> + register void *tos asm("r11"); \
> + \
> + tos = ((void *)__this_cpu_read(hardirq_stack_ptr)); \
> + \
> + asm_inline volatile( \
> + "movq %%rsp, (%[__tos]) \n" \
> + "movq %[__tos], %%rsp \n" \
> + \
> + asm_call \
> + \
> + "popq %%rsp \n" \
> + \
> + : "+r" (tos) IRQSTACK_CALL_CONSTRAINT \
>
> Please note that GCC documents "U" register constraint that can be
> used here instead of declaring hard register in the variable
> declaration:
>
>     'U'
>          The call-clobbered integer registers.

That's not really helpful because clang does not support 'U'.

> + : [__func] "i" (func), [__tos] "r" (tos) constr \
>
> There is no need to declare "tos" as read operand again, it is already
> declared above as readwrite (+) operand.

It makes clang builds fail.

> Considering that (according to the above documentation) it is
> necessary to list all input registers that pass function arguments,
> the compiler is free to allocate any remaining register from "U"
> register class, not only r11. Using an earlyclobber modifier prevents
> the compiler from allocating a register that carries input argument,
> so:
>
> : [__tos] "+&U" (tos) IRQSTACK_CALL_CONSTRAINT \
> : [__func] "i" (func) constr \
>
> could be used.

See above. Without the U constraint we can't rely on the compiler to do
the right thing without the explicit register asm("r11"); And even with
'U' we need to enforce that there is only one U register left to use.

The problem is that the compiler does not know about the call. So we
need to ensure via the clobbers and input/output arguments that it can't
use any of the callee clobbered registers accross the inline asm.

With

        void *tos = this_cpu_read(...);

        : "cc", .... "r9", "r10"

the compiler could still use "r11" for some other stuff and stick tos
into a callee saved register, e.g. r15. If the called function then
clobbers "r11" everything goes south.

There is no point in being extra smart here. The functions have no
register pressure as they are small so enforcing the register allocation
is not restricting the compiler freedom to much. But it ensures that the
compiler can't do anything subtly wrong which would end up being a hard
to debug disaster.

> Also note that functions with variable arguments pass information
> about the number of vector registers used in %rax, so %rax should be
> listed as input argument in this case. But this should be of no issue
> here.

That's really irrelevant as it's a very narrow use case for functions
with 0..2 arguments.

Thanks,

        tglx


