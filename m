Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982FD3556AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbhDFOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbhDFOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:31:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E72C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:31:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b4so23103306lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAbAgRsevYpEf22UGCEjPx5xKc+hazQx7qglGcL+BnI=;
        b=Sw527LAr3qxsLscT6t43K7tdyRIWbhxyuTkhnY09A6q/cnmvEIDdjGb63s702ua3gg
         komCXgUt3UPzFcBK1wEip1SlMzpWmdkLh3l4SmK/JLtQE3EETgoZZApGW/LKlVACVT1i
         16At7wVUmkg2zauQBJtwPS+uq/L9rT0SAJ90wooIxbv67/hzIQm93d7k6qnEXiwLwjVf
         oCx5CU1TsAnlrBa/aZeUkRIzVJwHo2xFULy06QXHdZAizb+rDOAiV68z7y0rISOkPJWO
         Tga8qfXo8hn/1HruSAZisA/3fBOO2tWML+ywiKaJ+hceGIfr/YfS/O0vgQ8FyLI7rAPp
         W92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAbAgRsevYpEf22UGCEjPx5xKc+hazQx7qglGcL+BnI=;
        b=AzsPFWolKsHD3u65yjoRdZAoFdOGAMA8ss9oxezV7ZsEpNisJ5ntp52yDnaThfagGB
         ujgUDVPQj9HZiGiT4zhdAqeAsnKcNGM15Pik0Di4M9yjPJ53PvVn5QYdYWeDEH/3uFQy
         tDvjoDX1ftyyI5waukDN6rMtRfucK1fR6RZ7bLSs04NdB/TcqSNiRZ1EnIj66ty9W4zg
         bX2oOp7IqQgRmOpMNcKtXeRUhRkLJkRBzo3RzXaMtsmt1NzdYwBdA9WpTKoouCRzAGVK
         +iY2jpXZga8Lg+DOcKPUGZhpRzDdm/DqP5VFCXSh1TVto2rdsVLGx+XpXJjWHYuPHTpJ
         ybzA==
X-Gm-Message-State: AOAM530XbfU/VtszHsOuCCEEvP4ylA1GZpwpULVJGrXeMqsZ8wdG6cdS
        naa61zQ3TRTmoo4y2TOc/YE35Bs5TPMw6XBmunQNkQ==
X-Google-Smtp-Source: ABdhPJzQSlbElGn8nHA98I4hP9j7AwlPcvxJ87T4dlz5PAkM+o+DemSEHJAFUkclv7rwtilB3Ns3JPM0uLCq0O3Wp6k=
X-Received: by 2002:a19:f812:: with SMTP id a18mr21272329lff.254.1617719506474;
 Tue, 06 Apr 2021 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com> <20210406041108.7416-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20210406041108.7416-3-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Apr 2021 16:31:35 +0200
Message-ID: <CAKfTPtBfRCXgfLVbTo1tD+_puzvba8qbhYc99RiL9QchQ+S5ew@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/fair: Introduce arch_sched_asym_prefer_early()
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 06:11, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Introduce arch_sched_asym_prefer_early() so that architectures with SMT
> can delay the decision to label a candidate busiest group as
> group_asym_packing.
>
> When using asymmetric packing, high priority idle CPUs pull tasks from
> scheduling groups with low priority CPUs. The decision on using asymmetric
> packing for load balancing is done after collecting the statistics of a
> candidate busiest group. However, this decision needs to consider the
> state of SMT siblings of dst_cpu.
>
> Cc: Aubrey Li <aubrey.li@intel.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 8f0f778b7c91..663b98959305 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
>  #endif
>
>  extern int arch_asym_cpu_priority(int cpu);
> +extern bool arch_sched_asym_prefer_early(int a, int b);
>
>  struct sched_domain_attr {
>         int relax_domain_level;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4ef3fa0d5e8d..e74da853b046 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
>         return -cpu;
>  }
>
> +/*
> + * For asym packing, early check if CPUs with higher priority should be
> + * preferred. On some architectures, more data is needed to make a decision.
> + */
> +bool __weak arch_sched_asym_prefer_early(int a, int b)
> +{
> +       return sched_asym_prefer(a, b);
> +}
> +
>  /*
>   * The margin used when comparing utilization with CPU capacity.
>   *
> @@ -8458,7 +8467,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>             env->idle != CPU_NOT_IDLE &&
>             sgs->sum_h_nr_running &&
> -           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> +           arch_sched_asym_prefer_early(env->dst_cpu, group->asym_prefer_cpu)) {

If itmt set arch_sched_asym_prefer_early to true all groups will be
set as group_asym_packing unconditionally which is wrong. The state
has to be set only when we want asym packing migration

>                 sgs->group_asym_packing = 1;
>         }
>
> --
> 2.17.1
>
