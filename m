Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2D305A08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhA0LkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhA0LiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:38:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23355C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QJyndTWkn5XEvi71brp8E2w9iWAw89DA57TQ5d/JfX4=; b=ydI+/8w/RCePiHUHnfZcBYYAWJ
        LEX5pdb4dhqsIxffzr6EBJQb9r5mfo1N4IIDHgeMF4D9ojV/ZlLZRFdyE+75FfU9Qxfxjs5TW9phM
        yjo2qYSa5vcAC+M2WQGxR00ZR8sOj/O99ANyt3eMGn1tuhHDD1N6zIjMlPcbJJFnsyhYfJC6IW0jX
        Omk2nEV9ufvpn1CE/SUao+LW/8XtQo5X+GoC9XV6jNJ773EWIFoYVmPwm5fQNtzKJl5T7vpXu9hb+
        /tz/iH3zAc0rh+XakpwzLyhd3HDgIiW1ywpiABBX59YC2YpAkdSmSxoHqzkCpQ39vjXiviTPnDYU7
        yBL/ievw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4j8P-0001Ql-Uq; Wed, 27 Jan 2021 11:37:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56E83300DB4;
        Wed, 27 Jan 2021 12:37:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3219F201F6C5D; Wed, 27 Jan 2021 12:37:16 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:37:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: Re: [PATCH] sched/tracing: Reset critical timings on scheduling
Message-ID: <YBFQbF/BqmjXFAd0@hirez.programming.kicks-ass.net>
References: <20210126135718.5bf8d273@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126135718.5bf8d273@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:57:18PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> There's some paths that can call into the scheduler from interrupt disabled
> or preempt disabled state. Specifically from the idle thread. The problem is
> that it can call the scheduler, still stay idle, and continue. The preempt
> and irq disabled tracer considers this a very long latency, and hides real
> latencies that we care about.
> 
> For example, this is from a preemptirqsoff trace:
> 
>   <idle>-0         2dN.1   16us : tick_nohz_account_idle_ticks.isra.0 <-tick_nohz_idle_exit
>   <idle>-0         2.N.1   17us : flush_smp_call_function_from_idle <-do_idle
>   <idle>-0         2dN.1   17us : flush_smp_call_function_queue <-flush_smp_call_function_from_idle
>   <idle>-0         2dN.1   17us : nohz_csd_func <-flush_smp_call_function_queue
>   <idle>-0         2.N.1   18us : schedule_idle <-do_idle
>   <idle>-0         2dN.1   18us : rcu_note_context_switch <-__schedule
>   <idle>-0         2dN.1   18us : rcu_preempt_deferred_qs <-rcu_note_context_switch
>   <idle>-0         2dN.1   19us : rcu_preempt_need_deferred_qs <-rcu_preempt_deferred_qs
>   <idle>-0         2dN.1   19us : rcu_qs <-rcu_note_context_switch
>   <idle>-0         2dN.1   19us : _raw_spin_lock <-__schedule
>   <idle>-0         2dN.1   19us : preempt_count_add <-_raw_spin_lock
>   <idle>-0         2dN.2   20us : do_raw_spin_trylock <-_raw_spin_lock
> 
> do_idle() calls schedule_idle() which calls __schedule, but the latency
> continues on for 1.4 milliseconds.

I'm not sure I understand the problem from this... what?

> To handle this case, create a new function called
> "reset_critical_timings()" which just calls stop_critical_timings() followed
> by start_critical_timings() and place this in the scheduler. There's no
> reason to worry about timings when the scheduler is called, as that should
> allow everything to move forward.

And that's just really daft.. why are you adding two unconditional
function calls to __schedule() that are a complete waste of time
99.999999% of the time?

If anything, this should be fixed in schedule_idle().
