Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25E84399BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJYPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233628AbhJYPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:12:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90C8660524
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635174636;
        bh=gy9J/5BDZ2lhozFmaft1KzOIRN5nWsMFvd7nwHjZzSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqYkbtir4K+AH4C2aBnJkIAaOZnvYSvfpT/3utR194mWgdr7vk48Ipibou8syVHa4
         dlpl5KkQcW9uSktDtAdbl1qlzywR2B9ghUsptF8HpfamTEeJIL25UiHjMzaqqyNLua
         QOOsYgGJR8dqHt/tDI0ooCJth2PLkq3ogiZ8q3IuKwaiQoficMvLOcBX7i/jlsk5pj
         ipVYWeozOn2pLZSEck5/Twd+IjhbmSfP+zvRuTF+5UK4X5QYX3teYck1Nj2Do9Ud6D
         CCQ2tHIGHtqRUecFtLsXWWhqw7TLAde+NZjY4xURbfrf4dBGVUoXmBdzUpp3q7Quua
         KbTTEVkgXO/0A==
Received: by mail-ot1-f41.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso15381725otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:10:36 -0700 (PDT)
X-Gm-Message-State: AOAM530f6TgjTEoEO1PtkhFHEKPg5LDQeOEjAPG5kx9MTfQ13ik1++Ue
        7KvgVbLRgEufGj3tpPU00pq8rby7ci/pHGg6vXA=
X-Google-Smtp-Source: ABdhPJzeBzIy5SAQGapWoEn0WD0KhCteSgFSGO0aWCwDoyB7cf8FCoVh4pLOyVJ9ZE24v/Azw7k5PJXeWdajr7ww7Ms=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr14066197otg.147.1635174635861;
 Mon, 25 Oct 2021 08:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211025122102.46089-1-frederic@kernel.org> <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net> <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net> <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com> <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
In-Reply-To: <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Oct 2021 17:10:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
Message-ID: <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
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

On Mon, 25 Oct 2021 at 17:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 25, 2021 at 04:55:17PM +0200, Ard Biesheuvel wrote:
> > On Mon, 25 Oct 2021 at 16:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Perhaps a little something like so.. Shaves 2 instructions off each
> > > trampoline.
> > >
> > > --- a/arch/arm64/include/asm/static_call.h
> > > +++ b/arch/arm64/include/asm/static_call.h
> > > @@ -11,9 +11,7 @@
> > >             "   hint    34      /* BTI C */                             \n" \
> > >                 insn "                                                  \n" \
> > >             "   ldr     x16, 0b                                         \n" \
> > > -           "   cbz     x16, 1f                                         \n" \
> > >             "   br      x16                                             \n" \
> > > -           "1: ret                                                     \n" \
> > >             "   .popsection                                             \n")
> > >
> > >  #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                      \
> > > --- a/arch/arm64/kernel/patching.c
> > > +++ b/arch/arm64/kernel/patching.c
> > > @@ -90,6 +90,11 @@ int __kprobes aarch64_insn_write(void *a
> > >         return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
> > >  }
> > >
> > > +asm("__static_call_ret:                \n"
> > > +    "  ret                     \n")
> > > +
> >
> > This breaks BTI as it lacks the landing pad, and it will be called indirectly.
>
> Argh!
>
> > > +extern void __static_call_ret(void);
> > > +
> >
> > Better to have an ordinary C function here (with consistent linkage),
> > but we need to take the address in a way that works with Clang CFI.
>
> There is that.
>
> > As the two additional instructions are on an ice cold path anyway, I'm
> > not sure this is an obvious improvement tbh.
>
> For me it's both simpler -- by virtue of being more consistent, and
> smaller. So double win :-)
>
> That is; you're already relying on the literal being unconditionally
> updated for the normal B foo -> NOP path, and having the RET -> NOP path
> be handled differently is just confusing.
>
> At least, that's how I'm seeing it today...

Fair enough. I don't have a strong opinion either way, so I'll let
some other arm64 folks chime in as well.
