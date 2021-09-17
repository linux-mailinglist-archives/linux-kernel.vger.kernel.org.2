Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D540FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhIQP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhIQP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:28:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:27:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 72so6833648qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3XLvp+C7BZKXW25qtQnmeavwVREq13mF2t8TnFg7h8=;
        b=ma9ysC6dZG9BsfBsHogzoGydNfFrVUn1as1xUYntDMccIRrlY99NeyBPhwHd/PxK8J
         W69EHqcxgp3u7OemM6zJuAPYq5W+lwHJLdmVR0GemDUBsm01UzXg9R1/2Bl8IOjL2IWl
         vzfe89aY5HuipfX4n9ZSRCUol7TEreaMJP2kBHfRhgMDfzZSDnXEIo958Wvt/zeknR6/
         9+4vWnBOKIjYmXJLd/CV282S1I8LTMVYoBl1fKyT+YiKUB2sivgvB7Wu9/5nx2KbCS0/
         1HXoDsygGoSUYBALVwdn48h6o7ecIf4Gts3LN+RChZySPk3xzrEJfG+nJT2kEH7JDWKm
         hGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3XLvp+C7BZKXW25qtQnmeavwVREq13mF2t8TnFg7h8=;
        b=24Ur/Vk62ivhhw3saoNsBHi6ZBJ3OSRM6CtWVV0drkwEIpxmbhbOYt5LLcHHMXuk6+
         YynY0I7O3aY7KUJFY+zcVJsXvp6+uXsK5FH5ejb5FLHpz7BBZKmr/qCEjmaecxhcdYvV
         T/zusA9pyAov/1JcQdDSKqyKGIUriIZOpClrjtHZUcuQsj3ehLZelVc+NZTt/0lvEM56
         9X35k46h95rlNjFwFhpVrFBeDQ+W+J4w+aJEtEwURVNJe9BE+XH+ZcsYGL5Nt52VulO7
         ePDW7/mRQwbyql70vbKPvSKXaCs4Q25iAlEhj9FIoOSN9j7uI5q0p6GRatBhd6qVpB5G
         1Tzw==
X-Gm-Message-State: AOAM533UFgBwvGQnyZOvHqj1alYf9dns0bCiUlPKS+t4FJUkHdA8gmsf
        83u+DjUMIRAIlIX/8rZBUZM4VZXREOYhIaBufQzD8w==
X-Google-Smtp-Source: ABdhPJynu1fj/apO6ALW2WO1rvp19yZafCLVj5aI2S/7fbxCB+Cgviatp/AVipcP4rN8wUwU5dAIgkebf0THkNd6sZs=
X-Received: by 2002:a5b:142:: with SMTP id c2mr14709743ybp.425.1631892430927;
 Fri, 17 Sep 2021 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com> <20210911011819.12184-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20210911011819.12184-5-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Sep 2021 17:27:00 +0200
Message-ID: <CAKfTPtDWKkCJwimuU9DRUUyStn+ZVkUX23mNMCoqpLzXrn+jfQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] sched/fair: Provide update_sg_lb_stats() with
 sched domain statistics
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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

On Sat, 11 Sept 2021 at 03:19, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Before deciding to pull tasks when using asymmetric packing of tasks,
> on some architectures (e.g., x86) it is necessary to know not only the
> state of dst_cpu but also of its SMT siblings. The decision to classify
> a candidate busiest group as group_asym_packing is done in
> update_sg_lb_stats(). Give this function access to the scheduling domain
> statistics, which contains the statistics of the local group.
>
> Cc: Aubrey Li <aubrey.li@intel.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes since v4:
>   * None
>
> Changes since v3:
>   * None
>
> Changes since v2:
>   * Introduced this patch.
>
> Changes since v1:
>   * N/A
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a054f528bcc..c5851260b4d8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8605,6 +8605,7 @@ group_type group_classify(unsigned int imbalance_pct,
>   * @sg_status: Holds flag indicating the status of the sched_group
>   */
>  static inline void update_sg_lb_stats(struct lb_env *env,
> +                                     struct sd_lb_stats *sds,
>                                       struct sched_group *group,
>                                       struct sg_lb_stats *sgs,
>                                       int *sg_status)
> @@ -8613,7 +8614,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>
>         memset(sgs, 0, sizeof(*sgs));
>
> -       local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
> +       local_group = group == sds->local;
>
>         for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>                 struct rq *rq = cpu_rq(i);
> @@ -9176,7 +9177,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                                 update_group_capacity(env->sd, env->dst_cpu);
>                 }
>
> -               update_sg_lb_stats(env, sg, sgs, &sg_status);
> +               update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
>
>                 if (local_group)
>                         goto next_group;
> --
> 2.17.1
>
