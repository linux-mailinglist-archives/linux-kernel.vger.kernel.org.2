Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0E31DDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhBQRCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhBQRCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:02:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4D5964E42;
        Wed, 17 Feb 2021 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613581279;
        bh=suQXsZu5FOQt1GV8Sn0zUfOQRwhj5nslyZPOGONixyA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=THdlT2vXlBdLQqQAJ2kMEaIPL/b9av6tmuwJzsCzu0cOjhSjHMaoEJXsvyY7WkUiE
         QIYl8Z0czUQGCX4ZpPGgGZ4YEaqO4BqGqsm3Nx9WFN2J+My9hs0c4DrIF4vAqc+7DD
         3CwnsuR0fPIY9So+NCvoBm3ZvlL1/FY9CxXZXIj1K/IO59EYo2c0JXa8sk5ybWnUXK
         FZrz0D5RZamezay4Ev3Kw1zCuyBhsDVK90w+WGFBC+dlBmhAsc+wNK37uTq6+4mmgr
         jsRk3xmbSj4q7mZ02cQGt385BK9FfV4GvQX86+18WbCDp/8rezwg1qldtCP0SQDysB
         SYJ8dZNW7L9aw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 919683522611; Wed, 17 Feb 2021 09:01:19 -0800 (PST)
Date:   Wed, 17 Feb 2021 09:01:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217170119.GD2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
 <20210217155447.GC2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217155447.GC2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 07:54:47AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 17, 2021 at 04:32:53PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-02-16 10:36:09 [-0800], Paul E. McKenney wrote:
> > > Hello, Sebastian,
> > 
> > Hi Paul,
> > 
> > > I punted on this for the moment by making RCU priority boosting testing
> > > depend on CONFIG_PREEMPT_RT, but longer term I am wondering if RCU's
> > > various timed delays and timeouts should use hrtimers rather than normal
> > > timers in kernels built with CONFIG_RCU_BOOST.  As it is, RCU priority
> > > boosting can be defeated if any of the RCU grace-period kthread's timeouts
> > > are serviced by the non-realtime ksoftirqd.
> > 
> > I though boosting is accomplished by acquiring a rt_mutex in a
> > rcu_read() section. Do you have some code to point me to, to see how a
> > timer is involved here? Or is it the timer saying that *now* boosting is
> > needed.
> 
> Yes, this last, which is in the grace-period kthread code, for example,
> in rcu_gp_fqs_loop().
> 
> > If your hrtimer is a "normal" hrtimer then it will be served by
> > ksoftirqd, too. You would additionally need one of the
> > HRTIMER_MODE_*_HARD to make it work.
> 
> Good to know.  Anything I should worry about for this mode?
> 
> Also, the current test expects callbacks to be invoked, which involves a
> number of additional kthreads and timers, for example, in nocb_gp_wait().
> I suppose I could instead look at grace-period sequence numbers, but I
> believe that real-life use cases needing RCU priority boosting also need
> the callbacks to be invoked reasonably quickly (as in within hundreds
> of milliseconds up through very small numbers of seconds).
> 
> Thoughts?

Hmmm...  Unless there are current use cases where callbacks are being
prevented from being invoked, I will modify rcutorture's testing of RCU
priority boosting to look only at grace-period progress on the theory
that most real-time uses offload callbacks, and in that case it is the
sysadm's job to make sure that they get the CPU time they needs.

							Thanx, Paul

> > > This might require things like swait_event_idle_hrtimeout_exclusive(),
> > > either as primitives or just open coded.
> > > 
> > > Thoughts?
> > > 
> > > 							Thanx, Paul
> > 
> > Sebastian
