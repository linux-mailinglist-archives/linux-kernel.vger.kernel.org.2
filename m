Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E7A36CE72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhD0WLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhD0WLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:11:17 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:10:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p15so15018777iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3OZQuMMYXhVRdbAGQKUg7Wra51AHbtP59/ycR6cv1A=;
        b=oLMo6M7eRBG1HrCjd7sWkyEU1zNn7c1dNI2nSNyG7pjWl3w068pOFMPhpW/AcnTaPv
         tCdMb6rULM+RIohelzjfDLq+l6ZbzrKLyBWjTm5BbpCT+ODZhmB/LKNRZDXI0vUJQYE3
         sV/EQ7yolgixvjTxAhI1tFHPkXqX3J3uqn6vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3OZQuMMYXhVRdbAGQKUg7Wra51AHbtP59/ycR6cv1A=;
        b=LdC4OcPRg5EyrDU0dJYISN2cDwU6anGM4pGMJySk4IG/pNASqz4g/tGg3RaXFEysHU
         kVCCsp0zwmM4d9M9oDtSdeXp77IrHYUa3z9cYqbV4AnPpi/rIORuKtLgHcxgU4pQPtvy
         rxgt1fVpQ//UyBuCTAQW/XAC9T1j3xS9x4q+Szpw5k8eur59/YuT+GkFc4wjqiGc/eCn
         Bmu27YVy1yOCS52r6QijpOkxEP+ZPb+ytxjm57FnqQ4mzUGioVSs4wkC1Z1LBVzOmgLw
         j29nnis7V0lNsmOwhclchEu8VmSikpDEaf4NRSMiMEx04isjF3uyNfT5ykfBLzNofXLa
         0pVw==
X-Gm-Message-State: AOAM533PUBpI3V75RDuERpu1mNwNYwhfKdIW7mgQRRtTRlDfD8VyoUqo
        Q5VgFKLTPHp0DdCl7GDtxKJhXg==
X-Google-Smtp-Source: ABdhPJw34ZHavmKPDKd0vx3zQxgvpuLI+I18D2MJ1XBSYeqrCsPCmQS1A/sWP4DQ9voyjhp4gEccCg==
X-Received: by 2002:a92:c0c2:: with SMTP id t2mr20188209ilf.210.1619561431634;
        Tue, 27 Apr 2021 15:10:31 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id n22sm528725ioc.5.2021.04.27.15.10.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 15:10:30 -0700 (PDT)
Date:   Tue, 27 Apr 2021 22:10:29 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to
 seccomp user notifier
Message-ID: <20210427221028.GA16602@ircssh-2.c.rugged-nimbus-611.internal>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco>
 <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
 <20210427134853.GA1746081@cisco>
 <CALCETrVrfBtQPh=YeDEK4P9+QHQvNxHbn8ZT3fdQNznpSeS5oQ@mail.gmail.com>
 <20210427170753.GA1786245@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427170753.GA1786245@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:07:53AM -0600, Tycho Andersen wrote:
> On Tue, Apr 27, 2021 at 09:23:42AM -0700, Andy Lutomirski wrote:
> > On Tue, Apr 27, 2021 at 6:48 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> > > > On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> > > > > On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > > > > > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> > > > > >    * This is where we wait for a reply from userspace.
> > > > > >    */
> > > > > >   do {
> > > > > > +         interruptible = notification_interruptible(&n);
> > > > > > +
> > > > > >           mutex_unlock(&match->notify_lock);
> > > > > > -         err = wait_for_completion_interruptible(&n.ready);
> > > > > > +         if (interruptible)
> > > > > > +                 err = wait_for_completion_interruptible(&n.ready);
> > > > > > +         else
> > > > > > +                 err = wait_for_completion_killable(&n.ready);
> > > > > >           mutex_lock(&match->notify_lock);
> > > > > > -         if (err != 0)
> > > > > > +
> > > > > > +         if (err != 0) {
> > > > > > +                 /*
> > > > > > +                  * There is a race condition here where if the
> > > > > > +                  * notification was received with the
> > > > > > +                  * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > > > > > +                  * non-fatal signal was received before we could
> > > > > > +                  * transition we could erroneously end our wait early.
> > > > > > +                  *
> > > > > > +                  * The next wait for completion will ensure the signal
> > > > > > +                  * was not fatal.
> > > > > > +                  */
> > > > > > +                 if (interruptible && !notification_interruptible(&n))
> > > > > > +                         continue;
> > > > >
> > > > > I'm trying to understand how one would hit this race,
> > > > >
> > > >
> > > > I'm thinking:
> > > > P: Process that "generates" notification
> > > > S: Supervisor
> > > > U: User
> > > >
> > > > P: Generated notification
> > > > S: ioctl(RECV...) // With wait_killable flag.
> > > > ...complete is called in the supervisor, but the P may not be woken up...
> > > > U: kill -SIGTERM $P
> > > > ...signal gets delivered to p and causes wakeup and
> > > > wait_for_completion_interruptible returns 1...
> > > >
> > > > Then you need to check the race
> > >
> > > I see, thanks. This seems like a consequence of having the flag be
> > > per-RECV-call vs. per-filter. Seems like it might be simpler to have
> > > it be per-filter?
> > >
I agree that it is hard / impossible to guarantee correctness *after* the fact.
> > 
> > Backing up a minute, how is the current behavior not a serious
> > correctness issue?  I can think of two scenarios that seem entirely
> > broken right now:
> > 
> > 1. Process makes a syscall that is not permitted to return -EINTR.  It
> > gets a signal and returns -EINTR when user notifiers are in use.
> >
Yes, there's a whole host of problems here. Things like fsmount should not
be interruptible.
 
> > 2. Process makes a syscall that is permitted to return -EINTR.  But
> > -EINTR for IO means "I got interrupted and *did not do the IO*".
> > Nevertheless, the syscall returns -EINTR and the IO is done.
In general, I think that the idea is to do as little side-effect I/O
as possible. The use cases we've looked at all have nice ways to unwind
them (perf_event_open, BPF, accept), but others are less good for unwinding
(mount). There are some middle ground calls like connect, but they're
less bad.

> > 
> > ISTM the current behavior is severely broken, and the new behavior
> > isn't *that* much better since it simply ignores signals and can't
> > emulate -EINTR (or all the various restart modes, sigh).  Surely the
> > right behavior is to have the seccomped process notice that it got a
> > signal and inform the monitor of that fact so that the monitor can
> > take appropriate action.
> 
> This doesn't help your case (2) though, since the IO could be done
> before the supervisor gets the notification.
> 
I think for something like mount, if it fails (gets interrupted) via a
fatal signal, that's grounds for terminating the container.

> > IOW, I don't think that the current behavior *or* the patched opt-in
> > behavior is great.  I think we would do better to have the filter
> > indicate that it is signal-aware and to document that non-signal-aware
> > filters cannot behave correctly with respect to signals.
> 
> I think it would be hard to make a signal-aware filter, it really does
> feel like the only thing to do is a killable wait.
> 
> Tycho

There are plenty of scenarios where the syscall can be handled in an interruptible
fashion. I like to use accept as an example. I think Jann Horn had put together
a patchset on how the supervisor could be notified (as opposed to background
polling). If the call is interrupted, you can just "finish" the accept on restart
of the sycall by handing the FD over.

I see a handful of paths forward:

* We add a new action USER_NOTIF_KILLABLE which requires a fatal signal
  in order to be interrupted
* We add a chunk of data to the USER_NOTIF return code (say, WAIT_KILLABLE)
  from the BPF filter that indicates what kind of wait should happen
* (what is happening now) An ioctl flag to say pickup the notification
  and put it into a wait_killable state
* An ioctl "command" that puts an existing notifcation in progress into
  the wait killable state.
