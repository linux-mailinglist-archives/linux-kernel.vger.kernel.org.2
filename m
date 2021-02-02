Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D023E30C2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhBBPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhBBPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612278185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fsOJkf4bP3+S1uZ9SgJdlvEbwti5yHP26L3Xwu6/Vc=;
        b=YrkOdeH7Sje8BtDatGo6uwNkX/yw6pWwOh+lTcx4efWd+K84LOkN9EUB/nKkQwKpB5/Ptm
        m6IbdjebFkg51aDYkcOFtT+OuV9XmsyFelFFVpNja+Y53LsIvwDRtUBSFF2JCqCD4kcMah
        6dvLzXlFbacoL/qRakJzEQbA+cBV+oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Wc_Uh04xMZiUsrpEj2mkzQ-1; Tue, 02 Feb 2021 10:03:02 -0500
X-MC-Unique: Wc_Uh04xMZiUsrpEj2mkzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF81CB8132;
        Tue,  2 Feb 2021 15:02:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id A035971C8B;
        Tue,  2 Feb 2021 15:02:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  2 Feb 2021 16:02:59 +0100 (CET)
Date:   Tue, 2 Feb 2021 16:02:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v4 3/4] x86: introduce TS_COMPAT_RESTART to fix
Message-ID: <20210202150247.GA20059@redhat.com>
References: <20210201174555.GA17819@redhat.com>
 <20210201174709.GA17895@redhat.com>
 <CALCETrWrPyd1HLXfKLc17CF85r2336YoEpe6bo6dNGdG_2A2bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWrPyd1HLXfKLc17CF85r2336YoEpe6bo6dNGdG_2A2bQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Andy Lutomirski wrote:
>
> On Mon, Feb 1, 2021 at 9:47 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > The comment in get_nr_restart_syscall() says:
> >
> >          * The problem is that we can get here when ptrace pokes
> >          * syscall-like values into regs even if we're not in a syscall
> >          * at all.
> >
> > Yes. but if we are not in syscall then the
> >
> >         status & (TS_COMPAT|TS_I386_REGS_POKED)
> >
> > check below can't really help:
> >
> >         - TS_COMPAT can't be set
> >
> >         - TS_I386_REGS_POKED is only set if regs->orig_ax was changed by
> >           32bit debugger; and even in this case get_nr_restart_syscall()
> >           is only correct if the tracee is 32bit too.
> >
> > Suppose that 64bit debugger plays with 32bit tracee and
>
> At the risk of asking an obnoxious question here:
>
> >
> >         * Tracee calls sleep(2) // TS_COMPAT is set
> >         * User interrupts the tracee by CTRL-C after 1 sec and does
> >           "(gdb) call func()"
> >         * gdb saves the regs by PTRACE_GETREGS
>
> It seems to me that a better solution may be for gdb to see the
> post-restart-setup state.  In other words, shouldn't the GETREGS
> return with the ax pointing to the restart syscall already?

and ip = regs-ip - 2? And hide ERESTART_BLOCK from debugger? Perhaps
I misunderstood, but this doesn't look like a better solution to me.
Not to mention this would be the serious user-visible change... And
even the necessary changes in getreg() do not look good to me.

Plus I do not understand how this could work. OK, suppose that the
tracee reports a signal with ax = ERESTART_BLOCK.

Debugger simply does GETREGS + SETREGS + PTRACE_CONT(signr). In this
case handle_signal() should set ax = -EINTR, but syscall_get_error()
will report __NR_ia32_restart_syscall?

Probably I greatly misunderstood you...

Oleg.

