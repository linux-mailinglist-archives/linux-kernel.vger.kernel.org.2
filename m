Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686031FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBSTs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBSTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:48:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8570D64EAF;
        Fri, 19 Feb 2021 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613764064;
        bh=lmxz4Kw1dYoWbImqI8vdI4znpPPVecXgCXugHd/TVYo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CTnx4oMB1vy+y4M7xx0X235vuR6J/1dtvCknq5QzDtTLvHid5ukw00aVj4Vm86K6Z
         QBc83dtnXL+HYtqVMq7XzyNWBEMDCUrYtUV7ozo/oxxCVU3UYk7hILFCu5mXJJrxsk
         5yWE4p0TnKRSf7kjHEceTSa9p4Teyet8SyqaToDy/iEj2HW5H11dFTBFLhfe2FA8E5
         eYn9FJF5edzwTNxLe1L/VX0LZJEEzf9JMVJ20ROreHHyXP7DthgoRggAoLfhGNGU9o
         MUtV5ZyD7/zgmMiqt5r0XW+DgjMZa3JL7nLtp+PSaWwctQtuDAMwryX8c5gaXoqI16
         uDSoSXNoDgNsg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3CB9C3520E6A; Fri, 19 Feb 2021 11:47:44 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:47:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20210219194744.GA2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210219143607.3cdf9ed8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219143607.3cdf9ed8@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:36:07PM -0500, Steven Rostedt wrote:
> On Thu, 18 Feb 2021 23:29:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Commit 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> > moved the kprobe setup in early_initcall(), which includes kprobe
> > jump optimization.
> > The kprobes jump optimizer involves synchronize_rcu_tasks() which
> > depends on the ksoftirqd and rcu_spawn_tasks_*(). However, since
> > those are setup in core_initcall(), kprobes jump optimizer can not
> > run at the early_initcall().
> > 
> > To avoid this issue, make the kprobe optimization disabled in the
> > early_initcall() and enables it in subsys_initcall().
> > 
> > Note that non-optimized kprobes is still available after
> > early_initcall(). Only jump optimization is delayed.
> > 
> > Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> 
> I pulled this into my queue to be tested, and when that completes
> (hopefully without failure), I'll add this to my pull request for the
> current merge window (which I still need to send).

Thank you, Steve!

Could you please add the following Reported-by tags?

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Uladzislau Rezki <urezki@gmail.com>

Sebastian first noticed the problem, and Uladzislau figured out
how softirqs were involved.

						Thanx, Paul
