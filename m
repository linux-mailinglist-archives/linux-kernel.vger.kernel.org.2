Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A76427479
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbhJIAFc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Oct 2021 20:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243797AbhJIAFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:05:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7275060FC1;
        Sat,  9 Oct 2021 00:03:35 +0000 (UTC)
Date:   Fri, 8 Oct 2021 20:03:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <20211008200328.5b88422d@oasis.local.home>
In-Reply-To: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 11:12:24 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> With CONFIG_DEBUG_PREEMPT we observed reports like:
> 
>   BUG: using smp_processor_id() in preemptible
>   caller is perf_ftrace_function_call+0x6f/0x2e0
>   CPU: 1 PID: 680 Comm: a.out Not tainted
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x8d/0xcf
>    check_preemption_disabled+0x104/0x110
>    ? optimize_nops.isra.7+0x230/0x230
>    ? text_poke_bp_batch+0x9f/0x310
>    perf_ftrace_function_call+0x6f/0x2e0
>    ...

It would be useful to see the full backtrace, to know how this
happened. Please do not shorten back traces.

-- Steve

>    __text_poke+0x5/0x620
>    text_poke_bp_batch+0x9f/0x310
> 
> This telling us the CPU could be changed after task is preempted, and
> the checking on CPU before preemption will be invalid.
> 
> This patch just turn off preemption in perf_ftrace_function_call()
> to prevent CPU changing.
> 
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/trace/trace_event_perf.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 6aed10e..dcbefdf 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -441,12 +441,19 @@ void perf_trace_buf_update(void *record, u16 type)
>  	if (!rcu_is_watching())
>  		return;
> 
> +	/*
> +	 * Prevent CPU changing from now on. rcu must
> +	 * be in watching if the task was migrated and
> +	 * scheduled.
> +	 */
> +	preempt_disable_notrace();
> +
>  	if ((unsigned long)ops->private != smp_processor_id())
> -		return;
> +		goto out;
> 
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
> -		return;
> +		goto out;
> 
>  	event = container_of(ops, struct perf_event, ftrace_ops);
> 
> @@ -468,16 +475,18 @@ void perf_trace_buf_update(void *record, u16 type)
> 
>  	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
>  	if (!entry)
> -		goto out;
> +		goto unlock;
> 
>  	entry->ip = ip;
>  	entry->parent_ip = parent_ip;
>  	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
>  			      1, &regs, &head, NULL);
> 
> -out:
> +unlock:
>  	ftrace_test_recursion_unlock(bit);
>  #undef ENTRY_SIZE
> +out:
> +	preempt_enable_notrace();
>  }
> 
>  static int perf_ftrace_function_register(struct perf_event *event)

