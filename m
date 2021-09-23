Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA46A416002
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbhIWNfe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Sep 2021 09:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241205AbhIWNfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:35:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BB56115A;
        Thu, 23 Sep 2021 13:34:00 +0000 (UTC)
Date:   Thu, 23 Sep 2021 09:33:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <20210923093359.30da8ba6@gandalf.local.home>
In-Reply-To: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
References: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 11:42:56 +0800
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
>    __text_poke+0x5/0x620
>    text_poke_bp_batch+0x9f/0x310
> 
> This tell us the CPU could be changed after task is preempted, and
> the checking on CPU before preemption is helpless.
> 
> This patch just turn off preemption in perf_ftrace_function_call()
> to prevent CPU changing.
> 
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/trace/trace_event_perf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 6aed10e..5486b18 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -438,15 +438,17 @@ void perf_trace_buf_update(void *record, u16 type)
>  	int rctx;
>  	int bit;
> 
> +	preempt_disable_notrace();
> +
>  	if (!rcu_is_watching())
> -		return;
> +		goto out;

You don't need preemption disabled for the above check. It's better to
disable it here and leave the above return untouched.

-- Steve

> 
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
> @@ -468,16 +470,18 @@ void perf_trace_buf_update(void *record, u16 type)
> 
>  	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
>  	if (!entry)
> -		goto out;
> +		goto out_unlock;
> 
>  	entry->ip = ip;
>  	entry->parent_ip = parent_ip;
>  	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
>  			      1, &regs, &head, NULL);
> 
> -out:
> +out_unlock:
>  	ftrace_test_recursion_unlock(bit);
>  #undef ENTRY_SIZE
> +out:
> +	preempt_enable_notrace();
>  }
> 
>  static int perf_ftrace_function_register(struct perf_event *event)

