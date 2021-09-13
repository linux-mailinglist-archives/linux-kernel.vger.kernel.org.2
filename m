Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1433D409F74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbhIMWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:09:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhIMWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:09:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631570911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIFUULZXQDg7+U+CZahOjC36byrqbcllUTVbW2ndRTI=;
        b=oobnOPnv/ggcqFhOGebZ9ySpZq+NIwxYkAiXEFvvJdj7DfcY5kccC7NrbYxg5lMTx1LkSU
        5l+86n9pmRp9MzWFh7kCXymBuCDafS89r5Lx+9k/YH8MUEcZIQ09fd/CKJUzpRAkiLNdKZ
        IUgXcPDc15T40ygrnkbVCNyu3LjOAeKST8PtOgw06tAlNmITuEWza02cX6OzTN8dqhM4PT
        2hNSLvebcAcZFsjjgjlZYjoeuvQasqGxa/hmCSWpm33ubukH00Xb9civpoaC8i7hbueUBZ
        a0FqELq6ZY/5kT7Jm2+pHusWsWlxaC4uy9WR4aQtn93yygzvtexEJMyBOLGt7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631570911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIFUULZXQDg7+U+CZahOjC36byrqbcllUTVbW2ndRTI=;
        b=QmsCXBvqYyPbrTlY/BjmSoIMCMv/ifqWhO3if8hnHHMFXy91oJaqHeVQFBAf1QFdzhzLmg
        qSNxJs7/1M+mVPBw==
To:     Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
In-Reply-To: <20210909110203.767330253@infradead.org>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
Date:   Tue, 14 Sep 2021 00:08:30 +0200
Message-ID: <871r5sf7s1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2021 at 12:59, Peter Zijlstra wrote:
> While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> it really ought to use smp_store_mb(), because something like:
>
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (try_lock())
> 			break;
>
> 		raw_spin_unlock_irq(&lock->wait_lock);
> 		schedule();
> 		raw_spin_lock_irq(&lock->wait_lock);
>
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
>
> which is the advertised usage in the comment, is actually broken,
> since trylock() will only need a load-acquire in general and that
> could be re-ordered against the state store, which could lead to a
> missed wakeup -> BAD (tm).

I don't think so because both the state store and the wakeup are
serialized via tsk->pi_lock.

> While there, make them consistent with the IRQ usage in
> set_special_state().
>
> Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -245,7 +245,8 @@ struct task_group;
>   *		if (try_lock())
>   *			break;
>   *		raw_spin_unlock_irq(&lock->wait_lock);
> - *		schedule_rtlock();
> + *		if (!cond)
> + *			schedule_rtlock();

cond is not really relevant here.

>   *		raw_spin_lock_irq(&lock->wait_lock);
>   *		set_current_state(TASK_RTLOCK_WAIT);
>   *	}
> @@ -253,22 +254,24 @@ struct task_group;
>   */
>  #define current_save_and_set_rtlock_wait_state()			\
>  	do {								\
> -		lockdep_assert_irqs_disabled();				\
> -		raw_spin_lock(&current->pi_lock);			\
> +		unsigned long flags; /* may shadow */			\
> +									\
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);	\

Why? This is solely for the rtlock use case which invokes this with
interrupts disabled. So why do we need that irqsave() overhead here?

>  		current->saved_state = current->__state;		\
>  		debug_rtlock_wait_set_state();				\
> -		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
> -		raw_spin_unlock(&current->pi_lock);			\
> +		smp_store_mb(current->__state, TASK_RTLOCK_WAIT);	\

The try_lock() does not matter at all here, really. All what matters is
that the unlocker cannot observe the wrong state and that's fully
serialized via tsk::pi_lock.

Thanks,

        tglx
