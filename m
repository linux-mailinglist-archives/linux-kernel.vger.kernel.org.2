Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3063F5988
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhHXH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhHXH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:58:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:58:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i28so43618748lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkL8eEEmKiR7pvO2SpdEQ+Oh8oZUTxJ0gPcBukqY2xk=;
        b=jzMU9nCdzFi8j7hQPhlm+riPG8adjDQxBT3umncaJUchFtytnBJIfy/qCl+yOxbB/C
         gmU8RaU+TBPvnp0umh/GBhVA3vvII7Yya12NSbVJ0eUA1GYs6ctnJ+gav+vW3vngIjX2
         EPgpHqGPH3+TmQOwuZjLKA6COwItgxAUN6dbVkHfo3BsYCqsovtGXt2o/fn/srDP0Iil
         2vt5p+EFJS4k3ZHjQ4A/3lPtga/5ppImLwHsW5ktdCXuIzBMLP885X+EYNvfkT6JEPfu
         qwOjEWyaEV3F/Gw2Gv3ZSsNSU962ruoRCeIkqY4ltdJzTe2+hWGCbkhaZGgAjKyDnqf0
         pE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkL8eEEmKiR7pvO2SpdEQ+Oh8oZUTxJ0gPcBukqY2xk=;
        b=mGLPbsZh9IkTjvkcy1sUaV/PzkoD3Fzr3s4/OjVIYWsbx81JXWwEAfmeLe1VuM94lZ
         Xj3pv1iqsaEUpHTFFr4Nnc7vDPhl5NtgB/Vna46zC560GK3oGL1aIl6U3Y8g/KXTKLdC
         VvnumZEicEPBVIu6pwFusNCICzvtjVFlRBhLmgq97dfx2DvbxBZ1PzEdtbR23aAcnfkR
         yrKyPcIBsPo5DmOxNe3q4o3nj+/lttDQAfF+Um42OeZDE8r58h5ORSB7cBJQyxvXbTVu
         zfouQWyypfOLkfx1y0wmcdqL4vVk5JgjTmLi9fF57pXgeummN53MZs5ZEMN4nCzEMu2N
         JXjQ==
X-Gm-Message-State: AOAM531i8tfTi5tDRw1Cs67hpeXNYQpz1nxs3i/6yzWt+uGXTpr8SjpY
        1jfX8sz38N+gtGuS/4LCT8pPaUAOfWiJiCx+9GoR4A==
X-Google-Smtp-Source: ABdhPJyNSOeyrhIqJhKCCZa/ygabib95x7I1htBvbtt7Z+ZR4F3zoVJ4vyrdD99OYpuweJ1Rwday1P9uvrAtYyTdLbg=
X-Received: by 2002:ac2:54a4:: with SMTP id w4mr19796521lfk.254.1629791878947;
 Tue, 24 Aug 2021 00:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-3-joshdon@google.com>
In-Reply-To: <20210820010403.946838-3-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Aug 2021 09:57:47 +0200
Message-ID: <CAKfTPtAN5tpux3rcvMR4PHdPL53=_bmX2pVtwjn7WmhsuxnZFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] sched: account number of SCHED_IDLE entities on
 each cfs_rq
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 03:04, Josh Don <joshdon@google.com> wrote:
>
> Adds cfs_rq->idle_nr_running, which accounts the number of idle entities
> directly enqueued on the cfs_rq.
>
> Signed-off-by: Josh Don <joshdon@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/debug.c |  2 ++
>  kernel/sched/fair.c  | 25 ++++++++++++++++++++++++-
>  kernel/sched/sched.h |  1 +
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 49716228efb4..33538579db9a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -608,6 +608,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>                         cfs_rq->nr_spread_over);
>         SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
>         SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
> +       SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
> +                       cfs_rq->idle_nr_running);
>         SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
>                         cfs_rq->idle_h_nr_running);
>         SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5aa3cfd15a2e..19a9244c140f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2995,6 +2995,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         }
>  #endif
>         cfs_rq->nr_running++;
> +       if (se_is_idle(se))
> +               cfs_rq->idle_nr_running++;
>  }
>
>  static void
> @@ -3008,6 +3010,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         }
>  #endif
>         cfs_rq->nr_running--;
> +       if (se_is_idle(se))
> +               cfs_rq->idle_nr_running--;
>  }
>
>  /*
> @@ -5573,6 +5577,17 @@ static int sched_idle_rq(struct rq *rq)
>                         rq->nr_running);
>  }
>
> +/*
> + * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
> + * of idle_nr_running, which does not consider idle descendants of normal
> + * entities.
> + */
> +static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +       return cfs_rq->nr_running &&
> +               cfs_rq->nr_running == cfs_rq->idle_nr_running;
> +}
> +
>  #ifdef CONFIG_SMP
>  static int sched_idle_cpu(int cpu)
>  {
> @@ -11556,7 +11571,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
>         for_each_possible_cpu(i) {
>                 struct rq *rq = cpu_rq(i);
>                 struct sched_entity *se = tg->se[i];
> -               struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
> +               struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
>                 bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
>                 long idle_task_delta;
>                 struct rq_flags rf;
> @@ -11567,6 +11582,14 @@ int sched_group_set_idle(struct task_group *tg, long idle)
>                 if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
>                         goto next_cpu;
>
> +               if (se->on_rq) {
> +                       parent_cfs_rq = cfs_rq_of(se);
> +                       if (cfs_rq_is_idle(grp_cfs_rq))
> +                               parent_cfs_rq->idle_nr_running++;
> +                       else
> +                               parent_cfs_rq->idle_nr_running--;
> +               }
> +
>                 idle_task_delta = grp_cfs_rq->h_nr_running -
>                                   grp_cfs_rq->idle_h_nr_running;
>                 if (!cfs_rq_is_idle(grp_cfs_rq))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dfad8fb756c..6af039e433fb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -530,6 +530,7 @@ struct cfs_rq {
>         struct load_weight      load;
>         unsigned int            nr_running;
>         unsigned int            h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
> +       unsigned int            idle_nr_running;   /* SCHED_IDLE */
>         unsigned int            idle_h_nr_running; /* SCHED_IDLE */
>
>         u64                     exec_clock;
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
