Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5052318B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhBKMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBKMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:33:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB116C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:31:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so3308054pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=V7tyMuY/5KEo5pXTOshCcdQyTqF3+HT5Y6mFI4N/U9c=;
        b=VzdEl4o2hwPvMjH0S3Vsw808S+CscxtoCEfTj9XJfB7yjyiMt6sfGA1cFzbC8PcSXi
         pKDd34NCszzBIDQYWrNvKKwLeRERBPz22vW5vlCsD45BoWlZfBG6TbFhKlAsLvG9BACm
         7x4L3lTYW+Yq44C881IXkb1TSrXzNCPEm2ZyhHN+Iu7FerPs7CykKeA5b/NI5A/gCUDn
         O+btfJpCTqjdCcOs6fh9L1f1VBFYh81oRokcHGcvqUyqKATt44ucjXgs+MQtPSBTrsG0
         po8KNi7V6/s60xK5dEsxklaFA2JcQng0cIH2Wz2/+XGgflTh6q6ETQBcp3LjGJ6fFVvW
         7O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=V7tyMuY/5KEo5pXTOshCcdQyTqF3+HT5Y6mFI4N/U9c=;
        b=mxkMWXLp0qQxCDrW22RdYqEy5bDwlo5K2UVrIoJm8O4MxawiUMJLy3wukwSFwwJan9
         ERfNb7JE5zLWEW6sxrN4ACSNywZy8JkNA+vQFMIzmNSC5bxou1WAA7+1Ofl0+zWrUrMN
         IGu60M/Gozpz7AFf6fZ7hIwPv27aMcg2jVnUdJqoY4AfbTLAsLbWiqka7hsqMAGjxDhz
         VLodAcR573oonOFUk7ZSbtn39OvH+qWa840psiy5I1BYaj4sPM0ZaeAKbSF8IECZQUiz
         u9ms4/CuA3pmiikEPwmRMMOa+4eDdmdtNq1f2EpFfWon4vCUNa8SVdI+dguk+dYBjweS
         VadA==
X-Gm-Message-State: AOAM5324k0Ro7VnREQYEQg8xn2cXXTvVdBAInlTgrgI0Ei4Yx8LTXX2y
        4rZgrbPNA2zBRzlSNhcbzvMyIl9X2eQOeQ==
X-Google-Smtp-Source: ABdhPJyXmCwFGHVhBQfHpdEKOYicI+2J54gJjaE/ej8txlEZUuRHwyD8NlUmgsnKTbMHaSXze42eeA==
X-Received: by 2002:a17:902:a5c9:b029:e0:8ef:1633 with SMTP id t9-20020a170902a5c9b02900e008ef1633mr7517298plq.13.1613046685239;
        Thu, 11 Feb 2021 04:31:25 -0800 (PST)
Received: from [10.255.35.32] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id y14sm5441682pjg.52.2021.02.11.04.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 04:31:24 -0800 (PST)
Subject: Re: [External] Re: [PATCH] psi: Use ONCPU state tracking machinery to
 detect reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210210040605.38973-1-zhouchengming@bytedance.com>
 <YCRD+IkZNPkOtNYz@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <40e0cd03-4c97-86f6-0b79-c1b212f9c0dd@bytedance.com>
Date:   Thu, 11 Feb 2021 20:31:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCRD+IkZNPkOtNYz@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

在 2021/2/11 上午4:37, Johannes Weiner 写道:
> On Wed, Feb 10, 2021 at 12:06:05PM +0800, Chengming Zhou wrote:
>> Move the reclaim detection from the timer tick to the task state
>> tracking machinery using the recently added ONCPU state. And we
>> also add memstall state changes checking in the psi_task_switch()
>> optimization to update the parents properly.
>>
>> Thanks to Johannes Weiner for pointing out the psi_task_switch()
>> optimization things and the clearer changelog.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Thanks for the update, Chengming.
>
> It would be good to include a rationale in the changelog that explains
> why we're doing this. Performance and cost are a bit questionable, IMO
> because it doesn't look cheaper in aggregate...

Yes, there maybe not obvious win in terms of performance and cost. But I think

the statistical time maybe a little more acurrate and the code become fewer. : )

>> ---
>>  include/linux/psi.h  |  1 -
>>  kernel/sched/core.c  |  1 -
>>  kernel/sched/psi.c   | 52 ++++++++++++++++------------------------------------
>>  kernel/sched/stats.h |  9 ---------
>>  4 files changed, 16 insertions(+), 47 deletions(-)
> ...but the code is simpler and shorter this way: fewer lines, and
> we're removing one of the hooks into the scheduler. So it's a
> maintainability win, I would say.
>
> I did some testing with perf bench. The new code appears to have
> slightly more overhead (which is expected), although the error bars
> overlap to a point where I don't think it would matter on real loads.
>
> I tested an additional version of the code that adds unlikely()
> annotations to move the pressure state branches out of line - since
> they are after all exceptional situations. It seems to help -
> especially the pipe bench actually looks better than on vanilla.

Thank you so much for these tests. I didn't go that far and learned that unlikely()

can be used like this.

> Attached the incremental patch below.
>
> ---
>
> perf stat -r 3 -- perf sched bench messaging -l 10000
>
> vanilla
>         125,833.65 msec task-clock:u              #   22.102 CPUs utilized            ( +-  1.94% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>             69,526      page-faults:u             #    0.553 K/sec                    ( +-  0.79% )
>      8,189,667,649      cycles:u                  #    0.065 GHz                      ( +-  1.49% )  (83.31%)
>      2,184,284,296      stalled-cycles-frontend:u #   26.67% frontend cycles idle     ( +-  4.37% )  (83.32%)
>      1,152,703,719      stalled-cycles-backend:u  #   14.08% backend cycles idle      ( +-  0.56% )  (83.37%)
>      2,483,312,679      instructions:u            #    0.30  insn per cycle         
>                                                   #    0.88  stalled cycles per insn  ( +-  0.15% )  (83.33%)
>        781,332,174      branches:u                #    6.209 M/sec                    ( +-  0.13% )  (83.35%)
>        159,531,476      branch-misses:u           #   20.42% of all branches          ( +-  0.17% )  (83.32%)
>
>             5.6933 +- 0.0911 seconds time elapsed  ( +-  1.60% )
>
> patched
>         129,756.92 msec task-clock:u              #   22.243 CPUs utilized            ( +-  1.92% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>             69,904      page-faults:u             #    0.539 K/sec                    ( +-  0.67% )
>      8,518,161,670      cycles:u                  #    0.066 GHz                      ( +-  2.19% )  (83.30%)
>      2,337,165,666      stalled-cycles-frontend:u #   27.44% frontend cycles idle     ( +-  5.47% )  (83.32%)
>      1,148,789,343      stalled-cycles-backend:u  #   13.49% backend cycles idle      ( +-  0.05% )  (83.35%)
>      2,483,527,911      instructions:u            #    0.29  insn per cycle         
>                                                   #    0.94  stalled cycles per insn  ( +-  0.18% )  (83.38%)
>        782,138,388      branches:u                #    6.028 M/sec                    ( +-  0.09% )  (83.33%)
>        160,131,311      branch-misses:u           #   20.47% of all branches          ( +-  0.16% )  (83.31%)
>
>              5.834 +- 0.106 seconds time elapsed  ( +-  1.81% )
>
> patched-unlikely
>         127,437.78 msec task-clock:u              #   22.184 CPUs utilized            ( +-  0.74% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>             70,063      page-faults:u             #    0.550 K/sec                    ( +-  0.53% )
>      8,453,581,973      cycles:u                  #    0.066 GHz                      ( +-  1.49% )  (83.34%)
>      2,327,192,242      stalled-cycles-frontend:u #   27.53% frontend cycles idle     ( +-  2.43% )  (83.32%)
>      1,146,196,558      stalled-cycles-backend:u  #   13.56% backend cycles idle      ( +-  0.35% )  (83.34%)
>      2,486,920,732      instructions:u            #    0.29  insn per cycle         
>                                                   #    0.94  stalled cycles per insn  ( +-  0.10% )  (83.34%)
>        781,067,666      branches:u                #    6.129 M/sec                    ( +-  0.15% )  (83.34%)
>        160,104,212      branch-misses:u           #   20.50% of all branches          ( +-  0.10% )  (83.33%)
>
>             5.7446 +- 0.0418 seconds time elapsed  ( +-  0.73% )
>
> ---
>
> perf stat -r 3 -- perf bench sched pipe
>
> vanilla
>          14,086.14 msec task-clock:u              #    1.009 CPUs utilized            ( +-  6.52% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>              1,467      page-faults:u             #    0.104 K/sec                    ( +-  0.06% )
>        306,181,835      cycles:u                  #    0.022 GHz                      ( +-  2.13% )  (83.41%)
>         43,975,811      stalled-cycles-frontend:u #   14.36% frontend cycles idle     ( +- 14.45% )  (83.05%)
>         52,429,386      stalled-cycles-backend:u  #   17.12% backend cycles idle      ( +-  0.28% )  (83.58%)
>         93,097,176      instructions:u            #    0.30  insn per cycle         
>                                                   #    0.56  stalled cycles per insn  ( +-  0.36% )  (83.23%)
>         35,351,661      branches:u                #    2.510 M/sec                    ( +-  0.21% )  (83.37%)
>          6,124,932      branch-misses:u           #   17.33% of all branches          ( +-  0.51% )  (83.36%)
>
>             13.955 +- 0.164 seconds time elapsed  ( +-  1.17% )
>
> patched
>          14,574.69 msec task-clock:u              #    1.040 CPUs utilized            ( +-  0.87% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>              1,469      page-faults:u             #    0.101 K/sec                    ( +-  0.13% )
>        302,769,739      cycles:u                  #    0.021 GHz                      ( +-  1.19% )  (83.17%)
>         37,638,522      stalled-cycles-frontend:u #   12.43% frontend cycles idle     ( +-  0.31% )  (83.47%)
>         46,206,055      stalled-cycles-backend:u  #   15.26% backend cycles idle      ( +-  6.56% )  (83.34%)
>         92,566,358      instructions:u            #    0.31  insn per cycle         
>                                                   #    0.50  stalled cycles per insn  ( +-  0.51% )  (83.45%)
>         35,667,707      branches:u                #    2.447 M/sec                    ( +-  0.67% )  (83.23%)
>          6,224,587      branch-misses:u           #   17.45% of all branches          ( +-  2.24% )  (83.35%)
>
>             14.010 +- 0.245 seconds time elapsed  ( +-  1.75% )
>
> patched-unlikely
>          13,470.99 msec task-clock:u              #    1.024 CPUs utilized            ( +-  3.10% )
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>              1,477      page-faults:u             #    0.110 K/sec                    ( +-  0.09% )
>        310,752,740      cycles:u                  #    0.023 GHz                      ( +-  1.32% )  (83.35%)
>         44,894,078      stalled-cycles-frontend:u #   14.45% frontend cycles idle     ( +- 13.24% )  (83.47%)
>         52,540,903      stalled-cycles-backend:u  #   16.91% backend cycles idle      ( +-  0.36% )  (82.96%)
>         92,296,178      instructions:u            #    0.30  insn per cycle         
>                                                   #    0.57  stalled cycles per insn  ( +-  0.48% )  (83.44%)
>         35,316,802      branches:u                #    2.622 M/sec                    ( +-  0.06% )  (83.32%)
>          6,173,049      branch-misses:u           #   17.48% of all branches          ( +-  0.66% )  (83.47%)
>
>             13.161 +- 0.293 seconds time elapsed  ( +-  2.22% )
>
>> @@ -833,7 +827,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		 */
>>  		iter = NULL;
>>  		while ((group = iterate_groups(next, &iter))) {
>> -			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
>> +			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU] &&
>> +			    next->in_memstall == prev->in_memstall) {
>>  				common = group;
>>  				break;
> It'd be better to compare psi_flags instead of just in_memstall: it's
> clearer and also more robust against future changes (even though it's
> somewhat unlikely we grow more states). It's also an invariant
> throughout the loop, so we should move it out.
Ok, make sense a lot.
>
> The comment above the loop is now stale too.
>
> Can you fold the following into your patch?

Of course, I will take the following and send a patch-v2 for more review.

Thank you.

>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 8735d5f291dc..6d4a246ef131 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -809,18 +809,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  	void *iter;
>  
>  	if (next->pid) {
> +		bool identical_state;
> +
>  		psi_flags_change(next, 0, TSK_ONCPU);
>  		/*
> -		 * When moving state between tasks, the group that
> -		 * contains them both does not change: we can stop
> -		 * updating the tree once we reach the first common
> -		 * ancestor. Iterate @next's ancestors until we
> -		 * encounter @prev's state.
> +		 * When switching between tasks that have an identical
> +		 * runtime state, the cgroup that contains both tasks
> +		 * does not change: we can stop updating the tree once
> +		 * we reach the first common ancestor. Iterate @next's
> +		 * ancestors only until we encounter @prev's ONCPU.
>  		 */
> +		identical_state = prev->psi_flags == next->psi_flags;
>  		iter = NULL;
>  		while ((group = iterate_groups(next, &iter))) {
> -			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU] &&
> -			    next->in_memstall == prev->in_memstall) {
> +			if (identical_state &&
> +			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
>  				common = group;
>  				break;
>  			}
>
> Otherwise, this looks good to me. Peter, what do you think?
>
> ---
>
> From cf36f1dde714a2c543f5947e47138de32468f33a Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 10 Feb 2021 13:38:34 -0500
> Subject: [PATCH] psi: pressure states are unlikely
>
> Move the unlikely branches out of line. This eliminates undesirable
> jumps during wakeup and sleeps for workloads that aren't under any
> sort of resource pressure.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 8735d5f291dc..7fbacd6347a6 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -216,15 +216,15 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
>  {
>  	switch (state) {
>  	case PSI_IO_SOME:
> -		return tasks[NR_IOWAIT];
> +		return unlikely(tasks[NR_IOWAIT]);
>  	case PSI_IO_FULL:
> -		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
> +		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
>  	case PSI_MEM_SOME:
> -		return tasks[NR_MEMSTALL];
> +		return unlikely(tasks[NR_MEMSTALL]);
>  	case PSI_MEM_FULL:
> -		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
> +		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
>  	case PSI_CPU_SOME:
> -		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
> +		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
>  	case PSI_NONIDLE:
>  		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
>  			tasks[NR_RUNNING];
> @@ -721,7 +721,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  	 * task in a cgroup is in_memstall, the corresponding groupc
>  	 * on that cpu is in PSI_MEM_FULL state.
>  	 */
> -	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
> +	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
>  		state_mask |= (1 << PSI_MEM_FULL);
>  
>  	groupc->state_mask = state_mask;
