Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4945417CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346916AbhIXVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346324AbhIXVEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 735C260F4C;
        Fri, 24 Sep 2021 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632517367;
        bh=aDwG96YTFcAYS5kY2EJnAKx6v7vIc/eNuYEX5dpVXQk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aHbEEjzxbM0QSJGk3n7NVAKqzVNP3qxdI8zqvMWQwsZWOmIWmwIPxOKVsTh75yvd/
         Y2wWrBNhbQ6wjiCFUW4yjItAt36RZIjviX/igqVpy6JcsL/A9nDYMS11tMuxK7OLYd
         Eq4PzEG7ZYvDvIaKlUHbWbhxUHCJL10JuhW6NC+fKVhgETk7AVH3xjHKUa+khbQ5Dm
         NwkzBihdz+wz294BDyABb7JMJQ5oIvLW/ekFNIXufM/7JYVXYOwvAwEDmQlSBwhY+M
         T1s5TsCPHBeGJX8kGv6swA0Zop+Jpmhq22MvXABFsYiG8zM02QnPR92U6zSpd0GT5F
         CN2xkx6w7XRXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4356F5C0800; Fri, 24 Sep 2021 14:02:47 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:02:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, richard@nod.at
Subject: Confusing lockdep splat
Message-ID: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got the lockdep splat below from an SRCU-T rcutorture run, which uses
a !SMP !PREEMPT kernel.  This is a random event, and about half the time
it happens within an hour or two.  My reproducer (on current -rcu "dev"
branch for a 16-CPU system) is:

	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200

My points of confusion are as follows:

1.	The locks involved in this deadlock cycle are irq-disabled
	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
	There is only one CPU.	There is no possibility of preemption
	or interrupts.	So how can this deadlock actually happen?

2.	If there was more than one CPU, then yes, there would be
	a deadlock.  The PI lock is acquired by the wakeup code after
	acquiring the workqueue lock, and rcutorture tests the new ability
	of the scheduler to hold the PI lock across rcu_read_unlock(),
	and while it is at it, across the rest of the unlock primitives.

	But if there was more than one CPU, Tree SRCU would be used
	instead of Tiny SRCU, and there would be no wakeup invoked from
	srcu_read_unlock().

	Given only one CPU, there is no way to complete the deadlock
	cycle.

For now, I am working around this by preventing rcutorture from holding
the PI lock across Tiny srcu_read_unlock().

Am I missing something subtle here?

						Thanx, Paul

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc1+ #3766 Not tainted
------------------------------------------------------
rcu_torture_rea/53 is trying to acquire lock:
ffffffffa074e6a8 (srcu_ctl.srcu_wq.lock){....}-{2:2}, at: swake_up_one+0xa/0x30

but task is already holding lock:
ffffa03502479d80 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend+0x370/0x400

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       _raw_spin_lock_irqsave+0x2f/0x50
       try_to_wake_up+0x50/0x580
       swake_up_locked.part.7+0xe/0x30
       swake_up_one+0x22/0x30
       rcutorture_one_extend+0x1b6/0x400
       rcu_torture_one_read+0x290/0x5d0
       rcu_torture_reader+0xac/0x200
       kthread+0x12d/0x150
       ret_from_fork+0x22/0x30

-> #0 (srcu_ctl.srcu_wq.lock){....}-{2:2}:
       __lock_acquire+0x130c/0x2440
       lock_acquire+0xc2/0x270
       _raw_spin_lock_irqsave+0x2f/0x50
       swake_up_one+0xa/0x30
       rcutorture_one_extend+0x387/0x400
       rcu_torture_one_read+0x290/0x5d0
       rcu_torture_reader+0xac/0x200
       kthread+0x12d/0x150
       ret_from_fork+0x22/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->pi_lock);
                               lock(srcu_ctl.srcu_wq.lock);
                               lock(&p->pi_lock);
  lock(srcu_ctl.srcu_wq.lock);

 *** DEADLOCK ***

1 lock held by rcu_torture_rea/53:
 #0: ffffa03502479d80 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend+0x370/0x400

stack backtrace:
CPU: 0 PID: 53 Comm: rcu_torture_rea Not tainted 5.15.0-rc1+ #3766
Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.5.0+746+bbd5d70c 04/01/2014
Call Trace:
 check_noncircular+0xfe/0x110
 ? find_held_lock+0x2d/0x90
 __lock_acquire+0x130c/0x2440
 lock_acquire+0xc2/0x270
 ? swake_up_one+0xa/0x30
 ? find_held_lock+0x72/0x90
 _raw_spin_lock_irqsave+0x2f/0x50
 ? swake_up_one+0xa/0x30
 swake_up_one+0xa/0x30
 rcutorture_one_extend+0x387/0x400
 rcu_torture_one_read+0x290/0x5d0
 rcu_torture_reader+0xac/0x200
 ? rcutorture_oom_notify+0xf0/0xf0
 ? __kthread_parkme+0x61/0x90
 ? rcu_torture_one_read+0x5d0/0x5d0
 kthread+0x12d/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
