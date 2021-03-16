Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021DB33D763
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhCPP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbhCPP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:28:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OGmqb8bd2k4uQAcmFJO02M/bVFEk0pVsLjKNZFO7H8U=; b=IP5DJMboAeWlisUPED4xpD5Z5q
        2P9jG+CMq9zMK0w2Q+WA0G626LU+QfN+sVTHotGTeyOMmSbuOGtJ5Ple9biZxPpaRllEEo52Nk/1q
        d67GOHEC1ZEXX1p9fNdgcmf2KQZ3T3/5Uhedee19TEabjyPUl/louoUqsc41RvOhOilWOpRBXHBx6
        rCKgwTTH+qjP0dQB6scKYet0SZ4hW++rqgqOpJeSWJzvNmh5AV85BheowDVycisAh6rwFcQ+77FRX
        An8Sf/PsJOhZ7lSlbPklxN5rAKwCiTDPjwbmtHEFePVXG0+USkcXRBc/Zm1llJJKuSPFj6k2oiDkh
        HOIrQ+eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMBby-00144d-4y; Tue, 16 Mar 2021 15:27:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1822F3012DF;
        Tue, 16 Mar 2021 16:27:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 067BA23E8EF8D; Tue, 16 Mar 2021 16:27:57 +0100 (CET)
Date:   Tue, 16 Mar 2021 16:27:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 06/10] timer: Report ignored local enqueue in nohz mode
Message-ID: <YFDOfEsr07LN++YD@hirez.programming.kicks-ass.net>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311123708.23501-7-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:37:04PM +0100, Frederic Weisbecker wrote:
> Enqueuing a local timer after the tick has been stopped will result in
> the timer being ignored until the next random interrupt.
> 
> Perform sanity checks to report these situations.
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/sched/core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca2bb629595f..24552911f92b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -674,6 +674,22 @@ int get_nohz_timer_target(void)
>  	return cpu;
>  }
>  
> +/* Make sure the timer won't be ignored in dynticks-idle case */
> +static void wake_idle_assert_possible(void)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	/*
> +	 * Timers are re-evaluated after idle IRQs. In case of softirq,
> +	 * we assume IRQ tail. Ksoftirqd shouldn't reach here as the
> +	 * timer base wouldn't be idle. And inline softirq processing
> +	 * after a call to local_bh_enable() within idle loop sound too
> +	 * fun to be considered here.
> +	 */
> +	WARN_ONCE(in_task(),
> +		  "Late timer enqueue may be ignored\n");
> +#endif
> +}
> +
>  /*
>   * When add_timer_on() enqueues a timer into the timer wheel of an
>   * idle CPU then this timer might expire before the next timer event
> @@ -688,8 +704,10 @@ static void wake_up_idle_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  
> -	if (cpu == smp_processor_id())
> +	if (cpu == smp_processor_id()) {
> +		wake_idle_assert_possible();
>  		return;
> +	}
>  
>  	if (set_nr_and_not_polling(rq->idle))
>  		smp_send_reschedule(cpu);

I'm not entirely sure I understand this one. What's the callchain that
leads to this?
