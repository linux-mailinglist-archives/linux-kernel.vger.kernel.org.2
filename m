Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD34E3244BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhBXTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhBXTqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:46:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D55964EDD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614195924;
        bh=LfQXoknJnKVbOBg04Drxni9CXS4PBfq5QMqoj1lDLe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qjFNcpfrEj7+RKhcovMLEWE+fr7MyNKQDA6oH+yhSwA2DlW1XSz12WmN6dnwW0Wdx
         IHYAkvxKEH0G+ngeFKxFWAxHkfAJRmJZko6qKOp2YTbb6MzzmhckWc9yue3xu96jVg
         xYkWQI2uq/7X2Yr+iAC2dqFbL9F4gqOHxQSnuynAWPIXCyccs+0/6/x+zPiJvOLHpb
         B8PjzFBOpjKWARxgxbnEGg4ooTnuvVxRrCKdLx5d0wSanGIWEN1S6oHVLxUxxh1ZOe
         +Wy7vgNyHgX5GkFLcKVjjGNIuavk7ddiG6ZazmHMsxVpVhsmsTDLvuFb/rRLKvo/PQ
         CTbz1GrO0xEtQ==
Received: by mail-ej1-f51.google.com with SMTP id k13so4965801ejs.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:45:24 -0800 (PST)
X-Gm-Message-State: AOAM530J42QXz2tVypEt23zb0Q0CZzb1M93S7xQww6pLTIGD2tIGvZfz
        gj2Enl4lp0Dvl3popXP89dZ80rNA4h3xuvOKZCu6hQ==
X-Google-Smtp-Source: ABdhPJzspvZ4+VyJhHC42XdWTdsLh0GKsOAMGkUa3xGhV7C9hlfZz2wwwk0EiwDCBnbWLUSbfQm9ON9E+/PfdX7tUpo=
X-Received: by 2002:a17:906:7d87:: with SMTP id v7mr29214938ejo.214.1614195922091;
 Wed, 24 Feb 2021 11:45:22 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org>
In-Reply-To: <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Feb 2021 11:45:10 -0800
X-Gmail-Original-Message-ID: <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
Message-ID: <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
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

On Tue, Feb 23, 2021 at 5:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 23 Feb 2021 15:24:19 -0800
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > A while back, I let myself be convinced that kprobes genuinely need to
> > single-step the kernel on occasion, and I decided that this sucked but
> > I could live with it.  it would, however, be Really Really Nice (tm)
> > if we could have a rule that anyone running x86 Linux who single-steps
> > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > when the system falls apart around them.  Specifically, if we don't
> > allow kernel single-stepping and if we suitably limit kernel
> > instruction breakpoints (the latter isn't actually a major problem),
> > then we don't really really need to use IRET to return to the kernel,
> > and that means we can avoid some massive NMI nastiness.
>
> Would you mean using "pop regs + popf + ret" instead of IRET after
> int3 handled for avoiding IRET releasing the NMI mask? Yeah, it is
> possible. I don't complain about that.

Yes, more or less.

>
> However, what is the relationship between the IRET and single-stepping?
> I think we can do same thing in do_debug...

Because there is no way to single-step without using IRET.  POPF; RET
will trap after RET and you won't make forward progress.

>
> > But I was contemplating the code, and I'm no longer convinced.
> > Uprobes seem to single-step user code for no discernable reason.
> > (They want to trap after executing an out of line instruction, AFAICT.
> > Surely INT3 or even CALL after the out-of-line insn would work as well
> > or better.)  Why does kprobe single-step?  I spend a while staring at
> > the code, and it was entirely unclear to me what the purpose of the
> > single-step is.
>
> For kprobes, there are 2 major reasons for (still relaying on) single stepping.
> One is to provide post_handler, another is executing the original code,
> which is replaced by int3, without modifying code nor emulation.

I don't follow.  Suppose we execute out of line.  If we originally have:

INSN

we replace it with:

INT3

and we have, out of line:

INSN [but with displacement modified if it's RIP-relative]

right now, we single-step the out of line copy.  But couldn't we instead do:

INSN [but with displacement modified if it's RIP-relative]
INT3

or even

INSN [but with displacement modified if it's RIP-relative]
JMP kprobe_post_handler

and avoid single-stepping?

I guess I see the point for CALL, JMP and RET, but it seems like we
could emulate those cases instead fairly easily.
