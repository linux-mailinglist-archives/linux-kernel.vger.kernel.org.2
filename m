Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8EA3A4A52
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKUu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:50:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07712613CA;
        Fri, 11 Jun 2021 20:48:56 +0000 (UTC)
Date:   Fri, 11 Jun 2021 16:48:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 9/9] tracing: Add timerlat tracer
Message-ID: <20210611164855.252f35fb@gandalf.local.home>
In-Reply-To: <6bc850eb-14c8-6898-847c-d9f0e67d60f8@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
        <20210607213639.68aad064@gandalf.local.home>
        <6bc850eb-14c8-6898-847c-d9f0e67d60f8@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 16:13:36 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> >> +
> >> +#ifdef CONFIG_STACKTRACE
> >> +/*
> >> + * Stack trace will take place only at IRQ level, so, no need
> >> + * to control nesting here.
> >> + */
> >> +struct trace_stack {
> >> +	int stack_size;
> >> +	int nr_entries;
> >> +	unsigned long           calls[PAGE_SIZE];  
> > 
> > That is rather big. It's 8 * PAGE_SIZE. I don't think that's what you really
> > wanted.  
> 
> no, I did not want that... is 256 a good number?

Sure. But make it a macro.

#define MAX_CALLS 256

or something like that.

> 
> >> +};
> >> +
> >> +static DEFINE_PER_CPU(struct trace_stack, trace_stack);
> >> +
> >> +/**  
> > 
> > Again, remove the KernelDoc notation of /**, or make it real kerneldoc
> > notation.  
> 
> Fixed!
> 
> [...]
> 
> >>   *
> >> @@ -801,6 +1017,22 @@ void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
> >>  	if (!osn_var->sampling)
> >>  		return;
> >>  
> >> +#ifdef CONFIG_TIMERLAT_TRACER
> >> +	/*
> >> +	 * If the timerlat is enabled, but the irq handler did
> >> +	 * not run yet enabling timerlat_tracer, do not trace.
> >> +	 */
> >> +	if (unlikely(osnoise_data.timerlat_tracer)) {
> >> +		struct timerlat_variables *tlat_var;
> >> +		tlat_var = this_cpu_tmr_var();
> >> +		if (!tlat_var->tracing_thread) {  
> > 
> > What happens if the timer interrupt triggers here?  
> 
> The tracer will not report the softirq overhead. But at this point, the softirq
> is returning, and the duration would be from this time to...
> 
> 
> 
> >> +			osn_var->softirq.arrival_time = 0;
> >> +			osn_var->softirq.delta_start = 0;
> >> +			return;
> >> +		}
> >> +	}
> >> +#endif
> >> +
> >>  	duration = get_int_safe_duration(osn_var, &osn_var->softirq.delta_start);  
> 
> here.
> 
> We can disable interrupts to avoid this issue. But the question is, is it worth
> to disable interrupts to avoid this problem?
> 
> >>  	trace_softirq_noise(vec_nr, osn_var->softirq.arrival_time, duration);
> >>  	cond_move_thread_delta_start(osn_var, duration);
> >> @@ -893,6 +1125,18 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
> >>  	if (!osn_var->sampling)
> >>  		return;
> >>  
> >> +#ifdef CONFIG_TIMERLAT_TRACER
> >> +	if (osnoise_data.timerlat_tracer) {
> >> +		struct timerlat_variables *tlat_var;
> >> +		tlat_var = this_cpu_tmr_var();
> >> +		if (!tlat_var->tracing_thread) {  
> > 
> > Or here?  
> 
> The problem that can happen with the softirq cannot happen here: this code runs
> with interrupts disabled on __schedule() (it is hooked to the sched_switch).
> 
> >> +			osn_var->thread.delta_start = 0;
> >> +			osn_var->thread.arrival_time = 0;
> >> +			return;
> >> +		}
> >> +	}
> >> +#endif
> >> +
> >>  	duration = get_int_safe_duration(osn_var, &osn_var->thread.delta_start);
> >>  
> >>  	trace_thread_noise(t, osn_var->thread.arrival_time, duration);
> >> @@ -1182,6 +1426,197 @@ static int osnoise_main(void *data)
> >>  	return 0;
> >>  }
> >>  
> >> +#ifdef CONFIG_TIMERLAT_TRACER
> >> +/**
> >> + * timerlat_irq - hrtimer handler for timerlat.
> >> + */
> >> +static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
> >> +{
> >> +	struct osnoise_variables *osn_var = this_cpu_osn_var();
> >> +	struct trace_array *tr = osnoise_trace;
> >> +	struct timerlat_variables *tlat;
> >> +	struct timerlat_sample s;
> >> +	u64 now;
> >> +	u64 diff;
> >> +
> >> +	/*
> >> +	 * I am not sure if the timer was armed for this CPU. So, get
> >> +	 * the timerlat struct from the timer itself, not from this
> >> +	 * CPU.
> >> +	 */
> >> +	tlat = container_of(timer, struct timerlat_variables, timer);
> >> +
> >> +	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
> >> +
> >> +	/*
> >> +	 * Enable the osnoise: events for thread an softirq.
> >> +	 */
> >> +	tlat->tracing_thread = true;
> >> +
> >> +	osn_var->thread.arrival_time = time_get();
> >> +
> >> +	/*
> >> +	 * A hardirq is running: the timer IRQ. It is for sure preempting
> >> +	 * a thread, and potentially preempting a softirq.
> >> +	 *
> >> +	 * At this point, it is not interesting to know the duration of the
> >> +	 * preempted thread (and maybe softirq), but how much time they will
> >> +	 * delay the beginning of the execution of the timer thread.
> >> +	 *
> >> +	 * To get the correct (net) delay added by the softirq, its delta_start
> >> +	 * is set as the IRQ one. In this way, at the return of the IRQ, the delta
> >> +	 * start of the sofitrq will be zeroed, accounting then only the time
> >> +	 * after that.
> >> +	 *
> >> +	 * The thread follows the same principle. However, if a softirq is
> >> +	 * running, the thread needs to receive the softirq delta_start. The
> >> +	 * reason being is that the softirq will be the last to be unfolded,
> >> +	 * resseting the thread delay to zero.
> >> +	 */
> >> +#ifndef CONFIG_PREEMPT_RT
> >> +	if (osn_var->softirq.delta_start) {
> >> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
> >> +				   &osn_var->softirq.delta_start);  
> > 
> > Isn't softirq.delta_start going to be zero here? It doesn't look to get
> > updated until you set tracing_thread to true, but that happens here, and as
> > this is in a interrupt context, there will not be a softirq happening
> > between the setting of that to true to this point.  
> 
> No... on the timerlat, the "sampling" is always on. And the
> osnoise_data.timerlat_tracer is only checked at the softirq return, so the
> softirq entry always set set the delta_start.

OK, I was confused by the timerlat using the "__osnoise_tracer_start()". If
timerlat is going to use that, perhaps we need to rename it, because the
"osnoise" is one tracer, and its confusing that the "timerlat" is using
functions called "*_osnoise_*". I was thinking that those functions were
only for the osnoise tracer and not part of the timerlat tracer, and
ignored them when looking at what the timerlat tracer was doing.

Can we rename that to simply "start_latency_tracing()" or something more
generic.

> 
> >> +
> >> +		copy_int_safe_time(osn_var, &osn_var->softirq.delta_start,
> >> +				    &osn_var->irq.delta_start);
> >> +	} else {
> >> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
> >> +				    &osn_var->irq.delta_start);
> >> +	}
> >> +#else /* CONFIG_PREEMPT_RT */
> >> +	/*
> >> +	 * The sofirqs run as threads on RT, so there is not need
> >> +	 * to keep track of it.
> >> +	 */
> >> +	copy_int_safe_time(osn_var, &osn_var->thread.delta_start, &osn_var->irq.delta_start);
> >> +#endif /* CONFIG_PREEMPT_RT */
> >> +
> >> +	/*
> >> +	 * Compute the current time with the expected time.
> >> +	 */
> >> +	diff = now - tlat->abs_period;
> >> +
> >> +	tlat->count++;
> >> +	s.seqnum = tlat->count;
> >> +	s.timer_latency = diff;
> >> +	s.context = IRQ_CONTEXT;
> >> +
> >> +	trace_timerlat_sample(&s);
> >> +
> >> +	/* Keep a running maximum ever recorded os noise "latency" */
> >> +	if (diff > tr->max_latency) {
> >> +		tr->max_latency = diff;
> >> +		latency_fsnotify(tr);
> >> +	}
> >> +
> >> +	if (osnoise_data.stop_tracing_in)
> >> +		if (time_to_us(diff) >= osnoise_data.stop_tracing_in)
> >> +			osnoise_stop_tracing();
> >> +
> >> +	wake_up_process(tlat->kthread);
> >> +
> >> +#ifdef CONFIG_STACKTRACE
> >> +	if (osnoise_data.print_stack)
> >> +		timerlat_save_stack(0);
> >> +#endif  
> > 
> > No need for the #ifdef above. timerlat_save_stack() is defined as a nop
> > when not enabled, and the compiler will just optimize this out.  
> 
> The osnoise_data.print_stack is ifdefed, should I remove it from ifdef?

Well, the above ifdef is for STACKTRACE not for TIMERLAT_TRACER, which
encompasses all of this. And the "timerlat_save_stack()" is a nop when
STACKTRACE is not defined. So no.

-- Steve

> 
> >   
> >> +
> >> +	return HRTIMER_NORESTART;
> >> +}
> >> +
