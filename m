Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9833D2F89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 00:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhGVV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhGVV3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A48D60EB4;
        Thu, 22 Jul 2021 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626991790;
        bh=WfWCrb49/Gxb0XralON/gWVqHDOl/urdeKuCJdZ8so4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o//dnAM2OGR5aQxSf4jqMta1UISFSXjbQ/q+oNJvtkvcQn/rUxT9u30tCQgG3kiRs
         v7Bmc3DD5WOE9CKYIBy5pYLCUavfe6l0C8A5/sYVNhISLNEx9X2zx3U3cE/7d2BV3G
         CBqPny4oViTn7tmths1CPxjROKH7AEDZ7u/Qa5VIx/9tK2kSUOLpTIDaP0+T2yu0/q
         QNrXPYilvUzPeBWU1pmQiXWIZcRZ7OQuy0i98Lv9XuP3fQmJapJpyrB1XMLIzMJapF
         h8nfftHuZ/8GSVba2zZvaJZFMg4nTs8/R3VURQelSF0ZVQWOURPVRTzRHhY+2AYa6E
         CHuFbuUeCBO7w==
Message-ID: <6e6917df9be1034ea54c90e10568eefb10d0b395.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jul 2021 17:09:48 -0500
In-Reply-To: <20210722142837.458596338@goodmis.org>
References: <20210722142705.992001628@goodmis.org>
         <20210722142837.458596338@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2021-07-22 at 10:27 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow common_pid.execname to be saved in a variable in one histogram
> to be
> passed to another histogram that can pass it as a parameter to a
> synthetic
> event.
> 
>  ># echo
> 'hist:keys=pid:__arg__1=common_timestamp.usecs:arg2=common_pid.execna
> me' \
>        > events/sched/sched_waking/trigger
>  ># echo 'wakeup_lat s32 pid; u64 delta; char wake_comm[]' >
> synthetic_events
>  ># echo
> 'hist:keys=next_pid:pid=next_pid,delta=common_timestamp.usecs-
> $__arg__1,exec=$arg2'\
> ':onmatch(sched.sched_waking).trace(wakeup_lat,$pid,$delta,$exec)' \
>  > events/sched/sched_switch/trigger
> 
> The above is a wake up latency synthetic event setup that passes the
> execname
> of the common_pid that woke the task to the scheduling of that task,
> which
> triggers a synthetic event that passes the original execname as a
> parameter to display it.
> 
>  ># echo 1 > events/synthetic/enable
>  ># cat trace
>     <idle>-0       [006] d..4   186.863801: wakeup_lat: pid=1306
> delta=65 wake_comm=kworker/u16:3
>     <idle>-0       [000] d..4   186.863858: wakeup_lat: pid=163
> delta=27 wake_comm=<idle>
>     <idle>-0       [001] d..4   186.863903: wakeup_lat: pid=1307
> delta=36 wake_comm=kworker/u16:4
>     <idle>-0       [000] d..4   186.863927: wakeup_lat: pid=163
> delta=5 wake_comm=<idle>
>     <idle>-0       [006] d..4   186.863957: wakeup_lat: pid=1306
> delta=24 wake_comm=kworker/u16:3
>       sshd-1306    [006] d..4   186.864051: wakeup_lat: pid=61
> delta=62 wake_comm=<idle>
>     <idle>-0       [000] d..4   186.965030: wakeup_lat: pid=609
> delta=18 wake_comm=<idle>
>     <idle>-0       [006] d..4   186.987582: wakeup_lat: pid=1306
> delta=65 wake_comm=kworker/u16:3
>     <idle>-0       [000] d..4   186.987639: wakeup_lat: pid=163
> delta=27 wake_comm=<idle>
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 46 +++++++++++++++++++++++++++++-
> --
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 5c9082201bc2..14b840de1326 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1395,17 +1395,17 @@ static int hist_trigger_elt_data_alloc(struct
> tracing_map_elt *elt)
>  	struct hist_trigger_data *hist_data = elt->map->private_data;
>  	unsigned int size = TASK_COMM_LEN;
>  	struct hist_elt_data *elt_data;
> -	struct hist_field *key_field;
> +	struct hist_field *hist_field;
>  	unsigned int i, n_str;
>  
>  	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
>  	if (!elt_data)
>  		return -ENOMEM;
>  
> -	for_each_hist_key_field(i, hist_data) {
> -		key_field = hist_data->fields[i];
> +	for_each_hist_field(i, hist_data) {
> +		hist_field = hist_data->fields[i];
>  
> -		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
> +		if (hist_field->flags & HIST_FIELD_FL_EXECNAME) {
>  			elt_data->comm = kzalloc(size, GFP_KERNEL);
>  			if (!elt_data->comm) {
>  				kfree(elt_data);
> @@ -3703,6 +3703,41 @@ static int create_val_field(struct
> hist_trigger_data *hist_data,
>  	return __create_val_field(hist_data, val_idx, file, NULL,
> field_str, 0);
>  }
>  
> +static const char *no_comm = "(no comm)";
> +
> +static u64 hist_field_execname(struct hist_field *hist_field,
> +			       struct tracing_map_elt *elt,
> +			       struct trace_buffer *buffer,
> +			       struct ring_buffer_event *rbe,
> +			       void *event)
> +{
> +	struct hist_elt_data *elt_data;
> +
> +	if (WARN_ON_ONCE(!elt))
> +		return (u64)(unsigned long)no_comm;
> +
> +	elt_data = elt->private_data;
> +
> +	if (WARN_ON_ONCE(!elt_data->comm))
> +		return (u64)(unsigned long)no_comm;
> +
> +	return (u64)(unsigned long)(elt_data->comm);
> +}
> +
> +/* Convert a var that points to common_pid.execname to a string */
> +static void update_var_execname(struct hist_field *hist_field)
> +{
> +	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
> +		HIST_FIELD_FL_EXECNAME;
> +	hist_field->size = MAX_FILTER_STR_VAL;
> +	hist_field->is_signed = 0;
> +
> +	kfree_const(hist_field->type);
> +	hist_field->type = "char[]";
> +
> +	hist_field->fn = hist_field_execname;
> +}
> +
>  static int create_var_field(struct hist_trigger_data *hist_data,
>  			    unsigned int val_idx,
>  			    struct trace_event_file *file,
> @@ -3727,6 +3762,9 @@ static int create_var_field(struct
> hist_trigger_data *hist_data,
>  
>  	ret = __create_val_field(hist_data, val_idx, file, var_name,
> expr_str, flags);
>  
> +	if (!ret && hist_data->fields[val_idx]->flags &
> HIST_FIELD_FL_EXECNAME)
> +		update_var_execname(hist_data->fields[val_idx]);
> +
>  	if (!ret && hist_data->fields[val_idx]->flags &
> HIST_FIELD_FL_STRING)
>  		hist_data->fields[val_idx]->var_str_idx = hist_data-
> >n_var_str++;
>  

Yeah, the common_pid.execname thing is kind of a strange beast, and I
think this is actually a nice and reasonable way to deal with it for
this case.

Thanks,

Reviewed-by: <zanussi@kernel.org>


