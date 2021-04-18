Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36FD3632C7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 02:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhDRAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 20:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhDRAMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 20:12:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6A67613C0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618704705;
        bh=gNEhzWecmTp3XWY/WnFaq/aNAPJ0JX4o9jqiGRm7HEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HC84tZLfZsGQUNlT74di2sUtDPYzZilQBaeOeCEgWFVznzKWa15BqaRkPIWUCd/o3
         X++I+jKEOpKhJbbwo64T5Xqb/vBWxHfEu7L5g8aVHQZL88fyDCXTZW+gri+yOXRtqp
         sL4xBHQUMuT3noBbO0B8tf01XXWGAqiPNpiF5xfAm+aDACE5KSMyRs4Yi9Ytxe6Lab
         GZtNynC0DY4iWZSmz7v09XW3/o27FBsFvP31H6JI5UFCUc3+BjCtRSiElHdWTQpRyD
         9gV116OHZc1j8vZfZC+DEqbGJ0AUTJkfKyFT9BP+mgmRFnhto1/wxaTHUnfgIyIv7t
         igLH18G3fvCag==
Received: by mail-ej1-f49.google.com with SMTP id r12so47487066ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 17:11:45 -0700 (PDT)
X-Gm-Message-State: AOAM532LoYxuUjzE21IcTMLXpdQjGopCi2DG3eDBPrZVBZ2BqNCnBVcp
        66iENLmTi9KW2CbphvAO0pY8pX4duEcTx2pfvFhPgQ==
X-Google-Smtp-Source: ABdhPJxGbdPGKMfMseiubzobKdUyGieCMD5xYH9dWjIbtwOC+7MkuJJeuA2rTLQQvUxpJoWoI64KK1jmSgKTIVPVCZ4=
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr15049555ejb.253.1618704704291;
 Sat, 17 Apr 2021 17:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
 <202104161601.CFB2CCF84F@keescook> <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
 <877dl0sc2m.ffs@nanos.tec.linutronix.de>
In-Reply-To: <877dl0sc2m.ffs@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 17 Apr 2021 17:11:32 -0700
X-Gmail-Original-Message-ID: <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
Message-ID: <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Apr 17 2021 at 16:19, Andy Lutomirski wrote:
> > On Fri, Apr 16, 2021 at 4:40 PM Kees Cook <keescook@chromium.org> wrote:
> >> Okay, you're saying you want __builtin_gimme_body_p() to be a constant
> >> expression for the compiler, not inline asm?
> >
> > Yes.
> >
> > I admit that, in the trivial case where the asm code is *not* a
> > C-ABI-compliant function, giving a type that doesn't fool the compiler
> > into thinking that it might be is probably the best fix.  Maybe we
> > should standardize something, e.g.:
> >
> > struct raw_symbol;  /* not defined anywhere */
> > #define DECLARE_RAW_SYMBOL(x) struct raw_symbol x[]
> >
> > and then we write this:
> >
> > DECLARE_RAW_SYMBOL(entry_SYSCALL_64);
> >
> > wrmsrl(..., (unsigned long)entry_SYSCALL_64);
> >
> > It would be a bit nifty if we didn't need a forward declaration, but
> > I'm not immediately seeing a way to do this without hacks that we'll
> > probably regret;
> >
> > But this doesn't help the case in which the symbol is an actual
> > C-callable function and we want to be able to call it, too.
>
> The right way to solve this is that the compiler provides a builtin
>
>  function_nocfi() +/- the naming bikeshed
>
> which works for
>
>       foo = function_nocfi(bar);

I agree in general.  But right now, we have, in asm/proto.h:

void entry_SYSCALL_64(void);

and that's pure nonsense.  Depending on your point of view,
entry_SYSCALL_64 is a symbol that resolves to an integer or it's an
array of bytes containing instructions, but it is most definitely not
a function void (void).  So, regardless of any CFI stuff, I propose
that we standardize our handling of prototypes of symbols that are
opaque to the C compiler.  Here are a couple of choices:

Easy one:

extern u8 entry_SYSCALL_64[];

Slightly more complicated:

struct opaque_symbol;
extern struct opaque_symbol entry_SYSCALL_64;

The opaque_symbol variant avoids any possible confusion over the weird
status of arrays in C, and it's hard to misuse, since struct
opaque_symbol is an incomplete type.

--Andy
