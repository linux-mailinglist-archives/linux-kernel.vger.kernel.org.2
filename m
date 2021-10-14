Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93C042D0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNDEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJNDEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFB4C61039;
        Thu, 14 Oct 2021 03:02:02 +0000 (UTC)
Date:   Wed, 13 Oct 2021 23:02:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: save cmdline only when task does not exist in
 savecmd for optimization
Message-ID: <20211013230201.0f777564@oasis.local.home>
In-Reply-To: <20211011115018.88948-1-yangjihong1@huawei.com>
References: <20211011115018.88948-1-yangjihong1@huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 19:50:18 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
> on ARM64 machine, this commit causes performance degradation.
> 
> For the task that already exists in savecmd, it is unnecessary to call
> set_cmdline to execute strncpy once, run set_cmdline only if the task does
> not exist in savecmd.
> 
> I have written an example (which is an extreme case) in which trace sched switch
> is invoked for 1000 times, as shown in the following:
> 
>   for (int i = 0; i < 1000; i++) {
>           trace_sched_switch(true, current, current);
>  }

Well that's a pretty non realistic benchmark.

> 
> On ARM64 machine, compare the data before and after the optimization:
> +---------------------+------------------------------+------------------------+
> |                     | Total number of instructions | Total number of cycles |
> +---------------------+------------------------------+------------------------+
> | Before optimization |           1107367            |          658491        |
> +---------------------+------------------------------+------------------------+
> | After optimization  |            869367            |          520171        |
> +---------------------+------------------------------+------------------------+
> As shown above, there is nearly 26% performance

I'd prefer to see a more realistic benchmark.

> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/trace/trace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..a795610a3b37 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2427,8 +2427,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
>  		savedcmd->cmdline_idx = idx;
>  	}
>  
> -	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
> -	set_cmdline(idx, tsk->comm);
> +	/* save cmdline only when task does not exist in savecmd */
> +	if (savedcmd->map_cmdline_to_pid[idx] != tsk->pid) {
> +		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
> +		set_cmdline(idx, tsk->comm);
> +	}

I'm not against adding this. Just for kicks I ran the following before
and after this patch:

  # trace-cmd start -e sched
  # perf stat -r 100 hackbench 50

Before:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

          6,261.26 msec task-clock                #    6.126 CPUs utilized            ( +-  0.12% )
            93,519      context-switches          #   14.936 K/sec                    ( +-  1.12% )
            13,725      cpu-migrations            #    2.192 K/sec                    ( +-  1.16% )
            47,266      page-faults               #    7.549 K/sec                    ( +-  0.54% )
    22,911,885,026      cycles                    #    3.659 GHz                      ( +-  0.11% )
    15,171,250,777      stalled-cycles-frontend   #   66.22% frontend cycles idle     ( +-  0.13% )
    18,330,841,604      instructions              #    0.80  insn per cycle
                                                  #    0.83  stalled cycles per insn  ( +-  0.11% )
     4,027,904,559      branches                  #  643.306 M/sec                    ( +-  0.11% )
        31,327,782      branch-misses             #    0.78% of all branches          ( +-  0.20% )

           1.02201 +- 0.00158 seconds time elapsed  ( +-  0.15% )
After:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

          6,216.47 msec task-clock                #    6.124 CPUs utilized            ( +-  0.10% )
            93,311      context-switches          #   15.010 K/sec                    ( +-  0.91% )
            13,719      cpu-migrations            #    2.207 K/sec                    ( +-  1.09% )
            47,085      page-faults               #    7.574 K/sec                    ( +-  0.49% )
    22,746,703,318      cycles                    #    3.659 GHz                      ( +-  0.09% )
    15,012,911,121      stalled-cycles-frontend   #   66.00% frontend cycles idle     ( +-  0.11% )
    18,275,147,949      instructions              #    0.80  insn per cycle
                                                  #    0.82  stalled cycles per insn  ( +-  0.08% )
     4,017,673,788      branches                  #  646.295 M/sec                    ( +-  0.08% )
        31,313,459      branch-misses             #    0.78% of all branches          ( +-  0.17% )

           1.01506 +- 0.00150 seconds time elapsed  ( +-  0.15% )

Really it's all in the noise, so adding this doesn't seem to hurt.

-- Steve



>  
>  	arch_spin_unlock(&trace_cmdline_lock);
>  

