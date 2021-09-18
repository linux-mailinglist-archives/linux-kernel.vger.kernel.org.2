Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1A41057D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhIRJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhIRJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:35:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1560C061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:33:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 72so13633581qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LriAj22OV80pzVv/mnvzrKjxggP7MKMvTt9ZA2KFDVk=;
        b=R1+rfQT5YmmHQBkzuppyCmqAGnFFlD1KYGye76Esp5u1EXeNz6KSetDOfiE6t0vZUM
         7hRk8qg9MW2cDEEc+gvIcH3CGvVlE4rzMSZbl5QU1yP0sLHuz9IkBgrBfJJqMM1T5Nlv
         4GlVzQJJHuAmysU2R0+rmsI+Lw5O44HqX1p/mYZOb8POnfI4dCNzVviWa3cBn38M7oUt
         AUMc8AvJXLrjZq5kXRr2FRUUqcvDAmq4mqemgkgDRjC/rUShQsDxb8YQhoyTZ9SpxeRM
         /76X4EmfrC7xyND8rnawFDbmHIx3m4tmf7Uau5to0/EGdt0PaQgnMM3v2zddUGeNVYso
         aanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LriAj22OV80pzVv/mnvzrKjxggP7MKMvTt9ZA2KFDVk=;
        b=6Er8JCfpCQ0bHpFb3LwNwu6WgFzBtoWpVLtAWeWz0bJWfSSvHwEWqNU7nHujBhbGCM
         ZRqsEw7QhMhgfh1e+vWMqQQ1SRoox7ZNeECu0IdWVMRy95739NZsR6YzamVqEjl2OJe5
         rBg/zZqZfUNE1WGogpXt/Tk2jL0t3rEusWMmFgEJmMkSfGxL57cyb+/yMjzPLP2RfsLZ
         QbVd3hq4jU0s07x6xgyYbAS1XZzzFU310JjqyOL21UJavFYtb6Z9eBZfDgpU4FkWhmwH
         4jngu03xE49rI7K3j81y8KtijrJtshPLWphiVvmcDullCTKEr8cI9QerfhJRNQcqZi1G
         +Tdg==
X-Gm-Message-State: AOAM533JzUP1kmrqrKvSdVLsZtGeUt0smHXkG12UWDcZzqhCJLvGsyMs
        Ms/miA9po+8HD4kKk0o4jBex+rRS7Nj8POTLudDvhg==
X-Google-Smtp-Source: ABdhPJw05MikhXwjtWHor5wBzvwiNlzbFPN2ZU1Dqbb0kQtkWV9vpnBWXWgwslkfXi5IIS3Y0wKOtxHX6Gyv1iczIdk=
X-Received: by 2002:a25:ac13:: with SMTP id w19mr18743555ybi.402.1631957628695;
 Sat, 18 Sep 2021 02:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
 <20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtBcDP3Yp54sd4+1kP=o=4e_1HEmOf=eMXydag_J38CEng@mail.gmail.com>
 <20210917010044.GA23727@ranerica-svr.sc.intel.com> <CAKfTPtCh72m86pbT5vY_rWzU79Q9NP9t6mcrO8ewbZkBJdN03Q@mail.gmail.com>
 <20210917184659.GI4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210917184659.GI4323@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 18 Sep 2021 11:33:37 +0200
Message-ID: <CAKfTPtCJJ4v0nXE=CnpMhqPb-FuWQdhkgp63khEibmrMc8EN-w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] sched/fair: Consider SMT in ASYM_PACKING load balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 20:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 17, 2021 at 05:25:02PM +0200, Vincent Guittot wrote:
>
> > With the removal of the condition !sds->local_stat.sum_nr_running
> > which seems useless because dst_cpu is idle and not SMT, this patch
> > looks good to me
>
> I've made it look like this. Thanks!

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

>
> ---
> Subject: sched/fair: Consider SMT in ASYM_PACKING load balance
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Date: Fri, 10 Sep 2021 18:18:19 -0700
>
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>
> When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
> check for the idle state of the destination CPU, dst_cpu, but also of
> its SMT siblings.
>
> If dst_cpu is idle but its SMT siblings are busy, performance suffers
> if it pulls tasks from a medium priority CPU that does not have SMT
> siblings.
>
> Implement asym_smt_can_pull_tasks() to inspect the state of the SMT
> siblings of both dst_cpu and the CPUs in the candidate busiest group.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Link: https://lkml.kernel.org/r/20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com
> ---
>  kernel/sched/fair.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8538,10 +8538,96 @@ group_type group_classify(unsigned int i
>         return group_has_spare;
>  }
>
> +/**
> + * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> + * @dst_cpu:   Destination CPU of the load balancing
> + * @sds:       Load-balancing data with statistics of the local group
> + * @sgs:       Load-balancing statistics of the candidate busiest group
> + * @sg:                The candidate busiest group
> + *
> + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> + * if @dst_cpu can pull tasks.
> + *
> + * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
> + * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
> + * only if @dst_cpu has higher priority.
> + *
> + * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
> + * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
> + * Bigger imbalances in the number of busy CPUs will be dealt with in
> + * update_sd_pick_busiest().
> + *
> + * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
> + * of @dst_cpu are idle and @sg has lower priority.
> + */
> +static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> +                                   struct sg_lb_stats *sgs,
> +                                   struct sched_group *sg)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +       bool local_is_smt, sg_is_smt;
> +       int sg_busy_cpus;
> +
> +       local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> +       sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> +
> +       sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> +
> +       if (!local_is_smt) {
> +               /*
> +                * If we are here, @dst_cpu is idle and does not have SMT
> +                * siblings. Pull tasks if candidate group has two or more
> +                * busy CPUs.
> +                */
> +               if (sg_busy_cpus >= 2) /* implies sg_is_smt */
> +                       return true;
> +
> +               /*
> +                * @dst_cpu does not have SMT siblings. @sg may have SMT
> +                * siblings and only one is busy. In such case, @dst_cpu
> +                * can help if it has higher priority and is idle (i.e.,
> +                * it has no running tasks).
> +                */
> +               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> +       }
> +
> +       /* @dst_cpu has SMT siblings. */
> +
> +       if (sg_is_smt) {
> +               int local_busy_cpus = sds->local->group_weight -
> +                                     sds->local_stat.idle_cpus;
> +               int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> +
> +               if (busy_cpus_delta == 1)
> +                       return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> +
> +               return false;
> +       }
> +
> +       /*
> +        * @sg does not have SMT siblings. Ensure that @sds::local does not end
> +        * up with more than one busy SMT sibling and only pull tasks if there
> +        * are not busy CPUs (i.e., no CPU has running tasks).
> +        */
> +       if (!sds->local_stat.sum_nr_running)
> +               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> +
> +       return false;
> +#else
> +       /* Always return false so that callers deal with non-SMT cases. */
> +       return false;
> +#endif
> +}
> +
>  static inline bool
>  sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
>            struct sched_group *group)
>  {
> +       /* Only do SMT checks if either local or candidate have SMT siblings */
> +       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> +           (group->flags & SD_SHARE_CPUCAPACITY))
> +               return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> +
>         return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>
> @@ -9547,6 +9633,12 @@ static struct rq *find_busiest_queue(str
>                     nr_running == 1)
>                         continue;
>
> +               /* Make sure we only pull tasks from a CPU of lower priority */
> +               if ((env->sd->flags & SD_ASYM_PACKING) &&
> +                   sched_asym_prefer(i, env->dst_cpu) &&
> +                   nr_running == 1)
> +                       continue;
> +
>                 switch (env->migration_type) {
>                 case migrate_load:
>                         /*
