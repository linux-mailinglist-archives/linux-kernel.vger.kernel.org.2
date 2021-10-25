Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FA439967
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhJYO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhJYO5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:57:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FEE86103B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635173729;
        bh=v35gq3+4P5DC3vkeKUNcLSgbcP1wFHUYLLL8LD21IOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iuGLcz8Qf/8bLTEEuXVEmlYjIpdwPuaiJs8j+Azg+FmWX0t6E+GuEyX2PTTTiDb/M
         bVRaadAV5u6/vEbwO2kahshnZSyRXr0i+Mi2BSSJJOXUu210DVXlfpK2aQxeQyfXLJ
         5sCl+x2rmom0fSdDOHlMhhoNJtbhlCXHTFpL+KRcKFHBsLsYXThWNiaDoT7X8hcAOZ
         JoZn8B2EBOcpKZk4FIE2E73unRdaonJqBghn8kbD+wvj0Y45yg7xw8433+fJAk+4KF
         5Kp2SBqzCNBhu4y49NBj8tvGQRkwLL0A8QYnfPrMhFSzChZ/xgNP/RZ/kTCQABsQuR
         th9Jx6Qa+MFvQ==
Received: by mail-oi1-f181.google.com with SMTP id r6so15934169oiw.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:55:29 -0700 (PDT)
X-Gm-Message-State: AOAM532C4Kk8styEYqmsCS5NNp7EphUaO4ivHW3Egn5v30svWGbIsS9i
        5u8RQaN9xBjvAx/4qk+IFnjsOkw+FIpzHBrjoac=
X-Google-Smtp-Source: ABdhPJzPKFwx/aTU/TiGOpftBOoX6KFfI2ildkT0MEfX6CzQ9Cfbjr8wH/NgOGaM/1MjX78Euf+wNxMblpTRWbFAui8=
X-Received: by 2002:aca:1712:: with SMTP id j18mr12645020oii.33.1635173728690;
 Mon, 25 Oct 2021 07:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211025122102.46089-1-frederic@kernel.org> <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net> <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net> <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
In-Reply-To: <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Oct 2021 16:55:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
Message-ID: <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 25, 2021 at 04:19:16PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 25, 2021 at 04:08:37PM +0200, Ard Biesheuvel wrote:
>
> > > > Ooohh, but what if you go from !func to NOP.
> > > >
> > > > assuming:
> > > >
> > > >         .literal = 0
> > > >         BTI C
> > > >         RET
> > > >
> > > > Then
> > > >
> > > >         CPU0                    CPU1
> > > >
> > > >         [S] literal = func      [I] NOP
> > > >         [S] insn[1] = NOP       [L] x16 = literal (NULL)
> > > >                                 b x16
> > > >                                 *BANG*
> > > >
> > > > Is that possible? (total lack of memory ordering etc..)
> > > >
> > >
> > > The CBZ will branch to the RET instruction if x16 == 0x0, so this
> > > should not happen.
> >
> > Oooh, I missed that :/ I was about to suggest writing the address of a
> > bare 'ret' trampoline instead of NULL into the literal.
>
> Perhaps a little something like so.. Shaves 2 instructions off each
> trampoline.
>
> --- a/arch/arm64/include/asm/static_call.h
> +++ b/arch/arm64/include/asm/static_call.h
> @@ -11,9 +11,7 @@
>             "   hint    34      /* BTI C */                             \n" \
>                 insn "                                                  \n" \
>             "   ldr     x16, 0b                                         \n" \
> -           "   cbz     x16, 1f                                         \n" \
>             "   br      x16                                             \n" \
> -           "1: ret                                                     \n" \
>             "   .popsection                                             \n")
>
>  #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                      \
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -90,6 +90,11 @@ int __kprobes aarch64_insn_write(void *a
>         return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
>  }
>
> +asm("__static_call_ret:                \n"
> +    "  ret                     \n")
> +

This breaks BTI as it lacks the landing pad, and it will be called indirectly.

> +extern void __static_call_ret(void);
> +

Better to have an ordinary C function here (with consistent linkage),
but we need to take the address in a way that works with Clang CFI.

As the two additional instructions are on an ice cold path anyway, I'm
not sure this is an obvious improvement tbh.

>  void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
>  {
>         /*
> @@ -97,9 +102,7 @@ void arch_static_call_transform(void *si
>          *  0x0 bti c           <--- trampoline entry point
>          *  0x4 <branch or nop>
>          *  0x8 ldr x16, <literal>
> -        *  0xc cbz x16, 20
> -        * 0x10 br x16
> -        * 0x14 ret
> +        *  0xc br x16
>          */
>         struct {
>                 u64     literal;
> @@ -113,6 +116,7 @@ void arch_static_call_transform(void *si
>         insns.insn[0] = cpu_to_le32(insn);
>
>         if (!func) {
> +               insns.literal = (unsigned long)&__static_call_ret;
>                 insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
>                                                    AARCH64_INSN_BRANCH_RETURN);
>         } else {
