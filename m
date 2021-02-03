Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED730E25E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhBCSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhBCSTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:19:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C86FD60295
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612376313;
        bh=zdQgjgjUk3KJOQ14/l2VAanex15NlCvPFgpWCWqM3u0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfzxJJ+e2xedb2QhiyU0mb8Y1mjh6MNeSY57sFyd3QSHm0P++USv7ly9zcIfyWTRy
         nFbS3ZY876I20trgwrIGUDdQxoc0priWUCasdcyR0wPMgEYXMYnn0I+fcc/FRlDAok
         9J+v7GUt4PKLFs3f+s3Ubj75Zi53eExcrdT7za5+5Z7zI8yCvwrQfT8RWJ4EFipU95
         o4ok9melo2WJqnBfL4+JTCZFw0QBZxR7fnNN80xDGNV/WlAzre5apmYjfc65CszWr8
         GW+6dzgF1xHq2rBjuk2Zs6ERB3mysDuQkOPn4hHCzsexlVo8i3nTCVOzASFww0kx1b
         ldDckC5zekrjA==
Received: by mail-ed1-f54.google.com with SMTP id df22so803678edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:18:32 -0800 (PST)
X-Gm-Message-State: AOAM532Bc9hoZlZf0RiJ/octgCZc0AmwZ3tdjA1IY42iv4b4FcyQmPLP
        S9I8vZO1Jg5Xjnq1j7ecDN9mwuwyBELvn2bpN3U/Cg==
X-Google-Smtp-Source: ABdhPJwbVTP8/QZorEVxpVsXXUKSLb56Ak86qM7XNfxRnGd9DFtlwoEjEuXACyGNpz+UHa/SJQtea7lcAbejhmVNY8w=
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr4504548edr.238.1612376311167;
 Wed, 03 Feb 2021 10:18:31 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
 <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
 <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
 <87h7mtc9pr.fsf_-_@collabora.com> <CAHk-=wjFV8j03vyvuY4qhKnJ6Vy2DLfjzgTJ1n+LO9EsVsJmDg@mail.gmail.com>
In-Reply-To: <CAHk-=wjFV8j03vyvuY4qhKnJ6Vy2DLfjzgTJ1n+LO9EsVsJmDg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Feb 2021 10:18:11 -0800
X-Gmail-Original-Message-ID: <CALCETrWpouBd+DqVu594B-94MQH_D0D7sECXZHEoAa+=X-_0=A@mail.gmail.com>
Message-ID: <CALCETrWpouBd+DqVu594B-94MQH_D0D7sECXZHEoAa+=X-_0=A@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix missed trap after single-step on system call return
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Feb 3, 2021 at 10:00 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Does the patch below follows your suggestion?  I'm setting the
> > SYSCALL_WORK shadowing TIF_SINGLESTEP every time, instead of only when
> > the child is inside a system call.  Is this acceptable?
>
> Looks sane to me.
>
> My main worry would be about "what about the next system call"? It's
> not what Kyle's case cares about, but let me just give an example:
>
>  - task A traces task B, and starts single-stepping. Task B was *not*
> in a system call at this point.
>
>  - task B happily executes one instruction at a time, takes a TF
> fault, everything is good
>
>  - task B now does a system call. That will disable single-stepping
> while in the kernel
>
>  - task B returns from the system call. TF will be set in eflags, but
> the first instruction *after* the system call will execute unless we
> go through the system call exit path
>
> So I think the tracer basically misses one instruction when single-stepping.

I was hoping you wouldn't ask this :)

The x86 architecture is fundamentally a bit busted here.  If we return
from a system call with SYSRET and TF is set in R11, then SYSRET
traps, which means that #DB is delivered before executing a user
instruction.  I have been asking Intel for quite a while to document
this, and they said they did, but I still can't find it.  IRET is the
opposite: if we return from a system call with IRET and TF is set on
the stack, we execute one user instruction and then trap.

So if we want to reliably single-step a system call and trap after the
system call, we just need to synthesize a trap on the way out.  Doing
this and getting all the nasty corners (e.g. sigreturn setting TF,
sigreturn *clearing* TF, signal delivery as part of the syscall,
ptrace mucking with TF) etc right might be nontrivial.

I suspect the behavior back in the bad old asm-entry-path days was at
best inconsistent.

--Andy
