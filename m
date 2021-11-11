Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47044DCB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKKUxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhKKUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:53:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC233C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kl7JbWlL34pNGb++3yFiHVHpsuiOYGzlNKmrcCj0Jhw=; b=kVXWD3i3oT1BXqDlrKAGwXXBnO
        aUHwwbvt3CL5kNPcJKaZPMF/Ak50fH9q1T+rjuFDESEnrZx3NlVaxTxDSog0cEDy8MHGaFxfRMf/T
        PLvj+/PvvMC5+4mnDqRCzgkzxMUkW1+OaHogb4bTdvik/KF9oTpz7Z5O9zb2u4+JrwZJZ6+c5+mwq
        sl3wgi2Y7fvrl6ojPU2CHCwCj0znxpwrfyckNXooe9VLD1L4erZKeyGaaaDAwL5aFUEC6SElru+td
        VH7/GgznUxXdWRzePU7jQoX2DwCcWTwrwC/2ufCwOuR6F7lVkqyC15u52rN9fkxHjN3De3N7lA9lJ
        ZYmRkBYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlH1M-0031tY-Gc; Thu, 11 Nov 2021 20:50:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21354986981; Thu, 11 Nov 2021 21:50:08 +0100 (CET)
Date:   Thu, 11 Nov 2021 21:50:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <20211111205008.GJ174703@worktop.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I suspect that if..

On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
>  static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> -					enum writer_wait_state wstate)
> +					struct rwsem_waiter *waiter)
>  {
>  	long count, new;
> +	bool first = rwsem_first_waiter(sem) == waiter;
>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> @@ -546,13 +541,14 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
> -		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +		if (has_handoff && !first)
>  			return false;
>  
>  		new = count;
>  
>  		if (count & RWSEM_LOCK_MASK) {
> -			if (has_handoff || (wstate != WRITER_HANDOFF))
> +			if (has_handoff || (!waiter->rt_task &&
> +					    !time_after(jiffies, waiter->timeout)))
>  				return false;

we delete this whole condition, and..

>  
>  			new |= RWSEM_FLAG_HANDOFF;

> @@ -889,6 +888,24 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  }
>  #endif
>  
> +/*
> + * Common code to handle rwsem flags in out_nolock path with wait_lock held.
> + */
> +static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
> +						struct rwsem_waiter *waiter)
> +{
> +	long flags = 0;
> +
> +	list_del(&waiter->list);
> +	if (list_empty(&sem->wait_list))
> +		flags = RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS;
> +	else if (waiter->handoff_set)
> +		flags = RWSEM_FLAG_HANDOFF;

take out this else,

> +
> +	if (flags)
> +		atomic_long_andnot(flags,  &sem->count);
> +}

We get the inherit thing for free, no?

Once HANDOFF is set, new readers are blocked. And then allow any first
waiter to acquire the lock, who cares if it was the one responsible for
having set the HANDOFF bit.
