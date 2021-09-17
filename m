Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D552840FC38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhIQP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhIQP1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:27:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:26:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 73so13500345qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TM+ZvTPf59AjLNF10A7BeoUcO09QDb2XjgFhcgEDZCg=;
        b=pcT+euw9MpfxQpJL8z5inrpc9UbXVQZQ2nVgy3O0RT7nq5c/czEiRM05cSO6EWRAuU
         gE3sH5RezrEgqj9lPVJEAu1Uzrg63Jak+ajw250s5JXTUVdhdSWTpDiwqoZNqO6W2BTl
         iNiiM8l0WCOGD/sAV79DF7a1IHO3945+rAGe8zfPj+wOUu4ATHL6jo3lqNChqMEEN412
         cJ0vLnhz7SNKPo0tENlJC/VFRAMZ9oFiGUgIcgYmTaG8TThWqqImE82NqnednT5wz7/Y
         LyRhnDQUB7rs2oy5bGl5O3HzHYdQHhgq2TJI78EruFDheVBMN8yXNEsxozl98C+G0V4B
         mm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TM+ZvTPf59AjLNF10A7BeoUcO09QDb2XjgFhcgEDZCg=;
        b=DYS2bQDWpmC4q2f+oBtSnDaue8AwWqSExrJVpDq2K5cSwCzPbLCH9w7eLRj84O2CIF
         MnUAHrmKCJn/8qA4eXB9B2UmO3AE4kg/CKnoNO+Vk033Hm6kQ1q+POGKX1vdH3FRGabW
         R3XVPTXBHLAo+vImkRF2o7NFBDkyJJETV7NwxNwk5KfP5mxcyLhxPo1TA/Li7NjuZrxx
         ckJM7nGhVyNYRXIprfdkjzWq8iYxvWfzvOWDos5Xz5bp3hj5rfiIav1S93xqPIirkA9h
         GnWT09iigmu9AQpPXy+gtw3MEoPrUm+ypeSkZoehHpGhAFZcWhjqSzMVC/ljMJzx2aXn
         EAKg==
X-Gm-Message-State: AOAM530V4yifY+T+ct8ylj+MNr/V3uQDe8ft3RwFrkcdD9HniI4WubVu
        vbsNGzpLushF52cOR8nmQMT1ulR8cy7tY4URgo2Wyg==
X-Google-Smtp-Source: ABdhPJxYtMwzo8aY4gkreJvqG8Rt6IjAobZ8kHMhtN1A5QYsNekX9RpcATkzUqrXx8D61aktoQcUcLetCjDmy3mwdzs=
X-Received: by 2002:a25:5645:: with SMTP id k66mr14018619ybb.259.1631892372580;
 Fri, 17 Sep 2021 08:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com> <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Sep 2021 17:26:01 +0200
Message-ID: <CAKfTPtDHJxtczRCATGJfuHHuQy9NbpXZAsPL1R9Qf=Jd46TU-A@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] sched/topology: Introduce sched_group::flags
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
> There exist situations in which the load balance needs to know the
> properties of the CPUs in a scheduling group. When using asymmetric
> packing, for instance, the load balancer needs to know not only the
> state of dst_cpu but also of its SMT siblings, if any.
>
> Use the flags of the child scheduling domains to initialize scheduling
> group flags. This will reflect the properties of the CPUs in the
> group.
>
> A subsequent changeset will make use of these new flags. No functional
> changes are introduced.
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
>   * Clear the flags of the scheduling groups of a domain if its child is
>     destroyed.
>   * Minor rewording of the commit message.
>
> Changes since v2:
>   * Introduced this patch.
>
> Changes since v1:
>   * N/A
> ---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 21 ++++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3d3e5793e117..86ab33ce529d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1809,6 +1809,7 @@ struct sched_group {
>         unsigned int            group_weight;
>         struct sched_group_capacity *sgc;
>         int                     asym_prefer_cpu;        /* CPU of highest priority in group */
> +       int                     flags;
>
>         /*
>          * The CPUs this group covers.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4e8698e62f07..c56faae461d9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -716,8 +716,20 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>                 tmp = sd;
>                 sd = sd->parent;
>                 destroy_sched_domain(tmp);
> -               if (sd)
> +               if (sd) {
> +                       struct sched_group *sg = sd->groups;
> +
> +                       /*
> +                        * sched groups hold the flags of the child sched
> +                        * domain for convenience. Clear such flags since
> +                        * the child is being destroyed.
> +                        */
> +                       do {
> +                               sg->flags = 0;
> +                       } while (sg != sd->groups);
> +
>                         sd->child = NULL;
> +               }
>         }
>
>         for (tmp = sd; tmp; tmp = tmp->parent)
> @@ -916,10 +928,12 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
>                 return NULL;
>
>         sg_span = sched_group_span(sg);
> -       if (sd->child)
> +       if (sd->child) {
>                 cpumask_copy(sg_span, sched_domain_span(sd->child));
> -       else
> +               sg->flags = sd->child->flags;
> +       } else {
>                 cpumask_copy(sg_span, sched_domain_span(sd));
> +       }
>
>         atomic_inc(&sg->ref);
>         return sg;
> @@ -1169,6 +1183,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
>         if (child) {
>                 cpumask_copy(sched_group_span(sg), sched_domain_span(child));
>                 cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
> +               sg->flags = child->flags;
>         } else {
>                 cpumask_set_cpu(cpu, sched_group_span(sg));
>                 cpumask_set_cpu(cpu, group_balance_mask(sg));
> --
> 2.17.1
>
