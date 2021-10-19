Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5065E433DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhJSSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:02:43 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:64464 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:02:42 -0400
Date:   Tue, 19 Oct 2021 18:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634666423; bh=jAndP/ZdC+GdpA1dIsp1nEY8S4dGqOR03D236U+cg9U=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YwEGi0vJYFZp4zisZRBbTWrO8PhaRaSfdDssCEgfvNER+bmXLS5s2a2j0iT0xRx29
         Z+xoof5muWVZCUoPwhiqLFtqQNvc0VYXqCyAev5ExYxSHuB2VySoPeGdTpglIy5kEd
         4ONaQ0RXcNJBcPOu+vN3jQ4kwBDP9E9D4f72GTn4Yw+tDLHKEyW0mhkaAlEangda2S
         scJX1hxWlCLfepqOBWfvXccEzlg7BVTBV59J6+toPTf8I/YMevgFc4fZtFyOeLv16Z
         ZTAqyGvB9EeLPiMXjkPelc47Oq6RbIlAHAq3hutYpWu2KjdP3jbqd5MRDnOzqQnjzB
         xJjFhzBmQmJag==
To:     Sami Tolvanen <samitolvanen@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        alexei.starovoitov@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211019175336.169584-1-alobakin@pm.me>
In-Reply-To: <CABCJKudtYwFtYPAES_Y1uU1TYrApf0D054H8soJo2J_Mx51wkg@mail.gmail.com>
References: <20211013122217.304265366@infradead.org> <20211013123645.002402102@infradead.org> <YWmPCF+g+sF4+ieh@zn.tnic> <20211015165635.GH174703@worktop.programming.kicks-ass.net> <20211018225905.86034-1-alobakin@pm.me> <20211019001845.85256-1-alobakin@pm.me> <20211019094038.80569-1-alobakin@pm.me> <YW6a67fGzM2AyHot@hirez.programming.kicks-ass.net> <CABCJKudtYwFtYPAES_Y1uU1TYrApf0D054H8soJo2J_Mx51wkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 19 Oct 2021 08:37:14 -0700

> On Tue, Oct 19, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wro=
te:
> >
> >
> > + Sami
> >
> > (Sami, for context:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/=
?h=3Dobjtool/core
> >
> > which contains the following code:
> >
> > +       void (*target)(void);
> > +       int reg, i =3D 0;
> > +
> > +       target =3D addr + insn->length + insn->immediate.value;
> > +       reg =3D (target - &__x86_indirect_thunk_rax) /
> > +             (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > +
> > +       if (WARN_ON_ONCE(reg & ~0xf))
> > +               return -1;
> >
> > which blows up something fierce on clang-cfi)
> >
> > On Tue, Oct 19, 2021 at 09:47:26AM +0000, Alexander Lobakin wrote:
> >
> > > Oh okay, it's because of ClangCFI:
> > >
> > > SMP alternatives: You were looking for __typeid__ZTSFvvE_global_addr+=
0x370/0x1410 at 0xffffffffa523cd60,>
> > > SMP alternatives: rax is __typeid__ZTSFvvE_global_addr+0x360/0x1410 a=
t 0xffffffffa523cd50
> > >
> > > Sorry for confusing, seems like it's a side effect of using it on
> > > Clang 12 while the original series supports only 13+. I'll double
> > > check and let know if find something.
> >
> > I'm thinking CFI will totally screw this up regardless, seeing how a
> > function pointer is taken, and the CFI magicks will turn that into one
> > of those weird trampolines instead of the actual symbol.
> >
> > The compiler could of course deduce that these addresses are never
> > called and don't escape the function, and therefore doesn't need to do
> > the CFI transformation on then, but I'm guessing it isn't quite that
> > clever.
>
> Yes, it's unfortunately not that clever.
>
> > Also doing CFI on retpoline thunks seems 'weird', they have a very
> > particular calling convention, excplicitly very much not the standard C
> > one. Can't we mark them using asmlinkage or something to tell the
> > compiler to politely 'bugger off' or somesuch ;-)
>
> I confirmed that using an opaque type for the thunk declaration fixes
> this issue with CFI. It also makes it obvious that these are not
> callable from C code.

Oh, glad we caught this then, much thanks y'all!

> Sami

Thanks,
Al

