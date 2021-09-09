Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067140479B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhIIJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhIIJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:16:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868AC061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iJ+LADRxdLPZM727LMglahJjUEPHundrRN9dzRuwx+o=; b=gUMxz8mZWzsYtQlQ+RO7LUqX6w
        YNXyVASKM2jIH09kgjbiNCs//6wApXb7v1rQ+222T+D0l6NESx8AKjNelhB3TBo6vlpwdtx8QXwKl
        zw9fbBdXScFIOf4gHkKkqE26tD3eCO6761XV7P8+saEj1IEVWd94u+1YvtcC/Qb6AqgYjJdSALNk+
        I0Y4gxcOCECXA8uGjWcn99fUtFL5bX3CvxGMf6l66D4mzqTEMe38UFNhWFfbkeh8SlkZiqMkptQ++
        AOVVIWm53VzvCTr6Zo5K3FezJ75rJuMt/a6EuIE38a4oIo9n1WYUz9xyzdW2tHAhCE4pi4fbhiZKb
        ObTCvMlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOG9B-001prP-KD; Thu, 09 Sep 2021 09:15:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ED75300047;
        Thu,  9 Sep 2021 11:15:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E4492C625915; Thu,  9 Sep 2021 11:15:04 +0200 (CEST)
Date:   Thu, 9 Sep 2021 11:15:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 07/13] perf/core: add idle hooks
Message-ID: <YTnQmPXXQwuMFuoJ@hirez.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-8-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-8-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:56:54AM -0700, Stephane Eranian wrote:
> This patch adds a new set of hooks to connect perf_events with the
> idle task. On some PMU models, it may be necessary to flush or stop
> the PMU when going to low power. Upon return from low power, the opposite
> action, i.e., re-enable the PMU, may be necessary. The patch adds
> perf_pmu_register_lopwr_cb() to register a callback on entry or return
> from low power. The callback is invoked with a boolean arg. If true,
> then this is an entry. If false, this is a return.
> 
> The callback is invoked from the idle code with interrupts already
> disabled.

Urghh... we've had this before and always managed to refuse doing this
(in generic code).

Also, it's broken..

> +/*
> + * The perf_lopwr_cb() is invoked from the idle task. As such it
> + * cannot grab a mutex that may end up sleeping. The idle task cannot
> + * sleep by construction. Therefore we create a spinlock and a new
> + * list of PMUs to invoke on idle. The list is protected by a spinlock
> + * Normally we would use the pmus_lock and iterate over each PMUs. But
> + * mutex is not possible and we need to iterate only over the PMU which
> + * do require a idle callback.

That rationale is broken, pmus is also SRCU protected and SRCU iteration
would actually work from the idle context, unlike:

> + */
> +static DEFINE_SPINLOCK(lopwr_cb_lock);

which is not allowed from preempt disable context, if you really need
that lock, you need a raw_spinlock_t.

> +static LIST_HEAD(lopwr_cb_pmus);
> +static DEFINE_PER_CPU(int, lopwr_nr_active);
> +
> +void perf_lopwr_active_inc(void)
> +{
> +	__this_cpu_inc(lopwr_nr_active);
> +}
> +
> +void perf_lopwr_active_dec(void)
> +{
> +	__this_cpu_dec(lopwr_nr_active);
> +}
> +
> +/*
> + * lopwr_in = true means going to low power state
> + * lopwr_in = false means returning from low power state
> + */
> +void perf_lopwr_cb(bool lopwr_in)
> +{
> +	struct pmu *pmu;
> +	unsigned long flags;
> +
> +	if (!__this_cpu_read(lopwr_nr_active))
> +		return;

We have static_branch and static_call to deal with these things.

> +
> +	spin_lock_irqsave(&lopwr_cb_lock, flags);
> +
> +	list_for_each_entry(pmu, &lopwr_cb_pmus, lopwr_entry) {
> +		if (pmu->lopwr_cb)
> +			pmu->lopwr_cb(lopwr_in);
> +	}

I *really* do not like unbound iteration in the idle path.

> +
> +	spin_unlock_irqrestore(&lopwr_cb_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(perf_lopwr_cb);

Why?

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 912b47aa99d8..14ce130aee1b 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -179,6 +179,7 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (need_resched()) {
>  		local_irq_enable();
> +		perf_lopwr_cb(false);
>  		return;
>  	}
>  
> @@ -191,7 +192,14 @@ static void cpuidle_idle_call(void)
>  	if (cpuidle_not_available(drv, dev)) {
>  		tick_nohz_idle_stop_tick();
>  
> +		if (!cpu_idle_force_poll)
> +			perf_lopwr_cb(true);
> +
>  		default_idle_call();
> +
> +		if (!cpu_idle_force_poll)
> +			perf_lopwr_cb(false);
> +
>  		goto exit_idle;
>  	}
>  
> @@ -249,8 +257,10 @@ static void cpuidle_idle_call(void)
>  	/*
>  	 * It is up to the idle functions to reenable local interrupts
>  	 */
> -	if (WARN_ON_ONCE(irqs_disabled()))
> +	if (WARN_ON_ONCE(irqs_disabled())) {
>  		local_irq_enable();
> +		perf_lopwr_cb(false);
> +	}
>  }
>  
>  /*
> @@ -279,9 +289,12 @@ static void do_idle(void)
>  	__current_set_polling();
>  	tick_nohz_idle_enter();
>  
> +
>  	while (!need_resched()) {
>  		rmb();
>  
> +		perf_lopwr_cb(true);
> +
>  		local_irq_disable();
>  
>  		if (cpu_is_offline(cpu)) {

I so hate all of this...  but mostly, this doesn't seem right, you're
unconditionally calling this, even for high power idle states.

*IFF* you really have to do this, stuff it in an AMD idle state driver
that knows about the relevant idle states. But really, why can't we just
take the his while the event is running?
