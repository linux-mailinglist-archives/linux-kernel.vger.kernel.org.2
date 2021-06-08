Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD06639EB89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFHBif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFHBie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:38:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D79960BBB;
        Tue,  8 Jun 2021 01:36:41 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:36:39 -0400
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
Message-ID: <20210607213639.68aad064@gandalf.local.home>
In-Reply-To: <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
 <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 22:51:18 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> The timerlat tracer aims to help the preemptive kernel developers to
> found souces of wakeup latencies of real-time threads. Like cyclictest,
> the tracer sets a periodic timer that wakes up a thread. The thread then
> computes a *wakeup latency* value as the difference between the *current
> time* and the *absolute time* that the timer was set to expire. The main
> goal of timerlat is tracing in such a way to help kernel developers.
> 

Hmm, we should add a way to have wake up tracers only trace a specific
task, where these osnoise trace events would also be useful. That is,
run cyclictest with the wakeup tracer, that it does this for cyclictest
directly. That shouldn't be too difficult to add.

> Usage
> 
> Write the ASCII text "timerlat" into the current_tracer file of the
> tracing system (generally mounted at /sys/kernel/tracing).
> 
> For example:
> 
>         [root@f32 ~]# cd /sys/kernel/tracing/
>         [root@f32 tracing]# echo timerlat > current_tracer
> 
> It is possible to follow the trace by reading the trace trace file::

Do not need rst markup in commit logs ;-)

> 
>   [root@f32 tracing]# cat trace
>   # tracer: timerlat
>   #
>   #                              _-----=> irqs-off
>   #                             / _----=> need-resched
>   #                            | / _---=> hardirq/softirq
>   #                            || / _--=> preempt-depth
>   #                            || /
>   #                            ||||             ACTIVATION
>   #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
>   #            | |         |   ||||      |         |                  |                       |
>           <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
>            <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
>           <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
>            <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
>           <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
>            <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
>           <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
>            <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
> 
> The tracer creates a per-cpu kernel thread with real-time priority that
> prints two lines at every activation. The first is the *timer latency*
> observed at the *hardirq* context before the activation of the thread.
> The second is the *timer latency* observed by the thread, which is the
> same level that cyclictest reports. The ACTIVATION ID field

The above is misleading. Below, I see that you state that the values are
"net values" where the thread latency does not include the irq latency.
This is not the same as cyclictest. (I had to update my ASCII art below
after reading the below statement).

> serves to relate the *irq* execution to its respective *thread* execution.
> 
> The irq/thread splitting is important to clarify at which context
> the unexpected high value is coming from. The *irq* context can be
> delayed by hardware related actions, such as SMIs, NMIs, IRQs
> or by a thread masking interrupts. Once the timer happens, the delay
> can also be influenced by blocking caused by threads. For example, by
> postponing the scheduler execution via preempt_disable(),  by the
> scheduler execution, or by masking interrupts. Threads can
> also be delayed by the interference from other threads and IRQs.


I wonder if ASCII art would help clarify the above. At least for the
document (not the change log here).


  time ==>
            expected         actual      thread
             wakeup          wakeup     scheduled
                |              |          |
                v              v          v
      |---------|-------|------|----------|
                        ^
                        |
                    interrupt 

                |--------------|
                   irq latency

                               |-----------|
                       thread latency


> 
> The timerlat can also take advantage of the osnoise: traceevents.
> For example:
> 
>         [root@f32 ~]# cd /sys/kernel/tracing/
>         [root@f32 tracing]# echo timerlat > current_tracer
>         [root@f32 tracing]# echo osnoise > set_event
>         [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
>         [root@f32 tracing]# tail -10 trace
>              cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency      1585 ns
>              cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 4597 ns
>              cc1-87882   [005] dNLh2..   548.771083: irq_noise: reschedule:253 start 548.771083017 duration 56 ns
>              cc1-87882   [005] dNLh2..   548.771086: irq_noise: call_function_single:251 start 548.771083811 duration 2048 ns
>              cc1-87882   [005] dNLh2..   548.771088: irq_noise: call_function_single:251 start 548.771086814 duration 1495 ns
>              cc1-87882   [005] dNLh2..   548.771091: irq_noise: call_function_single:251 start 548.771089194 duration 1558 ns
>              cc1-87882   [005] dNLh2..   548.771094: irq_noise: call_function_single:251 start 548.771091719 duration 1932 ns
>              cc1-87882   [005] dNLh2..   548.771096: irq_noise: call_function_single:251 start 548.771094696 duration 1050 ns
>              cc1-87882   [005] d...3..   548.771101: thread_noise:      cc1:87882 start 548.771078243 duration 10909 ns
>       timerlat/5-1035    [005] .......   548.771103: #402268 context thread timer_latency     25960 ns
> 
> For further information see: Documentation/trace/timerlat-tracer.rst
> 


> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 608107b27cc0..3769b9b7aed8 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -24,6 +24,7 @@ Linux Tracing Technologies
>     boottime-trace
>     hwlat_detector
>     osnoise-tracer
> +   timerlat-tracer
>     intel_th
>     ring-buffer-design
>     stm
> diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
> new file mode 100644
> index 000000000000..902d2f9a489f
> --- /dev/null
> +++ b/Documentation/trace/timerlat-tracer.rst
> @@ -0,0 +1,158 @@
> +###############
> +Timerlat tracer
> +###############
> +
> +The timerlat tracer aims to help the preemptive kernel developers to
> +found souces of wakeup latencies of real-time threads. Like cyclictest,

  "to find sources"

> +the tracer sets a periodic timer that wakes up a thread. The thread then
> +computes a *wakeup latency* value as the difference between the *current
> +time* and the *absolute time* that the timer was set to expire. The main
> +goal of timerlat is tracing in such a way to help kernel developers.
> +
> +Usage
> +-----
> +
> +Write the ASCII text "timerlat" into the current_tracer file of the
> +tracing system (generally mounted at /sys/kernel/tracing).
> +
> +For example::
> +
> +        [root@f32 ~]# cd /sys/kernel/tracing/
> +        [root@f32 tracing]# echo timerlat > current_tracer
> +
> +It is possible to follow the trace by reading the trace trace file::
> +
> +  [root@f32 tracing]# cat trace
> +  # tracer: timerlat
> +  #
> +  #                              _-----=> irqs-off
> +  #                             / _----=> need-resched
> +  #                            | / _---=> hardirq/softirq
> +  #                            || / _--=> preempt-depth
> +  #                            || /
> +  #                            ||||             ACTIVATION
> +  #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
> +  #            | |         |   ||||      |         |                  |                       |
> +          <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
> +           <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
> +          <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
> +           <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
> +          <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
> +           <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
> +          <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
> +           <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
> +
> +
> +The tracer creates a per-cpu kernel thread with real-time priority that
> +prints two lines at every activation. The first is the *timer latency*
> +observed at the *hardirq* context before the activation of the thread.
> +The second is the *timer latency* observed by the thread, which is the
> +same level that cyclictest reports. The ACTIVATION ID field
> +serves to relate the *irq* execution to its respective *thread* execution.
> +
> +The *irq*/*thread* splitting is important to clarify at which context
> +the unexpected high value is coming from. The *irq* context can be
> +delayed by hardware related actions, such as SMIs, NMIs, IRQs
> +or by a thread masking interrupts. Once the timer happens, the delay
> +can also be influenced by blocking caused by threads. For example, by
> +postponing the scheduler execution via preempt_disable(),  by the
> +scheduler execution, or by masking interrupts. Threads can
> +also be delayed by the interference from other threads and IRQs.

This is where I would add that ASCII art.

> +
> +Tracer options
> +---------------------
> +
> +The timerlat tracer is built on top of osnoise tracer.
> +So its configuration is also done in the osnoise/ config
> +directory. The timerlat configs are:
> +
> + - cpus: CPUs at which a timerlat thread will execute.
> + - timerlat_period_us: the period of the timerlat thread.
> + - osnoise/stop_tracing_in_us: stop the system tracing if a
> +   timer latency at the *irq* context higher than the configured
> +   value happens. Writing 0 disables this option.
> + - stop_tracing_out_us: stop the system tracing if a
> +   timer latency at the *thread* context higher than the configured
> +   value happens. Writing 0 disables this option.
> + - print_stack: save the stack of the IRQ ocurrence, and print
> +   it after the *thread* read the latency.

"thread read the latency" doesn't make sense.

 "and print it after the *thread context* event".  ?


> +
> +timerlat and osnoise
> +----------------------------
> +
> +The timerlat can also take advantage of the osnoise: traceevents.
> +For example::
> +
> +        [root@f32 ~]# cd /sys/kernel/tracing/
> +        [root@f32 tracing]# echo timerlat > current_tracer
> +        [root@f32 tracing]# echo osnoise > set_event

Note, set_event should be deprecated. Use:

	echo 1 > events/osnoise/enable

instead.


> +        [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
> +        [root@f32 tracing]# tail -10 trace
> +             cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency      1585 ns
> +             cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 4597 ns
> +             cc1-87882   [005] dNLh2..   548.771083: irq_noise: reschedule:253 start 548.771083017 duration 56 ns
> +             cc1-87882   [005] dNLh2..   548.771086: irq_noise: call_function_single:251 start 548.771083811 duration 2048 ns
> +             cc1-87882   [005] dNLh2..   548.771088: irq_noise: call_function_single:251 start 548.771086814 duration 1495 ns
> +             cc1-87882   [005] dNLh2..   548.771091: irq_noise: call_function_single:251 start 548.771089194 duration 1558 ns
> +             cc1-87882   [005] dNLh2..   548.771094: irq_noise: call_function_single:251 start 548.771091719 duration 1932 ns
> +             cc1-87882   [005] dNLh2..   548.771096: irq_noise: call_function_single:251 start 548.771094696 duration 1050 ns
> +             cc1-87882   [005] d...3..   548.771101: thread_noise:      cc1:87882 start 548.771078243 duration 10909 ns
> +      timerlat/5-1035    [005] .......   548.771103: #402268 context thread timer_latency     25960 ns
> +
> +In this case, the root cause of the timer latency does not point for a
> +single, but to a series of call_function_single IPIs, followed by a 10

"not point to a single"

> +*us* delay from a cc1 thread noise, along with the regular timer
> +activation. It is worth mentioning that the *duration* values reported
> +by the osnoise events are *net* values. For example, the
> +thread_noise does not include the duration of the overhead caused
> +by the IRQ execution (which indeed accounted for 12736 ns).

As stated above, I updated my view of the ASCII art after reading this. You
should not compare what cyclictest reports as the thread latency. But what
cyclictest reports is the sum of the two (irq latency plus thread latency).


> +
> +Such pieces of evidence are useful for the developer to use other
> +tracing methods to figure out how to optimize the environment.
> +
> +IRQ stacktrace
> +---------------------------
> +
> +The osnoise/print_stack option is helpful for the cases in which a thread
> +noise causes the major factor for the timer latency, because of preempt or
> +irq disabled. For example::
> +
> +        [root@f32 tracing]# echo 500 > osnoise/stop_tracing_out_us
> +        [root@f32 tracing]# echo 500 > osnoise/print_stack
> +        [root@f32 tracing]# echo timerlat > current_tracer
> +        [root@f32 tracing]# tail -21 per_cpu/cpu7/trace
> +          insmod-1026    [007] dN.h1..   200.201948: irq_noise: local_timer:236 start 200.201939376 duration 7872 ns
> +          insmod-1026    [007] d..h1..   200.202587: #29800 context    irq timer_latency      1616 ns
> +          insmod-1026    [007] dN.h2..   200.202598: irq_noise: local_timer:236 start 200.202586162 duration 11855 ns
> +          insmod-1026    [007] dN.h3..   200.202947: irq_noise: local_timer:236 start 200.202939174 duration 7318 ns
> +          insmod-1026    [007] d...3..   200.203444: thread_noise:   insmod:1026 start 200.202586933 duration 838681 ns
> +      timerlat/7-1001    [007] .......   200.203445: #29800 context thread timer_latency    859978 ns
> +      timerlat/7-1001    [007] ....1..   200.203446: <stack trace>
> +  => timerlat_irq
> +  => __hrtimer_run_queues
> +  => hrtimer_interrupt
> +  => __sysvec_apic_timer_interrupt
> +  => asm_call_irq_on_stack
> +  => sysvec_apic_timer_interrupt
> +  => asm_sysvec_apic_timer_interrupt
> +  => delay_tsc
> +  => dummy_load_1ms_pd_init
> +  => do_one_initcall
> +  => do_init_module
> +  => __do_sys_finit_module
> +  => do_syscall_64
> +  => entry_SYSCALL_64_after_hwframe
> +
> +In this case, it is possible to see that the thread added the highest
> +contribution to the *timer latency* and the stack trace points to
> +a function named dummy_load_1ms_pd_init, which had the following
> +code (on purpose)::

Should add here as well that the stack is saved at the time of interrupt,
and not at the time it is reported.

> +
> +	static int __init dummy_load_1ms_pd_init(void)
> +	{
> +		preempt_disable();
> +		mdelay(1);
> +		preempt_enable();
> +		return 0;
> +
> +	}
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 41582ae4682b..d567b1717c4c 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -390,6 +390,34 @@ config OSNOISE_TRACER
>  	  To enable this tracer, echo in "osnoise" into the current_tracer
>            file.
>  
> +config TIMERLAT_TRACER
> +	bool "Timerlat tracer"
> +	select OSNOISE_TRACER
> +	select GENERIC_TRACER
> +	help
> +	  The timerlat tracer aims to help the preemptive kernel developers
> +	  to find sources of wakeup latencies of real-time threads.
> +
> +	  The tracer creates a per-cpu kernel thread with real-time priority.
> +	  The tracer thread sets a periodic timer to wakeup itself, and goes
> +	  to sleep waiting for the timer to fire. At the wakeup, the thread
> +	  then computes a wakeup latency value as the difference between
> +	  the current time and the absolute time that the timer was set
> +	  to expire.
> +
> +	  The tracer prints two lines at every activation. The first is the
> +	  timer latency observed at the hardirq context before the
> +	  activation of the thread. The second is the timer latency observed
> +	  by the thread, which is the same level that cyclictest reports. The

Again, change the reference to cyclictest here. As what cyclictest reports
is the sum of the two. Saying the "same level that cyclictest reports" is
misleading.

> +	  ACTIVATION ID field serves to relate the irq execution to its
> +	  respective thread execution.
> +
> +	  The tracer is build on top of osnoise tracer, and the osnoise:
> +	  events can be used to trace the source of interference from NMI,
> +	  IRQs and other threads. It also enables the capture of the
> +	  stacktrace at the IRQ context, which helps to identify the code
> +	  path that can cause thread delay.
> +
>  config MMIOTRACE
>  	bool "Memory mapped IO tracing"
>  	depends on HAVE_MMIOTRACE_SUPPORT && PCI
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 754dfe8987a2..889986242c40 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -45,6 +45,7 @@ enum trace_type {
>  	TRACE_BPUTS,
>  	TRACE_HWLAT,
>  	TRACE_OSNOISE,
> +	TRACE_TIMERLAT,
>  	TRACE_RAW_DATA,
>  	TRACE_FUNC_REPEATS,
>  
> @@ -448,6 +449,7 @@ extern void __ftrace_bad_type(void);
>  		IF_ASSIGN(var, ent, struct bputs_entry, TRACE_BPUTS);	\
>  		IF_ASSIGN(var, ent, struct hwlat_entry, TRACE_HWLAT);	\
>  		IF_ASSIGN(var, ent, struct osnoise_entry, TRACE_OSNOISE);\
> +		IF_ASSIGN(var, ent, struct timerlat_entry, TRACE_TIMERLAT);\
>  		IF_ASSIGN(var, ent, struct raw_data_entry, TRACE_RAW_DATA);\
>  		IF_ASSIGN(var, ent, struct trace_mmiotrace_rw,		\
>  			  TRACE_MMIO_RW);				\
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 158c0984b59b..cd41e863b51c 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -385,3 +385,19 @@ FTRACE_ENTRY(osnoise, osnoise_entry,
>  		 __entry->softirq_count,
>  		 __entry->thread_count)
>  );
> +
> +FTRACE_ENTRY(timerlat, timerlat_entry,
> +
> +	TRACE_TIMERLAT,
> +
> +	F_STRUCT(
> +		__field(	unsigned int,		seqnum		)
> +		__field(	int,			context		)
> +		__field(	u64,			timer_latency	)
> +	),
> +
> +	F_printk("seq:%u\tcontext:%d\ttimer_latency:%llu\n",
> +		 __entry->seqnum,
> +		 __entry->context,
> +		 __entry->timer_latency)
> +);
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 9bd40b514d84..3a8d70fbb57f 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * OS Noise Tracer: computes the OS Noise suffered by a running thread.
> + * Timerlat Tracer: measures the wakeup latency of a timer triggered IRQ and thread.
>   *
>   * Based on "hwlat_detector" tracer by:
>   *   Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
> @@ -21,6 +22,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/delay.h>
>  #include <linux/sched/clock.h>
> +#include <uapi/linux/sched/types.h>
>  #include <linux/sched.h>
>  #include "trace.h"
>  
> @@ -45,6 +47,9 @@ static struct trace_array	*osnoise_trace;
>  #define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
>  #define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
>  
> +#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
> +#define DEFAULT_TIMERLAT_PRIO	95			/* FIFO 95 */
> +
>  /*
>   * NMI runtime info.
>   */
> @@ -62,6 +67,8 @@ struct irq {
>  	u64 delta_start;
>  };
>  
> +#define IRQ_CONTEXT	0
> +#define THREAD_CONTEXT	1
>  /*
>   * SofIRQ runtime info.
>   */
> @@ -108,32 +115,76 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
>  	return this_cpu_ptr(&per_cpu_osnoise_var);
>  }
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +/*
> + * Runtime information for the timer mode.
> + */
> +struct timerlat_variables {
> +	struct task_struct *kthread;
> +	struct hrtimer timer;
> +	u64 rel_period;
> +	u64 abs_period;
> +	bool tracing_thread;
> +	u64 count;
> +};

Like with the osnoise comment, put in tabs to make the fields stand out.

> +
> +DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
> +
>  /**
> - * osn_var_reset - Reset the values of the given osnoise_variables
> + * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
> + */
> +static inline struct timerlat_variables *this_cpu_tmr_var(void)
> +{
> +	return this_cpu_ptr(&per_cpu_timerlat_var);
> +}
> +
> +/**
> + * tlat_var_reset - Reset the values of the given timerlat_variables
>   */
> -static inline void osn_var_reset(struct osnoise_variables *osn_var)
> +static inline void tlat_var_reset(void)
>  {
> +	struct timerlat_variables *tlat_var;
> +	int cpu;
>  	/*
>  	 * So far, all the values are initialized as 0, so
>  	 * zeroing the structure is perfect.
>  	 */
> -	memset(osn_var, 0, sizeof(struct osnoise_variables));
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
> +		memset(tlat_var, 0, sizeof(struct timerlat_variables));
> +	}
>  }
> +#else /* CONFIG_TIMERLAT_TRACER */
> +#define tlat_var_reset()	do {} while (0)
> +#endif /* CONFIG_TIMERLAT_TRACER */
>  
>  /**
> - * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
> + * osn_var_reset - Reset the values of the given osnoise_variables
>   */
> -static inline void osn_var_reset_all(void)
> +static inline void osn_var_reset(void)
>  {
>  	struct osnoise_variables *osn_var;
>  	int cpu;
>  
> +	/*
> +	 * So far, all the values are initialized as 0, so
> +	 * zeroing the structure is perfect.
> +	 */
>  	for_each_cpu(cpu, cpu_online_mask) {
>  		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
> -		osn_var_reset(osn_var);
> +		memset(osn_var, 0, sizeof(struct osnoise_variables));
>  	}
>  }
>  
> +/**
> + * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
> + */
> +static inline void osn_var_reset_all(void)
> +{
> +	osn_var_reset();
> +	tlat_var_reset();
> +}
> +
>  /*
>   * Tells NMIs to call back to the osnoise tracer to record timestamps.
>   */
> @@ -154,6 +205,18 @@ struct osnoise_sample {
>  	int			thread_count;	/* # Threads during this sample */
>  };
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +/*
> + * timerlat sample structure definition. Used to store the statistics of
> + * a sample run.
> + */
> +struct timerlat_sample {
> +	u64			seqnum;		/* unique sequence */

The seqnum in the event is unsigned int, whereas here it's u64.

> +	u64			timer_latency;	/* timer_latency */
> +	int			context;	/* timer context */
> +};
> +#endif
> +
>  /*
>   * Protect the interface.
>   */
> @@ -165,13 +228,23 @@ struct mutex interface_lock;
>  static struct osnoise_data {
>  	u64	sample_period;		/* total sampling period */
>  	u64	sample_runtime;		/* active sampling portion of period */
> -	u64	stop_tracing_in;	/* stop trace in the inside operation (loop) */
> -	u64	stop_tracing_out;	/* stop trace in the outside operation (report) */
> +	u64	stop_tracing_in;	/* stop trace in the inside operation (loop/irq) */
> +	u64	stop_tracing_out;	/* stop trace in the outside operation (report/thread) */
> +#ifdef CONFIG_TIMERLAT_TRACER
> +	u64	timerlat_period;	/* timerlat period */
> +	u64	print_stack;		/* print IRQ stack if total > */
> +	int	timerlat_tracer;	/* timerlat tracer */
> +#endif
>  } osnoise_data = {
>  	.sample_period			= DEFAULT_SAMPLE_PERIOD,
>  	.sample_runtime			= DEFAULT_SAMPLE_RUNTIME,
>  	.stop_tracing_in		= 0,
>  	.stop_tracing_out		= 0,
> +#ifdef CONFIG_TIMERLAT_TRACER
> +	.print_stack			= 0,
> +	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
> +	.timerlat_tracer		= 0,
> +#endif
>  };
>  
>  /*
> @@ -232,6 +305,125 @@ static void trace_osnoise_sample(struct osnoise_sample *sample)
>  		trace_buffer_unlock_commit_nostack(buffer, event);
>  }
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +/*
> + * Print the timerlat header info.
> + */
> +static void print_timerlat_headers(struct seq_file *s)
> +{
> +	seq_puts(s, "#                                _-----=> irqs-off\n");
> +	seq_puts(s, "#                               / _----=> need-resched\n");
> +	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
> +	seq_puts(s, "#                              || / _--=> preempt-depth\n");
> +	seq_puts(s, "#                              || /\n");
> +	seq_puts(s, "#                              ||||             ACTIVATION\n");
> +	seq_puts(s, "#           TASK-PID      CPU# ||||   TIMESTAMP    ID     ");
> +	seq_puts(s, "       CONTEXT                LATENCY\n");
> +	seq_puts(s, "#              | |         |   ||||      |         |      ");
> +	seq_puts(s, "            |                       |\n");
> +}
> +
> +/*
> + * Record an timerlat_sample into the tracer buffer.
> + */
> +static void trace_timerlat_sample(struct timerlat_sample *sample)
> +{
> +	struct trace_array *tr = osnoise_trace;
> +	struct trace_event_call *call = &event_osnoise;
> +	struct trace_buffer *buffer = tr->array_buffer.buffer;
> +	struct ring_buffer_event *event;
> +	struct timerlat_entry *entry;
> +
> +	event = trace_buffer_lock_reserve(buffer, TRACE_TIMERLAT, sizeof(*entry),
> +					  tracing_gen_ctx());
> +	if (!event)
> +		return;
> +	entry	= ring_buffer_event_data(event);
> +	entry->seqnum			= sample->seqnum;
> +	entry->context			= sample->context;
> +	entry->timer_latency		= sample->timer_latency;
> +
> +	if (!call_filter_check_discard(call, entry, buffer, event))
> +		trace_buffer_unlock_commit_nostack(buffer, event);
> +}
> +
> +#ifdef CONFIG_STACKTRACE
> +/*
> + * Stack trace will take place only at IRQ level, so, no need
> + * to control nesting here.
> + */
> +struct trace_stack {
> +	int stack_size;
> +	int nr_entries;
> +	unsigned long           calls[PAGE_SIZE];

That is rather big. It's 8 * PAGE_SIZE. I don't think that's what you really
wanted.

> +};
> +
> +static DEFINE_PER_CPU(struct trace_stack, trace_stack);
> +
> +/**

Again, remove the KernelDoc notation of /**, or make it real kerneldoc
notation.

> + * timerlat_save_stack - save a stack trace without printing
> + *
> + * Save the current stack trace without printing. The
> + * stack will be printed later, after the end of the measurement.
> + */
> +static void timerlat_save_stack(int skip)
> +{
> +	unsigned int size, nr_entries;
> +	struct trace_stack *fstack;
> +
> +	fstack = this_cpu_ptr(&trace_stack);
> +
> +	size = ARRAY_SIZE(fstack->calls);
> +
> +	nr_entries = stack_trace_save(fstack->calls, size, skip);
> +
> +	fstack->stack_size = nr_entries * sizeof(unsigned long);
> +	fstack->nr_entries = nr_entries;
> +
> +	return;
> +
> +}
> +/**
> + * timerlat_dump_stack - dump a stack trace previously saved
> + *
> + * Dump a saved stack trace into the trace buffer.
> + */
> +static void timerlat_dump_stack(void)
> +{
> +	struct trace_event_call *call = &event_osnoise;
> +	struct trace_array *tr = osnoise_trace;
> +	struct trace_buffer *buffer = tr->array_buffer.buffer;
> +	struct ring_buffer_event *event;
> +	struct trace_stack *fstack;
> +	struct stack_entry *entry;
> +	unsigned int size;
> +
> +	preempt_disable_notrace();
> +	fstack = this_cpu_ptr(&trace_stack);
> +	size = fstack->stack_size;
> +
> +	event = trace_buffer_lock_reserve(buffer, TRACE_STACK, sizeof(*entry) + size,
> +					  tracing_gen_ctx());
> +	if (!event)
> +		goto out;
> +
> +	entry = ring_buffer_event_data(event);
> +
> +	memcpy(&entry->caller, fstack->calls, size);
> +	entry->size = fstack->nr_entries;
> +
> +	if (!call_filter_check_discard(call, entry, buffer, event))
> +		trace_buffer_unlock_commit_nostack(buffer, event);
> +
> +out:
> +	preempt_enable_notrace();
> +}
> +#else
> +#define timerlat_dump_stack() do {} while (0)
> +#define timerlat_save_stack(a) do {} while (0)
> +#endif /* CONFIG_STACKTRACE */
> +#endif /* CONFIG_TIMERLAT_TRACER */
> +
>  /**
>   * Macros to encapsulate the time capturing infrastructure.
>   */
> @@ -373,6 +565,30 @@ set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
>  	return int_counter;
>  }
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +/**
> + * copy_int_safe_time - Copy *src into *desc aware of interference
> + */
> +static u64
> +copy_int_safe_time(struct osnoise_variables *osn_var, u64 *dst, u64 *src)
> +{
> +	u64 int_counter;
> +
> +	do {
> +		int_counter = local_read(&osn_var->int_counter);
> +		/* synchronize with interrupts */
> +		barrier();
> +
> +		*dst = *src;
> +
> +		/* synchronize with interrupts */
> +		barrier();
> +	} while (int_counter != local_read(&osn_var->int_counter));

Note, that the loop is unnecessary on 64 bit machines.

The compiler should not split loads, in such cases.

> +
> +	return int_counter;
> +}
> +#endif /* CONFIG_TIMERLAT_TRACER */
> +
>  /**
>   * trace_osnoise_callback - NMI entry/exit callback
>   *
> @@ -801,6 +1017,22 @@ void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
>  	if (!osn_var->sampling)
>  		return;
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +	/*
> +	 * If the timerlat is enabled, but the irq handler did
> +	 * not run yet enabling timerlat_tracer, do not trace.
> +	 */
> +	if (unlikely(osnoise_data.timerlat_tracer)) {
> +		struct timerlat_variables *tlat_var;
> +		tlat_var = this_cpu_tmr_var();
> +		if (!tlat_var->tracing_thread) {

What happens if the timer interrupt triggers here?

> +			osn_var->softirq.arrival_time = 0;
> +			osn_var->softirq.delta_start = 0;
> +			return;
> +		}
> +	}
> +#endif
> +
>  	duration = get_int_safe_duration(osn_var, &osn_var->softirq.delta_start);
>  	trace_softirq_noise(vec_nr, osn_var->softirq.arrival_time, duration);
>  	cond_move_thread_delta_start(osn_var, duration);
> @@ -893,6 +1125,18 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
>  	if (!osn_var->sampling)
>  		return;
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +	if (osnoise_data.timerlat_tracer) {
> +		struct timerlat_variables *tlat_var;
> +		tlat_var = this_cpu_tmr_var();
> +		if (!tlat_var->tracing_thread) {

Or here?

> +			osn_var->thread.delta_start = 0;
> +			osn_var->thread.arrival_time = 0;
> +			return;
> +		}
> +	}
> +#endif
> +
>  	duration = get_int_safe_duration(osn_var, &osn_var->thread.delta_start);
>  
>  	trace_thread_noise(t, osn_var->thread.arrival_time, duration);
> @@ -1182,6 +1426,197 @@ static int osnoise_main(void *data)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_TIMERLAT_TRACER
> +/**
> + * timerlat_irq - hrtimer handler for timerlat.
> + */
> +static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
> +{
> +	struct osnoise_variables *osn_var = this_cpu_osn_var();
> +	struct trace_array *tr = osnoise_trace;
> +	struct timerlat_variables *tlat;
> +	struct timerlat_sample s;
> +	u64 now;
> +	u64 diff;
> +
> +	/*
> +	 * I am not sure if the timer was armed for this CPU. So, get
> +	 * the timerlat struct from the timer itself, not from this
> +	 * CPU.
> +	 */
> +	tlat = container_of(timer, struct timerlat_variables, timer);
> +
> +	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
> +
> +	/*
> +	 * Enable the osnoise: events for thread an softirq.
> +	 */
> +	tlat->tracing_thread = true;
> +
> +	osn_var->thread.arrival_time = time_get();
> +
> +	/*
> +	 * A hardirq is running: the timer IRQ. It is for sure preempting
> +	 * a thread, and potentially preempting a softirq.
> +	 *
> +	 * At this point, it is not interesting to know the duration of the
> +	 * preempted thread (and maybe softirq), but how much time they will
> +	 * delay the beginning of the execution of the timer thread.
> +	 *
> +	 * To get the correct (net) delay added by the softirq, its delta_start
> +	 * is set as the IRQ one. In this way, at the return of the IRQ, the delta
> +	 * start of the sofitrq will be zeroed, accounting then only the time
> +	 * after that.
> +	 *
> +	 * The thread follows the same principle. However, if a softirq is
> +	 * running, the thread needs to receive the softirq delta_start. The
> +	 * reason being is that the softirq will be the last to be unfolded,
> +	 * resseting the thread delay to zero.
> +	 */
> +#ifndef CONFIG_PREEMPT_RT
> +	if (osn_var->softirq.delta_start) {
> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
> +				   &osn_var->softirq.delta_start);

Isn't softirq.delta_start going to be zero here? It doesn't look to get
updated until you set tracing_thread to true, but that happens here, and as
this is in a interrupt context, there will not be a softirq happening
between the setting of that to true to this point.

> +
> +		copy_int_safe_time(osn_var, &osn_var->softirq.delta_start,
> +				    &osn_var->irq.delta_start);
> +	} else {
> +		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
> +				    &osn_var->irq.delta_start);
> +	}
> +#else /* CONFIG_PREEMPT_RT */
> +	/*
> +	 * The sofirqs run as threads on RT, so there is not need
> +	 * to keep track of it.
> +	 */
> +	copy_int_safe_time(osn_var, &osn_var->thread.delta_start, &osn_var->irq.delta_start);
> +#endif /* CONFIG_PREEMPT_RT */
> +
> +	/*
> +	 * Compute the current time with the expected time.
> +	 */
> +	diff = now - tlat->abs_period;
> +
> +	tlat->count++;
> +	s.seqnum = tlat->count;
> +	s.timer_latency = diff;
> +	s.context = IRQ_CONTEXT;
> +
> +	trace_timerlat_sample(&s);
> +
> +	/* Keep a running maximum ever recorded os noise "latency" */
> +	if (diff > tr->max_latency) {
> +		tr->max_latency = diff;
> +		latency_fsnotify(tr);
> +	}
> +
> +	if (osnoise_data.stop_tracing_in)
> +		if (time_to_us(diff) >= osnoise_data.stop_tracing_in)
> +			osnoise_stop_tracing();
> +
> +	wake_up_process(tlat->kthread);
> +
> +#ifdef CONFIG_STACKTRACE
> +	if (osnoise_data.print_stack)
> +		timerlat_save_stack(0);
> +#endif

No need for the #ifdef above. timerlat_save_stack() is defined as a nop
when not enabled, and the compiler will just optimize this out.

> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * wait_next_period - Wait for the next period for timerlat
> + */
> +static int wait_next_period(struct timerlat_variables *tlat)
> +{
> +	ktime_t next_abs_period, now;
> +	u64 rel_period = osnoise_data.timerlat_period * 1000;
> +
> +	now = hrtimer_cb_get_time(&tlat->timer);
> +	next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
> +
> +	/*
> +	 * Save the next abs_period.
> +	 */
> +	tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
> +
> +	/*
> +	 * If the new abs_period is in the past, skip the activation.
> +	 */
> +	while (ktime_compare(now, next_abs_period) > 0) {
> +		next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
> +		tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);
> +	schedule();
> +	return 1;
> +}
> +
> +/**
> + * timerlat_main- Timerlat main
> + */
> +static int timerlat_main(void *data)
> +{
> +	struct osnoise_variables *osn_var = this_cpu_osn_var();
> +	struct timerlat_variables *tlat = this_cpu_tmr_var();
> +	struct timerlat_sample s;
> +	struct sched_param sp;
> +	u64 now, diff;
> +
> +	/*
> +	 * Make the thread RT, that is how cyclictest is usually used.
> +	 */
> +	sp.sched_priority = DEFAULT_TIMERLAT_PRIO;
> +	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);

Hmm, I thought Peter Zijlstra was removing all sched_setscheduler*() calls
in the kernel :-/ Although, this one seems legit, and we are not running
from within a module.

-- Steve

> +
> +	tlat->count = 0;
> +	tlat->tracing_thread = false;
> +
> +	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> +	tlat->timer.function = timerlat_irq;
> +	tlat->kthread = current;
> +	osn_var->pid = current->pid;
> +	/*
> +	 * Anotate the arrival time.
> +	 */
> +	tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
> +
> +	wait_next_period(tlat);
> +
> +	osn_var->sampling = 1;
> +
> +	while (!kthread_should_stop()) {
> +		now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
> +		diff = now - tlat->abs_period;
> +
> +		s.seqnum = tlat->count;
> +		s.timer_latency = diff;
> +		s.context = THREAD_CONTEXT;
> +
> +		trace_timerlat_sample(&s);
> +
> +#ifdef CONFIG_STACKTRACE
> +	if (osnoise_data.print_stack)
> +		if (osnoise_data.print_stack <= time_to_us(diff))
> +			timerlat_dump_stack();
> +#endif /* CONFIG_STACKTRACE */
> +
> +		tlat->tracing_thread = false;
> +		if (osnoise_data.stop_tracing_out)
> +			if (time_to_us(diff) >= osnoise_data.stop_tracing_out)
> +				osnoise_stop_tracing();
> +
> +		wait_next_period(tlat);
> +	}
> +
> +	hrtimer_cancel(&tlat->timer);
> +	return 0;
> +}
> +#endif /* CONFIG_TIMERLAT_TRACER */
