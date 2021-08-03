Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2083DEAE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhHCK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbhHCK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:28:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=98yoqGV89pwFhKfA2G0ApRnFEwhqF1s9mokkYkzcMB0=; b=hvdQbsYTmm2V2o4geRiTekYLe0
        D6sC416zaFsMzwxx6poisxuewKnC5OAzsa322fKxbyuIfzWAVegZmsHwk+JZaEdHO2SeSpS062h3S
        LYow5Jnk7X2yqNp8QQYv/2k0Z5zPLGztoYpkQqHq9jJfzVzYLUEWsdcdikNrIiXh8M7g6NOhXcY9x
        XEA25H/LF67m1+kNa6JTwbcsfFsJv+3d+euHJpLdKC6Tf8jqGIJj8v978jDe/8PifBplAq+uYYKHJ
        capMAc8YHFs/NEJOCYcGRvlpsdwd1GU+c6F8dWx8NuYM9jwWXDoHjPUunsU1Ro3p7vqRYq7lYvfKS
        tcklv57g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAreb-005OUb-8G; Tue, 03 Aug 2021 10:28:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD4609862A3; Tue,  3 Aug 2021 12:28:08 +0200 (CEST)
Date:   Tue, 3 Aug 2021 12:28:08 +0200
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
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on
 RT
Message-ID: <20210803102808.GA8641@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:56:09PM +0200, Peter Zijlstra wrote:
>  static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
>  {
> +	int old, new;
>  
> +	old = atomic_read_acquire(&q->requeue_state);
> +	do {

		if (old == Q_REQUEUE_PI_IGNORE)
			return;

>  		if (locked >= 0) {

			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
			             old != Q_REQUEUE_PI_WAIT)

>  			/* Requeue succeeded. Set DONE or LOCKED */
>  			new = Q_REQUEUE_PI_DONE + locked;
> +		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
>  			/* Deadlock, no early wakeup interleave */
>  			new = Q_REQUEUE_PI_NONE;
>  		} else {

			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);

>  			/* Deadlock, early wakeup interleave. */
>  			new = Q_REQUEUE_PI_IGNORE;
>  		}
> +	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
>  
>  #ifdef CONFIG_PREEMPT_RT
>  	/* If the waiter interleaved with the requeue let it know */
> +	if (unlikely(old == Q_REQUEUE_PI_WAIT))
>  		rcuwait_wake_up(&q->requeue_wait);
>  #endif
>  }

I think... 
