Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228453D92FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhG1QPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhG1QPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:15:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 570976101C;
        Wed, 28 Jul 2021 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627488941;
        bh=YxSnffw74ATV0fmbxVeBDi/P3tDrgFf/jC+1OaxRqSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHeYikXeFbCTn1+EBLk6YFrxmtYD4lEyWh+Er8+BbSIAcORwF4v5MZUthOyQnNBWa
         BJc54Sh/GB1kD03yHcoi7pPuB9AqYTSJWow4vNQ9lhblNuLLfBnN99jBDthfM2SJOP
         fC1UtbZwBFOczNjmN2VLOYq3zN9JiDFddrYlSFAU=
Date:   Wed, 28 Jul 2021 18:15:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
Message-ID: <YQGCqylzS6sTW7Nm@kroah.com>
References: <20210719162418.GA28003@zipoli.concurrent-rt.com>
 <YPl8nfZBjgmSnE7N@kroah.com>
 <20210727221950.GA51120@zipoli.concurrent-rt.com>
 <YQD0BIYaD/y9VCEz@kroah.com>
 <20210728135114.GA2453@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728135114.GA2453@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 09:51:14AM -0400, Joe Korty wrote:
> On Wed, Jul 28, 2021 at 08:07:00AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 27, 2021 at 06:19:50PM -0400, Joe Korty wrote:
> > > 
> > >  [ Added missing people to the cc: as listed in MAINTAINERS ]
> > > 
> > > On Thu, Jul 22, 2021 at 04:11:41PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 19, 2021 at 12:24:18PM -0400, Joe Korty wrote:
> > > > > [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
> > > > > 
> > > > >    [ replicator, attached ]
> > > > >    [ workaround patch that crudely clears the loop, attached ]
> > > > >    [ 4.4.256 does _not_ have this problem, 4.4.262 is known to have it ]
> > > > > 
> > > > > When a certain, secure-site application is run on 4.4.262, it locks up and
> > > > > is unkillable.  Crash(8) and sysrq backtraces show that the application
> > > > > is looping in the kernel in futex_unlock_pi.
> > > > > 
> > > > > Between 4.4.256 and .257, 4.4 got this 4.12 patch backported into it:
> > > > > 
> > > > >    73d786b ("[PATCH] futex: Rework inconsistent rt_mutex/futex_q state")
> > > > > 
> > > > > This patch has the following comment:
> > > > > 
> > > > >    The only problem is that this breaks RT timeliness guarantees. That
> > > > >    is, consider the following scenario:
> > > > > 
> > > > >       T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)
> > > > > 
> > > > >         CPU0
> > > > > 
> > > > >         T1
> > > > >           lock_pi()
> > > > >           queue_me()  <- Waiter is visible
> > > > >    
> > > > >         preemption
> > > > > 
> > > > >         T2
> > > > >           unlock_pi()
> > > > >             loops with -EAGAIN forever
> > > > > 
> > > > >     Which is undesirable for PI primitives. Future patches will rectify
> > > > >     this.
> > > > > 
> > > > > This describes the situation exactly.  To prove, we developed a little
> > > > > kernel patch that, on loop detection, puts a message into the kernel log for
> > > > > just the first occurrence, keeps a count of the number of occurrences seen
> > > > > since boot, and tries to break out of the loop via usleep_range(1000,1000).
> > > > > Note that the patch is not really needed for replication.  It merely shows,
> > > > > by 'fixing' the problem, that it really is the EAGAIN loop that triggers
> > > > > the lockup.
> > > > > 
> > > > > Along with this patch, we submit a replicator.  Running this replicator
> > > > > with this patch, it can be seen that 4.4.256 does not have the problem.
> > > > > 4.4.267 and the latest 4.4, 4.4.275, do.  In addition, 4.9.274 (tested
> > > > > w/o the patch) does not have the problem.
> > > > > 
> > > > > >From this pattern there may be some futex fixup patch that was ported
> > > > > back into 4.9 but failed to make it to 4.4.
> > > > 
> > > > Odd, I can't seem to find anything that we missed.  Can you dig to see
> > > > if there is something that we need to do here so we can resolve this?
> > > > 
> > > > thanks,
> > > > greg k-h
> > > 
> > > 
> > > Hi Greg,
> > > 
> > > 4.12 has these apparently-original patches:
> > > 
> > >   73d786b  futex: Rework inconsistent rt_mutex/futex_q state
> > >   cfafcd1  futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
> > > 
> > > I have verified that the first commit, 73d786b, introduces
> > > the futex_unlock_pi infinite loop bug into 4.12.  I have
> > > also verified that the last commit, cfafcd1, fixes the bug.
> > > 
> > > 4.9 has had both futex patches backported into it.
> > > Verified that 4.9.276 does not suffer from the bug.
> > > 
> > > 4.4 has had the first patch backported, as 394fc49, but
> > > not the last.  I have verified that building a kernel at
> > > 394fc49 and at v4.4.276, the bug is seen, and at 394fc49^,
> > > the bug is not present.
> > > 
> > > The missing commit, cfafcd1 in 4.12, is present in 4.9
> > > as 13c98b0.  A visual spot-check of 13c98b0, as a patch,
> > > with kernel/futex.c in 4.4.276 did not find any hunks of
> > > 13c98b0 present in 4.4.276's kernel/futex.c.
> > 
> > Ok, so what do you recommend be done to resolve this?
> > 
> > thanks,
> > greg k-h
> 
> I suppose we could either back out 394fc49 from 4.4, or
> backport 13c98b0 from 4.9 to 4.4.  At the time I wrote
> the above, I hadn't tried either approach yet.
> 
> Since then, I did a trial backport of 13c98b0 into 4.4.
> All the changes to kernel/futex.c applied, none of the
> changes to kernel/locking/rtmutex.c applied.  That implies
> to me that we have at least one other patch that needs
> finding-n-backporting before we can proceed.

Ok, let me know if there's anything I can apply here after you test
things.

greg k-h
