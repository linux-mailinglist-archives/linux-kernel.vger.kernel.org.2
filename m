Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84402414753
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhIVLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235293AbhIVLLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:11:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BBB61050;
        Wed, 22 Sep 2021 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632309014;
        bh=heL9ashJZjDXOujO0aAimbm/D8yBEukgS7g+p+wZ0ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2d16Jyh5F/xzhvIwRlDHLRaVW7DbD3t+EZTg4COyDcZeIBU65zti9fqJZICzEwNo
         ltFnrILzJ3lCdMkDSq+vCfPWnLTGKrVkmP9GxT8NnOZ5kudw3G4VS6R3YKvYd8koQi
         nzci3jd+b/s8o2U9DLzMZJ0pCfHbFAxjjvI23BtSCu9txoTjddzX1lg/9tw85YWENo
         qBCcZWhKiGYS5DVFwyRkqCicyeXvs9FtOExuIyHsY8GbIdiuwtXJcWF++kMGLGUCeq
         l7d/SHcV4pInDsJri8BalseyYbCjDLbrP6Dvpa0H1SF7uidIb5i6kZZPPRYoEGxxkN
         hnbyZgXIJ8u/g==
Date:   Wed, 22 Sep 2021 13:10:12 +0200
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
Message-ID: <20210922111012.GA106513@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921234518.GB100318@lothringen>
 <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:32:08AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-22 01:45:18 [+0200], Frederic Weisbecker wrote:
> > 
> > Also while at it, I'm asking again: traditionally softirqs could assume that
> > manipulating a local state was safe against !irq_count() code fiddling with
> > the same state on the same CPU.
> > 
> > Now with preemptible softirqs, that assumption can be broken anytime. RCU was
> > fortunate enough to have a warning for that. But who knows how many issues like
> > this are lurking?
> 
> If "local state" is modified then it is safe as long as it is modified
> within a local_bh_disable() section. And we are in this section while
> invoking a forced-threaded interrupt. The special part about RCU is
> that it is used in_irq() as part of core-code.

But local_bh_disable() was deemed for protecting from interrupting softirqs,
not the other way around (softirqs being preempted by other tasks). The latter
semantic is new and nobody had that in mind until softirqs have been made
preemptible.

For example:

                             CPU 0
          -----------------------------------------------
          SOFTIRQ                            RANDOM TASK
          ------                             -----------
          int *X = &per_cpu(CPUX, 0)         int *X = &per_cpu(CPUX, 0)
          int A, B;                          WRITE_ONCE(*X, 0);
                                             WRITE_ONCE(*X, 1);
          A = READ_ONCE(*X);
          B = READ_ONCE(*X);


We used to have the guarantee that A == B. That's not true anymore. Now
some new explicit local_bh_disable() should be carefully placed on RANDOM_TASK
where it wasn't necessary before. RCU is not that special in this regard.
