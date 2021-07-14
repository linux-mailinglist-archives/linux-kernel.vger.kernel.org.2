Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE963C8352
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGNLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhGNLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:03:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA843C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K7isHcB9XbWY3/t3e+rScO4gWizRci/DCT5TG2IS/qE=; b=CCl6htJYxIz+aAgEIV6dtCJgqG
        q8XRPCQAwItC3an6cMHluHWUpn3tqsy9BTu1sgO7aswWqvjNiDywyIsxfNNsDEKggIETR/EFiTSx1
        yQMKIuMSvvIsoYSRV9wqssqQWuslqVadtuaby62O3cM0bNwcou9sXK/5gDmeZVTrVOLSUuwE50jwH
        lSAJjkrBAVCdicMj4fteVC4nvAJy383pYopFDiHr2eY6RD//BxvNXzJLvWPWEIONloRnNiIkLbXLv
        y0QtX+v+K2PASgL/DODkAbQ2IHoZsFNfyHClaQMo0eoeC+VGXCGEVqNwbJA0+OXc52iFk+1+LPO/F
        jWTT+UjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3cbt-0028QE-Uu; Wed, 14 Jul 2021 10:59:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78F7A98689D; Wed, 14 Jul 2021 12:59:24 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:59:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 26/50] locking/rtmutex: Provide the spin/rwlock core lock
 function
Message-ID: <20210714105924.GD2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160748.491632534@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160748.491632534@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:20PM +0200, Thomas Gleixner wrote:
> +/**
> + * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
> + * @lock:	The underlying rt mutex
> + */
> +static void __sched rtlock_slowlock_locked(struct rt_mutex *lock)
> +{
> +	struct rt_mutex_waiter waiter;
> +
> +	lockdep_assert_held(&lock->wait_lock);
> +
> +	if (try_to_take_rt_mutex(lock, current, NULL))
> +		return;
> +
> +	rt_mutex_init_rtlock_waiter(&waiter);
> +
> +	/* Save current state and set state to TASK_RTLOCK_WAIT */
> +	current_save_and_set_rtlock_wait_state();
> +
> +	task_blocks_on_rt_mutex(lock, &waiter, current, RT_MUTEX_MIN_CHAINWALK);
> +
> +	for (;;) {
> +		/* Try to acquire the lock again. */
> +		if (try_to_take_rt_mutex(lock, current, &waiter))
> +			break;
> +
> +		raw_spin_unlock_irq(&lock->wait_lock);
> +
> +		schedule_rtlock();
> +
> +		raw_spin_lock_irq(&lock->wait_lock);
> +		set_current_state(TASK_RTLOCK_WAIT);

Since both waker and waiter are fully serialized on ->wait_lock, this
can be __set_current_state(), there is no race condition AFAICT.

Might not be worth it though..

> +	}
> +
> +	/* Restore the task state */
> +	current_restore_rtlock_saved_state();
> +
> +	/*
> +	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We
> +	 * might have to fix that up:
> +	 */
> +	fixup_rt_mutex_waiters(lock);
> +	debug_rt_mutex_free_waiter(&waiter);
> +}
