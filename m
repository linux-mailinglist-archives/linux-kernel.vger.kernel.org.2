Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBA457031
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKSOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235173AbhKSOEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:04:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF4F560EAF;
        Fri, 19 Nov 2021 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637330482;
        bh=ZFFhBqFQ0dxA1iW0ZK53vHsp4PUpjVnMspzKf8PSyYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tm96WI34mBLJKPVdYsy+/nbWPhlCde/gxkkAAGDiktHMI2Zc3XBwD914y3WwpqF3i
         tvjrg531qTfMyTsWsMXGG+hYwmnhOKN8A6t47t3BruT+8Mni5RA7ZEJMCP7m9dTG/d
         jHiBb7Hzdszbidg2moG9JnFlRzliyExVQmbvg2aNA1txD+2j55fBQvDVV8qAUGp44M
         XcRus+J2RYI8bvxCwWroWUVVX3Wn/tCyuBOPcgMu6bGbAob0jkCGd0aYhCCFSYCMv0
         CtZz2QXdCO9kbmEcL9vl9EO7eGgoW7JP7uidMf1LPjqZMvcfaSzOxc6aMMSxFA31Re
         WfRohod9jdIiw==
Date:   Fri, 19 Nov 2021 23:01:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v5 2/4] trace/objtrace: get the value of the object
Message-Id: <20211119230118.2f8689d630817cb103161402@kernel.org>
In-Reply-To: <20211113120632.94754-2-xiehuan09@gmail.com>
References: <20211113120632.94754-1-xiehuan09@gmail.com>
        <20211113120632.94754-2-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat, 13 Nov 2021 20:06:30 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

Please describe here what feature this patch adds.
How to use, and new syntax, etc.

BTW, the syntax for this value trace is a bit confusing.

objtrace:add:OFFS(OBJ):TYPE[:COUNT]

This trace "OBJ", but from the user point of view, this seems to trace
"OFFS(OBJ)".

I rather like make it optional and split from OBJ as below;

objtrace:add:OBJ[,OFFS:TYPE][:COUNT]

(Note that the part braced by [] is optional.)

Thank you,

> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  kernel/trace/trace_entries.h |   5 +-
>  kernel/trace/trace_object.c  | 121 +++++++++++++++++++++++++++++------
>  kernel/trace/trace_output.c  |   6 +-
>  3 files changed, 107 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index bb120d9498a9..2407c45a568c 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
>  		__field(	unsigned long,		ip		)
>  		__field(	unsigned long,		parent_ip	)
>  		__field(	unsigned long,		object		)
> +		__field(	unsigned long,		value		)
>  	),
>  
> -	F_printk(" %ps <-- %ps object:%lx\n",
> -		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> +	F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__entry->ip,
> +	       (void *)__entry->parent_ip, __entry->object, __entry->value)
>  );
> diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> index 69465c2ffb7e..14993f7d0e5a 100644
> --- a/kernel/trace/trace_object.c
> +++ b/kernel/trace/trace_object.c
> @@ -11,14 +11,25 @@
>  
>  static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
>  static struct trace_event_file event_trace_file;
> -static const int max_args_num = 6;
>  static const int max_obj_pool = 10;
>  static atomic_t trace_object_ref;
>  static int exit_trace_object(void);
>  static int init_trace_object(void);
>  
> +struct objtrace_trigger_data {
> +	struct ftrace_event_field *field;
> +	long offset;
> +	int type_size;
> +};
> +
> +struct objtrace_fetch_type {
> +	char *name;
> +	int type_size;
> +};
> +
>  struct object_instance {
>  	void *object;
> +	int obj_type_size;
>  	struct freelist_node freelist;
>  };
>  
> @@ -59,8 +70,7 @@ static bool object_empty(void)
>  	return ret;
>  }
>  
> -
> -static void set_trace_object(void *obj)
> +static void set_trace_object(void *obj, int type_size)
>  {
>  	struct freelist_node *fn;
>  	struct object_instance *ins;
> @@ -79,6 +89,7 @@ static void set_trace_object(void *obj)
>  
>  	ins = container_of(fn, struct object_instance, freelist);
>  	ins->object = obj;
> +	ins->obj_type_size = type_size;
>  
>  	freelist_add(&ins->freelist, &obj_pool->customer_freelist);
>  	atomic_inc(&obj_pool->nobject);
> @@ -135,7 +146,7 @@ static int init_object_pool(void)
>  }
>  
>  static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> -				 unsigned long object)
> +				 unsigned long object, unsigned long value)
>  {
>  
>  	struct trace_buffer *buffer;
> @@ -152,6 +163,7 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
>  	entry->ip                       = ip;
>  	entry->parent_ip                = parent_ip;
>  	entry->object			= object;
> +	entry->value			= value;
>  
>  	event_trigger_unlock_commit(&event_trace_file, buffer, event,
>  		entry, pc);
> @@ -161,10 +173,11 @@ static void
>  trace_object_events_call(unsigned long ip, unsigned long parent_ip,
>  		struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> -	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> -	unsigned long obj;
> +	struct freelist_node *node;
> +	struct object_instance *inst;
> +	unsigned long val = 0;
>  	long disabled;
> -	int cpu, n;
> +	int cpu;
>  
>  	preempt_disable_notrace();
>  
> @@ -177,10 +190,14 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
>  	if (object_empty())
>  		goto out;
>  
> -	for (n = 0; n < max_args_num; n++) {
> -		obj = regs_get_kernel_argument(pt_regs, n);
> -		if (object_exist((void *)obj))
> -			submit_trace_object(ip, parent_ip, obj);
> +	node = obj_pool->customer_freelist.head;
> +
> +	while (node) {
> +		inst = container_of(node, struct object_instance, freelist);
> +		if (copy_from_kernel_nofault(&val, inst->object, inst->obj_type_size))
> +			goto out;
> +		submit_trace_object(ip, parent_ip, (unsigned long)inst->object, val);
> +		node = node->next;
>  	}
>  
>  out:
> @@ -198,12 +215,14 @@ trace_object_trigger(struct event_trigger_data *data,
>  		   struct trace_buffer *buffer,  void *rec,
>  		   struct ring_buffer_event *event)
>  {
> +	struct objtrace_trigger_data *obj_data = data->private_data;
> +	struct ftrace_event_field *field;
> +	void *obj, *val = NULL;
>  
> -	struct ftrace_event_field *field = data->private_data;
> -	void *obj = NULL;
> -
> -	memcpy(&obj, rec + field->offset, sizeof(obj));
> -	set_trace_object(obj);
> +	field = obj_data->field;
> +	memcpy(&val, rec + field->offset, sizeof(val));
> +	obj = val + obj_data->offset;
> +	set_trace_object(obj, obj_data->type_size);
>  }
>  
>  static void
> @@ -350,6 +369,22 @@ static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
>  	}
>  }
>  
> +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> +	{"u8", 1},
> +	{"s8", 1},
> +	{"x8", 1},
> +	{"u16", 2},
> +	{"s16", 2},
> +	{"x16", 2},
> +	{"u32", 4},
> +	{"s32", 4},
> +	{"x32", 4},
> +	{"u64", 8},
> +	{"s64", 8},
> +	{"x64", 8},
> +	{}
> +};
> +
>  static int
>  event_object_trigger_callback(struct event_command *cmd_ops,
>  		       struct trace_event_file *file,
> @@ -357,13 +392,15 @@ event_object_trigger_callback(struct event_command *cmd_ops,
>  {
>  	struct event_trigger_data *trigger_data;
>  	struct event_trigger_ops *trigger_ops;
> +	struct objtrace_trigger_data *obj_data;
>  	struct trace_event_call *call;
>  	struct ftrace_event_field *field;
>  	char *objtrace_cmd;
> +	long offset = 0;
>  	char *trigger = NULL;
> -	char *arg;
> +	char *arg, *type, *tr, *tr_end;
>  	char *number;
> -	int ret;
> +	int ret, i, type_size = 0;
>  
>  	ret = -EINVAL;
>  	if (!param)
> @@ -386,6 +423,38 @@ event_object_trigger_callback(struct event_command *cmd_ops,
>  	arg = strsep(&trigger, ":");
>  	if (!arg)
>  		goto out;
> +
> +	tr = strchr(arg, '(');
> +	/* now force to get the value of the val. */
> +	if (!tr)
> +		goto out;
> +	tr_end = strchr(tr, ')');
> +	if (!tr_end)
> +		goto out;
> +	*tr++ = '\0';
> +	*tr_end = '\0';
> +	ret = kstrtol(arg, 0, &offset);
> +	if (ret)
> +		goto out;
> +	arg = tr;
> +	ret = -EINVAL;
> +	if (!trigger)
> +		goto out;
> +
> +	type = strsep(&trigger, ":");
> +	if (!type)
> +		goto out;
> +	for (i = 0; objtrace_fetch_types[i].name; i++) {
> +		if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
> +			type_size = objtrace_fetch_types[i].type_size;
> +			break;
> +		}
> +	}
> +
> +	if (type_size == 0)
> +		goto out;
> +
> +
>  	call = file->event_call;
>  	field = trace_find_event_field(call, arg);
>  	if (!field)
> @@ -394,19 +463,30 @@ event_object_trigger_callback(struct event_command *cmd_ops,
>  	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
>  
>  	ret = -ENOMEM;
> +	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> +	if (!obj_data)
> +		goto out;
> +
> +	obj_data->field = field;
> +	obj_data->offset = offset;
> +	obj_data->type_size = type_size;
> +
>  	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> -	if (!trigger_data)
> +	if (!trigger_data) {
> +		kfree(obj_data);
>  		goto out;
> +	}
>  
>  	trigger_data->count = -1;
>  	trigger_data->ops = trigger_ops;
>  	trigger_data->cmd_ops = cmd_ops;
> -	trigger_data->private_data = field;
> +	trigger_data->private_data = obj_data;
>  	INIT_LIST_HEAD(&trigger_data->list);
>  	INIT_LIST_HEAD(&trigger_data->named_list);
>  
>  	if (glob[0] == '!') {
>  		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
> +		kfree(obj_data);
>  		kfree(trigger_data);
>  		ret = 0;
>  		goto out;
> @@ -461,6 +541,7 @@ event_object_trigger_callback(struct event_command *cmd_ops,
>   out_free:
>  	if (cmd_ops->set_filter)
>  		cmd_ops->set_filter(NULL, trigger_data, NULL);
> +	kfree(obj_data);
>  	kfree(trigger_data);
>  	goto out;
>  }
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 76ca560af693..c8c427c23127 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1562,6 +1562,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
>  	trace_assign_type(field, iter->ent);
>  	print_fn_trace(s, field->ip, field->parent_ip, flags);
>  	trace_seq_printf(s, " object:0x%lx", field->object);
> +	trace_seq_printf(s, " value:0x%lx", field->value);
>  	trace_seq_putc(s, '\n');
>  
>  	return trace_handle_return(s);
> @@ -1574,9 +1575,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	trace_seq_printf(&iter->seq, "%lx %lx\n",
> -			 field->ip,
> -			 field->parent_ip);
> +	trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip,
> +			field->parent_ip, field->object, field->value);
>  
>  	return trace_handle_return(&iter->seq);
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
