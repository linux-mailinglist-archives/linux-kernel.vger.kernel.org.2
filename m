Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A02415BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbhIWKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240296AbhIWKEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:04:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10EF961279;
        Thu, 23 Sep 2021 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632391357;
        bh=HSGgjOkM07hP18XY0Q7ip8XE7xzU+dWwNiaGeoorR+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezUOH5LwO3C9X8XT2O3wod7/4tozea/MoFSP0eDIzfoREoUL/ofOHPz5zZA4bxVZ9
         W2aMpWaykopLVUT2RXZXQEFiioNPoayW57JkHrOffhINp4RudJqKPyugUSshE0suKM
         aEZD0tY8kz/1ryB3nQ0aW7+5A/rk+Ud5RYmFBaWN+kKI/HaOw5c/5TRvL4d03xn3H7
         HJf2SMOwrOSiHH4Jl3Cj++owGNKQsvhUum/Mp1ccx8xDELF5IpU4Z4nJfL0U1uTvEN
         s3KlUuWVv8K0RVKSZiImnCg4c2gkTUzFKvOalBEKxOo+SaYGaAiZLXkkVb/nk/XqF5
         pc+ttDdIUmebg==
Date:   Thu, 23 Sep 2021 12:02:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
Message-ID: <20210923100235.GA113809@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921234518.GB100318@lothringen>
 <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
 <20210922111012.GA106513@lothringen>
 <20210922112731.dvauvxlhx5suc7qd@linutronix.de>
 <20210922113820.GC106513@lothringen>
 <20210922130232.vm7rgkdszfhejf34@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922130232.vm7rgkdszfhejf34@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:02:32PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-22 13:38:20 [+0200], Frederic Weisbecker wrote:
> > > So you rely on some implicit behaviour which breaks with RT such as:
> > > 
> > >                               CPU 0
> > >            -----------------------------------------------
> > >            RANDOM TASK-A                      RANDOM TASK-B
> > >            ------                             -----------
> > >            int *X = &per_cpu(CPUX, 0)         int *X = &per_cpu(CPUX, 0)
> > >            int A, B;                          
> > > 					      spin_lock(&D);
> > >            spin_lock(&C);
> > > 	   				      WRITE_ONCE(*X, 0);
> > >            A = READ_ONCE(*X);
> > >                                               WRITE_ONCE(*X, 1);
> > >            B = READ_ONCE(*X);
> > > 
> > > while spinlock C and D are just random locks not related to CPUX but it
> > > just happens that they are held at that time. So for !RT you guarantee
> > > that A == B while it is not the case on RT.
> > 
> > Not sure which spinlocks you are referring to here. Also most RCU spinlocks
> > are raw.
> 
> I was bringing an example where you also could rely on implicit locking
> provided by spin_lock() which breaks on RT.

Good point!
