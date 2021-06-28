Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F03B664B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhF1QA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhF1QA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F5FD61A0F;
        Mon, 28 Jun 2021 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624895882;
        bh=csP55REVlUAszW4MM0vqV/RVMhEoLkY4GQk44xF0Zb4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hwInxAlGUv+JI7nc/C7vs+08Ff7D6oZT6QjWfoZaGFRFjpk5y+H4scf8qnBSk4wwv
         g+LZoaBcRcOGoyEsshQAagPv6XFLoIAosy9vSA2Hnz5c2RJae51IdJbPNgEWAZUi8R
         pp8/rY2Y9un7Rog1ra3zgjxbHHI35B5MCum+pBhsTCYYX51iQe2qhPw+jKQCiWCCh0
         mkvz0tJ58SOyFaWfDx4aYRTZtfajPfZbAylsKTw7H4KLI2mzh8UlPVqnWNQ0Pqx111
         TQGqYJj9ZlNZ5dA/okKOTfmOD5NPmZnLML7SrlwI44KYQNm8N04KI3FF8nOQMXl0Iq
         uijBm5Ffq2B0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14C9E5C065A; Mon, 28 Jun 2021 08:58:02 -0700 (PDT)
Date:   Mon, 28 Jun 2021 08:58:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracing: Have osnoise_main() add a quiescent state for
 task rcu
Message-ID: <20210628155802.GH4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210628114953.6dc06a91@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628114953.6dc06a91@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:49:53AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> ftracetest triggered:
> 
>  INFO: rcu_tasks detected stalls on tasks:
>  00000000b92b832d: .. nvcsw: 1/1 holdout: 1 idle_cpu: -1/7
>  task:osnoise/7       state:R  running task     stack:    0 pid: 2133 ppid:     2 flags:0x00004000
>  Call Trace:
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? trace_hardirqs_on+0x2b/0xe0
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? trace_clock_local+0xc/0x20
>   ? osnoise_main+0x10e/0x450
>   ? trace_softirq_entry_callback+0x50/0x50
>   ? kthread+0x153/0x170
>   ? __kthread_bind_mask+0x60/0x60
>   ? ret_from_fork+0x22/0x30
> 
> While running osnoise tracer with other tracers that rely on
> synchronize_rcu_tasks(), where that just hung.
> 
> The reason is that osnoise_main() never schedules out if the interval
> is less than 1, and this will cause synchronize_rcu_tasks() to never
> return.
> 
> Fixes: bce29ac9ce0bb ("trace: Add osnoise tracer")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

That looks like something I would do!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/trace/trace_osnoise.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 38aa5e208ffd..556d530af805 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1216,8 +1216,11 @@ static int osnoise_main(void *data)
>  		 * differently from hwlat_detector, the osnoise tracer can run
>  		 * without a pause because preemption is on.
>  		 */
> -		if (interval < 1)
> +		if (interval < 1) {
> +			/* Let synchronize_rcu_tasks() make progress */
> +			cond_resched_tasks_rcu_qs();
>  			continue;
> +		}
>  
>  		if (msleep_interruptible(interval))
>  			break;
> -- 
> 2.29.2
> 
