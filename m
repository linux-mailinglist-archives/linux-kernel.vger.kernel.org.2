Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0C31E3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBRBOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:14:19 -0500
Received: from z11.mailgun.us ([104.130.96.11]:61351 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhBRBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:14:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613610833; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=zJoHio0vuZUbruR36qJQGNO2CmP3Bf9EuFGfJiHJNVs=; b=REs+SV63Hms7r0ESKrCocwtQ61+XN0wahA92fEQEwEWLDLfJ/1PUdGn9UmFRJ4mLyISGbrst
 +eeV41W72mBY9WuS/rj/pHG/RAP4u0Mjegz6HL7LuZhzRS/gLeqmm85qefY7wyYJ0fH1fxT3
 xWRziRmAHbmK/8b8d/qU+sVarhE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 602dbf2a70933e9467eb72e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 01:13:14
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 632A2C433ED; Thu, 18 Feb 2021 01:13:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AFA7C433CA;
        Thu, 18 Feb 2021 01:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AFA7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 18 Feb 2021 06:43:06 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH] sched/fair: Ignore percpu threads for imbalance pulls
Message-ID: <20210218011305.GB23511@codeaurora.org>
References: <20210217120854.1280-1-clingutla@codeaurora.org>
 <jhjim6qsq8g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjim6qsq8g.mognet@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 02:50:23PM +0000, Valentin Schneider wrote:
> On 17/02/21 17:38, Lingutla Chandrasekhar wrote:
> > In load balancing, when balancing group is unable to pull task
> > due to ->cpus_ptr constraints from busy group, then it sets
> > LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
> > is set for its parent domain level. which makes the group
> > classified as imbalance to get help from another balancing cpu.
> >
> > Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
> > CPUs 2-3 as Bigs with below scenario:
> > - CPU0 doing newly_idle balancing
> > - CPU1 running percpu kworker and RT task (small tasks)
> > - CPU2 running 2 big tasks
> > - CPU3 running 1 medium task
> >
> > While CPU0 is doing newly_idle load balance at MC level, it fails to
> > pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
> > and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
> > it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
> > find other busiest_group, so CPU0 stops balacing at MC level without
> > clearing 'sgc->imbalance' and restart the load balacing at DIE level.
> >
> > And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
> > type as imbalance, and Bigs that classified the level below imbalance type
> > would be ignored to pick as busiest, and the balancing would be aborted
> > without pulling any tasks (by the time, CPU1 might not have running tasks).
> >
> > It is suboptimal decision to classify the group as imbalance due to
> > percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.
> >
> 
> Sounds like you've stumbled on the same thing I'm trying to fix in
> 
>   http://lore.kernel.org/r/20210128183141.28097-8-valentin.schneider@arm.com
> 
> (I'm currently working on a v2)
> 
> Now, I'd tend to agree that if we could prevent pcpu kworkers from
> interfering with load-balance altogether, that would indeed be much
> better than trying to deal with the group_imbalanced faff further down the
> line (which is what I've been doing).
> 
> > Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce20da67..44a05ad8c96b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7560,7 +7560,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >  
> >  		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
> >  
> > -		env->flags |= LBF_SOME_PINNED;
> > +		/* Ignore percpu threads for imbalance pulls. */
> > +		if (p->nr_cpus_allowed > 1)
> > +			env->flags |= LBF_SOME_PINNED;
> >  
> >  		/*
> >  		 * Remember if this task can be migrated to any other CPU in
> 
> Unlike user tasks, pcpu kworkers have a stable affinity (with some hotplug
> quirks), so perhaps we could do this instead:
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..84fca350b9ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7539,6 +7539,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> +	if (kthread_is_per_cpu(p))
> +		return 0;
> +
>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>  		int cpu;
>  

Looks good to me. In our testing also, the false imbalance is manifested due
to pinned kworkers.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

