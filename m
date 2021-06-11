Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8194B3A43DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFKOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhFKOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623420823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ENVtvseDbmj7ZgEmV7Psk0RqVdvEey9Ta/RiNCDnvk=;
        b=Hq76zfP14ADpcP9w7UhFe8tvIyPoVHqSPknzYmo64rX6yD9g+/kEKxX76JVJRstfx5lhxc
        d1dqtKALnyMtQ+5bI+PSZrUHf3+hqnoCQWl3wmvP+cbTUwLhphi/2zIuQuzgmUSZvZpFAL
        K+rOBQgUj5e4YkmHs1g+TNG1wFTPBJA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-Hmv5VHGePBOrRSrgfhEQmg-1; Fri, 11 Jun 2021 10:13:40 -0400
X-MC-Unique: Hmv5VHGePBOrRSrgfhEQmg-1
Received: by mail-ej1-f71.google.com with SMTP id q7-20020a1709063607b02903f57f85ac45so1191701ejb.15
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ENVtvseDbmj7ZgEmV7Psk0RqVdvEey9Ta/RiNCDnvk=;
        b=eXPTHiY32Z+ZifmCBGEXppFJ2etn8mu5STOQIZr37MD4FMi/hD9tQS4/ASiUBquPEF
         aUvavM9I92NvE7/W/o0w19D2mzCF53lJYcnaV7pypelBEBXfbBK8zZxQFxb4yviZW+73
         YUcV2tpNabNdA57Iz6CYXwINilI7J8pgHt3SehjdO9bIkIIWi5eLIIRam88L4nEWByn+
         hJxszDF4wtVdgS/pOOmOW7MBKDZZpu2DRGvCSp7XDgl7RfLpeoLCxPTPyT5cmytMmhqf
         brjecDy1exmg9LRGjER642Imztm9uuP4IA3hdUEUojzzM0QToFqTkt2VLepYKhcFtUHy
         obeA==
X-Gm-Message-State: AOAM530QU5TyOWLDKO9bKj2w7FhneG4bCcvwTQtZPegglVz6tX78/vwN
        Q4JBVKGG3eo5mbAaGrb+eX2mCwtw97drKykLteZ+oGinAu3Sysy3jplFPAtR5b4i6oNJQsTNteB
        UOILqd8z0ZnlgaarxGCJspOgi
X-Received: by 2002:aa7:d602:: with SMTP id c2mr3976666edr.317.1623420818790;
        Fri, 11 Jun 2021 07:13:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJzgu+LWCAHFHwSTZrjf47xGZW9KAh0xjFNZseVfltU3z8ojqVvX+Bq9TfBWJV5mFs/yNlnQ==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr3976634edr.317.1623420818414;
        Fri, 11 Jun 2021 07:13:38 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id d2sm1881467ejo.13.2021.06.11.07.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:13:38 -0700 (PDT)
Subject: Re: [PATCH V3 9/9] tracing: Add timerlat tracer
To:     Steven Rostedt <rostedt@goodmis.org>
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
References: <cover.1621024265.git.bristot@redhat.com>
 <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
 <20210607213639.68aad064@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <6bc850eb-14c8-6898-847c-d9f0e67d60f8@redhat.com>
Date:   Fri, 11 Jun 2021 16:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607213639.68aad064@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 3:36 AM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:18 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> The timerlat tracer aims to help the preemptive kernel developers to
>> found souces of wakeup latencies of real-time threads. Like cyclictest,
>> the tracer sets a periodic timer that wakes up a thread. The thread then
>> computes a *wakeup latency* value as the difference between the *current
>> time* and the *absolute time* that the timer was set to expire. The main
>> goal of timerlat is tracing in such a way to help kernel developers.
>>
> 
> Hmm, we should add a way to have wake up tracers only trace a specific
> task, where these osnoise trace events would also be useful. That is,
> run cyclictest with the wakeup tracer, that it does this for cyclictest
> directly. That shouldn't be too difficult to add.

Yep! the osnoise: events are useful for other tracers, and even alone... Indeed,
they are part of the rtsl (which I plan to submit later this year).

It was already on my todo list to find a way to enable the events independently.
It could be as simple as adding a "hook" file to the osnoise/ dir, or to hook
the events when the first osnoise: event gets enabled, and to unhook them when
the last gets disable.

I will have a look at enabling them with wakeup tracers along the way.

>> Usage
>>
>> Write the ASCII text "timerlat" into the current_tracer file of the
>> tracing system (generally mounted at /sys/kernel/tracing).
>>
>> For example:
>>
>>         [root@f32 ~]# cd /sys/kernel/tracing/
>>         [root@f32 tracing]# echo timerlat > current_tracer
>>
>> It is possible to follow the trace by reading the trace trace file::
> 
> Do not need rst markup in commit logs ;-)

Oops! :-)

>>
>>   [root@f32 tracing]# cat trace
>>   # tracer: timerlat
>>   #
>>   #                              _-----=> irqs-off
>>   #                             / _----=> need-resched
>>   #                            | / _---=> hardirq/softirq
>>   #                            || / _--=> preempt-depth
>>   #                            || /
>>   #                            ||||             ACTIVATION
>>   #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
>>   #            | |         |   ||||      |         |                  |                       |
>>           <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
>>            <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
>>           <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
>>            <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
>>           <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
>>            <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
>>           <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
>>            <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
>>
>> The tracer creates a per-cpu kernel thread with real-time priority that
>> prints two lines at every activation. The first is the *timer latency*
>> observed at the *hardirq* context before the activation of the thread.
>> The second is the *timer latency* observed by the thread, which is the
>> same level that cyclictest reports. The ACTIVATION ID field

[..]

>> --- /dev/null
>> +++ b/Documentation/trace/timerlat-tracer.rst
>> @@ -0,0 +1,158 @@
>> +###############
>> +Timerlat tracer
>> +###############
>> +
>> +The timerlat tracer aims to help the preemptive kernel developers to
>> +found souces of wakeup latencies of real-time threads. Like cyclictest,
> 
>   "to find sources"

Fixed.

[...]
>> +
>> +Tracer options
>> +---------------------
>> +
>> +The timerlat tracer is built on top of osnoise tracer.
>> +So its configuration is also done in the osnoise/ config
>> +directory. The timerlat configs are:
>> +
>> + - cpus: CPUs at which a timerlat thread will execute.
>> + - timerlat_period_us: the period of the timerlat thread.
>> + - osnoise/stop_tracing_in_us: stop the system tracing if a
>> +   timer latency at the *irq* context higher than the configured
>> +   value happens. Writing 0 disables this option.
>> + - stop_tracing_out_us: stop the system tracing if a
>> +   timer latency at the *thread* context higher than the configured
>> +   value happens. Writing 0 disables this option.
>> + - print_stack: save the stack of the IRQ ocurrence, and print
>> +   it after the *thread* read the latency.
> 
> "thread read the latency" doesn't make sense.
> 
>  "and print it after the *thread context* event".  ?

Fixed.

> 
>> +
>> +timerlat and osnoise
>> +----------------------------
>> +
>> +The timerlat can also take advantage of the osnoise: traceevents.
>> +For example::
>> +
>> +        [root@f32 ~]# cd /sys/kernel/tracing/
>> +        [root@f32 tracing]# echo timerlat > current_tracer
>> +        [root@f32 tracing]# echo osnoise > set_event
> 
> Note, set_event should be deprecated. Use:
> 
> 	echo 1 > events/osnoise/enable
> 
> instead.
> 

Fixed (and mental note added).

>> +        [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
>> +        [root@f32 tracing]# tail -10 trace
>> +             cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency      1585 ns
>> +             cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 4597 ns
>> +             cc1-87882   [005] dNLh2..   548.771083: irq_noise: reschedule:253 start 548.771083017 duration 56 ns
>> +             cc1-87882   [005] dNLh2..   548.771086: irq_noise: call_function_single:251 start 548.771083811 duration 2048 ns
>> +             cc1-87882   [005] dNLh2..   548.771088: irq_noise: call_function_single:251 start 548.771086814 duration 1495 ns
>> +             cc1-87882   [005] dNLh2..   548.771091: irq_noise: call_function_single:251 start 548.771089194 duration 1558 ns
>> +             cc1-87882   [005] dNLh2..   548.771094: irq_noise: call_function_single:251 start 548.771091719 duration 1932 ns
>> +             cc1-87882   [005] dNLh2..   548.771096: irq_noise: call_function_single:251 start 548.771094696 duration 1050 ns
>> +             cc1-87882   [005] d...3..   548.771101: thread_noise:      cc1:87882 start 548.771078243 duration 10909 ns
>> +      timerlat/5-1035    [005] .......   548.771103: #402268 context thread timer_latency     25960 ns
>> +
>> +In this case, the root cause of the timer latency does not point for a
>> +single, but to a series of call_function_single IPIs, followed by a 10
> 
> "not point to a single"

Fixed.

[...]

>> +IRQ stacktrace
>> +---------------------------
>> +
>> +The osnoise/print_stack option is helpful for the cases in which a thread
>> +noise causes the major factor for the timer latency, because of preempt or
>> +irq disabled. For example::
>> +
>> +        [root@f32 tracing]# echo 500 > osnoise/stop_tracing_out_us
>> +        [root@f32 tracing]# echo 500 > osnoise/print_stack
>> +        [root@f32 tracing]# echo timerlat > current_tracer
>> +        [root@f32 tracing]# tail -21 per_cpu/cpu7/trace
>> +          insmod-1026    [007] dN.h1..   200.201948: irq_noise: local_timer:236 start 200.201939376 duration 7872 ns
>> +          insmod-1026    [007] d..h1..   200.202587: #29800 context    irq timer_latency      1616 ns
>> +          insmod-1026    [007] dN.h2..   200.202598: irq_noise: local_timer:236 start 200.202586162 duration 11855 ns
>> +          insmod-1026    [007] dN.h3..   200.202947: irq_noise: local_timer:236 start 200.202939174 duration 7318 ns
>> +          insmod-1026    [007] d...3..   200.203444: thread_noise:   insmod:1026 start 200.202586933 duration 838681 ns
>> +      timerlat/7-1001    [007] .......   200.203445: #29800 context thread timer_latency    859978 ns
>> +      timerlat/7-1001    [007] ....1..   200.203446: <stack trace>
>> +  => timerlat_irq
>> +  => __hrtimer_run_queues
>> +  => hrtimer_interrupt
>> +  => __sysvec_apic_timer_interrupt
>> +  => asm_call_irq_on_stack
>> +  => sysvec_apic_timer_interrupt
>> +  => asm_sysvec_apic_timer_interrupt
>> +  => delay_tsc
>> +  => dummy_load_1ms_pd_init
>> +  => do_one_initcall
>> +  => do_init_module
>> +  => __do_sys_finit_module
>> +  => do_syscall_64
>> +  => entry_SYSCALL_64_after_hwframe
>> +
>> +In this case, it is possible to see that the thread added the highest
>> +contribution to the *timer latency* and the stack trace points to
>> +a function named dummy_load_1ms_pd_init, which had the following
>> +code (on purpose)::
> 
> Should add here as well that the stack is saved at the time of interrupt,
> and not at the time it is reported.

Fixed.

[...]

>>  
>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +/*
>> + * Runtime information for the timer mode.
>> + */
>> +struct timerlat_variables {
>> +	struct task_struct *kthread;
>> +	struct hrtimer timer;
>> +	u64 rel_period;
>> +	u64 abs_period;
>> +	bool tracing_thread;
>> +	u64 count;
>> +};
> 
> Like with the osnoise comment, put in tabs to make the fields stand out.

Done.

[...]

>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +/*
>> + * timerlat sample structure definition. Used to store the statistics of
>> + * a sample run.
>> + */
>> +struct timerlat_sample {
>> +	u64			seqnum;		/* unique sequence */
> 
> The seqnum in the event is unsigned int, whereas here it's u64.

all set to unsigned int.

[...]

>> +
>> +#ifdef CONFIG_STACKTRACE
>> +/*
>> + * Stack trace will take place only at IRQ level, so, no need
>> + * to control nesting here.
>> + */
>> +struct trace_stack {
>> +	int stack_size;
>> +	int nr_entries;
>> +	unsigned long           calls[PAGE_SIZE];
> 
> That is rather big. It's 8 * PAGE_SIZE. I don't think that's what you really
> wanted.

no, I did not want that... is 256 a good number?

>> +};
>> +
>> +static DEFINE_PER_CPU(struct trace_stack, trace_stack);
>> +
>> +/**
> 
> Again, remove the KernelDoc notation of /**, or make it real kerneldoc
> notation.

Fixed!

[...]

>>   *
>> @@ -801,6 +1017,22 @@ void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
>>  	if (!osn_var->sampling)
>>  		return;
>>  
>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +	/*
>> +	 * If the timerlat is enabled, but the irq handler did
>> +	 * not run yet enabling timerlat_tracer, do not trace.
>> +	 */
>> +	if (unlikely(osnoise_data.timerlat_tracer)) {
>> +		struct timerlat_variables *tlat_var;
>> +		tlat_var = this_cpu_tmr_var();
>> +		if (!tlat_var->tracing_thread) {
> 
> What happens if the timer interrupt triggers here?

The tracer will not report the softirq overhead. But at this point, the softirq
is returning, and the duration would be from this time to...



>> +			osn_var->softirq.arrival_time = 0;
>> +			osn_var->softirq.delta_start = 0;
>> +			return;
>> +		}
>> +	}
>> +#endif
>> +
>>  	duration = get_int_safe_duration(osn_var, &osn_var->softirq.delta_start);

here.

We can disable interrupts to avoid this issue. But the question is, is it worth
to disable interrupts to avoid this problem?

>>  	trace_softirq_noise(vec_nr, osn_var->softirq.arrival_time, duration);
>>  	cond_move_thread_delta_start(osn_var, duration);
>> @@ -893,6 +1125,18 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
>>  	if (!osn_var->sampling)
>>  		return;
>>  
>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +	if (osnoise_data.timerlat_tracer) {
>> +		struct timerlat_variables *tlat_var;
>> +		tlat_var = this_cpu_tmr_var();
>> +		if (!tlat_var->tracing_thread) {
> 
> Or here?

The problem that can happen with the softirq cannot happen here: this code runs
with interrupts disabled on __schedule() (it is hooked to the sched_switch).

>> +			osn_var->thread.delta_start = 0;
>> +			osn_var->thread.arrival_time = 0;
>> +			return;
>> +		}
>> +	}
>> +#endif
>> +
>>  	duration = get_int_safe_duration(osn_var, &osn_var->thread.delta_start);
>>  
>>  	trace_thread_noise(t, osn_var->thread.arrival_time, duration);
>> @@ -1182,6 +1426,197 @@ static int osnoise_main(void *data)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +/**
>> + * timerlat_irq - hrtimer handler for timerlat.
>> + */
>> +static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
>> +{
>> +	struct osnoise_variables *osn_var = this_cpu_osn_var();
>> +	struct trace_array *tr = osnoise_trace;
>> +	struct timerlat_variables *tlat;
>> +	struct timerlat_sample s;
>> +	u64 now;
>> +	u64 diff;
>> +
>> +	/*
>> +	 * I am not sure if the timer was armed for this CPU. So, get
>> +	 * the timerlat struct from the timer itself, not from this
>> +	 * CPU.
>> +	 */
>> +	tlat = container_of(timer, struct timerlat_variables, timer);
>> +
>> +	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
>> +
>> +	/*
>> +	 * Enable the osnoise: events for thread an softirq.
>> +	 */
>> +	tlat->tracing_thread = true;
>> +
>> +	osn_var->thread.arrival_time = time_get();
>> +
>> +	/*
>> +	 * A hardirq is running: the timer IRQ. It is for sure preempting
>> +	 * a thread, and potentially preempting a softirq.
>> +	 *
>> +	 * At this point, it is not interesting to know the duration of the
>> +	 * preempted thread (and maybe softirq), but how much time they will
>> +	 * delay the beginning of the execution of the timer thread.
>> +	 *
>> +	 * To get the correct (net) delay added by the softirq, its delta_start
>> +	 * is set as the IRQ one. In this way, at the return of the IRQ, the delta
>> +	 * start of the sofitrq will be zeroed, accounting then only the time
>> +	 * after that.
>> +	 *
>> +	 * The thread follows the same principle. However, if a softirq is
>> +	 * running, the thread needs to receive the softirq delta_start. The
>> +	 * reason being is that the softirq will be the last to be unfolded,
>> +	 * resseting the thread delay to zero.
>> +	 */
>> +#ifndef CONFIG_PREEMPT_RT
>> +	if (osn_var->softirq.delta_start) {
>> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
>> +				   &osn_var->softirq.delta_start);
> 
> Isn't softirq.delta_start going to be zero here? It doesn't look to get
> updated until you set tracing_thread to true, but that happens here, and as
> this is in a interrupt context, there will not be a softirq happening
> between the setting of that to true to this point.

No... on the timerlat, the "sampling" is always on. And the
osnoise_data.timerlat_tracer is only checked at the softirq return, so the
softirq entry always set set the delta_start.

>> +
>> +		copy_int_safe_time(osn_var, &osn_var->softirq.delta_start,
>> +				    &osn_var->irq.delta_start);
>> +	} else {
>> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
>> +				    &osn_var->irq.delta_start);
>> +	}
>> +#else /* CONFIG_PREEMPT_RT */
>> +	/*
>> +	 * The sofirqs run as threads on RT, so there is not need
>> +	 * to keep track of it.
>> +	 */
>> +	copy_int_safe_time(osn_var, &osn_var->thread.delta_start, &osn_var->irq.delta_start);
>> +#endif /* CONFIG_PREEMPT_RT */
>> +
>> +	/*
>> +	 * Compute the current time with the expected time.
>> +	 */
>> +	diff = now - tlat->abs_period;
>> +
>> +	tlat->count++;
>> +	s.seqnum = tlat->count;
>> +	s.timer_latency = diff;
>> +	s.context = IRQ_CONTEXT;
>> +
>> +	trace_timerlat_sample(&s);
>> +
>> +	/* Keep a running maximum ever recorded os noise "latency" */
>> +	if (diff > tr->max_latency) {
>> +		tr->max_latency = diff;
>> +		latency_fsnotify(tr);
>> +	}
>> +
>> +	if (osnoise_data.stop_tracing_in)
>> +		if (time_to_us(diff) >= osnoise_data.stop_tracing_in)
>> +			osnoise_stop_tracing();
>> +
>> +	wake_up_process(tlat->kthread);
>> +
>> +#ifdef CONFIG_STACKTRACE
>> +	if (osnoise_data.print_stack)
>> +		timerlat_save_stack(0);
>> +#endif
> 
> No need for the #ifdef above. timerlat_save_stack() is defined as a nop
> when not enabled, and the compiler will just optimize this out.

The osnoise_data.print_stack is ifdefed, should I remove it from ifdef?

> 
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +/**
>> + * wait_next_period - Wait for the next period for timerlat
>> + */
>> +static int wait_next_period(struct timerlat_variables *tlat)
>> +{
>> +	ktime_t next_abs_period, now;
>> +	u64 rel_period = osnoise_data.timerlat_period * 1000;
>> +
>> +	now = hrtimer_cb_get_time(&tlat->timer);
>> +	next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
>> +
>> +	/*
>> +	 * Save the next abs_period.
>> +	 */
>> +	tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
>> +
>> +	/*
>> +	 * If the new abs_period is in the past, skip the activation.
>> +	 */
>> +	while (ktime_compare(now, next_abs_period) > 0) {
>> +		next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
>> +		tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
>> +	}
>> +
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);
>> +	schedule();
>> +	return 1;
>> +}
>> +
>> +/**
>> + * timerlat_main- Timerlat main
>> + */
>> +static int timerlat_main(void *data)
>> +{
>> +	struct osnoise_variables *osn_var = this_cpu_osn_var();
>> +	struct timerlat_variables *tlat = this_cpu_tmr_var();
>> +	struct timerlat_sample s;
>> +	struct sched_param sp;
>> +	u64 now, diff;
>> +
>> +	/*
>> +	 * Make the thread RT, that is how cyclictest is usually used.
>> +	 */
>> +	sp.sched_priority = DEFAULT_TIMERLAT_PRIO;
>> +	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
> 
> Hmm, I thought Peter Zijlstra was removing all sched_setscheduler*() calls
> in the kernel :-/ Although, this one seems legit, and we are not running
> from within a module.
> 
> -- Steve
> 

-- Daniel

