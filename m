Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD3418223
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245087AbhIYM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234877AbhIYM5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22EB4610CF;
        Sat, 25 Sep 2021 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632574540;
        bh=nfYw1aza6mD4lKuunNvDXwpq0ZgXwpRzUvT+rq3N9Oo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VhJ78QWJXLAR1I/ATgFasH8XRbCKbxeLN24zfmxA6QcAhyeMhpNUreMnsyvg78HGe
         V9DRfS89msTasQJVafrj+B2dJVjWIFHz9z33IeVg/BnHxYjKjvN6n/+ERjz+7z0sfk
         uXXwHEhqgk8uaO+h0JZo8MA+9K5hWIsmvyDE7AVlPG8MADzf6/6ZLCqDhBCAXCRhSd
         5h6oOFLCKpeJRYe/bCv5pOKbAo+gK4YUYJzvHWd22dFUESIVy2zPchvb0PxUkbXp+P
         ZxlYJJ0vjQ3f8VE9S5TOosO2px8Sn+LHqwI0OaphXQTJupL0qBZ4+D25HHv2Dj0zV+
         2zYQ59sCV8x3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC93F5C08E8; Sat, 25 Sep 2021 05:55:39 -0700 (PDT)
Date:   Sat, 25 Sep 2021 05:55:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org, richard@nod.at
Subject: Re: Confusing lockdep splat
Message-ID: <20210925125539.GP880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
 <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
 <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
 <ce4e1130-203b-095d-be4e-5b3a05a08ba7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4e1130-203b-095d-be4e-5b3a05a08ba7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 08:30:20PM -0400, Waiman Long wrote:
> On 9/24/21 6:43 PM, Paul E. McKenney wrote:
> > On Fri, Sep 24, 2021 at 05:41:17PM -0400, Waiman Long wrote:
> > > On 9/24/21 5:02 PM, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > I got the lockdep splat below from an SRCU-T rcutorture run, which uses
> > > > a !SMP !PREEMPT kernel.  This is a random event, and about half the time
> > > > it happens within an hour or two.  My reproducer (on current -rcu "dev"
> > > > branch for a 16-CPU system) is:
> > > > 
> > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
> > > > 
> > > > My points of confusion are as follows:
> > > > 
> > > > 1.	The locks involved in this deadlock cycle are irq-disabled
> > > > 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
> > > > 	There is only one CPU.	There is no possibility of preemption
> > > > 	or interrupts.	So how can this deadlock actually happen?
> > > > 
> > > > 2.	If there was more than one CPU, then yes, there would be
> > > > 	a deadlock.  The PI lock is acquired by the wakeup code after
> > > > 	acquiring the workqueue lock, and rcutorture tests the new ability
> > > > 	of the scheduler to hold the PI lock across rcu_read_unlock(),
> > > > 	and while it is at it, across the rest of the unlock primitives.
> > > > 
> > > > 	But if there was more than one CPU, Tree SRCU would be used
> > > > 	instead of Tiny SRCU, and there would be no wakeup invoked from
> > > > 	srcu_read_unlock().
> > > > 
> > > > 	Given only one CPU, there is no way to complete the deadlock
> > > > 	cycle.
> > > > 
> > > > For now, I am working around this by preventing rcutorture from holding
> > > > the PI lock across Tiny srcu_read_unlock().
> > > > 
> > > > Am I missing something subtle here?
> > > I would say that the lockdep code just doesn't have enough intelligence to
> > > identify that deadlock is not possible in this special case. There are
> > > certainly false positives, and it can be hard to get rid of them.
> > Would it make sense for lockdep to filter out reports involving more
> > than one CPU unless there is at least one sleeplock in the cycle?
> > 
> > Of course, it gets more complicated when interrupts are involved...
> 
> Actually, lockdep keeps track of all the possible lock orderings and put out
> a splat whenever these lock orderings suggest that a circular deadlock is
> possible. It doesn't keep track if a lock is sleepable or not. Also lockdep
> deals with lock classes each of which can have many instances. So all the
> pi_lock's in different task_struct's are all treated as the same lock from
> lockdep's perspective. We can't treat all different instances separately or
> we will run out of lockdep table space very quickly.

We shouldn't need additional classes, but only instead a marking of a
given lock class to tell whether or not it was a sleeplock.  Either way,
I now have a workaround within Tiny SRCU that appears to handle this case,
so it is not as urgent as it might be.

							Thanx, Paul
