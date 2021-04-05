Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5A35488E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhDEWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236113AbhDEWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:15:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3897D613D6;
        Mon,  5 Apr 2021 22:15:29 +0000 (UTC)
Date:   Mon, 5 Apr 2021 18:15:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v2 4/5] tracing: Unify the logic for function tracing
 options
Message-ID: <20210405181525.0d4a724e@gandalf.local.home>
In-Reply-To: <20210329130533.199507-5-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
        <20210329130533.199507-5-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:05:32 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> Currently the logic for dealing with the options for function tracing
> has two different implementations. One is used when we set the flags
> (in "static int func_set_flag()") and another used when we initialize
> the tracer (in "static int function_trace_init()"). Those two
> implementations are meant to do essentially the same thing and they
> are both not very convenient for adding new options. In this patch
> we add a helper function that provides a single implementation of
> the logic for dealing with the options and we make it such that new
> options can be easily added.
> 
> Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
> ---
>  kernel/trace/trace_functions.c | 66 ++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index f93723ca66bc..6c912eb0508a 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -27,13 +27,17 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  static void
>  function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  			  struct ftrace_ops *op, struct ftrace_regs *fregs);
> +static ftrace_func_t select_trace_function(u32 flags_val);
>  static struct tracer_flags func_flags;
>  
>  /* Our option */
>  enum {
> +	TRACE_FUNC_NO_OPTS	= 0x0, /* No flags set. */
>  	TRACE_FUNC_OPT_STACK	= 0x1,
>  };
>  
> +#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_STACK)
> +
>  int ftrace_allocate_ftrace_ops(struct trace_array *tr)
>  {
>  	struct ftrace_ops *ops;
> @@ -97,12 +101,9 @@ static int function_trace_init(struct trace_array *tr)
>  	if (!tr->ops)
>  		return -ENOMEM;
>  
> -	/* Currently only the global instance can do stack tracing */
> -	if (tr->flags & TRACE_ARRAY_FL_GLOBAL &&
> -	    func_flags.val & TRACE_FUNC_OPT_STACK)
> -		func = function_stack_trace_call;
> -	else
> -		func = function_trace_call;
> +	func = select_trace_function(func_flags.val);
> +	if (!func)
> +		return -EINVAL;
>  
>  	ftrace_init_array_ops(tr, func);
>  
> @@ -205,6 +206,18 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  	local_irq_restore(flags);
>  }
>  
> +static ftrace_func_t select_trace_function(u32 flags_val)
> +{
> +	switch (flags_val & TRACE_FUNC_OPT_MASK) {
> +	case TRACE_FUNC_NO_OPTS:
> +		return function_trace_call;
> +	case TRACE_FUNC_OPT_STACK:
> +		return function_stack_trace_call;
> +	default:
> +		return NULL;
> +	}
> +}

Is there a reason why you defined this function here and not before its
first use? When defining functions, I tend to try to define them before
their first use to not need to declare the static prototype above.

The reasons for doing the static prototype and using a static function is
usually because of #ifdef around the first use, and keeping the function
from being hidden by the #ifdef, or the static function already exists, and
then gets used in a function before it, where it's just easier to add the
static declaration than moving the function.


> +
>  static struct tracer_opt func_opts[] = {
>  #ifdef CONFIG_STACKTRACE
>  	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
> @@ -213,7 +226,7 @@ static struct tracer_opt func_opts[] = {
>  };
>  
>  static struct tracer_flags func_flags = {
> -	.val = 0, /* By default: all flags disabled */
> +	.val = TRACE_FUNC_NO_OPTS, /* By default: all flags disabled */
>  	.opts = func_opts
>  };
>  
> @@ -235,30 +248,31 @@ static struct tracer function_trace;
>  static int
>  func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
>  {
> -	switch (bit) {
> -	case TRACE_FUNC_OPT_STACK:
> -		/* do nothing if already set */
> -		if (!!set == !!(func_flags.val & TRACE_FUNC_OPT_STACK))
> -			break;
> +	ftrace_func_t func;
> +	u32 new_flags_val;

Nit, but the variable should just be "new_flags", which is consistent with
old_flags. In the kernel we don't need to the variable names to be so
verbose.

>  
> -		/* We can change this flag when not running. */
> -		if (tr->current_trace != &function_trace)
> -			break;
> +	/* Do nothing if already set. */
> +	if (!!set == !!(func_flags.val & bit))
> +		return 0;
>  
> -		unregister_ftrace_function(tr->ops);
> +	/* We can change this flag only when not running. */
> +	if (tr->current_trace != &function_trace)
> +		return 0;
>  
> -		if (set) {
> -			tr->ops->func = function_stack_trace_call;
> -			register_ftrace_function(tr->ops);
> -		} else {
> -			tr->ops->func = function_trace_call;
> -			register_ftrace_function(tr->ops);
> -		}
> +	new_flags_val = (func_flags.val & ~(1UL << (bit - 1)));
> +	new_flags_val |= (set << (bit - 1));

bit is already the mask, no need to shift it, nor there's no reason for the
extra set of parenthesis. And the above can be done in one line.

	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);

-- Steve


>  
> -		break;
> -	default:
> +	func = select_trace_function(new_flags_val);
> +	if (!func)
>  		return -EINVAL;
> -	}
> +
> +	/* Check if there's anything to change. */
> +	if (tr->ops->func == func)
> +		return 0;
> +
> +	unregister_ftrace_function(tr->ops);
> +	tr->ops->func = func;
> +	register_ftrace_function(tr->ops);
>  
>  	return 0;
>  }

