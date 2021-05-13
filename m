Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6937F3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhEMHvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhEMHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:51:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED991C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=laso0NJGsAhov91wC9gA5ni0VjCkObp7QNRNmEa9AYA=; b=u9tp+TFbBpeQwFNkq1r8749PsI
        9az8yTQY3jxlQWJ2m20Yc1KP/+l7JLeMNem1SVPsRMWix9/DSGzx3Kpqu7n3jHpMecAWgOPGxlED9
        FSpiCmlKu8Ib1U6xa7p4ycI+ivZ1PChH1LBd5rBy97XOYVEW09NvJkvdoMHNvTumVnvl2dNK1a37h
        +YcbJIC4g39NUHnVs/Gw5/CtOhO26IqKtVUb8RT87HvMYAZIPGN79kR3eIDtk8QkHqPl3soLpUFfe
        Y51iFiS0WD0wnN3h4Lgq/Nm2frOT22kMK+oeO3EsU4vod0iRTSGcSjZgU2UjRjsK6QWRTd4xvn7HU
        TtROvOLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh64b-009FPW-5e; Thu, 13 May 2021 07:48:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB27930022A;
        Thu, 13 May 2021 09:47:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D324B2BC7450F; Thu, 13 May 2021 09:47:55 +0200 (CEST)
Date:   Thu, 13 May 2021 09:47:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch V2 8/8] hrtimer: Avoid more SMP function calls in
 clock_was_set()
Message-ID: <YJzZqyaEWstfWtYW@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.840364566@linutronix.de>
 <20210427151125.GA171315@fuller.cnet>
 <877dkno5w0.ffs@nanos.tec.linutronix.de>
 <87a6pgfdps.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6pgfdps.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 09:12:15AM +0200, Thomas Gleixner wrote:
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

So far so simple, if there's nothing to update, we done.

> +	/*
> +	 * If the remote CPU is currently handling an hrtimer interrupt, it
> +	 * will reevaluate the first expiring timer of all clock bases
> +	 * before reprogramming. Nothing to do here.
> +	 */
> +	if (cpu_base->in_hrtirq)
> +		return false;

This one gives me a head-ache though; if we get here, that means
hrtimer_interrupt()'s hrtimer_update_base() happened before the change.
It also means that CPU is in __run_hrtimer() running a fn(), since we
own cpu_base->lock.

That in turn means it is in __hrtimer_run_queues(), possible on the last
base.

Now, if I understand it right, the thing that saves us, is that
hrtimer_update_next_event() -- right after returning from
__hrtimer_run_queues() -- will re-evaluate all bases (with the
hrtimer_update_base() we just did visible to it) and we'll eventually
goto retry if time moved such that we now have timers that should've ran
but were missed due to this concurrent shift in time.

However, since that retries thing is limited to 3; could we not trigger
that by generating a stream of these updates, causing the timer to keep
having to be reset? I suppose updating time is a root only thing, and
root can shoot its own foot off any time it damn well likes, so who
cares.

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

Fair enough..

> +	return false;
> +}
> +
>  /*
>   * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
>   * CLOCK_BOOTTIME (for late sleep time injection).

