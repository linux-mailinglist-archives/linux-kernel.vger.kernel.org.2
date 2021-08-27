Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C73F9B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbhH0PSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhH0PSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:18:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:17:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l18so11980999lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM/CxF5Vtipf0rVSZWIFjaITExCiSF5UaWeEAnIcTEw=;
        b=rZKo/xkSxOYtcba9J7/+0V5cMzi3YhrAvsucSGb0EXR+9KpR4clAG48MGZOkB7XsKM
         gC6jd+RSf50EAxZ2G1ZebjRkY4haNkQFvcHIjI3aY3k1GGYk0LqCM71a14hZynxrmnd3
         UAF5+mYGFRRerrl3fMLWFAjI8RfKhskVU2Rrg5XEyYBuCMk4k1BbP2oa7wo2qL61dPa7
         dPtPO7DUW7tvUjpw0V/mRvT6b+7eTdlI9ITo8qaYwoktp9Y2DWQ3ckOKGGsTEEmx2wOh
         oKTpoqXokPPV1rENax4p60VN3uKF14PbAAixwpTbfSGVTuAtWjWxncuFWkwuhIi/JBRr
         vIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM/CxF5Vtipf0rVSZWIFjaITExCiSF5UaWeEAnIcTEw=;
        b=kiSOKCbCbTVvvJyiCmS4rbcJKstvaBAaqgK/wvSBk4E7n+o6k1wce3xIO8j7n8cawG
         Khf6RIST8LRNDKsN91CjgCcthIIIO+nj5FG4/7KhPu0bjneQ5slJxPtr9TOjE996TOK/
         1bIIgrgo87r5nRTD8OaBfekmHxUk8CH24fctcFPLck64OMKQBTjbnvUT4rcYpWDAqZRk
         3/Fxy1crEHF2FkUro0zouJrq5wv940Jpma+wDTsRNXUckhAx2smT7Urt/UW4hc1qBXLc
         iG0c7sTKSeS4vUHt8V84FVsjUGqD9Iy4HLp0J1M3SWYZ8B5z9vmOLbWD1D2m2PYaP9jQ
         svSA==
X-Gm-Message-State: AOAM530MttWzuKphWpu1Lq9cZR8pE8IVTAJ53E0rLEw3shO9/avt01zu
        vZqho4Ell9BPOjYLMm5smYm3Ys9o0Qdf3azgv+qXKQ==
X-Google-Smtp-Source: ABdhPJwxg6+G/p9Zxy/iB6dw7aQN+kTMb4qEz7bs96RHQ7YVNxY5eUU9KARqLpKu2fk7gD+0uGYfd5O5I+kxGo5dAeE=
X-Received: by 2002:a05:651c:382:: with SMTP id e2mr7884424ljp.401.1630077453333;
 Fri, 27 Aug 2021 08:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210810144145.18776-1-ricardo.neri-calderon@linux.intel.com>
 <20210810144145.18776-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtArtmhLG5QYR6TzKevDrEuiQu2HJxm_C3pe549XdGU-1g@mail.gmail.com> <YSj7PrVGVpcKf/vz@hirez.programming.kicks-ass.net>
In-Reply-To: <YSj7PrVGVpcKf/vz@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 27 Aug 2021 17:17:22 +0200
Message-ID: <CAKfTPtBvhHBA-BLkh-fd2eJk_JOm2chgMy6AKpR=WV_hc3sQKA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] sched/fair: Consider SMT in ASYM_PACKING load balance
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 16:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 27, 2021 at 12:13:42PM +0200, Vincent Guittot wrote:
> > > +/**
> > > + * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> > > + * @dst_cpu:   Destination CPU of the load balancing
> > > + * @sds:       Load-balancing data with statistics of the local group
> > > + * @sgs:       Load-balancing statistics of the candidate busiest group
> > > + * @sg:                The candidate busiet group
> > > + *
> > > + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> > > + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> > > + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> > > + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> > > + *
> > > + * If both @dst_cpu and @sg have SMT siblings, even the number of idle CPUs
> > > + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> > > + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> > > + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> > > + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> > > + * has lower priority.
> > > + */
> > > +static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> > > +                                   struct sg_lb_stats *sgs,
> > > +                                   struct sched_group *sg)
> > > +{
> > > +#ifdef CONFIG_SCHED_SMT
> > > +       bool local_is_smt, sg_is_smt;
> > > +       int sg_busy_cpus;
> > > +
> > > +       local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> > > +       sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> > > +
> > > +       sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > > +
> > > +       if (!local_is_smt) {
> > > +               /*
> > > +                * If we are here, @dst_cpu is idle and does not have SMT
> > > +                * siblings. Pull tasks if candidate group has two or more
> > > +                * busy CPUs.
> > > +                */
> > > +               if (sg_is_smt && sg_busy_cpus >= 2)
> > > +                       return true;
> > > +
> > > +               /*
> > > +                * @dst_cpu does not have SMT siblings. @sg may have SMT
> > > +                * siblings and only one is busy. In such case, @dst_cpu
> > > +                * can help if it has higher priority and is idle.
> > > +                */
> > > +               return !sds->local_stat.group_util &&
> >
> > sds->local_stat.group_util can't be used to decide if a CPU or group
> > of CPUs is idle. util_avg is usually not null when a CPU becomes idle
> > and you can have to wait  more than 300ms before it becomes Null
> > At the opposite, the utilization of a CPU can be null but a task with
> > null utilization has just woken up on it.
> > Utilization is used to reflect the average work of the CPU or group of
> > CPUs but not the current state
>
> If you want immediate idle, sgs->nr_running == 0 or sgs->idle_cpus ==
> sgs->group_weight come to mind.

yes, I have the same in mind

>
> > > +                      sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > > +       }
> > > +
> > > +       /* @dst_cpu has SMT siblings. */
> > > +
> > > +       if (sg_is_smt) {
> > > +               int local_busy_cpus = sds->local->group_weight -
> > > +                                     sds->local_stat.idle_cpus;
> > > +               int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> > > +
> > > +               /* Local can always help to even the number busy CPUs. */
> >
> > default behavior of the load balance already tries to even the number
 a> > of idle CPUs.
>
> Right, but I suppose this is because we're trapped here and have to deal
> with the SMT-SMT case too. Ricardo, can you clarify?

IIUC, this function is used in sg_lb_stats to set
sgs->group_asym_packing which is then used to set the group state to
group_asym_packing and force asym migration.
But if we only want to even the number of busy CPUs between the group,
we should not need to set the group state to  group_asym_packing

>
> > > +               if (busy_cpus_delta >= 2)
> > > +                       return true;
> > > +
> > > +               if (busy_cpus_delta == 1)
> > > +                       return sched_asym_prefer(dst_cpu,
> > > +                                                sg->asym_prefer_cpu);
> > > +
> > > +               return false;
> > > +       }
> > > +
> > > +       /*
> > > +        * @sg does not have SMT siblings. Ensure that @sds::local does not end
> > > +        * up with more than one busy SMT sibling and only pull tasks if there
> > > +        * are not busy CPUs. As CPUs move in and out of idle state frequently,
> > > +        * also check the group utilization to smoother the decision.
> > > +        */
> > > +       if (!sds->local_stat.group_util)
> >
> > same comment as above about the meaning of group_util == 0
> >
> > > +               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > > +
> > > +       return false;
> > > +#else
> > > +       /* Always return false so that callers deal with non-SMT cases. */
> > > +       return false;
> > > +#endif
> > > +}
> > > +
> > >  static inline bool
> > >  sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
> > >            struct sched_group *group)
> > >  {
> > > +       /* Only do SMT checks if either local or candidate have SMT siblings */
> > > +       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> > > +           (group->flags & SD_SHARE_CPUCAPACITY))
> > > +               return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> > > +
> > >         return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> > >  }
