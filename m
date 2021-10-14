Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB642D051
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhJNCXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:23:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EB9C60F93;
        Thu, 14 Oct 2021 02:20:59 +0000 (UTC)
Date:   Wed, 13 Oct 2021 22:20:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, chenhuacai@kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: Add trace any kernel object
Message-ID: <20211013222056.312bec0c@oasis.local.home>
In-Reply-To: <20211014014445.5734-1-xiehuan09@gmail.com>
References: <20211014014445.5734-1-xiehuan09@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added Masami ]

On Thu, 14 Oct 2021 09:44:45 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce a method based on function tracer and kprobe event 
> to trace any object in the linux kernel.

I first want to say that this looks really interesting, and something
that can help out a lot!

That said, we are going to have to work with you to come up with a
better and more flexible interface, and make sure locking and
synchronization works.

> 
> Usage:
> When using the kprobe event, only need to enable trace_object,
> we can trace any function argument or the return value. When 
> the object passes through a function, it can be traced.
> 
> For example:
> 
> For the function bio_add_page, we can trace the first argument:
> 
> int bio_add_page(struct bio *bio, struct page *page,
> 				unsigned int len, unsigned int offset)
> 
> 	#cd /sys/kernel/debug/tracing
> 	#echo 1 > ./trace_object
> 	#echo 'p bio_add_page arg1=$arg1' > kprobe_events 
> 	#echo 1 > ./events/kprobes/p_bio_add_page_0/enable
> 	#sync
> 	#cat ./trace
> 
> 	# tracer: nop
> 	#
> 	# entries-in-buffer/entries-written: 367/367   #P:4
> 	#
> 	#                                _-----=> irqs-off
> 	#                               / _----=> need-resched
> 	#                              | / _---=> hardirq/softirq
> 	#                              || / _--=> preempt-depth
> 	#                              ||| / _-=> migrate-disable
> 	#                              |||| /     delay
> 	#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> 	#              | |         |   |||||     |         |
>     kworker/u8:5-89      [000] .....    60.310385: p_bio_add_page_0: (bio_add_page+0x0/0x90) arg1=0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310386: bio_add_page <-ext4_bio_write_page object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310387: __bio_try_merge_page <-bio_add_page object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310387: __bio_add_page <-bio_add_page object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_io_submit object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_io_submit object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310389: submit_bio_noacct <-ext4_io_submit object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310389: submit_bio_checks <-submit_bio_noacct object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310390: __cond_resched <-submit_bio_checks object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310390: rcu_all_qs <-__cond_resched object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310390: should_fail_bio <-submit_bio_checks object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310391: blk_mq_submit_bio <-submit_bio_noacct object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310392: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310393: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888102bde780
>     kworker/u8:5-89      [000] .....    60.310394: blk_account_io_start <-blk_mq_submit_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311264: bio_advance <-blk_update_request object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311265: bio_endio <-blk_update_request object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311265: ext4_end_bio <-blk_update_request object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311266: ext4_finish_bio <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311274: bio_put <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311274: bio_free <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311274: bio_free <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311274: bvec_free <-bio_free object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311275: mempool_free <-bio_free object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311275: mempool_free_slab <-bio_free object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311275: mempool_free <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311275: mempool_free_slab <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311275: kmem_cache_free <-ext4_end_bio object:0xffff888102bde780
>           <idle>-0       [000] d....    60.311276: kmem_cache_free <-ext4_end_bio object:0xffff888102bde780
>     ...
> 

So if I understand the above, if you set this "trace_object" then
whatever gets placed into a kprobe parameter ($arg1?) or a return value
of a kretprobe, gets traced at every other function call?


> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  include/linux/ftrace.h       |   6 ++
>  kernel/trace/Kconfig         |   7 ++
>  kernel/trace/Makefile        |   1 +
>  kernel/trace/trace.c         |  69 +++++++++++++++++++
>  kernel/trace/trace.h         |   2 +
>  kernel/trace/trace_entries.h |  17 +++++
>  kernel/trace/trace_kprobe.c  |   6 ++
>  kernel/trace/trace_object.c  | 128 +++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.c  |  40 +++++++++++
>  9 files changed, 276 insertions(+)
>  create mode 100644 kernel/trace/trace_object.c
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 832e65f06754..2e097a5fa462 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1078,4 +1078,10 @@ unsigned long arch_syscall_addr(int nr);
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> +#ifdef CONFIG_TRACE_OBJECT
> +int init_trace_object(void);
> +int exit_trace_object(void);
> +void set_trace_object(void *obj);

Add here:

#else
static inline int init_trace_object(void) { return 0; }
static inline int exit_trace_object(void) { return 0; }
static inline void set_trace_object(void *obj) { }

> +#endif

This will allow you to get rid of the ugly "#ifdef"s all over the code
below.

> +
>  #endif /* _LINUX_FTRACE_H */
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 420ff4bc67fd..d302a0f085f9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -237,6 +237,13 @@ config FUNCTION_PROFILER
>  
>  	  If in doubt, say N.
>  
> +config TRACE_OBJECT
> +	bool "Trace kernel object"
> +	depends on FUNCTION_TRACER
> +	default y
> +	help
> +	 This help kernel developer to trace any kernel object.

We'll need to work with you to come up with a better description.

> +
>  config STACK_TRACER
>  	bool "Trace max stack"
>  	depends on HAVE_FUNCTION_TRACER
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 6de5d4d63165..6d9e78a488aa 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
>  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
>  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
>  ifeq ($(CONFIG_BLOCK),y)
>  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
>  endif
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..8069562bfde1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9412,6 +9412,70 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  	mutex_unlock(&event_mutex);
>  }
>  
> +#if defined(CONFIG_TRACE_OBJECT)
> +
> +static DEFINE_MUTEX(trace_object_lock);

You don't want a mutex here. And if possible, we should try to
synchronize this with RCU. But if that can't happen, we need this to be
a raw_spin_lock().

> +static int trace_object_enabled __read_mostly;
> +
> +static ssize_t
> +trace_object_read(struct file *filp, char __user *ubuf,
> +		size_t cnt, loff_t *ppos)
> +{
> +	char buf[64];
> +	int r;
> +
> +	r = sprintf(buf, "%u\n", trace_object_enabled);
> +	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
> +}
> +
> +static ssize_t
> +trace_object_write(struct file *filp, const char __user *ubuf,
> +		size_t cnt, loff_t *ppos)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = !!val;
> +
> +	mutex_lock(&trace_object_lock);
> +	if (trace_object_enabled ^ val) {
> +		if (val) {
> +			ret = init_trace_object();
> +			if (ret < 0) {
> +				cnt = ret;
> +				goto out;
> +			}
> +
> +			trace_object_enabled = 1;
> +		} else {
> +			ret = exit_trace_object();
> +			if (ret < 0) {
> +				cnt = ret;
> +				goto out;
> +			}
> +
> +			trace_object_enabled = 0;
> +		}
> +	}
> +out:
> +	mutex_unlock(&trace_object_lock);
> +	*ppos += cnt;
> +	return cnt;
> +}
> +
> +static const struct file_operations trace_object_fops = {
> +	.open           = tracing_open_generic,
> +	.read           = trace_object_read,
> +	.write          = trace_object_write,
> +	.llseek         = default_llseek,

Honestly, I don't think this should be implemented by a file. What
could work, and Masami let me know your thoughts, is to add something
to the kprobe/uprobe/eprobe interface. That is:

 # echo 'p bio_add_page arg1=$arg1:trace' > kprobe_events 

Or something, that we explicitly set on the kprobe itself, and then we
can pick what we want to trace, especially if we only want to trace
one item in the list.

> +};
> +
> +#endif
> +
>  static void
>  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  {
> @@ -9477,6 +9541,11 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	trace_create_maxlat_file(tr, d_tracer);
>  #endif
>  
> +#if defined(CONFIG_TRACE_OBJECT)
> +	trace_create_file("trace_object", 0644, d_tracer, tr,
> +			&trace_object_fops);
> +#endif
> +
>  	if (ftrace_create_function_files(tr, d_tracer))
>  		MEM_FAIL(1, "Could not allocate function filter files");
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b7c0f8e160fb..bf6bcaa24e1a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -49,6 +49,7 @@ enum trace_type {
>  	TRACE_TIMERLAT,
>  	TRACE_RAW_DATA,
>  	TRACE_FUNC_REPEATS,
> +	TRACE_OBJECT,
>  
>  	__TRACE_LAST_TYPE,
>  };
> @@ -460,6 +461,7 @@ extern void __ftrace_bad_type(void);
>  			  TRACE_GRAPH_RET);		\
>  		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
>  			  TRACE_FUNC_REPEATS);				\
> +		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
>  		__ftrace_bad_type();					\
>  	} while (0)
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index cd41e863b51c..27bababc0ed4 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
>  		 __entry->context,
>  		 __entry->timer_latency)
>  );
> +
> +/*
> + * trace object entry:
> + */
> +FTRACE_ENTRY(object, trace_object_entry,
> +
> +	TRACE_OBJECT,
> +
> +	F_STRUCT(
> +		__field(	unsigned long,		ip		)
> +		__field(	unsigned long,		parent_ip	)
> +		__field(	unsigned long,		object		)
> +	),
> +
> +	F_printk(" %ps <-- %ps object:%lx\n",
> +		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> +);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 3a64ba4bbad6..0d46670702d9 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1341,6 +1341,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  		break;
>  	case FETCH_OP_RETVAL:
>  		val = regs_return_value(regs);
> +#ifdef CONFIG_TRACE_OBJECT
> +		set_trace_object((void *)val);

This can be called from atomic context.
> +#endif
>  		break;
>  	case FETCH_OP_IMM:
>  		val = code->immediate;
> @@ -1354,6 +1357,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>  	case FETCH_OP_ARG:
>  		val = regs_get_kernel_argument(regs, code->param);
> +#ifdef CONFIG_TRACE_OBJECT
> +		set_trace_object((void *)val);
> +#endif
>  		break;
>  #endif
>  	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
> diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> new file mode 100644
> index 000000000000..eb8edfebecee
> --- /dev/null
> +++ b/kernel/trace/trace_object.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * trace any object
> + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "trace_object: " fmt
> +
> +#include "trace_output.h"
> +
> +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> +static DEFINE_MUTEX(object_mutex_lock);
> +static struct trace_event_file event_trace_file;
> +
> +#define MAX_TRACE_OBJ_NUM 1024
> +static unsigned long *global_trace_obj;
> +static int global_trace_count;
> +static const int max_args_num = 6;
> +
> +void set_trace_object(void *obj)
> +{
> +	int i;
> +
> +	if (!obj || global_trace_count == MAX_TRACE_OBJ_NUM)
> +		goto out;
> +
> +	for (i = 0; i < global_trace_count; i++) {
> +		if (global_trace_obj[i] == (unsigned long)obj)
> +			goto out;
> +	}
> +	mutex_lock(&object_mutex_lock);

As stated above, this can be called from atomic context, and you can't
have a mutex here.

> +
> +	global_trace_obj[global_trace_count++] = (unsigned long)obj;
> +
> +	mutex_unlock(&object_mutex_lock);
> +out:
> +	return;
> +}
> +
> +static void submit_trace_object(unsigned long ip, unsigned long
> parent_ip,
> +				 unsigned long object)
> +{
> +
> +	struct trace_buffer *buffer;
> +	struct ring_buffer_event *event;
> +	struct trace_object_entry *entry;
> +	int pc;
> +
> +	pc = preempt_count();
> +	event = trace_event_buffer_lock_reserve(&buffer,
> &event_trace_file,
> +			TRACE_OBJECT, sizeof(*entry), pc);
> +	if (!event)
> +		return;
> +	entry   = ring_buffer_event_data(event);
> +	entry->ip                       = ip;
> +	entry->parent_ip                = parent_ip;
> +	entry->object			= object;
> +
> +	event_trigger_unlock_commit(&event_trace_file, buffer, event,
> +		entry, pc);
> +}
> +
> +static void
> +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> +		struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> +	unsigned long object;
> +	long disabled;
> +	int cpu, n, i;
> +
> +	preempt_disable_notrace();
> +
> +	cpu = raw_smp_processor_id();
> +	disabled =
> atomic_inc_return(&per_cpu(trace_object_event_disable, cpu)); +
> +	if (disabled != 1)
> +		goto out;
> +
> +	if (!global_trace_obj[0])
> +		goto out;
> +
> +	for (n = 0; n < max_args_num; n++) {
> +		object = regs_get_kernel_argument(pt_regs, n);
> +		for (i = 0; i < global_trace_count; i++) {
> +			if (object == global_trace_obj[i])
> +				submit_trace_object(ip, parent_ip,
> object);

I'm thinking we could possibly, make this a single event, with dynamic
arrays.

> +		}
> +	}
> +out:
> +	atomic_dec(&per_cpu(trace_object_event_disable, cpu));
> +	preempt_enable_notrace();
> +}
> +
> +static struct ftrace_ops trace_ops = {
> +	.func  = trace_object_events_call,
> +	.flags = FTRACE_OPS_FL_SAVE_REGS,
> +};
> +
> +int init_trace_object(void)
> +{
> +	int ret;
> +
> +	event_trace_file.tr = top_trace_array();
> +	if (WARN_ON(!event_trace_file.tr))
> +		return -1;
> +
> +	global_trace_obj = kzalloc(sizeof(unsigned long) * MAX_TRACE_OBJ_NUM,
> +				GFP_KERNEL);
> +	if (!global_trace_obj)
> +		return -ENOMEM;
> +
> +	ret = register_ftrace_function(&trace_ops);
> +
> +	return ret;
> +}
> +
> +int exit_trace_object(void)
> +{
> +	int ret;
> +
> +	ret = unregister_ftrace_function(&trace_ops);
> +
> +	kfree(global_trace_obj);
> +	return ret;
> +}
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index c2ca40e8595b..21a9c8737929 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1552,6 +1552,45 @@ static struct trace_event trace_func_repeats_event = {
>  	.funcs		= &trace_func_repeats_funcs,
>  };
>  
> +/* TRACE_OBJECT */
> +static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
> +					struct trace_event *event)
> +{
> +	struct trace_object_entry *field;
> +	struct trace_seq *s = &iter->seq;
> +
> +	trace_assign_type(field, iter->ent);
> +	print_fn_trace(s, field->ip, field->parent_ip, flags);
> +	trace_seq_printf(s, " object:0x%lx", field->object);
> +	trace_seq_putc(s, '\n');
> +
> +	return trace_handle_return(s);
> +}
> +
> +static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
> +				      struct trace_event *event)
> +{
> +	struct trace_object_entry *field;
> +
> +	trace_assign_type(field, iter->ent);
> +
> +	trace_seq_printf(&iter->seq, "%lx %lx\n",
> +			 field->ip,
> +			 field->parent_ip);
> +
> +	return trace_handle_return(&iter->seq);
> +}
> +
> +static struct trace_event_functions trace_object_funcs = {
> +	.trace		= trace_object_print,
> +	.raw		= trace_object_raw,
> +};
> +
> +static struct trace_event trace_object_event = {
> +	.type		= TRACE_OBJECT,
> +	.funcs		= &trace_object_funcs,
> +};
> +
>  static struct trace_event *events[] __initdata = {
>  	&trace_fn_event,
>  	&trace_ctx_event,
> @@ -1566,6 +1605,7 @@ static struct trace_event *events[] __initdata = {
>  	&trace_timerlat_event,
>  	&trace_raw_data_event,
>  	&trace_func_repeats_event,
> +	&trace_object_event,
>  	NULL
>  };
>  

So in conclusion, I really like this idea. Now we need to help you
clean it up, and make a proper interface and something that is flexible
as well.

Looking forward to working with you more on this.

Cheers,

-- Steve
