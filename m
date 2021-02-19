Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EE320048
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBSVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBSVXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:23:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F148D64E4B;
        Fri, 19 Feb 2021 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613769756;
        bh=V9ROP9BTU2xPPUZvYOXMkvnIE3PpDLZs4WcqEFNzXMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=noxUnBnIZsOFQTn2oToKV3Mzsq08CfvAmbEtvTr3lFeFF76Jso7mWpkrSi2NK35e9
         N442QCPPDn9yUS8GUtMA4bN83nk3mW6dqn/rDCP3nlpDSkMd7W3as7hKUYdDyYgb9a
         REeuTX3sOofttgNd9Gl3z4s5DAusYUJNvwrQWdWGce8Y7QG1s/Fm3VhjIRw2sVVuYh
         9lbvGffTWK9dNpdK6B3le3YO8FRPMEO4mpgXK3d53LW8vFuXUWHIf8EfqCt5VfufUI
         Dk/wZWgE5j2azkk3uTXHdusSFsXHbumI5BzdP2aBEr2if+qaW4t6Eoa5J0W6nvfft2
         zemMRctPLxKXQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 869F23520E6A; Fri, 19 Feb 2021 13:22:34 -0800 (PST)
Date:   Fri, 19 Feb 2021 13:22:34 -0800
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
Message-ID: <20210219212234.GC2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210219150231.31dc72a2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219150231.31dc72a2@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:02:31PM -0500, Steven Rostedt wrote:
> On Fri, 19 Feb 2021 10:33:36 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > commit 4f659bf04fc4610523544493d6db92fc8670b086
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Feb 12 16:20:40 2021 -0800
> > 
> >     softirq: Don't try waking ksoftirqd before it has been spawned
> >     
> >     If there is heavy softirq activity, the softirq system will attempt
> >     to awaken ksoftirqd and will stop the traditional back-of-interrupt
> >     softirq processing.  This is all well and good, but only if the
> >     ksoftirqd kthreads already exist, which is not the case during early
> >     boot, in which case the system hangs.
> >     
> >     One reproducer is as follows:
> >     
> >     tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> >     
> >     This commit therefore adds a couple of existence checks for ksoftirqd
> >     and forces back-of-interrupt softirq processing when ksoftirqd does not
> >     yet exist.  With this change, the above test passes.
> >     
> >     Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >     Reported-by: Uladzislau Rezki <urezki@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Hmm, I wonder if this is what patchwork picked up regarding the
> reported-by.
> 
> And I checked, it did not add the "Signed-off-by" from you to Masami's
> patch ;-)
> 
> The dangers of posting patches in threads of other patches :-/

Glad I asked, then!  ;-)

							Thanx, Paul
