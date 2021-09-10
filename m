Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D450406DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhIJPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43E6B60F92;
        Fri, 10 Sep 2021 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631286405;
        bh=VIn1b4GQH+TJrbsUH/3F2B+v61HV9neqi+1DLLKlHvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewu10aDmon6lqr9M+QtkSQT2j7QL/Zgb9y3S6QUIRpOEhC4DrrS5UrsycyCysrvSt
         kbEhtRU3QbKYVUtMalnpVlJbpeWcmWCfzT+ylUn4hIAtQikCfNlTHbWy1ZD7tmhqdD
         snjIJtA38vsRU93VedDt8M2/u7JVU+S4nc2be9fG6t8jGfpJaQ6E+jxLduMUrfPgmB
         OanYA8n4Y8Q5b0seD6Onap+yhWX4l7SZL7tIYVlrmioBlkA9OtcHsSHTqemSJympD+
         L3bdP68IkwCl7L09Kcn/FsgHbbNU/678BKD5aWTk0IT5c2BlQsUM41/tMVM8w5S1tE
         8lY33cKuTgsxQ==
Date:   Fri, 10 Sep 2021 16:06:40 +0100
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
Message-ID: <20210910150639.GA1755@willie-the-truck>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
 <20210910125658.GA1454@willie-the-truck>
 <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
 <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:01:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 03:17:04PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 10, 2021 at 01:57:26PM +0100, Will Deacon wrote:
> > > On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
> > > > Moo yes, so the earlier changelog I wrote was something like:
> > > > 
> > > > 	current_save_and_set_rtlock_wait_state();
> > > > 	for (;;) {
> > > > 		if (try_lock())
> > > > 			break;
> > > > 
> > > > 		raw_spin_unlock_irq(&lock->wait_lock);
> > > > 		if (!cond)
> > > > 			schedule();
> > > > 		raw_spin_lock_irq(&lock->wait_lock);
> > > > 
> > > > 		set_current_state(TASK_RTLOCK_WAIT);
> > > > 	}
> > > > 	current_restore_rtlock_saved_state();
> > > > 
> > > > which is more what the code looks like before these patches, and in that
> > > > case the @cond load can be lifted before __state.
> > > 
> > > Ah, so that makes more sense, thanks. I can't see how the try_lock() could
> > > be reordered though, as it's going to have to do an atomic rmw.
> > 
> > OK, lemme go update the Changelog and make it __flags for bigeasy :-)
> 
> The patch now reads:
> 
> ---
> Subject: sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 09 Sep 2021 12:59:16 +0200
> 
> While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> it really ought to use smp_store_mb(), because using it for a more
> traditional wait loop like:
> 
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (cond)
> 			schedule();
> 
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
> 
> is actually broken, since the cond load could be re-ordered against
> the state store, which could lead to a missed wakeup -> BAD (tm).
> 
> While there, make them consistent with the IRQ usage in
> set_special_state().

Cheers, that's much better:

Acked-by: Will Deacon <will@kernel.org>

Will
