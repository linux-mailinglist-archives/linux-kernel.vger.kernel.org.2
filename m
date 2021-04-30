Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C91E36FEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhD3Qu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhD3Qu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619801408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dUyZztzZO3YqdQUCORSFVu1rmqXrzkEdyXhkRc59QkA=;
        b=AJ+dsrQ++k19/AfltcOx0PkCy471FUNNrHpvIqrT/bNPCEc4V/JNTHKK4ihbxWG4sZjjQ9
        LARBcccxI3dXIxmedOaOi8G9BVRJ01UHMftfWsfNsNP/Tk/dr+JuSXUXRSRTU7U/xwqXR1
        eihhrREoVRPu7WOS2k4ipcPyup6S77E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Udr-qfYRNVSKA-kC7vUPdw-1; Fri, 30 Apr 2021 12:50:04 -0400
X-MC-Unique: Udr-qfYRNVSKA-kC7vUPdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257CE1008063;
        Fri, 30 Apr 2021 16:50:03 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB98119C66;
        Fri, 30 Apr 2021 16:49:55 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 62909418AE03; Fri, 30 Apr 2021 13:49:33 -0300 (-03)
Date:   Fri, 30 Apr 2021 13:49:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch V2 8/8] hrtimer: Avoid more SMP function calls in
 clock_was_set()
Message-ID: <20210430164933.GA73701@fuller.cnet>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.840364566@linutronix.de>
 <20210427151125.GA171315@fuller.cnet>
 <877dkno5w0.ffs@nanos.tec.linutronix.de>
 <87a6pgfdps.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6pgfdps.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 09:12:15AM +0200, Thomas Gleixner wrote:
> By unconditionally updating the offsets there are more indicators
> whether the SMP function calls on clock_was_set() can be avoided:
> 
>   - When the offset update already happened on the remote CPU then the
>     remote update attempt will yield the same seqeuence number and no
>     IPI is required.
> 
>   - When the remote CPU is currently handling hrtimer_interrupt(). In
>     that case the remote CPU will reevaluate the timer bases before
>     reprogramming anyway, so nothing to do.
> 
>   - After updating it can be checked whether the first expiring timer in
>     the affected clock bases moves before the first expiring (softirq)
>     timer of the CPU. If that's not the case then sending the IPI is not
>     required.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Fix the in_hrtirq thinko (Marcelo)
>     Add the missing masking (reported by 0day)
> 
> P.S.: The git branch is updated as well
> 
> ---
>  kernel/time/hrtimer.c |   74 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 9 deletions(-)
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -880,6 +880,68 @@ static void hrtimer_reprogram(struct hrt
>  	tick_program_event(expires, 1);
>  }
>  
> +static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
> +			     unsigned int active)
> +{
> +	struct hrtimer_clock_base *base;
> +	unsigned int seq;
> +	ktime_t expires;
> +
> +	/*
> +	 * Update the base offsets unconditionally so the following
> +	 * checks whether the SMP function call is required works.
> +	 *
> +	 * The update is safe even when the remote CPU is in the hrtimer
> +	 * interrupt or the hrtimer soft interrupt and expiring affected
> +	 * bases. Either it will see the update before handling a base or
> +	 * it will see it when it finishes the processing and reevaluates
> +	 * the next expiring timer.
> +	 */
> +	seq = cpu_base->clock_was_set_seq;
> +	hrtimer_update_base(cpu_base);
> +
> +	/*
> +	 * If the sequence did not change over the update then the
> +	 * remote CPU already handled it.
> +	 */
> +	if (seq == cpu_base->clock_was_set_seq)
> +		return false;
> +
> +	/*
> +	 * If the remote CPU is currently handling an hrtimer interrupt, it
> +	 * will reevaluate the first expiring timer of all clock bases
> +	 * before reprogramming. Nothing to do here.
> +	 */
> +	if (cpu_base->in_hrtirq)
> +		return false;

Looks good, thanks.

> +
> +	/*
> +	 * Walk the affected clock bases and check whether the first expiring
> +	 * timer in a clock base is moving ahead of the first expiring timer of
> +	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
> +	 * event devices cannot be remotely reprogrammed.
> +	 */
> +	active &= cpu_base->active_bases;
> +
> +	for_each_active_base(base, cpu_base, active) {
> +		struct timerqueue_node *next;
> +
> +		next = timerqueue_getnext(&base->active);
> +		expires = ktime_sub(next->expires, base->offset);
> +		if (expires < cpu_base->expires_next)
> +			return true;
> +
> +		/* Extra check for softirq clock bases */
> +		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
> +			continue;
> +		if (cpu_base->softirq_activated)
> +			continue;
> +		if (expires < cpu_base->softirq_expires_next)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /*
>   * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
>   * CLOCK_BOOTTIME (for late sleep time injection).
> @@ -914,16 +976,10 @@ void clock_was_set(unsigned int bases)
>  		unsigned long flags;
>  
>  		raw_spin_lock_irqsave(&cpu_base->lock, flags);
> -		/*
> -		 * Only send the IPI when there are timers queued in one of
> -		 * the affected clock bases. Otherwise update the base
> -		 * remote to ensure that the next enqueue of a timer on
> -		 * such a clock base will see the correct offsets.
> -		 */
> -		if (cpu_base->active_bases & bases)
> +
> +		if (update_needs_ipi(cpu_base, bases))
>  			cpumask_set_cpu(cpu, mask);
> -		else
> -			hrtimer_update_base(cpu_base);
> +
>  		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
>  	}
>  
> 
> 

