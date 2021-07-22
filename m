Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAD3D1ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 02:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhGVAAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhGVAAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4D306023F;
        Thu, 22 Jul 2021 00:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626914443;
        bh=/f4140xodaIH9QU/S3TCk0cngV5xFL5d2Afc6kU4ubs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FBGDN4CT3CyxNR4+gGSJTIdTr2SOiZcgZTbR1HTDr3/acEollJYNxgL0uoyvYxtvY
         c6qymxeKkogxrTLS+u43KGt7WmbIPtjCLrUqymmXY2jMAzq3xSE+v9mIPQfRJqeEYI
         3kpH3C+YRzOdb9RV0MprsjmlXnA9O98vxQ64meHGyEhZuy72z2BVJ/56eQmUHb86+f
         1oCcinsOTPCOPELBvmk6FUfZKKut3z552vpNYlvQjY25NtTXgRh0qBY5V76avjcpgh
         uQzfaY3maFUvRVqO6uDsI5g1yjqS6trqz4eoDsy7L9cOYbMX/nocXI6bwvGfaRyPKz
         foUbRtm65I5eg==
Date:   Thu, 22 Jul 2021 09:40:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing/histogram: Rename "cpu" to "common_cpu"
Message-Id: <20210722094041.53ef38491d70818310804c90@kernel.org>
In-Reply-To: <20210720233336.72b01525@oasis.local.home>
References: <20210720233336.72b01525@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 23:33:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Currently the histogram logic allows the user to write "cpu" in as an
> event field, and it will record the CPU that the event happened on.
> 
> The problem with this is that there's a lot of events that have "cpu"
> as a real field, and using "cpu" as the CPU it ran on, makes it
> impossible to run histograms on the "cpu" field of events.
> 
> For example, if I want to have a histogram on the count of the
> workqueue_queue_work event on its cpu field, running:
> 
>  ># echo 'hist:keys=cpu' > events/workqueue/workqueue_queue_work/trigger
> 
> Gives a misleading and wrong result.
> 
> Change the command to "common_cpu" as no event should have "common_*"
> fields as that's a reserved name for fields used by all events. And
> this makes sense here as common_cpu would be a field used by all events.
> 
> Now we can even do:
> 
>  ># echo 'hist:keys=common_cpu,cpu if cpu < 100' > events/workqueue/workqueue_queue_work/trigger
>  ># cat events/workqueue/workqueue_queue_work/hist
>  # event histogram
>  #
>  # trigger info: hist:keys=common_cpu,cpu:vals=hitcount:sort=hitcount:size=2048 if cpu < 100 [active]
>  #
> 
>  { common_cpu:          0, cpu:          2 } hitcount:          1
>  { common_cpu:          0, cpu:          4 } hitcount:          1
>  { common_cpu:          7, cpu:          7 } hitcount:          1
>  { common_cpu:          0, cpu:          7 } hitcount:          1
>  { common_cpu:          0, cpu:          1 } hitcount:          1
>  { common_cpu:          0, cpu:          6 } hitcount:          2
>  { common_cpu:          0, cpu:          5 } hitcount:          2
>  { common_cpu:          1, cpu:          1 } hitcount:          4
>  { common_cpu:          6, cpu:          6 } hitcount:          4
>  { common_cpu:          5, cpu:          5 } hitcount:         14
>  { common_cpu:          4, cpu:          4 } hitcount:         26
>  { common_cpu:          0, cpu:          0 } hitcount:         39
>  { common_cpu:          2, cpu:          2 } hitcount:        184
> 
> Now for backward compatibility, I added a trick. If "cpu" is used, and
> the field is not found, it will fall back to "common_cpu" and work as
> it did before. This way, it will still work for old programs that use
> "cpu" to get the actual CPU, but if the event has a "cpu" as a field, it
> will get that event's "cpu" field, which is probably what it wants
> anyway.
> 
> I updated the tracefs/README to include documentation about both the
> common_timestamp and the common_cpu. This way, if that text is present in
> the README, then an application can know that common_cpu is supported over
> just plain "cpu".
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: 8b7622bf94a44 ("tracing: Add cpu field for hist triggers")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since v1:
>    Added the README text about common_cpu and common_timestamp so
>    that user space can know that it is supported.
> 
>  Documentation/trace/histogram.rst |  2 +-
>  kernel/trace/trace.c              |  4 ++++
>  kernel/trace/trace_events_hist.c  | 22 ++++++++++++++++------
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index b71e09f745c3..f99be8062bc8 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -191,7 +191,7 @@ Documentation written by Tom Zanussi
>                                  with the event, in nanoseconds.  May be
>  			        modified by .usecs to have timestamps
>  			        interpreted as microseconds.
> -    cpu                    int  the cpu on which the event occurred.
> +    common_cpu             int  the cpu on which the event occurred.
>      ====================== ==== =======================================
>  
>  Extended error information
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 14f56e9fa001..af77452135ff 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5619,6 +5619,10 @@ static const char readme_msg[] =
>  	"\t            [:name=histname1]\n"
>  	"\t            [:<handler>.<action>]\n"
>  	"\t            [if <filter>]\n\n"
> +	"\t    Note, special fields can be used as well:
> +	"\t            common_timestamp - to record current timestamp\n"
> +	"\t            common_cpu - to record the CPU the event happened on\n"
> +	"\n"
>  	"\t    When a matching event is hit, an entry is added to a hash\n"
>  	"\t    table using the key(s) and value(s) named, and the value of a\n"
>  	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 16a9dfc9fffc..34325f41ebc0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1111,7 +1111,7 @@ static const char *hist_field_name(struct hist_field *field,
>  		 field->flags & HIST_FIELD_FL_ALIAS)
>  		field_name = hist_field_name(field->operands[0], ++level);
>  	else if (field->flags & HIST_FIELD_FL_CPU)
> -		field_name = "cpu";
> +		field_name = "common_cpu";
>  	else if (field->flags & HIST_FIELD_FL_EXPR ||
>  		 field->flags & HIST_FIELD_FL_VAR_REF) {
>  		if (field->system) {
> @@ -1991,14 +1991,24 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
>  		hist_data->enable_timestamps = true;
>  		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
>  			hist_data->attrs->ts_in_usecs = true;
> -	} else if (strcmp(field_name, "cpu") == 0)
> +	} else if (strcmp(field_name, "common_cpu") == 0)
>  		*flags |= HIST_FIELD_FL_CPU;
>  	else {
>  		field = trace_find_event_field(file->event_call, field_name);
>  		if (!field || !field->size) {
> -			hist_err(tr, HIST_ERR_FIELD_NOT_FOUND, errpos(field_name));
> -			field = ERR_PTR(-EINVAL);
> -			goto out;
> +			/*
> +			 * For backward compatibility, if field_name
> +			 * was "cpu", then we treat this the same as
> +			 * common_cpu.
> +			 */
> +			if (strcmp(field_name, "cpu") == 0) {
> +				*flags |= HIST_FIELD_FL_CPU;
> +			} else {
> +				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
> +					 errpos(field_name));
> +				field = ERR_PTR(-EINVAL);
> +				goto out;
> +			}
>  		}
>  	}
>   out:
> @@ -5085,7 +5095,7 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
>  		seq_printf(m, "%s=", hist_field->var.name);
>  
>  	if (hist_field->flags & HIST_FIELD_FL_CPU)
> -		seq_puts(m, "cpu");
> +		seq_puts(m, "common_cpu");
>  	else if (field_name) {
>  		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
>  		    hist_field->flags & HIST_FIELD_FL_ALIAS)
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
