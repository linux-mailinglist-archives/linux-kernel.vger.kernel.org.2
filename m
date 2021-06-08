Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55639F906
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhFHO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:27:54 -0400
Received: from foss.arm.com ([217.140.110.172]:60288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233220AbhFHO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:27:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E4036D;
        Tue,  8 Jun 2021 07:25:59 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013FD3F73D;
        Tue,  8 Jun 2021 07:25:56 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:25:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than
 cpu.uclamp.max
Message-ID: <20210608142554.tbiu2s5qnwflmk27@e107158-lin.cambridge.arm.com>
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com>
 <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
 <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
 <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com>
 <20210607134902.nlgvqtzj35rhjg7x@e107158-lin.cambridge.arm.com>
 <CAB8ipk8FaovUYY8ncDgLHO7k_EoEHtsfm+1QYsFTMf4fb7ix_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8FaovUYY8ncDgLHO7k_EoEHtsfm+1QYsFTMf4fb7ix_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 19:45, Xuewen Yan wrote:
> > Looking at this again now, I better understand what you were trying to say.
> > I got confused that you were still arguing about cgroup inverted
> > cpu.uclamp.min/max, but you're actually talking about something else.
> 
> Generally speaking, this kind of situation does not basically exist,
> but I just consider all the situations that can occur when users use
> it.

+1

> 
> >
> > It would be a lot easier to not cross talk threads and reply to my patch
> > directly with this remark.
> Sorry for the trouble because of my unfamiliar with the maillist, I
> will pay attention next time :）

Not really a problem, it was just a bit confusing to get the right context :)

> > +       uc_min = task_group(p)->uclamp[UCLAMP_MIN].value;
> > +       uc_max = task_group(p)->uclamp[UCLAMP_MAX].value;
> > +       val = uc_req.value;
> > +       uc_req.value = clamp(val, uc_min, uc_max);
> 
> This is not a good solution, because it just clamp the uc_req.value,
> but the  uc_req.bucket_id is not changed.


This is what I actually have now. I did move to using uclamp_se_set().
I also needed to modify uclamp_update_active_tasks() so that both
uclamp_min/max unconditionally.

I still need to sleep on it to make sure I haven't missed something else, but
it looks fine so far.

Thanks!

--
Qais Yousef


--->8---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e9a5be35cde..1d2d3e6648a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1403,38 +1403,28 @@ static void uclamp_sync_util_min_rt_default(void)
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
-       struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+       /* Copy by value as we could modify it */
+       struct uclamp_se uc_eff = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+       unsigned long tg_min, tg_max, value;

        /*
         * Tasks in autogroups or root task group will be
         * restricted by system defaults.
         */
        if (task_group_is_autogroup(task_group(p)))
-               return uc_req;
+               return uc_eff;
        if (task_group(p) == &root_task_group)
-               return uc_req;
+               return uc_eff;

-       switch (clamp_id) {
-       case UCLAMP_MIN: {
-               struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
-               if (uc_req.value < uc_min.value)
-                       return uc_min;
-               break;
-       }
-       case UCLAMP_MAX: {
-               struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
-               if (uc_req.value > uc_max.value)
-                       return uc_max;
-               break;
-       }
-       default:
-               WARN_ON_ONCE(1);
-               break;
-       }
+       tg_min = task_group(p)->uclamp[UCLAMP_MIN].value;
+       tg_max = task_group(p)->uclamp[UCLAMP_MAX].value;
+       value = uc_eff.value;
+       value = clamp(value, tg_min, tg_max);
+       uclamp_se_set(&uc_eff, value, false);
 #endif

-       return uc_req;
+       return uc_eff;
 }
 
 /*
@@ -1661,8 +1651,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
-uclamp_update_active_tasks(struct cgroup_subsys_state *css,
-                          unsigned int clamps)
+uclamp_update_active_tasks(struct cgroup_subsys_state *css)
 {
        enum uclamp_id clamp_id;
        struct css_task_iter it;
@@ -1670,10 +1659,8 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 
        css_task_iter_start(css, 0, &it);
        while ((p = css_task_iter_next(&it))) {
-               for_each_clamp_id(clamp_id) {
-                       if ((0x1 << clamp_id) & clamps)
-                               uclamp_update_active(p, clamp_id);
-               }
+               for_each_clamp_id(clamp_id)
+                       uclamp_update_active(p, clamp_id);
        }
        css_task_iter_end(&it);
 }
@@ -9626,7 +9613,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
                }
 
                /* Immediately update descendants RUNNABLE tasks */
-               uclamp_update_active_tasks(css, clamps);
+               uclamp_update_active_tasks(css);
        }
 }
