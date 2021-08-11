Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08F3E92B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhHKNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhHKNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:32:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29435C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:32:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so5766996lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggA1Ugc3KslRh4zjEhH3fdMSzLQAduhmaopCk/UOZFk=;
        b=DdSi7V2zcMU4qPXS+8vM/FdopgXTg0Zh9TF+KqCtpI/ClVWMeSy+FEvOME6qXFxeNw
         rM1Dw5e+zBaB2cFz6Q2L+Qtu3/BUr7FI8O19cwiCNNzWD8hgHaL8yn4HChnZ7GmKaUs6
         xNTXPw+vu2s4t6W+0oZsLWPBEa8vnBmYnbdGU5a8n1XfB2x1Gs4lTg8Zbl0xivdR0xwb
         M4+cgk4k9/zlYSClAMsMTaUm7FzMsDq3oJJ71wpXwrgGTK7JyWTpm9qFOhMFx//vkvRg
         cOjL5ba6VEExAIN8CFZSV6KRpzpouV64SLPHY4ozsjz21qmUEoYhjmIwpA2fhSeZ5Fmp
         Fo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggA1Ugc3KslRh4zjEhH3fdMSzLQAduhmaopCk/UOZFk=;
        b=H4Z7YjOW1/lDRVTcR2QgDy7Fu8ZnyfpkDhdUNG0o/WKqff3uMXGqHuy08/X1jZbb2t
         kO4cufWFkrr7EoEEVkso4d7hBXkH6bGwWM8Fba9fpFjSLRNMpEQD0Pzk0YKQEq6ImPsa
         0ckAwm8KVSyQARX4h5EsFt32ttSIItcxwzU9SvsZdJiKRFXoLCcz6D8mITP5Uid6RqTq
         tYmT1rBnE0rBdi6ZTXzn5Ceabf6dvgNqBser4u+s7Po7Am5XSfzM48azf5SzTfLQWgDP
         zSUhP4b4eVYgnGzXGDhgbGQadb0VKNex4xbNqXmtLStp0SuwwFZkps22UJRktNvQYkY5
         PnEQ==
X-Gm-Message-State: AOAM531aqXmPQcKwo2e7YoCt/dvmc2QH4jqvL+StxYT+lM0ULFPE+POn
        SLGmzXq70JNEfTsdDG7AtYa3nGIFqyuSIwwqgPCTEw==
X-Google-Smtp-Source: ABdhPJx5argS7G0ZE4Ndif5Z03u12TS7Wh/djhLXROnVEBtAasfPOm/ZHCJwZ4+XDviQ56txkQW80rIx93/lbfzrazE=
X-Received: by 2002:a05:6512:1041:: with SMTP id c1mr6413556lfb.277.1628688722466;
 Wed, 11 Aug 2021 06:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
In-Reply-To: <20210730020019.1487127-3-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 11 Aug 2021 15:31:49 +0200
Message-ID: <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
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

On Fri, 30 Jul 2021 at 04:00, Josh Don <joshdon@google.com> wrote:
>
> This patch makes some behavioral changes when SCHED_IDLE entities are
> competing with non SCHED_IDLE entities.
>
> 1) Ignore min_granularity for determining the sched_slide of a
> SCHED_IDLE entity when it is competing with a non SCHED_IDLE entity.
> This reduces the latency of getting a non SCHED_IDLE entity back on cpu,
> at the expense of increased context switch frequency of SCHED_IDLE
> entities.
>
> In steady state competition between SCHED_IDLE/non-SCHED_IDLE,
> preemption is driven by the tick, so SCHED_IDLE min_granularity is
> approximately bounded on the low end by the tick HZ.
>
> Example: on a machine with HZ=1000, spawned two threads, one of which is
> SCHED_IDLE, and affined to one cpu. Without this patch, the SCHED_IDLE
> thread runs for 4ms then waits for 1.4s. With this patch, it runs for
> 1ms and waits 340ms (as it round-robins with the other thread).
>
> The benefit of this change is to reduce the round-robin latency for non
> SCHED_IDLE entities when competing with a SCHED_IDLE entity.
>
> 2) Don't give sleeper credit to SCHED_IDLE entities when they wake onto
> a cfs_rq with non SCHED_IDLE entities. As a result, newly woken
> SCHED_IDLE entities will take longer to preempt non SCHED_IDLE entities.
>
> Example: spawned four threads affined to one cpu, one of which was set
> to SCHED_IDLE. Without this patch, wakeup latency for the SCHED_IDLE
> thread was ~1-2ms, with the patch the wakeup latency was ~10ms.
>
> The benefit of this change is to make it less likely that a newly woken
> SCHED_IDLE entity will preempt a short-running non SCHED_IDLE entity
> before it blocks.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a7feae1cb0f0..24b2c6c057e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -674,6 +674,7 @@ static u64 __sched_period(unsigned long nr_running)
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>         unsigned int nr_running = cfs_rq->nr_running;
> +       struct sched_entity *init_se = se;
>         u64 slice;
>
>         if (sched_feat(ALT_PERIOD))
> @@ -684,12 +685,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
>                 struct load_weight lw;
> +               struct cfs_rq *qcfs_rq;
>
> -               cfs_rq = cfs_rq_of(se);
> -               load = &cfs_rq->load;
> +               qcfs_rq = cfs_rq_of(se);
> +               load = &qcfs_rq->load;
>
>                 if (unlikely(!se->on_rq)) {
> -                       lw = cfs_rq->load;
> +                       lw = qcfs_rq->load;
>
>                         update_load_add(&lw, se->load.weight);
>                         load = &lw;
> @@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 slice = __calc_delta(slice, se->load.weight, load);
>         }
>
> -       if (sched_feat(BASE_SLICE))
> -               slice = max(slice, (u64)w);
> +       if (sched_feat(BASE_SLICE)) {
> +               /*
> +                * SCHED_IDLE entities are not subject to min_granularity if
> +                * they are competing with non SCHED_IDLE entities. As a result,
> +                * non SCHED_IDLE entities will have reduced latency to get back
> +                * on cpu, at the cost of increased context switch frequency of
> +                * SCHED_IDLE entities.
> +                */

Ensuring that the entity will have a minimum runtime has been added to
ensure that we let enough time to move forward.
If you exclude sched_idle entities from this min runtime, the
sched_slice of an idle_entity will be really small.
I don't have details of your example above but I can imagine that it's
a 16 cpus system which means a sysctl_sched_min_granularity=3.75ms
which explains the 4ms running time of an idle entity
For a 16 cpus system, the sched_slice of an idle_entity in your
example in the cover letter is: 6*(1+log2(16))*3/1027=87us. Of course
this become even worse with more threads and cgroups or thread with
ncie prio -19

This value is then used to set the next hrtimer event in SCHED_HRTICK
and 87us is too small to make any progress

The 1ms of your test comes from the tick which could be a good
candidate for a min value or the
normalized_sysctl_sched_min_granularity which has the advantage of not
increasing with number of CPU

> +               if (!se_is_idle(init_se) ||
> +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
> +                       slice = max(slice, (u64)sysctl_sched_min_granularity);
> +       }
>
>         return slice;
>  }
> @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
>                         thresh >>= 1;
>
> -               vruntime -= thresh;
> +               /*
> +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> +                */
> +               if (!se_is_idle(se) ||
> +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)

Can't this condition above create unfairness between idle entities ?
idle thread 1 wake up while normal thread is running
normal thread thread sleeps immediately after
idle thread 2 wakes up just after and gets some credits compared to the 1st one.

> +                       vruntime -= thresh;
> +               else
> +                       vruntime += 1;
>         }
>
>         /* ensure we never gain time by being placed backwards. */
> --
> 2.32.0.554.ge1b32706d8-goog
>
