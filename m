Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4530C7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhBBRam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhBBR1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D028264F5F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612286836;
        bh=Zk04KfSzdnOFWzT/qWyFIx7D8zqxW3K/43LWh0T3Sg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T6WDWAeu8Y8VAhy0igXONX2EZaJAOixX5lNH9ymm7QYfar+DEhlmnYBWs3LYpsI6q
         PkcPDa9tSbD64qm1ZBRi3IAtZEoKtwV0Fwdzul3o20FIR6fEbLP1Umz/bkVVtYgsOu
         bLc6XbPgP0BvB1CPEds/BOKygctMSkY+L84Zv5IS2oED+AxwEV0n9h137CzF2e1HnT
         dLFtgNymNTNOga2ibzlef0gB+lDz85UgrGbA/9EgXtLyeDQXWoQODYba4OSwEnU+ih
         PY0HwvN3nfDcI0VRWxbK5Yh1+7CgI/mSGmy/JB3slyeeCFdxj3thkNX87S7EvebHP/
         oBKyGTfi4JVvA==
Received: by mail-ej1-f45.google.com with SMTP id f14so6932995ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:27:15 -0800 (PST)
X-Gm-Message-State: AOAM533wAzu3Cg55q6BtHFYwzpLwe+uoG8T7vNCIDBlO2f67gbQg7OtJ
        zCeWISRe7u2pGekKXulP54GVwn0uJ7m8D5+rNQmQFg==
X-Google-Smtp-Source: ABdhPJwBw5als6sCiDI2Y3n25BFYHymIxtEGJKILquNgG75MkSk9gAouIJ7mpl1PKAzmPBKW5pihc3qS2IbUQATfXKs=
X-Received: by 2002:a17:906:17d3:: with SMTP id u19mr24720399eje.316.1612286834358;
 Tue, 02 Feb 2021 09:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20210201174555.GA17819@redhat.com> <20210201174709.GA17895@redhat.com>
 <CALCETrWrPyd1HLXfKLc17CF85r2336YoEpe6bo6dNGdG_2A2bQ@mail.gmail.com> <20210202150247.GA20059@redhat.com>
In-Reply-To: <20210202150247.GA20059@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 2 Feb 2021 09:27:02 -0800
X-Gmail-Original-Message-ID: <CALCETrVf-3QxFcNNGOwbK58RGuN_ACOFY=VVG=hBjWyc6QRFqQ@mail.gmail.com>
Message-ID: <CALCETrVf-3QxFcNNGOwbK58RGuN_ACOFY=VVG=hBjWyc6QRFqQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] x86: introduce TS_COMPAT_RESTART to fix
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 7:03 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/01, Andy Lutomirski wrote:
> >
> > On Mon, Feb 1, 2021 at 9:47 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > The comment in get_nr_restart_syscall() says:
> > >
> > >          * The problem is that we can get here when ptrace pokes
> > >          * syscall-like values into regs even if we're not in a syscall
> > >          * at all.
> > >
> > > Yes. but if we are not in syscall then the
> > >
> > >         status & (TS_COMPAT|TS_I386_REGS_POKED)
> > >
> > > check below can't really help:
> > >
> > >         - TS_COMPAT can't be set
> > >
> > >         - TS_I386_REGS_POKED is only set if regs->orig_ax was changed by
> > >           32bit debugger; and even in this case get_nr_restart_syscall()
> > >           is only correct if the tracee is 32bit too.
> > >
> > > Suppose that 64bit debugger plays with 32bit tracee and
> >
> > At the risk of asking an obnoxious question here:
> >
> > >
> > >         * Tracee calls sleep(2) // TS_COMPAT is set
> > >         * User interrupts the tracee by CTRL-C after 1 sec and does
> > >           "(gdb) call func()"
> > >         * gdb saves the regs by PTRACE_GETREGS
> >
> > It seems to me that a better solution may be for gdb to see the
> > post-restart-setup state.  In other words, shouldn't the GETREGS
> > return with the ax pointing to the restart syscall already?
>
> and ip = regs-ip - 2? And hide ERESTART_BLOCK from debugger? Perhaps
> I misunderstood, but this doesn't look like a better solution to me.
> Not to mention this would be the serious user-visible change... And
> even the necessary changes in getreg() do not look good to me.
>
> Plus I do not understand how this could work. OK, suppose that the
> tracee reports a signal with ax = ERESTART_BLOCK.
>
> Debugger simply does GETREGS + SETREGS + PTRACE_CONT(signr). In this
> case handle_signal() should set ax = -EINTR, but syscall_get_error()
> will report __NR_ia32_restart_syscall?
>
> Probably I greatly misunderstood you...

My idea may well be nuts, but I was indeed imagining that we hide
ERESTART_BLOCK from the debugger.  We would do the ip -= 2 and nr =
__NR_..._restart_syscall before any ptrace events happen at all.
Admittedly, this may cause strace to fail, so this is probably a bad
idea.

Oh well, your patch is probably a decent solution.
