Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3032107B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBVFe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:34:27 -0500
Received: from z11.mailgun.us ([104.130.96.11]:15631 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhBVFeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:34:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613972037; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=jO1TyQvWVUaMSZ6/OhAEI1jkl9QLoSv3X/DAz84wuSc=; b=HoIfTmWuo468r90ONTqF24FV/MwXh05m0HLqVaAmJTe3HRl0YaKrI8011dKqtwbPig79twyf
 zST+KYaehIePXS/aoC2/0pGl8F5DnzqtkGdmv+F6OvZscbRLjfi1T56tmI4K5je4Dp5vQ9iC
 uCrorKWsk8Tf7ZOQ7O2fYDS4cLk=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60334242090a774287426a90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 05:33:54
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E972C433ED; Mon, 22 Feb 2021 05:33:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6A87C433C6;
        Mon, 22 Feb 2021 05:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6A87C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 22 Feb 2021 11:03:46 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Ignore percpu threads for imbalance
 pulls
Message-ID: <20210222053346.GC23511@codeaurora.org>
References: <20210219130003.2890-1-valentin.schneider@arm.com>
 <20210219130003.2890-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219130003.2890-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:59:57PM +0000, Valentin Schneider wrote:
> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> 
> In load balancing, when balancing group is unable to pull task
> due to ->cpus_ptr constraints from busy group, then it sets
> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
> is set for its parent domain level. which makes the group
> classified as imbalance to get help from another balancing cpu.
> 
> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
> CPUs 2-3 as Bigs with below scenario:
> - CPU0 doing newly_idle balancing
> - CPU1 running percpu kworker and RT task (small tasks)
> - CPU2 running 2 big tasks
> - CPU3 running 1 medium task
> 
> While CPU0 is doing newly_idle load balance at MC level, it fails to
> pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
> and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
> it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
> find other busiest_group, so CPU0 stops balacing at MC level without
> clearing 'sgc->imbalance' and restart the load balacing at DIE level.
> 
> And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
> type as imbalance, and Bigs that classified the level below imbalance type
> would be ignored to pick as busiest, and the balancing would be aborted
> without pulling any tasks (by the time, CPU1 might not have running tasks).
> 
> It is suboptimal decision to classify the group as imbalance due to
> percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.
> 
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> [Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..2d4dcf1a3372 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7539,6 +7539,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> +	/* Disregard pcpu kthreads; they are where they need to be. */
> +	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
> +		return 0;
> +
>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>  		int cpu;
>  

Looks good to me. Thanks Valentin for the help.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

