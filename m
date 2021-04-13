Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72435E6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbhDMTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhDMTR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:17:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48ADC613C4;
        Tue, 13 Apr 2021 19:17:38 +0000 (UTC)
Date:   Tue, 13 Apr 2021 15:17:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v3 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210413151736.36ec77eb@gandalf.local.home>
In-Reply-To: <20210409181031.26772-2-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
        <20210409181031.26772-2-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 21:10:27 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> ---
>  kernel/trace/trace.h         |  3 +++
>  kernel/trace/trace_entries.h | 22 +++++++++++++++++
>  kernel/trace/trace_output.c  | 47 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
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
> index 4547ac59da61..fdd022a7aecf 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -338,3 +338,25 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>  		 __entry->nmi_total_ts,
>  		 __entry->nmi_count)
>  );
> +
> +#define FUNC_REPEATS_GET_DELTA_TS(entry)			\
> +(((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)	\
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

Running this with trace-cmd record, this displays:

          <idle>-0     [001]   261.848848: function:                            next_zone
          <idle>-0     [001]   261.848849: func_repeats:          next_zone <-need_update       (repeats:3  delta_ts: -189)

Which is confusing in a number of ways.

1. It would be better to have it be the actual timestamp of the last repeat.
   But that can be done in a trace-cmd plugin (like the function trace has).

2. It should be "delta_ns:" because it is not -189 from the timestamp, as
   the above time stamp is truncated to microseconds and this is not
   obvious to the user.


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

Here there's no reason to have either of the above issues.
We should show the timestamp of the last event.

	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
	trace_print_time(s, iter,
			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
	trace_seq_puts(s, ")\n");

Where we can add another patch to create the trace_print_time() that
uses the code from trace_print_context().

static void trace_print_time(struct trace_seq *s, struct trace_iterator *iter,
			     unsigned long long ts)
{
	unsigned long secs, usec_rem;
	unsigned long long t;

	if (iter->iter_flags & TRACE_FILE_TIME_IN_NS) {
		t = ns2usecs(iter->ts);
		usec_rem = do_div(t, USEC_PER_SEC);
		secs = (unsigned long)t;
		trace_seq_printf(s, " %5lu.%06lu: ", secs, usec_rem);
	} else
		trace_seq_printf(s, " %12llu: ", iter->ts);
}

And we may need to do something interesting if this is a latency format as
well. But we can add that another day.

-- Steve

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

