Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB636B0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhDZJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhDZJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:41:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ozwov2Jab0+sdWppm0QSKqpnQttHFNm7EGQNbnyhxZY=; b=ULR/QV59hqgaiNfhbThbBWZt4S
        1KVQaAKaVIvC2aalfM18LzeQ/MrkCHswrlvtV2Qe7ci4VnBPv0+rK7tHpHPkzQ69O2DVAAymuX62+
        m1Jt3x7khQ3xwzy//BvmZktV9aqGSJY/TGeS0Igi12Dv1VuH7YlqAOgiRTqae+3+Q0EWrhfa7MZjF
        yea6nFjUQT/WAdRJyV1M4b0E2JrnTMcqHp5mRiQLghBJcce3l5HRAxvhn2KPXUazR9I7kn4C0KC8Y
        WcXf/5uc0Kymd2ehQHfohiEFe0UjJPYAdFFOEFScmPMnBcWUKq16pxRmncvFuVBGBKDi3Wlqh2sXl
        qt/p1ekg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laxjT-007L12-DK; Mon, 26 Apr 2021 09:40:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FAEB3002F1;
        Mon, 26 Apr 2021 11:40:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 186252D193756; Mon, 26 Apr 2021 11:40:46 +0200 (CEST)
Date:   Mon, 26 Apr 2021 11:40:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in
 __hrtimer_start_range_ns()
Message-ID: <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com>
 <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
 <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de>
 <87v989topu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v989topu.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:49:33AM +0200, Thomas Gleixner wrote:
> If __hrtimer_start_range_ns() is invoked with an already armed hrtimer then
> the timer has to be canceled first and then added back. If the timer is the
> first expiring timer then on removal the clockevent device is reprogrammed
> to the next expiring timer to avoid that the pending expiry fires needlessly.
> 
> If the new expiry time ends up to be the first expiry again then the clock
> event device has to reprogrammed again.
> 
> Avoid this by checking whether the timer is the first to expire and in that
> case, keep the timer on the current CPU and delay the reprogramming up to
> the point where the timer has been enqueued again. 
> 
> Reported-by: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/hrtimer.c |   60 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1030,12 +1030,13 @@ static void __remove_hrtimer(struct hrti
>   * remove hrtimer, called with base lock held
>   */
>  static inline int
> -remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
> +remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
> +	       bool restart, bool keep_local)
>  {
>  	u8 state = timer->state;
>  
>  	if (state & HRTIMER_STATE_ENQUEUED) {
> -		int reprogram;
> +		bool reprogram;
>  
>  		/*
>  		 * Remove the timer and force reprogramming when high
> @@ -1048,8 +1049,16 @@ remove_hrtimer(struct hrtimer *timer, st
>  		debug_deactivate(timer);
>  		reprogram = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
>  
> +		/*
> +		 * If the timer is not restarted then reprogramming is
> +		 * required if the timer is local. If it is local and about
> +		 * to be restarted, avoid programming it twice (on removal
> +		 * and a moment later when it's requeued).
> +		 */
>  		if (!restart)
>  			state = HRTIMER_STATE_INACTIVE;
> +		else
> +			reprogram &= !keep_local;

			reprogram = reprogram && !keep_local;

perhaps?

>  
>  		__remove_hrtimer(timer, base, state, reprogram);
>  		return 1;
> @@ -1103,9 +1112,31 @@ static int __hrtimer_start_range_ns(stru
>  				    struct hrtimer_clock_base *base)
>  {
>  	struct hrtimer_clock_base *new_base;
> +	bool force_local, first;
>  
> -	/* Remove an active timer from the queue: */
> -	remove_hrtimer(timer, base, true);
> +	/*
> +	 * If the timer is on the local cpu base and is the first expiring
> +	 * timer then this might end up reprogramming the hardware twice
> +	 * (on removal and on enqueue). To avoid that by prevent the
> +	 * reprogram on removal, keep the timer local to the current CPU
> +	 * and enforce reprogramming after it is queued no matter whether
> +	 * it is the new first expiring timer again or not.
> +	 */
> +	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> +	force_local &= base->cpu_base->next_timer == timer;

Using bitwise ops on a bool is cute and all, but isn't that more
readable when written like:

	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases) &&
		      base->cpu_base->next_timer == timer;


> +
> +	/*
> +	 * Remove an active timer from the queue. In case it is not queued
> +	 * on the current CPU, make sure that remove_hrtimer() updates the
> +	 * remote data correctly.
> +	 *
> +	 * If it's on the current CPU and the first expiring timer, then
> +	 * skip reprogramming, keep the timer local and enforce
> +	 * reprogramming later if it was the first expiring timer.  This
> +	 * avoids programming the underlying clock event twice (once at
> +	 * removal and once after enqueue).
> +	 */
> +	remove_hrtimer(timer, base, true, force_local);
>  
>  	if (mode & HRTIMER_MODE_REL)
>  		tim = ktime_add_safe(tim, base->get_time());
> @@ -1115,9 +1146,24 @@ static int __hrtimer_start_range_ns(stru
>  	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
>  
>  	/* Switch the timer base, if necessary: */
> -	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
> +	if (!force_local) {
> +		new_base = switch_hrtimer_base(timer, base,
> +					       mode & HRTIMER_MODE_PINNED);
> +	} else {
> +		new_base = base;
> +	}
>  
> -	return enqueue_hrtimer(timer, new_base, mode);
> +	first = enqueue_hrtimer(timer, new_base, mode);
> +	if (!force_local)
> +		return first;
> +
> +	/*
> +	 * Timer was forced to stay on the current CPU to avoid
> +	 * reprogramming on removal and enqueue. Force reprogram the
> +	 * hardware by evaluating the new first expiring timer.
> +	 */
> +	hrtimer_force_reprogram(new_base->cpu_base, 1);
> +	return 0;
>  }

There is an unfortunate amount of duplication between
hrtimer_force_reprogram() and hrtimer_reprogram(). The obvious cleanups
don't work however :/ Still, does that in_hrtirq optimization make sense
to have in force_reprogram ?


