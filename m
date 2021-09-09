Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BE140594A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhIIOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbhIIOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:41:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93440C06643B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:04:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k65so4053717yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TGE0YJu7EQ7Wq1fLI7n32RnzTRmkM2znTcvpU1D6mEw=;
        b=iFs3OyuWQDLeLJHBRNZ2vfj3FFcczvRNVw/4J/9IAxlNl3+8lFA94yOkQJpe4sI7s/
         4+TZBJsdDyk/v5yQ6Y62YsCYfVYF0j0Mu1s5iIhFQ+CtsbNMdRHR0qCjflwYSODLR/LF
         O2GXqSF4p7rj/tsV4IW0DN9Tn83CgpNKn66pefNA3hwpBVI3o+z2tyYWewSYi7rRCbFF
         T6xKMTxNQSd32hW6qs/7wcQamrDffldHFVHdYnxc6FVd6amr2nVOv8pFHGhHjglWuCrH
         RLbDD1fR2xdfW90dwGRQASQPgP0PCPCIGuNjs5M6mZV8oMIg7WAwMYUnohmonxfjDNUD
         qQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TGE0YJu7EQ7Wq1fLI7n32RnzTRmkM2znTcvpU1D6mEw=;
        b=LbUEBlGXafcNIiHTdWVufDtXwUI6SFogwOasoLjqFEIUbGvcyrm4OZQSd8l8o4G02e
         VpaAvrOTTyFXfouMsgektFYny2H0UwKGVAg2IPSB+y9mOkxX/IAopuiPuZPMixKz/vSZ
         ErWW37/iYmofSSWQC8868mg+bHq73N1DN6scep4bpCWsSsFAfD5/D1xuW1Wn8SyO1Rrc
         3h7BNAL4W4CciMoqHOpE9V6yIydkXNOF2Caa0k06eAZQW9wkSP8b2n+BdCO44/H4P8In
         s9ggC59anZJP8YeXGuxUl39eGc6bdGkDRJTsHNJK+UwunvFaPrdzkrDvkEorhGDeoZsg
         CR/g==
X-Gm-Message-State: AOAM530ISDFiXT9aEhtWr1eRQknHyOs4/oovsLLB9N/NzOT2TeCZKRoN
        uyn1eUosMjH9Rd/1LJK3hWr40RLNDhPSvzhsheUGUw==
X-Google-Smtp-Source: ABdhPJzSufjLZvzQighk+f9xcVwFLfQ8b09NflKVMPNiqvIchbHGXIl5DfCpvq372NxI/+Lv0BF3+bPf2WJxAM1VH0c=
X-Received: by 2002:a25:db07:: with SMTP id g7mr2379146ybf.245.1631196252727;
 Thu, 09 Sep 2021 07:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-6-mkoutny@suse.com>
In-Reply-To: <20210819175034.4577-6-mkoutny@suse.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Sep 2021 16:04:02 +0200
Message-ID: <CAKfTPtDwOGu9kkMdXDx=+mGVGq_EmF0wgLen7hYO+VEy+j6rig@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] sched/fair: Simplify ancestor enqueue loops
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 at 19:50, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> When a task is enqueued or cfs_rq is unthrottled we have work to do from
> the cfs_rq in question possibly up to root. The important nodes on the
> path are throttled cfs_rqs or cfs_rqs already enqueud to their parent.
>
> Instead of multiple (interrupted) loops make all work in a single loop
> and decide what all needs to be done inside it. This undoes parts of

These multiple break loops have been done to make unthrottle_cfs_rq,
throttle_cfs_rq, enqueue_task_fair and dequeue_task_fair to follow the
same pattern and I don't see any good reason to break this

> commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for
> leaf_cfs_rq list") but it should not bring any functional changes.
>
> Note some PELT stats update code is duplicated both in enqueue_entity
> and the ancestor loop (update_load_avg, se_update_runnable,
> update_cfs_group). It'd be nice to factor these out, however, the later
> parts of enqueue_entity rely on the updates, so stick with the current
> repetition.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/sched/fair.c | 57 +++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9978485334ec..79f183336fa8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4883,6 +4883,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(cfs_rq->tg);
>         struct sched_entity *se;
>         long task_delta, idle_task_delta;
> +       int enqueue =3D 1;
>
>         cfs_rq->throttled =3D 0;
>
> @@ -4911,29 +4912,21 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         task_delta =3D cfs_rq->h_nr_running;
>         idle_task_delta =3D cfs_rq->idle_h_nr_running;
>         for_each_sched_entity(se) {
> -               if (se->on_rq)
> -                       break;
>                 cfs_rq =3D cfs_rq_of(se);
> -               enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> -
> -               cfs_rq->h_nr_running +=3D task_delta;
> -               cfs_rq->idle_h_nr_running +=3D idle_task_delta;
>
> -               /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> -                       goto unthrottle_throttle;
> -       }
> -
> -       for_each_sched_entity(se) {
> -               cfs_rq =3D cfs_rq_of(se);
> -
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> -               se_update_runnable(se);
> +               if (se->on_rq)
> +                       enqueue =3D 0;
> +               if (enqueue)
> +                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> +               else {
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
> +                       se_update_runnable(se);
> +                       /* XXX: no update_cfs_group(se); */
> +               }
>
>                 cfs_rq->h_nr_running +=3D task_delta;
>                 cfs_rq->idle_h_nr_running +=3D idle_task_delta;
>
> -
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto unthrottle_throttle;
> @@ -5537,6 +5530,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>         struct sched_entity *se =3D &p->se;
>         int idle_h_nr_running =3D task_has_idle_policy(p);
>         int task_new =3D !(flags & ENQUEUE_WAKEUP);
> +       int enqueue =3D 1;
>
>         /*
>          * The code below (indirectly) updates schedutil which looks at
> @@ -5555,27 +5549,18 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
>                 cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>
>         for_each_sched_entity(se) {
> -               if (se->on_rq)
> -                       break;
>                 cfs_rq =3D cfs_rq_of(se);
> -               enqueue_entity(cfs_rq, se, flags);
>
> -               cfs_rq->h_nr_running++;
> -               cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
> -
> -               /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> -                       goto enqueue_throttle;
> -
> -               flags =3D ENQUEUE_WAKEUP;
> -       }
> -
> -       for_each_sched_entity(se) {
> -               cfs_rq =3D cfs_rq_of(se);
> -
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> -               se_update_runnable(se);
> -               update_cfs_group(se);
> +               if (se->on_rq)
> +                       enqueue =3D 0;
> +               if (enqueue) {
> +                       enqueue_entity(cfs_rq, se, flags);
> +                       flags =3D ENQUEUE_WAKEUP;
> +               } else {
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
> +                       se_update_runnable(se);
> +                       update_cfs_group(se);
> +               }
>
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
> --
> 2.32.0
>
