Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21B631FFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 21:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBSUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 15:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSUEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 15:04:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DA9E64EAF;
        Fri, 19 Feb 2021 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613765047;
        bh=Zlci/AmdKj0FlBYDWFBN2+f3PZab3/D9d+nTODN6EFA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y7Z3/p7LBPRUIx0+KnL8gQEeNW60J4AxXN08vWXeRabAfn7bgCNn4U8Hl9c0Vn2i8
         Y9Q0AZ6I66evTtzNwD1RDKzz3Nt5DuDAPquJlgpymDMFxBPR3g7npnL75l1N69zS0M
         gcCt1JFvgodYUMcDg8EC9t8N51Zg5XdWzbOdWXB+5xfApoMehsQ9Jqd1+WBOgitSaY
         YjiKd8Q+DcmYcjrjpzMjBr9drmsz04E1QIuGsn3Myg9xaoNyA68DrddNb/OrrHTHWy
         Xfc1dUbv2mVLMsNcaihcpH+W6871y7o0D6NcEwSaWVkC28/dEp/jKMCGdAoPTuTHUv
         LElUZIG9jjt1w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3834F3520E6A; Fri, 19 Feb 2021 12:04:07 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:04:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219200407.GA18400@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219141429.53def012@gandalf.local.home>
 <20210219194539.GZ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219194539.GZ2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:45:39AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 19, 2021 at 02:14:29PM -0500, Steven Rostedt wrote:
> > On Fri, 19 Feb 2021 10:18:11 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > We can further prevent entry into dyntick-idle state until
> > > the ksoftirqd kthreads have been spawned, which means that if softirq
> > > handlers must be deferred, they will be resumed within one jiffy by the
> > > next scheduler-clock interrupt.
> > 
> > Why not just prevent entry into dyntick-idle state until the system is
> > finished booting? As you said; There should be no latency-sensitive
> > applications running, until after we started the system.
> 
> Exactly, and that is the effect of patch to rcu_needs_cpu() that I just
> now posted.
> 
> Ah, your point is that if the tick keeps running, there is no need to
> modify softirq?  Good point, and I will test that, thank you!!!

But sadly keeping the tick on without also modifying softirq still
results in a hang.  The problem is that when the kernel is booted with
threadirqs=1, invoke_softirq() will avoid ever running the softirq
handlers on the backside of an interrupt.

So is this where Sebastian tells me that some -rt transformation can
result in locking-based deadlocks if softirq handlers are ever run on
the backside of an interrupt?  ;-)

							Thanx, Paul
