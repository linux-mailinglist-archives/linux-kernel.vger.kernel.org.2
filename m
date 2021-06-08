Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94CA39F727
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhFHM5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:57:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhFHM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:57:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C3DD1FD46;
        Tue,  8 Jun 2021 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623156914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG6Va9omHPDtzqXpw+nWGAI/woTH33Rwbj3jGukOyg8=;
        b=CqtpU0WTSvM0gOySSzByrh9mGwylEPaai8Yd5ibRXUFyXgLgatITPlUtssTnMRdX6fGxBt
        w/WPnxN8XQl7uBbwdJqnWftrrJetxGaUyR8ti2nwzJ8vXJFB12XA8lh/vszvLgzVcux2Sw
        ar85N7c3+jhOtEGNpJbTyAk25y3m1r8=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2990FA3B81;
        Tue,  8 Jun 2021 12:55:14 +0000 (UTC)
Date:   Tue, 8 Jun 2021 14:55:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v2 2/2] printk: fix cpu lock ordering
Message-ID: <YL9osWvgvdCo4JAK@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
 <20210607200232.22211-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607200232.22211-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-06-07 22:02:32, John Ogness wrote:
> The cpu lock implementation uses a full memory barrier to take
> the lock, but no memory barriers when releasing the lock. This
> means that changes performed by a lock owner may not be seen by
> the next lock owner. This may have been "good enough" for use
> by dump_stack() as a serialization mechanism, but it is not
> enough to provide proper protection for a critical section.
> 
> Correct this problem by using acquire/release memory barriers
> for lock/unlock, respectively.
> 
> Note that it is not necessary for a cpu lock to disable
> interrupts. However, in upcoming work this cpu lock will be used
> for emergency tasks (for example, atomic consoles during kernel
> crashes) and any interruptions should be avoided if possible.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The change makes perfect sense and the code looks correct.
But I am not sure about the description of the memory barriers.

> ---
>  kernel/printk/printk.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f94babb38493..8c870581cfb4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3560,10 +3560,29 @@ void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
>  
>  	cpu = smp_processor_id();
>  
> -	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
> +	/*
> +	 * Guarantee loads and stores from the previous lock owner are
> +	 * visible to this CPU once it is the lock owner. This pairs
> +	 * with cpu_unlock:B.

These things are not easy to describe. It took me quite some time to
understand the above description. And think that it does not say
the full storry.

IMHO, the lock should work the way that:

   + The new owner see all writes done or seen by the previous owner(s).
   + The previous owner(s) never see writes done by the new owner.

It is actually a full barrier. I see this in include/linux/atomic.h

#define __atomic_acquire_fence		smp_mb__after_atomic
#define __atomic_release_fence		smp_mb__before_atomic


Well, I am not sure if my description is correct.
Documentation/memory-barriers.txt describes the acquire operation from
another angle:

 (5) ACQUIRE operations.

     This acts as a one-way permeable barrier.  It guarantees that all memory
     operations after the ACQUIRE operation will appear to happen after the
     ACQUIRE operation with respect to the other components of the system.
     ACQUIRE operations include LOCK operations and both smp_load_acquire()
     and smp_cond_load_acquire() operations.

     Memory operations that occur before an ACQUIRE operation may appear to
     happen after it completes.

     An ACQUIRE operation should almost always be paired with a RELEASE
     operation.

> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_lock:B
> +	 * reads from cpu_unlock:A.

IMHO, this seems to describe even smaller part of the picture.
It is just about reads.

*
> +	 * Relies on:
> +	 *
> +	 * RELEASE from cpu_unlock:A to cpu_unlock:B
> +	 *    matching
> +	 * ACQUIRE from cpu_lock:A to cpu_lock:B
> +	 */
> +	old = atomic_cmpxchg_acquire(&printk_cpulock_owner,
> +				     -1, cpu); /* LMM(cpu_lock:A) */
>  	if (old == -1) {
>  		/* This CPU is now the owner. */
>  
> +		/* This CPU begins loading/storing data: LMM(cpu_lock:B) */
> +
>  		*lock_flag = true;
>  
>  	} else if (old == cpu) {
> @@ -3600,7 +3619,14 @@ EXPORT_SYMBOL(printk_cpu_lock_irqsave);
>  void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags)
>  {
>  	if (lock_flag) {
> -		atomic_set(&printk_cpulock_owner, -1);
> +		/* This CPU is finished loading/storing data: LMM(cpu_unlock:A) */
> +
> +		/*
> +		 * Guarantee loads and stores from this CPU when it was the
> +		 * lock owner are visible to the next lock owner. This pairs
> +		 * with cpu_lock:A.

Yup, this seems to better match the formulation in
Documentation/memory-barriers.txt:

 (6) RELEASE operations.

     This also acts as a one-way permeable barrier.  It guarantees that all
     memory operations before the RELEASE operation will appear to happen
     before the RELEASE operation with respect to the other components of the
     system. RELEASE operations include UNLOCK operations and
     smp_store_release() operations.

     Memory operations that occur after a RELEASE operation may appear to
     happen before it completes.


Except that the acquire description does not mention "this CPU".

> +		 */
> +		atomic_set_release(&printk_cpulock_owner, -1); /* LMM(cpu_unlock:B) */
>  
>  		local_irq_restore(irq_flags);
>  	}

Honestly, I am not sure if we could describe the barriers correctly
and effectively at the same time.

IMHO, the following sentence, in the commit message, says everything:

   Correct this problem by using acquire/release memory barriers
   for lock/unlock, respectively.


In the code, I would use something similar:

	/* Try to take the lock with the appropriate memory barriers. */
	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1, cpu);

and

		/* Release the lock with the appropriate memory barriers. */
		atomic_set_release(&printk_cpulock_owner, -1);


After all, the _acquire() and _release() variants were introduced
to implement locking operations correctly and effectively.
AFAIK, there were long discussions about the implementation and
documentation. IMHO, we do not need to duplicate it.

Best Regards,
Petr
