Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE09354826
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhDEV2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232853AbhDEV2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:28:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D772A613C3;
        Mon,  5 Apr 2021 21:28:40 +0000 (UTC)
Date:   Mon, 5 Apr 2021 17:28:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v2 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210405172839.0dca7fe8@gandalf.local.home>
In-Reply-To: <20210329130533.199507-2-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
        <20210329130533.199507-2-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:05:29 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> The event aims to consolidate the function tracing record in the cases
> when a single function is called number of times consecutively.
> 
> 	while (cond)
> 		do_func();
> 
> This may happen in various scenarios (busy waiting for example).
> The new ftrace event can be used to show repeated function events with
> a single event and save space on the ring buffer
> 
> Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
> ---
>  kernel/trace/trace.h         |  3 +++
>  kernel/trace/trace_entries.h | 39 ++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.c  | 47 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5506424eae2a..6a5b4c2a0fa7 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -45,6 +45,7 @@ enum trace_type {
>  	TRACE_BPUTS,
>  	TRACE_HWLAT,
>  	TRACE_RAW_DATA,
> +	TRACE_FUNC_REPEATS,
>  
>  	__TRACE_LAST_TYPE,
>  };
> @@ -442,6 +443,8 @@ extern void __ftrace_bad_type(void);
>  			  TRACE_GRAPH_ENT);		\
>  		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
>  			  TRACE_GRAPH_RET);		\
> +		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
> +			  TRACE_FUNC_REPEATS);				\
>  		__ftrace_bad_type();					\
>  	} while (0)
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 4547ac59da61..6f98c3b4e4fa 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -338,3 +338,42 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>  		 __entry->nmi_total_ts,
>  		 __entry->nmi_count)
>  );
> +
> +#define FUNC_REPEATS_GET_DELTA_TS(entry)					\
> +(((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)			\
> +
> +#define FUNC_REPEATS_SET_DELTA_TS(entry, delta)					\

Hmm, this isn't used anywhere. Why is it defined here?

> +	do {									\
> +		if (likely(!((u64)delta >> 32))) {				\

If statements are more expensive than shifts and masks, thus, this first if
statement isn't needed. Because:

	entry->bottom_delta_ts = delta & U32_MAX;
	entry->top_delta_ts = (delta >> 32);

Would produce the same faster as this conditional, but be generally faster.


> +			entry->bottom_delta_ts = delta;				\
> +			entry->top_delta_ts = 0;				\
> +		} else {							\
> +			if (likely(!((u64)delta >> 48))) {			\
> +				entry->bottom_delta_ts = delta & U32_MAX;	\
> +				entry->top_delta_ts = (delta >> 32);		\
> +			} else {						\
> +				/* Timestamp overflow. Set to max. */		\
> +				entry->bottom_delta_ts = U32_MAX;		\
> +				entry->top_delta_ts = U16_MAX;			\

I'm almost thinking we should just ignore this as it should never happen,
because 2^48 nanoseconds is 78 hours. If we are repeating the same function
over and over again for over 78 hours, we have more issues to worry about
;-)

-- Steve

> +			}							\
> +		}								\
> +	} while (0);								\
> +
> +FTRACE_ENTRY(func_repeats, func_repeats_entry,
> +
> +	TRACE_FUNC_REPEATS,
> +
> +	F_STRUCT(
> +		__field(	unsigned long,	ip		)
> +		__field(	unsigned long,	parent_ip	)
> +		__field(	u16	,	count		)
> +		__field(	u16	,	top_delta_ts	)
> +		__field(	u32	,	bottom_delta_ts	)
> +	),
> +
> +	F_printk(" %ps <-%ps\t(repeats:%u  delta_ts: -%llu)",
> +		 (void *)__entry->ip,
> +		 (void *)__entry->parent_ip,
> +		 __entry->count,
> +		 FUNC_REPEATS_GET_DELTA_TS(__entry))
> +);
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index a0146e1fffdf..55b08e146afc 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1373,6 +1373,52 @@ static struct trace_event trace_raw_data_event = {
>  	.funcs		= &trace_raw_data_funcs,
>  };
>  
> +static enum print_line_t
> +trace_func_repeats_raw(struct trace_iterator *iter, int flags,
> +			 struct trace_event *event)
> +{
> +	struct func_repeats_entry *field;
> +	struct trace_seq *s = &iter->seq;
> +
> +	trace_assign_type(field, iter->ent);
> +
> +	trace_seq_printf(s, "%lu %lu %u %llu\n",
> +			 field->ip,
> +			 field->parent_ip,
> +			 field->count,
> +			 FUNC_REPEATS_GET_DELTA_TS(field));
> +
> +	return trace_handle_return(s);
> +}
> +
> +static enum print_line_t
> +trace_func_repeats_print(struct trace_iterator *iter, int flags,
> +			 struct trace_event *event)
> +{
> +	struct func_repeats_entry *field;
> +	struct trace_seq *s = &iter->seq;
> +
> +	trace_assign_type(field, iter->ent);
> +
> +	seq_print_ip_sym(s, field->ip, flags);
> +	trace_seq_puts(s, " <-");
> +	seq_print_ip_sym(s, field->parent_ip, flags);
> +	trace_seq_printf(s, " (repeats: %u, delta_ts: -%llu)\n",
> +			 field->count,
> +			 FUNC_REPEATS_GET_DELTA_TS(field));
> +
> +	return trace_handle_return(s);
> +}
> +
> +static struct trace_event_functions trace_func_repeats_funcs = {
> +	.trace		= trace_func_repeats_print,
> +	.raw		= trace_func_repeats_raw,
> +};
> +
> +static struct trace_event trace_func_repeats_event = {
> +	.type	 	= TRACE_FUNC_REPEATS,
> +	.funcs		= &trace_func_repeats_funcs,
> +};
>  
>  static struct trace_event *events[] __initdata = {
>  	&trace_fn_event,
> @@ -1385,6 +1431,7 @@ static struct trace_event *events[] __initdata = {
>  	&trace_print_event,
>  	&trace_hwlat_event,
>  	&trace_raw_data_event,
> +	&trace_func_repeats_event,
>  	NULL
>  };
>  

