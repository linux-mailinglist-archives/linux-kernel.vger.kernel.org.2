Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3E4136BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhIUP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhIUP4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:56:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89C4161186
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632239723;
        bh=kDPtX/MRkj65TFHRvsxE7KeGMXH+4kcMkYw/S9qrDFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hGGtKQIeLEGP6qDq0CnYhl1jn+cgq1VjEtwyH/pW5qpNL3cIpFQr96G/xV9PiF+hJ
         vMLk5CGH3xrBzgzTYsSpddR4tU7Tvr7VnJKxcSvQ9huVEs5fXvYSH+oHfkz2a0xxF4
         vCPD6SDcv8eeL7uAYO3WAZLZElRXilA6PvA027IAPYz6KOxRxPmpCBHUDV4mlo/+Gv
         I+af0bLIkYgU3msqwDkb5mOk+eAOvPEXcPAiND/sMkwXFe2TdxXfY7MVY4TbJ0SmLt
         sZDjCeFkTvd3UVsqQ1spBN6ZcRIXq5gD24pZrmYzRjc6C9Z5C8js+z3VhCvfdBOCtw
         2EzsdNw/T80ig==
Received: by mail-ot1-f47.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso28903134otr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:55:23 -0700 (PDT)
X-Gm-Message-State: AOAM532zAGFJMUECsCX5OEuj6Fzcf+CLjvXwNoexGezI9BWnX4EzqaTi
        JmXaDKt2l2n0TklJ02K1zBz8aBSoDPiHl81avJU=
X-Google-Smtp-Source: ABdhPJyMwvR6Uz54C9XdArSO3JXTHW6FCaw3TtlaQySLhgP3W5z3AVviIrK88qSUQzU4aMjeXPh8iKn27ySF4fhi6o8=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr25952913ota.30.1632239722938;
 Tue, 21 Sep 2021 08:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210920233237.90463-1-frederic@kernel.org> <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net> <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
 <20210921153352.GC35846@C02TD0UTHF1T.local>
In-Reply-To: <20210921153352.GC35846@C02TD0UTHF1T.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Sep 2021 17:55:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
Message-ID: <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 17:33, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> > On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
...
> > >
> > > So I like what Christophe did for PPC32:
> > >
> > >   https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu
> > >
> > > Where he starts with an unconditional jmp and uses that IFF the offset
> > > fits and only does the data load when it doesn't. Ard, woulnd't that
> > > also make sense on ARM64? I'm thinking most in-kernel function pointers
> > > would actually fit, it's just the module muck that gets to have too
> > > large pointers, no?
> > >
> >
> > Yeah, I'd have to page that back in. But it seems like the following
> >
> >   bti c
> >   <branch>
> >   adrp x16, <literal>
> >   ldr x16, [x16, ...]
> >   br x16
> >
> > with <branch> either set to 'b target' for the near targets, 'ret' for
> > the NULL target, and 'nop' for the far targets should work, and the
> > architecture permits patching branches into NOPs and vice versa
> > without special synchronization.
>
> I think so, yes. We can do sligntly better with an inline literal pool
> and a PC-relative LDR to fold the ADRP+LDR, e.g.
>
>         .align 3
> tramp:
>         BTI     C
>         {B <func> | RET | NOP}
>         LDR     X16, 1f
>         BR      X16
> 1:      .quad   <literal>
>
> Since that's in the .text, it's RO for regular accesses anyway.
>

I tried to keep the literal in .rodata to avoid inadvertent gadgets
and/or anticipate exec-only mappings of .text, but that may be a bit
overzealous.

> > But I must be missing something here, or why did we have that long
> > discussion before?
>
> I think the long discussion was because v2 had some more complex options
> (mostly due to trying to use ADRP+ADD) and atomicity/preemption issues
> meant we could only transition between some of those one-way, and it was
> subtle/complex:
>
> https://lore.kernel.org/linux-arm-kernel/20201028184114.6834-1-ardb@kernel.org/
>

Ah yes, I was trying to use ADRP/ADD to avoid the load, and this is
what created all the complexity.

> For v3, that was all gone, but we didn't have a user.
>
> Since the common case *should* be handled by {B <func> | RET | NOP }, I
> reckon it's fine to have just that and the literal pool fallback (which
> I'll definitely need for the sorts of kernel I run when fuzzing, where
> the kernel Image itself can be 100s of MiBs).

Ack. So I'll respin this along these lines. Do we care deeply about
the branch and the literal being transiently out of sync?
