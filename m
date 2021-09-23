Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0997415A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhIWI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:59:16 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43699 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239137AbhIWI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:59:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UpJJrJO_1632387460;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UpJJrJO_1632387460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 16:57:42 +0800
Subject: Re: [RFC PATCH] trace: prevent preemption in
 perf_ftrace_function_call()
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
Message-ID: <f2159a81-66e4-ca2d-d9d2-e024040cf271@linux.alibaba.com>
Date:   Thu, 23 Sep 2021 16:57:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Abaci <abaci@linux.alibaba.com>

On 2021/9/23 上午11:42, 王贇 wrote:
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
> 
