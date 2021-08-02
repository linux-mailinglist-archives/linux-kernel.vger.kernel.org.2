Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3503DD68C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhHBNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhHBNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:10:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96240C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LIz/HDLg0b0pNuMAX0mJJoo+pjCG6AVHyl/fwAyPTUc=; b=U6iEhcJMbtlwxdS4ebexu2zQ8D
        HOY+twmEwlZQv0u66YwfHEUKTS1mz2+iSoTMsPCRkSBX1pB5BLttsZGjNC6KmXetPh6jgCtiyi+uU
        m/QnE2tMvbFHSWBVsx0N8CO+iTl83Zp3PDna/C6HI92/jowAFPaz8KdOdJi1efBUpT3JgdXD9p6TE
        fDmwu1QNK7FEJEqsBVR2LjbKDO0+ojWFIrH0Yg6jjJQZKDlRrVfweBc3nwj1y0v/ESfjH9L/VZOCI
        8yfRkN2H54JadPaSCio8TxK0ZCOY+evznSsbldZweOPhJaIXsek1fYDCti4JVtp2o5wH6kLRr0YIL
        e7piGbpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAXhm-0059zH-Ro; Mon, 02 Aug 2021 13:10:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54978300103;
        Mon,  2 Aug 2021 15:10:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CF9F2023F512; Mon,  2 Aug 2021 15:10:06 +0200 (CEST)
Date:   Mon, 2 Aug 2021 15:10:06 +0200
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
Message-ID: <YQfurhYEojdg8VZY@hirez.programming.kicks-ass.net>
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
>  static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
>  {
> +	int old, new;
>  
> +	old = atomic_read_acquire(&q->requeue_state);
> +	do {
>  		/* Is requeue done already? */
> +		if (old >= Q_REQUEUE_PI_DONE)
>  			break;

I think that can be: return old; for slightly simpler code.

>  
>  		/*
>  		 * If not done, then tell the requeue code to either ignore
>  		 * the waiter or to wake it up once the requeue is done.
>  		 */
> +		new = Q_REQUEUE_PI_WAIT;
> +		if (old == Q_REQUEUE_PI_NONE)
> +			new = Q_REQUEUE_PI_IGNORE;
> +	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
>  
>  	/* If the requeue was in progress, wait for it to complete */
> +	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
>  #ifdef CONFIG_PREEMPT_RT
>  		rcuwait_wait_event(&q->requeue_wait,
>  				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
>  				   TASK_UNINTERRUPTIBLE);
>  #else
> +		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
>  #endif
>  	}
>  
