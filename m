Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A92324A63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhBYGHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235718AbhBYGEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:04:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C4E64E6C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614233005;
        bh=3VQnksZYqLO3+OxU+d0OuSrvWy37UWvOVG6PoUJYwpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o28WOzfSJXYNGp4NFcjiVTq5C+AM577RGzcgY6qSklpyDFqOdCHedELTxrYe30roO
         o4AtrX54M54c6G4RmXCsm6uGIijcsgGKR2ZTtMM9KY1+cBWV956AGItVaLPwjJtYpm
         YG1WdUpCBqflKhKy8EGcpGcId7BqIxS0orsIMhIJLe0wwpjjFXG3sxRtKERAK53Wgv
         qE1C/D2HLFBAZE6Qpx4JZKkR+KI5lMID8AoK6u0yj5ENjDWoLCr22Qw1lHmCJD8VCp
         y2PtcDR/n0zEtycV92MEWl7C+2qstObJyREM9mdFzKiXJY0/nXbtAvkawI8DvZdoTT
         kIkMXahBtwhMw==
Received: by mail-ej1-f43.google.com with SMTP id a22so6804334ejv.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 22:03:25 -0800 (PST)
X-Gm-Message-State: AOAM532Gxc26qlxlQUdoU070b3sZE3ilwl7GD3I0BRw0/cK8KRJbdXcf
        3kYuZd4kzyHTQ0Gt0w+qbMsvb3FT+tILKaKTXxqmLg==
X-Google-Smtp-Source: ABdhPJwc5KPA4KnXuPW/7+EJW+TbhY2NSaCUI0IEFFJJNSWQj5wYNnl/Lxczxe0d5i1SxbOs04dW+UmSoUd59J1zT/I=
X-Received: by 2002:a17:907:3e81:: with SMTP id hs1mr1223529ejc.316.1614233003917;
 Wed, 24 Feb 2021 22:03:23 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org> <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
 <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
In-Reply-To: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Feb 2021 22:03:12 -0800
X-Gmail-Original-Message-ID: <CALCETrVUBd5CuAh5TRTFqbCE2mYCiBvqrPouTicC0pyO7A6GWw@mail.gmail.com>
Message-ID: <CALCETrVUBd5CuAh5TRTFqbCE2mYCiBvqrPouTicC0pyO7A6GWw@mail.gmail.com>
Subject: Re: Why do kprobes and uprobes singlestep?
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 24 Feb 2021 11:45:10 -0800
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > On Tue, Feb 23, 2021 at 5:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Tue, 23 Feb 2021 15:24:19 -0800
> > > Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > > A while back, I let myself be convinced that kprobes genuinely need to
> > > > single-step the kernel on occasion, and I decided that this sucked but
> > > > I could live with it.  it would, however, be Really Really Nice (tm)
> > > > if we could have a rule that anyone running x86 Linux who single-steps
> > > > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > > > when the system falls apart around them.  Specifically, if we don't
> > > > allow kernel single-stepping and if we suitably limit kernel
> > > > instruction breakpoints (the latter isn't actually a major problem),
> > > > then we don't really really need to use IRET to return to the kernel,
> > > > and that means we can avoid some massive NMI nastiness.
> > >
> > > Would you mean using "pop regs + popf + ret" instead of IRET after
> > > int3 handled for avoiding IRET releasing the NMI mask? Yeah, it is
> > > possible. I don't complain about that.
> >
> > Yes, more or less.
> >
> > >
> > > However, what is the relationship between the IRET and single-stepping?
> > > I think we can do same thing in do_debug...
> >
> > Because there is no way to single-step without using IRET.  POPF; RET
> > will trap after RET and you won't make forward progress.
>
> Ah, indeed. "POPF; RET" is not atomically exceute.
>
> > > > But I was contemplating the code, and I'm no longer convinced.
> > > > Uprobes seem to single-step user code for no discernable reason.
> > > > (They want to trap after executing an out of line instruction, AFAICT.
> > > > Surely INT3 or even CALL after the out-of-line insn would work as well
> > > > or better.)  Why does kprobe single-step?  I spend a while staring at
> > > > the code, and it was entirely unclear to me what the purpose of the
> > > > single-step is.
> > >
> > > For kprobes, there are 2 major reasons for (still relaying on) single stepping.
> > > One is to provide post_handler, another is executing the original code,
> > > which is replaced by int3, without modifying code nor emulation.
> >
> > I don't follow.  Suppose we execute out of line.  If we originally have:
> >
> > INSN
> >
> > we replace it with:
> >
> > INT3
> >
> > and we have, out of line:
> >
> > INSN [but with displacement modified if it's RIP-relative]
> >
> > right now, we single-step the out of line copy.  But couldn't we instead do:
> >
> > INSN [but with displacement modified if it's RIP-relative]
> > INT3
>
> If the INSN is "jmp +127", it will skip the INT3. So those instructions
> must be identified and emulated. We did it already in the arm64 (see commit
> 7ee31a3aa8f4 ("arm64: kprobes: Use BRK instead of single-step when executing
>  instructions out-of-line")), because arm64 already emulated the branch
> instructions. I have to check x86 insns can be emulated without side-effects.

Off the top of my head:

JMP changes RIP but has no other side effects.  Jcc is the same except
that the condition needs checking, which would be a bit tedious.

CALL changes RIP and does a push but has no other side effects.  We
have special infrastructure to emulate CALL from int3 context:
int3_emulate_call().

RET pops and changes RIP.  No other side effects.

RET imm is rare.  I don't think it occurs in the kernel at all.

LRET is rare.  I don't think kprobe needs to support it.

IRET is rare, and trying to kprobe it seems likely to cause a
disaster, although it's within the realm of possibility that the IRET
in sync_core() could work.

JMP FAR and CALL FAR are rare.  I see no reason to support them.

>
> >
> > or even
> >
> > INSN [but with displacement modified if it's RIP-relative]
> > JMP kprobe_post_handler
>
> This needs a sequence of push-regs etc. ;)
>
> >
> > and avoid single-stepping?
> >
> > I guess I see the point for CALL, JMP and RET, but it seems like we
> > could emulate those cases instead fairly easily.
>
> OK, let's try to do it. I think it should be possible because even in the
> current code, resume fixup code (adjust IP register) works only for a few
> groups of instructions.

I suspect that emulating them would give a nice performance boost,
too.  Single-stepping is very slow on x86.

I should let you know, though, that I might have found a sneaky
alternative solution to handling NMIs, so this is a bit lower priority
from my perspective than I thought it was.  I'm not quite 100%
convinced my idea works, but I'll play with it.

--Andy

>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
