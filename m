Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C531717C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBJUiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBJUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:37:54 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F735C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:37:14 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id t18so1537171qvn.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bEoZ/pXpY1TgLGjif5eniysDe73VRnFXIAq3oTYPFBo=;
        b=s0wQX/oDmdF0xaGsx/wUB+gEkEHWO0pgT5HDmcxVR9IbmuCYY0u2aIkvea0S+Cs2g9
         04HLTzAcQgfmoTCBh2sR9I7c4++7wkSiGmCMt7LPfzuCp3eH/DiGnpV/6B9N7XoI2/Xm
         HxWWOrLjFfKDIUW4rdCg1bk7xbDAZDBb+ahPhMuhl6ZZucWcWBF92oWJ+N3ci1fzkbRG
         741oDdSCoU/wyl0RxB6eug1EiglZUtBppE2KDBhSab6AcN6P4OBfJ66mV3xxrflKCf+u
         4laWJTsnvRCRrfZn+84nmvv+9kIkt1bgS5PFK5HZuC7EHF1vYHLfjSoPbRcp1k2qt+T7
         ECLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bEoZ/pXpY1TgLGjif5eniysDe73VRnFXIAq3oTYPFBo=;
        b=N8J5lWVVEn/0NaotYStq1tyRal1gMhqu39g5J9nWoaaUwPyCovAbvkg6Gt+fGmx+GG
         b0k787QoQZhh1LfmT/UZlFbJF2vY17m8qZvL8cBPGG5SEyq4UrctQOZkWswo++DJWwTx
         H222wSKbnattzTua0Tfdv498UzZWYQ1KslfooI4g2V+uCcG6DVWrgsRHjZhJ3MvghMp+
         iXC6AdRDfe60bZvrnBEiDAuySuUfEuDqw53jjmX+xi1r9bJW+BM5+8cCrbdi9FBldjFH
         /SqrfDTs72WT+LWCTZxNZL1T/RhXoI+c4EAWrxfPjVnbiKfkX/DpCJd4v2/TKmA+9yUc
         LuXA==
X-Gm-Message-State: AOAM532N/cR/t7YSBAeaWN2H2In6PD5mk2KYHGzoF+uvgtMhk+cInZQh
        Rw6ZKK3ck0FUvgX9idC0pPwJIw==
X-Google-Smtp-Source: ABdhPJxT+R7ggBXisDGZZ/AHJAkQfVdbfP2CBQemQP5Np/3I45+aJcZ6xB76kj3kWFWkxMghsU+j/A==
X-Received: by 2002:a05:6214:148a:: with SMTP id bn10mr4644078qvb.52.1612989433678;
        Wed, 10 Feb 2021 12:37:13 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k8sm2289298qkk.79.2021.02.10.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:37:12 -0800 (PST)
Date:   Wed, 10 Feb 2021 15:37:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH] psi: Use ONCPU state tracking machinery to detect reclaim
Message-ID: <YCRD+IkZNPkOtNYz@cmpxchg.org>
References: <20210210040605.38973-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210040605.38973-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:06:05PM +0800, Chengming Zhou wrote:
> Move the reclaim detection from the timer tick to the task state
> tracking machinery using the recently added ONCPU state. And we
> also add memstall state changes checking in the psi_task_switch()
> optimization to update the parents properly.
> 
> Thanks to Johannes Weiner for pointing out the psi_task_switch()
> optimization things and the clearer changelog.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks for the update, Chengming.

It would be good to include a rationale in the changelog that explains
why we're doing this. Performance and cost are a bit questionable, IMO
because it doesn't look cheaper in aggregate...

> ---
>  include/linux/psi.h  |  1 -
>  kernel/sched/core.c  |  1 -
>  kernel/sched/psi.c   | 52 ++++++++++++++++------------------------------------
>  kernel/sched/stats.h |  9 ---------
>  4 files changed, 16 insertions(+), 47 deletions(-)

...but the code is simpler and shorter this way: fewer lines, and
we're removing one of the hooks into the scheduler. So it's a
maintainability win, I would say.

I did some testing with perf bench. The new code appears to have
slightly more overhead (which is expected), although the error bars
overlap to a point where I don't think it would matter on real loads.

I tested an additional version of the code that adds unlikely()
annotations to move the pressure state branches out of line - since
they are after all exceptional situations. It seems to help -
especially the pipe bench actually looks better than on vanilla.

Attached the incremental patch below.

---

perf stat -r 3 -- perf sched bench messaging -l 10000

vanilla
        125,833.65 msec task-clock:u              #   22.102 CPUs utilized            ( +-  1.94% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
            69,526      page-faults:u             #    0.553 K/sec                    ( +-  0.79% )
     8,189,667,649      cycles:u                  #    0.065 GHz                      ( +-  1.49% )  (83.31%)
     2,184,284,296      stalled-cycles-frontend:u #   26.67% frontend cycles idle     ( +-  4.37% )  (83.32%)
     1,152,703,719      stalled-cycles-backend:u  #   14.08% backend cycles idle      ( +-  0.56% )  (83.37%)
     2,483,312,679      instructions:u            #    0.30  insn per cycle         
                                                  #    0.88  stalled cycles per insn  ( +-  0.15% )  (83.33%)
       781,332,174      branches:u                #    6.209 M/sec                    ( +-  0.13% )  (83.35%)
       159,531,476      branch-misses:u           #   20.42% of all branches          ( +-  0.17% )  (83.32%)

            5.6933 +- 0.0911 seconds time elapsed  ( +-  1.60% )

patched
        129,756.92 msec task-clock:u              #   22.243 CPUs utilized            ( +-  1.92% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
            69,904      page-faults:u             #    0.539 K/sec                    ( +-  0.67% )
     8,518,161,670      cycles:u                  #    0.066 GHz                      ( +-  2.19% )  (83.30%)
     2,337,165,666      stalled-cycles-frontend:u #   27.44% frontend cycles idle     ( +-  5.47% )  (83.32%)
     1,148,789,343      stalled-cycles-backend:u  #   13.49% backend cycles idle      ( +-  0.05% )  (83.35%)
     2,483,527,911      instructions:u            #    0.29  insn per cycle         
                                                  #    0.94  stalled cycles per insn  ( +-  0.18% )  (83.38%)
       782,138,388      branches:u                #    6.028 M/sec                    ( +-  0.09% )  (83.33%)
       160,131,311      branch-misses:u           #   20.47% of all branches          ( +-  0.16% )  (83.31%)

             5.834 +- 0.106 seconds time elapsed  ( +-  1.81% )

patched-unlikely
        127,437.78 msec task-clock:u              #   22.184 CPUs utilized            ( +-  0.74% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
            70,063      page-faults:u             #    0.550 K/sec                    ( +-  0.53% )
     8,453,581,973      cycles:u                  #    0.066 GHz                      ( +-  1.49% )  (83.34%)
     2,327,192,242      stalled-cycles-frontend:u #   27.53% frontend cycles idle     ( +-  2.43% )  (83.32%)
     1,146,196,558      stalled-cycles-backend:u  #   13.56% backend cycles idle      ( +-  0.35% )  (83.34%)
     2,486,920,732      instructions:u            #    0.29  insn per cycle         
                                                  #    0.94  stalled cycles per insn  ( +-  0.10% )  (83.34%)
       781,067,666      branches:u                #    6.129 M/sec                    ( +-  0.15% )  (83.34%)
       160,104,212      branch-misses:u           #   20.50% of all branches          ( +-  0.10% )  (83.33%)

            5.7446 +- 0.0418 seconds time elapsed  ( +-  0.73% )

---

perf stat -r 3 -- perf bench sched pipe

vanilla
         14,086.14 msec task-clock:u              #    1.009 CPUs utilized            ( +-  6.52% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
             1,467      page-faults:u             #    0.104 K/sec                    ( +-  0.06% )
       306,181,835      cycles:u                  #    0.022 GHz                      ( +-  2.13% )  (83.41%)
        43,975,811      stalled-cycles-frontend:u #   14.36% frontend cycles idle     ( +- 14.45% )  (83.05%)
        52,429,386      stalled-cycles-backend:u  #   17.12% backend cycles idle      ( +-  0.28% )  (83.58%)
        93,097,176      instructions:u            #    0.30  insn per cycle         
                                                  #    0.56  stalled cycles per insn  ( +-  0.36% )  (83.23%)
        35,351,661      branches:u                #    2.510 M/sec                    ( +-  0.21% )  (83.37%)
         6,124,932      branch-misses:u           #   17.33% of all branches          ( +-  0.51% )  (83.36%)

            13.955 +- 0.164 seconds time elapsed  ( +-  1.17% )

patched
         14,574.69 msec task-clock:u              #    1.040 CPUs utilized            ( +-  0.87% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
             1,469      page-faults:u             #    0.101 K/sec                    ( +-  0.13% )
       302,769,739      cycles:u                  #    0.021 GHz                      ( +-  1.19% )  (83.17%)
        37,638,522      stalled-cycles-frontend:u #   12.43% frontend cycles idle     ( +-  0.31% )  (83.47%)
        46,206,055      stalled-cycles-backend:u  #   15.26% backend cycles idle      ( +-  6.56% )  (83.34%)
        92,566,358      instructions:u            #    0.31  insn per cycle         
                                                  #    0.50  stalled cycles per insn  ( +-  0.51% )  (83.45%)
        35,667,707      branches:u                #    2.447 M/sec                    ( +-  0.67% )  (83.23%)
         6,224,587      branch-misses:u           #   17.45% of all branches          ( +-  2.24% )  (83.35%)

            14.010 +- 0.245 seconds time elapsed  ( +-  1.75% )

patched-unlikely
         13,470.99 msec task-clock:u              #    1.024 CPUs utilized            ( +-  3.10% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
             1,477      page-faults:u             #    0.110 K/sec                    ( +-  0.09% )
       310,752,740      cycles:u                  #    0.023 GHz                      ( +-  1.32% )  (83.35%)
        44,894,078      stalled-cycles-frontend:u #   14.45% frontend cycles idle     ( +- 13.24% )  (83.47%)
        52,540,903      stalled-cycles-backend:u  #   16.91% backend cycles idle      ( +-  0.36% )  (82.96%)
        92,296,178      instructions:u            #    0.30  insn per cycle         
                                                  #    0.57  stalled cycles per insn  ( +-  0.48% )  (83.44%)
        35,316,802      branches:u                #    2.622 M/sec                    ( +-  0.06% )  (83.32%)
         6,173,049      branch-misses:u           #   17.48% of all branches          ( +-  0.66% )  (83.47%)

            13.161 +- 0.293 seconds time elapsed  ( +-  2.22% )

> @@ -833,7 +827,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		 */
>  		iter = NULL;
>  		while ((group = iterate_groups(next, &iter))) {
> -			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
> +			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU] &&
> +			    next->in_memstall == prev->in_memstall) {
>  				common = group;
>  				break;

It'd be better to compare psi_flags instead of just in_memstall: it's
clearer and also more robust against future changes (even though it's
somewhat unlikely we grow more states). It's also an invariant
throughout the loop, so we should move it out.

The comment above the loop is now stale too.

Can you fold the following into your patch?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8735d5f291dc..6d4a246ef131 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -809,18 +809,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	void *iter;
 
 	if (next->pid) {
+		bool identical_state;
+
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
-		 * When moving state between tasks, the group that
-		 * contains them both does not change: we can stop
-		 * updating the tree once we reach the first common
-		 * ancestor. Iterate @next's ancestors until we
-		 * encounter @prev's state.
+		 * When switching between tasks that have an identical
+		 * runtime state, the cgroup that contains both tasks
+		 * does not change: we can stop updating the tree once
+		 * we reach the first common ancestor. Iterate @next's
+		 * ancestors only until we encounter @prev's ONCPU.
 		 */
+		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU] &&
-			    next->in_memstall == prev->in_memstall) {
+			if (identical_state &&
+			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}

Otherwise, this looks good to me. Peter, what do you think?

---

From cf36f1dde714a2c543f5947e47138de32468f33a Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 10 Feb 2021 13:38:34 -0500
Subject: [PATCH] psi: pressure states are unlikely

Move the unlikely branches out of line. This eliminates undesirable
jumps during wakeup and sleeps for workloads that aren't under any
sort of resource pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8735d5f291dc..7fbacd6347a6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -216,15 +216,15 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 {
 	switch (state) {
 	case PSI_IO_SOME:
-		return tasks[NR_IOWAIT];
+		return unlikely(tasks[NR_IOWAIT]);
 	case PSI_IO_FULL:
-		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
 	case PSI_MEM_SOME:
-		return tasks[NR_MEMSTALL];
+		return unlikely(tasks[NR_MEMSTALL]);
 	case PSI_MEM_FULL:
-		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
+		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -721,7 +721,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * task in a cgroup is in_memstall, the corresponding groupc
 	 * on that cpu is in PSI_MEM_FULL state.
 	 */
-	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
+	if (unlikely(groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
 	groupc->state_mask = state_mask;
-- 
2.30.0

