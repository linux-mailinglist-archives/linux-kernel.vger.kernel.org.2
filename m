Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF02438171
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJWClC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 22:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJWClB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 22:41:01 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CC86101C;
        Sat, 23 Oct 2021 02:38:41 +0000 (UTC)
Date:   Fri, 22 Oct 2021 22:38:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V4 04/19] trace/osnoise: Support a list of trace_array
 *tr
Message-ID: <20211022223839.476905ed@rorschach.local.home>
In-Reply-To: <d54f5bfa2b2fbd11393c2a69a8b5cbdd808a506d.1634820694.git.bristot@kernel.org>
References: <cover.1634820694.git.bristot@kernel.org>
        <d54f5bfa2b2fbd11393c2a69a8b5cbdd808a506d.1634820694.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 14:56:42 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> osnoise/timerlat were built to run a single instance, and for this,
> a single variable is enough to store the current struct trace_array
> *tr with information about the tracing instance. This is done via
> the *osnoise_trace variable. A trace_array represents a trace instance.
> 
> In preparation to support multiple instances, replace the
> *osnoise_trace variable with an RCU protected list of instances.
> 
> The operations that refer to an instance now propagate to all
> elements of the list (all instances).
> 
> Also, replace the osnoise_busy variable with a check if the list
> has elements (busy).
> 
> No functional change is expected with this patch, i.e., only one
> instance is allowed yet.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-rt-users@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_osnoise.c | 253 +++++++++++++++++++++++++----------
>  1 file changed, 184 insertions(+), 69 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 9b9e6bc889e9..a6d8f514bd7c 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -38,8 +38,6 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/osnoise.h>
>  
> -static struct trace_array	*osnoise_trace;
> -
>  /*
>   * Default values.
>   */
> @@ -50,6 +48,73 @@ static struct trace_array	*osnoise_trace;
>  #define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
>  #define DEFAULT_TIMERLAT_PRIO	95			/* FIFO 95 */
>  
> +/*
> + * trace_array of the enabled osnoise/timerlat instances.
> + */
> +struct osnoise_instance {
> +	struct list_head	list;
> +	struct trace_array	*tr;
> +};
> +struct list_head osnoise_instances;
> +
> +static bool osnoise_has_registered_instances(void)
> +{
> +	return !!list_first_or_null_rcu(&osnoise_instances,
> +					struct osnoise_instance,
> +					list);
> +}
> +
> +/*
> + * osnoise_register_instance - register a new trace instance
> + *
> + * Register a trace_array *tr in the list of instances running
> + * osnoise/timerlat tracers.
> + */
> +static int osnoise_register_instance(struct trace_array *tr)
> +{
> +	struct osnoise_instance *inst;
> +
> +	inst = kmalloc(sizeof(*inst), GFP_KERNEL);
> +	if (!inst)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD_RCU(&inst->list);
> +	inst->tr = tr;
> +	list_add_tail_rcu(&inst->list, &osnoise_instances);
> +
> +	return 0;
> +}
> +
> +/*
> + *  osnoise_unregister_instance - unregister a registered trace instance
> + *
> + * Remove the trace_array *tr from the list of instances running
> + * osnoise/timerlat tracers.
> + */
> +static void osnoise_unregister_instance(struct trace_array *tr)
> +{
> +	struct osnoise_instance *inst;
> +	int found = 0;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		if (inst->tr == tr) {
> +			list_del_rcu(&inst->list);

Adding to the list requires more than RCU protection, and if this has
that protection there's no reason for using rcu to protect here.

[ Added Paul to comment about this too ]

-- Steve


> +			found = 1;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (!found) {
> +		WARN("osnoise unregister did not find tr %s\n", tr->name);
> +		return;
> +	}
> +
> +	synchronize_rcu();
> +	kfree(inst);
> +}
> +
>  /*
>   * NMI runtime info.
>   */
> @@ -248,11 +313,6 @@ static struct osnoise_data {
>  #endif
>  };
>  
> -/*
> - * Boolean variable used to inform that the tracer is currently sampling.
> - */
> -static bool osnoise_busy;
> -
>  #ifdef CONFIG_PREEMPT_RT
>  /*
>   * Print the osnoise header info.
> @@ -315,19 +375,24 @@ static void print_osnoise_headers(struct seq_file *s)
>   * osnoise_taint - report an osnoise error.
>   */
>  #define osnoise_taint(msg) ({							\
> -	struct trace_array *tr = osnoise_trace;					\
> +	struct osnoise_instance *inst;						\
> +	struct trace_buffer *buffer;						\
>  										\
> -	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_, msg);	\
> +	rcu_read_lock();							\
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {		\
> +		buffer = inst->tr->array_buffer.buffer;				\
> +		trace_array_printk_buf(buffer, _THIS_IP_, msg);			\
> +	}									\
> +	rcu_read_unlock();							\
>  	osnoise_data.tainted = true;						\
>  })
>  
>  /*
>   * Record an osnoise_sample into the tracer buffer.
>   */
> -static void trace_osnoise_sample(struct osnoise_sample *sample)
> +static void
> +__trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
>  {
> -	struct trace_array *tr = osnoise_trace;
> -	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct trace_event_call *call = &event_osnoise;
>  	struct ring_buffer_event *event;
>  	struct osnoise_entry *entry;
> @@ -350,6 +415,22 @@ static void trace_osnoise_sample(struct osnoise_sample *sample)
>  		trace_buffer_unlock_commit_nostack(buffer, event);
>  }
>  
> +/*
> + * Record an osnoise_sample on all osnoise instances.
> + */
> +static void trace_osnoise_sample(struct osnoise_sample *sample)
> +{
> +	struct osnoise_instance *inst;
> +	struct trace_buffer *buffer;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		buffer = inst->tr->array_buffer.buffer;
> +		__trace_osnoise_sample(sample, buffer);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  #ifdef CONFIG_TIMERLAT_TRACER
>  /*
>   * Print the timerlat header info.
> @@ -387,14 +468,10 @@ static void print_timerlat_headers(struct seq_file *s)
>  }
>  #endif /* CONFIG_PREEMPT_RT */
>  
> -/*
> - * Record an timerlat_sample into the tracer buffer.
> - */
> -static void trace_timerlat_sample(struct timerlat_sample *sample)
> +static void
> +__trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
>  {
> -	struct trace_array *tr = osnoise_trace;
>  	struct trace_event_call *call = &event_osnoise;
> -	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct ring_buffer_event *event;
>  	struct timerlat_entry *entry;
>  
> @@ -411,6 +488,22 @@ static void trace_timerlat_sample(struct timerlat_sample *sample)
>  		trace_buffer_unlock_commit_nostack(buffer, event);
>  }
>  
> +/*
> + * Record an timerlat_sample into the tracer buffer.
> + */
> +static void trace_timerlat_sample(struct timerlat_sample *sample)
> +{
> +	struct osnoise_instance *inst;
> +	struct trace_buffer *buffer;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		buffer = inst->tr->array_buffer.buffer;
> +		__trace_timerlat_sample(sample, buffer);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  #ifdef CONFIG_STACKTRACE
>  
>  #define	MAX_CALLS	256
> @@ -450,29 +543,18 @@ static void timerlat_save_stack(int skip)
>  	return;
>  
>  }
> -/*
> - * timerlat_dump_stack - dump a stack trace previously saved
> - *
> - * Dump a saved stack trace into the trace buffer.
> - */
> -static void timerlat_dump_stack(void)
> +
> +static void
> +__timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, unsigned int size)
>  {
>  	struct trace_event_call *call = &event_osnoise;
> -	struct trace_array *tr = osnoise_trace;
> -	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct ring_buffer_event *event;
> -	struct trace_stack *fstack;
>  	struct stack_entry *entry;
> -	unsigned int size;
> -
> -	preempt_disable_notrace();
> -	fstack = this_cpu_ptr(&trace_stack);
> -	size = fstack->stack_size;
>  
>  	event = trace_buffer_lock_reserve(buffer, TRACE_STACK, sizeof(*entry) + size,
>  					  tracing_gen_ctx());
>  	if (!event)
> -		goto out;
> +		return;
>  
>  	entry = ring_buffer_event_data(event);
>  
> @@ -481,8 +563,29 @@ static void timerlat_dump_stack(void)
>  
>  	if (!call_filter_check_discard(call, entry, buffer, event))
>  		trace_buffer_unlock_commit_nostack(buffer, event);
> +}
>  
> -out:
> +/*
> + * timerlat_dump_stack - dump a stack trace previously saved
> + */
> +static void timerlat_dump_stack(void)
> +{
> +	struct osnoise_instance *inst;
> +	struct trace_buffer *buffer;
> +	struct trace_stack *fstack;
> +	unsigned int size;
> +
> +	preempt_disable_notrace();
> +	fstack = this_cpu_ptr(&trace_stack);
> +	size = fstack->stack_size;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		buffer = inst->tr->array_buffer.buffer;
> +		__timerlat_dump_stack(buffer, fstack, size);
> +
> +	}
> +	rcu_read_unlock();
>  	preempt_enable_notrace();
>  }
>  #else
> @@ -1077,12 +1180,37 @@ diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *
>   */
>  static __always_inline void osnoise_stop_tracing(void)
>  {
> -	struct trace_array *tr = osnoise_trace;
> +	struct osnoise_instance *inst;
> +	struct trace_array *tr;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		tr = inst->tr;
> +		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> +				"stop tracing hit on cpu %d\n", smp_processor_id());
> +
> +		tracer_tracing_off(tr);
> +	}
> +	rcu_read_unlock();
> +}
>  
> -	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> -			"stop tracing hit on cpu %d\n", smp_processor_id());
> +/*
> + * notify_new_max_latency - Notify a new max latency via fsnotify interface.
> + */
> +void notify_new_max_latency(u64 latency)
> +{
> +	struct osnoise_instance *inst;
> +	struct trace_array *tr;
>  
> -	tracer_tracing_off(tr);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> +		tr = inst->tr;
> +		if (tr->max_latency < latency) {
> +			tr->max_latency = latency;
> +			latency_fsnotify(tr);
> +		}
> +	}
> +	rcu_read_unlock();
>  }
>  
>  /*
> @@ -1096,7 +1224,6 @@ static __always_inline void osnoise_stop_tracing(void)
>  static int run_osnoise(void)
>  {
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> -	struct trace_array *tr = osnoise_trace;
>  	u64 start, sample, last_sample;
>  	u64 last_int_count, int_count;
>  	s64 noise = 0, max_noise = 0;
> @@ -1231,11 +1358,7 @@ static int run_osnoise(void)
>  
>  	trace_osnoise_sample(&s);
>  
> -	/* Keep a running maximum ever recorded osnoise "latency" */
> -	if (max_noise > tr->max_latency) {
> -		tr->max_latency = max_noise;
> -		latency_fsnotify(tr);
> -	}
> +	notify_new_max_latency(max_noise);
>  
>  	if (osnoise_data.stop_tracing_total)
>  		if (s.noise > osnoise_data.stop_tracing_total)
> @@ -1293,7 +1416,6 @@ static int osnoise_main(void *data)
>  static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
>  {
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> -	struct trace_array *tr = osnoise_trace;
>  	struct timerlat_variables *tlat;
>  	struct timerlat_sample s;
>  	u64 now;
> @@ -1364,11 +1486,7 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
>  
>  	trace_timerlat_sample(&s);
>  
> -	/* Keep a running maximum ever recorded os noise "latency" */
> -	if (diff > tr->max_latency) {
> -		tr->max_latency = diff;
> -		latency_fsnotify(tr);
> -	}
> +	notify_new_max_latency(diff);
>  
>  	if (osnoise_data.stop_tracing)
>  		if (time_to_us(diff) >= osnoise_data.stop_tracing)
> @@ -1581,7 +1699,7 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
>  
>  	mutex_lock(&trace_types_lock);
>  
> -	if (!osnoise_busy)
> +	if (!osnoise_has_registered_instances())
>  		goto out_unlock_trace;
>  
>  	mutex_lock(&interface_lock);
> @@ -1716,11 +1834,10 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  		goto err_free;
>  
>  	/*
> -	 * trace_types_lock is taken to avoid concurrency on start/stop
> -	 * and osnoise_busy.
> +	 * trace_types_lock is taken to avoid concurrency on start/stop.
>  	 */
>  	mutex_lock(&trace_types_lock);
> -	running = osnoise_busy;
> +	running = osnoise_has_registered_instances();
>  	if (running)
>  		stop_per_cpu_kthreads();
>  
> @@ -1941,8 +2058,6 @@ static int osnoise_workload_start(void)
>  		return retval;
>  	}
>  
> -	osnoise_busy = true;
> -
>  	return 0;
>  }
>  
> @@ -1951,7 +2066,7 @@ static int osnoise_workload_start(void)
>   */
>  static void osnoise_workload_stop(void)
>  {
> -	if (!osnoise_busy)
> +	if (osnoise_has_registered_instances())
>  		return;
>  
>  	trace_osnoise_callback_enabled = false;
> @@ -1962,28 +2077,28 @@ static void osnoise_workload_stop(void)
>  	unhook_irq_events();
>  	unhook_softirq_events();
>  	unhook_thread_events();
> -
> -	osnoise_busy = false;
>  }
>  
>  static void osnoise_tracer_start(struct trace_array *tr)
>  {
>  	int retval;
>  
> -	if (osnoise_busy)
> +	if (osnoise_has_registered_instances())
>  		return;
>  
>  	retval = osnoise_workload_start();
>  	if (retval)
>  		pr_err(BANNER "Error starting osnoise tracer\n");
>  
> +	osnoise_register_instance(tr);
>  }
>  
>  static void osnoise_tracer_stop(struct trace_array *tr)
>  {
> -	if (!osnoise_busy)
> +	if (!osnoise_has_registered_instances())
>  		return;
>  
> +	osnoise_unregister_instance(tr);
>  	osnoise_workload_stop();
>  }
>  
> @@ -1991,14 +2106,12 @@ static int osnoise_tracer_init(struct trace_array *tr)
>  {
>  
>  	/* Only allow one instance to enable this */
> -	if (osnoise_busy)
> +	if (osnoise_has_registered_instances())
>  		return -EBUSY;
>  
> -	osnoise_trace = tr;
>  	tr->max_latency = 0;
>  
>  	osnoise_tracer_start(tr);
> -
>  	return 0;
>  }
>  
> @@ -2022,7 +2135,7 @@ static void timerlat_tracer_start(struct trace_array *tr)
>  {
>  	int retval;
>  
> -	if (osnoise_busy)
> +	if (osnoise_has_registered_instances())
>  		return;
>  
>  	osnoise_data.timerlat_tracer = 1;
> @@ -2031,6 +2144,8 @@ static void timerlat_tracer_start(struct trace_array *tr)
>  	if (retval)
>  		goto out_err;
>  
> +	osnoise_register_instance(tr);
> +
>  	return;
>  out_err:
>  	pr_err(BANNER "Error starting timerlat tracer\n");
> @@ -2040,7 +2155,7 @@ static void timerlat_tracer_stop(struct trace_array *tr)
>  {
>  	int cpu;
>  
> -	if (!osnoise_busy)
> +	if (!osnoise_has_registered_instances())
>  		return;
>  
>  	for_each_online_cpu(cpu)
> @@ -2054,11 +2169,9 @@ static void timerlat_tracer_stop(struct trace_array *tr)
>  static int timerlat_tracer_init(struct trace_array *tr)
>  {
>  	/* Only allow one instance to enable this */
> -	if (osnoise_busy)
> +	if (osnoise_has_registered_instances())
>  		return -EBUSY;
>  
> -	osnoise_trace = tr;
> -
>  	tr->max_latency = 0;
>  
>  	timerlat_tracer_start(tr);
> @@ -2105,6 +2218,8 @@ __init static int init_osnoise_tracer(void)
>  #endif
>  	osnoise_init_hotplug_support();
>  
> +	INIT_LIST_HEAD_RCU(&osnoise_instances);
> +
>  	init_tracefs();
>  
>  	return 0;

