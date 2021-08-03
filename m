Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A03DEBA8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhHCLWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhHCLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:22:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E6C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oCfToeqn1k3lFs3DOIR5EL/mFEuSqiZC986MzVwbPdU=; b=YOL9Vm4aXFmSu4ThuUzXqnI3hP
        xbEEDdxX6CJ271tInSEedEQOmZypN7wwUxoTCKSJn+0k0hBQOJ3OwlX7e6j/ccHaUnND73fj1MFgd
        M0ZgErz8X4EmE/JOqXTKRMngtIz1+gvm5WGT5P6UvqWBqYv/NafXs9tyuQdw3jhWCGT99hBnt6c9t
        A/oFsFy1MhAobuHEQKQUeHbBK8ODwKyfKkOBXAgEpkTGJrgZGcg0Mdfq2z8TdONdSiAYKAmqI+kRS
        BH3IziUukPn16BQsgtGbUV+ZU/j9VzZb+B2vj+mOA2eYs+sxhxQHBmPTRY2TCals4c2v3Qn+XdwEs
        YtWoeHLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAsTc-004ZGI-Tq; Tue, 03 Aug 2021 11:21:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17CF39862A8; Tue,  3 Aug 2021 13:20:51 +0200 (CEST)
Date:   Tue, 3 Aug 2021 13:20:51 +0200
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
Message-ID: <20210803112051.GC8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730135208.418508738@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
> @@ -3082,27 +3302,22 @@ static int futex_unlock_pi(u32 __user *u
>  }
>  
>  /**
> - * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial futex
> + * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
>   * @hb:		the hash_bucket futex_q was original enqueued on
>   * @q:		the futex_q woken while waiting to be requeued
> - * @key2:	the futex_key of the requeue target futex
>   * @timeout:	the timeout associated with the wait (NULL if none)
>   *
> - * Detect if the task was woken on the initial futex as opposed to the requeue
> - * target futex.  If so, determine if it was a timeout or a signal that caused
> - * the wakeup and return the appropriate error code to the caller.  Must be
> - * called with the hb lock held.
> + * Determine the cause for the early wakeup.
>   *
>   * Return:
> - *  -  0 = no early wakeup detected;
> - *  - <0 = -ETIMEDOUT or -ERESTARTNOINTR
> + *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
>   */
>  static inline
>  int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
> -				   struct futex_q *q, union futex_key *key2,
> +				   struct futex_q *q,
>  				   struct hrtimer_sleeper *timeout)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	/*
>  	 * With the hb lock held, we avoid races while we process the wakeup.
> @@ -3111,22 +3326,21 @@ int handle_early_requeue_pi_wakeup(struc
>  	 * It can't be requeued from uaddr2 to something else since we don't
>  	 * support a PI aware source futex for requeue.
>  	 */
> -	if (!match_futex(&q->key, key2)) {
> -		WARN_ON(q->lock_ptr && (&hb->lock != q->lock_ptr));
> -		/*
> -		 * We were woken prior to requeue by a timeout or a signal.
> -		 * Unqueue the futex_q and determine which it was.
> -		 */
> -		plist_del(&q->list, &hb->chain);
> -		hb_waiters_dec(hb);
> +	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
>  
> -		/* Handle spurious wakeups gracefully */
> -		ret = -EWOULDBLOCK;
> -		if (timeout && !timeout->task)
> -			ret = -ETIMEDOUT;
> -		else if (signal_pending(current))
> -			ret = -ERESTARTNOINTR;
> -	}
> +	/*
> +	 * We were woken prior to requeue by a timeout or a signal.
> +	 * Unqueue the futex_q and determine which it was.
> +	 */
> +	plist_del(&q->list, &hb->chain);
> +	hb_waiters_dec(hb);
> +
> +	/* Handle spurious wakeups gracefully */
> +	ret = -EWOULDBLOCK;
> +	if (timeout && !timeout->task)
> +		ret = -ETIMEDOUT;
> +	else if (signal_pending(current))
> +		ret = -ERESTARTNOINTR;
>  	return ret;
>  }

AFAICT this change is a separate cleanup, possible because the only
callsite already does that match_futex() test before calling this.

I think it might be worth splitting out, just to reduce the complexity
of this patch.
