Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2836C963
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhD0Q0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238822AbhD0QYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:24:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07482613DD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619540636;
        bh=l/R2qtxCn2ERJyPjYguJ0k39jAGXWUp2uQC+JMs9fuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O2KYc3CKaic0+kVdqHwz6NUbKNzh+h1LwX/U5B7DAk2n9gfQUarAKKBG4byLutmxL
         CSiAa3kK5T4m0Pq0fUraRZdHUxk2p7CCwxbMdfPvpeI78OhHjYslxmWBVyh0Xi0Fx5
         1PYiI5MSKNTTlp9a/CA9VHEVYNwsY45CaWfegLBTYN8mNgYz+VeQU9zinXSTaJjyyV
         ailQ8+ttWae1DHFXF3xtR4iF/Ql8jTI+lF+2osJe3z7MpJeDbu0uyHXFjoftaPqmS9
         bpHtLU1GnntvAu98y9TYtOmpBOrJTJco12W4rXovHJhYHTfegUgSrEdiEtKDjzikkS
         i5CE7iwNyyigw==
Received: by mail-ej1-f42.google.com with SMTP id ja3so14462454ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:23:55 -0700 (PDT)
X-Gm-Message-State: AOAM532fUgTHMa+qu1oNvtKaThrbxklXYGm7z1Jhp8UXXTme1m7KhHtW
        elpStmtGxr2D6H229CgYrcPzigQyNz38KwTjoENCMQ==
X-Google-Smtp-Source: ABdhPJxy9HL2ysFtlcSqWMWsv6cwp5/qFMPBPyFAP9+p+Zf66TnmOU2k4NUG/ma1/9pG/95JQLjY1P5Iln/2Bz8TT8E=
X-Received: by 2002:a17:906:e096:: with SMTP id gh22mr2231171ejb.101.1619540634457;
 Tue, 27 Apr 2021 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210426180610.2363-1-sargun@sargun.me> <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco> <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco>
In-Reply-To: <20210427134853.GA1746081@cisco>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Apr 2021 09:23:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
Message-ID: <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:48 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> > On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> > > On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > > > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> > > >    * This is where we wait for a reply from userspace.
> > > >    */
> > > >   do {
> > > > +         interruptible = notification_interruptible(&n);
> > > > +
> > > >           mutex_unlock(&match->notify_lock);
> > > > -         err = wait_for_completion_interruptible(&n.ready);
> > > > +         if (interruptible)
> > > > +                 err = wait_for_completion_interruptible(&n.ready);
> > > > +         else
> > > > +                 err = wait_for_completion_killable(&n.ready);
> > > >           mutex_lock(&match->notify_lock);
> > > > -         if (err != 0)
> > > > +
> > > > +         if (err != 0) {
> > > > +                 /*
> > > > +                  * There is a race condition here where if the
> > > > +                  * notification was received with the
> > > > +                  * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > > > +                  * non-fatal signal was received before we could
> > > > +                  * transition we could erroneously end our wait early.
> > > > +                  *
> > > > +                  * The next wait for completion will ensure the signal
> > > > +                  * was not fatal.
> > > > +                  */
> > > > +                 if (interruptible && !notification_interruptible(&n))
> > > > +                         continue;
> > >
> > > I'm trying to understand how one would hit this race,
> > >
> >
> > I'm thinking:
> > P: Process that "generates" notification
> > S: Supervisor
> > U: User
> >
> > P: Generated notification
> > S: ioctl(RECV...) // With wait_killable flag.
> > ...complete is called in the supervisor, but the P may not be woken up...
> > U: kill -SIGTERM $P
> > ...signal gets delivered to p and causes wakeup and
> > wait_for_completion_interruptible returns 1...
> >
> > Then you need to check the race
>
> I see, thanks. This seems like a consequence of having the flag be
> per-RECV-call vs. per-filter. Seems like it might be simpler to have
> it be per-filter?
>

Backing up a minute, how is the current behavior not a serious
correctness issue?  I can think of two scenarios that seem entirely
broken right now:

1. Process makes a syscall that is not permitted to return -EINTR.  It
gets a signal and returns -EINTR when user notifiers are in use.

2. Process makes a syscall that is permitted to return -EINTR.  But
-EINTR for IO means "I got interrupted and *did not do the IO*".
Nevertheless, the syscall returns -EINTR and the IO is done.

ISTM the current behavior is severely broken, and the new behavior
isn't *that* much better since it simply ignores signals and can't
emulate -EINTR (or all the various restart modes, sigh).  Surely the
right behavior is to have the seccomped process notice that it got a
signal and inform the monitor of that fact so that the monitor can
take appropriate action.

IOW, I don't think that the current behavior *or* the patched opt-in
behavior is great.  I think we would do better to have the filter
indicate that it is signal-aware and to document that non-signal-aware
filters cannot behave correctly with respect to signals.

--Andy
