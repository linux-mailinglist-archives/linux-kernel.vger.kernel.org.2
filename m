Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D351406C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhIJM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233345AbhIJM6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:58:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8432861153;
        Fri, 10 Sep 2021 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631278651;
        bh=MdI2jzzWxnLJvDkNGlzjcRf+bAWdpF09vvi+hNLsNKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgK9zb46wl8Klk9RtHhBHQeYoOyZ/NAPm+TlkTxaGO9yPNO3CiMKQPY5gRWlHt6eV
         aJJB1dox26RWF81tj8cwGBbsUzlmqG9yXw0lQ57Dh27tnxHSOner3CoPMa5o/IfA3B
         Csy20KJ7xjhGSjuKhWnKxmVYe8eBP62TTfMn0U435zxRFdlok1l6K3mRP0aiOaZHpR
         Al5VIzw0gp75rBep928nTDMXHv+i8QYMOlxQsLPrrTuRgSuWFhPL3sXrdCUYR4oh8E
         rlc6ktINqyakR3wkZX7yM4+7J5NEQhYTfiJ7X+lsPAUrNd5MMJhqwa3lRehBWVjbZv
         E0T2S4FFb0MFQ==
Date:   Fri, 10 Sep 2021 13:57:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <20210910125658.GA1454@willie-the-truck>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 09, 2021 at 02:45:24PM +0100, Will Deacon wrote:
> > On Thu, Sep 09, 2021 at 12:59:16PM +0200, Peter Zijlstra wrote:
> > > While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> > > it really ought to use smp_store_mb(), because something like:
> > > 
> > > 	current_save_and_set_rtlock_wait_state();
> > > 	for (;;) {
> > > 		if (try_lock())
> > > 			break;
> > > 
> > > 		raw_spin_unlock_irq(&lock->wait_lock);
> > > 		schedule();
> > > 		raw_spin_lock_irq(&lock->wait_lock);
> > > 
> > > 		set_current_state(TASK_RTLOCK_WAIT);
> > > 	}
> > > 	current_restore_rtlock_saved_state();
> > > 
> > > which is the advertised usage in the comment, is actually broken,
> > > since trylock() will only need a load-acquire in general and that
> > > could be re-ordered against the state store, which could lead to a
> > > missed wakeup -> BAD (tm).
> > 
> > Why doesn't the UNLOCK of pi_lock in current_save_and_set_rtlock_wait_state()
> > order the state change before the successful try_lock? I'm just struggling
> > to envisage how this actually goes wrong.
> 
> Moo yes, so the earlier changelog I wrote was something like:
> 
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (try_lock())
> 			break;
> 
> 		raw_spin_unlock_irq(&lock->wait_lock);
> 		if (!cond)
> 			schedule();
> 		raw_spin_lock_irq(&lock->wait_lock);
> 
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
> 
> which is more what the code looks like before these patches, and in that
> case the @cond load can be lifted before __state.

Ah, so that makes more sense, thanks. I can't see how the try_lock() could
be reordered though, as it's going to have to do an atomic rmw.

Will
