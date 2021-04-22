Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8722936858F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhDVRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhDVRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:10:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:09:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t14so16168288lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k0hnNuOG3QRzXOhhHlFC+IlgbwmTQXTG7uqldPEFX4=;
        b=UG9HTnyqjD2eRDdyDn5/wwES3kEbUb3/iOm5X2ZMSmkYyNJ34qt3Nh03sG97Y3Cpb7
         8STzfjT03MF4NWdNt/UclyvnG7v7z+kSGpXFy/2o96xIXRoc/kpiuS4DPf8no64hBnXj
         /eWS1vm8pfm6M64EHAcNYGWxDUJ9yeFo6zKwtMxKP3Tei9SWn0nQh2j08f9oTOUlsN2H
         8AtuEdJroDLuKSpy4JBVB39B/d7mcDcbNHsy5KVNL9xMsVbgmo+ZpNac1QoROLXPC7Cu
         G7W6QZFFdFn1OiLlm1BYg9IY/oybgyAsJt0vFwkU2vgBMLwUks2ebeMN3PPpt/rlDVrF
         e6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k0hnNuOG3QRzXOhhHlFC+IlgbwmTQXTG7uqldPEFX4=;
        b=Mb3dkP5Nzrc5I96THeNDHOn23IKd7FE3Del3qfSV3PRDEJlsmeL3Ebwn0ogIuR/z5H
         p5Yk7bkNb/phelhr4YE2YQrkJWo1YaczQy073LeCUk9nhqiHAihSV8EXx+EATLltSXyX
         i5VXgoF4YEA2WqAZXFYdmrjqIDo+pf7WTBbIUYndOBmIt5nLSadGcR0E7LfeWLjITYZ8
         ES0cvV/ZbRDdLO7G413hstxqDCBk96mUWqvVtliDAwCR9v0X6KIbtUy6hKfaIbgvZT37
         lEcbT5Urx7CHSuewXqLvzq7yEXIfEfN9NSoSNVBP2kSjMoM2mSTTji0NzGrEsDQ+9JwQ
         fItQ==
X-Gm-Message-State: AOAM530WgEhv8IPJ9r1RfJxHGMYfe73TV4UWtXuHtB8DmWQn7lm3kl8K
        s6DrHHbJ9IZtvTronImkMKGRasGcyKs+4XCEsWHBug==
X-Google-Smtp-Source: ABdhPJydGs0qRCEWgyCtCehMM4IgVNNvDuwXDx2BM1/gklS9Da8tHIoxO8T4is4zSl9yxtw2NjEULfKD7FWKgtezToM=
X-Received: by 2002:a19:a416:: with SMTP id q22mr3434882lfc.305.1619111397911;
 Thu, 22 Apr 2021 10:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210422130236.0bb353df@imladris.surriel.com>
In-Reply-To: <20210422130236.0bb353df@imladris.surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Apr 2021 19:09:46 +0200
Message-ID: <CAKfTPtBM=H53Vu+qXZROBwV6UAuNzf-m6eJBk=cPGS4aoQxzyg@mail.gmail.com>
Subject: Re: [PATCH v4] sched,fair: Skip newidle_balance if a wakeup is pending
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 at 19:02, Rik van Riel <riel@surriel.com> wrote:
>
> The try_to_wake_up function has an optimization where it can queue
> a task for wakeup on its previous CPU, if the task is still in the
> middle of going to sleep inside schedule().
>
> Once schedule() re-enables IRQs, the task will be woken up with an
> IPI, and placed back on the runqueue.
>
> If we have such a wakeup pending, there is no need to search other
> CPUs for runnable tasks. Just skip (or bail out early from) newidle
> balancing, and run the just woken up task.
>
> For a memcache like workload test, this reduces total CPU use by
> about 2%, proportionally split between user and system time,
> and p99 and p95 application response time by 10% on average.
> The schedstats run_delay number shows a similar improvement.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69680158963f..6a18688a37f8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10594,6 +10594,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         u64 curr_cost = 0;
>
>         update_misfit_status(NULL, this_rq);
> +
> +       /*
> +        * There is a task waiting to run. No need to search for one.
> +        * Return 0; the task will be enqueued when switching to idle.
> +        */
> +       if (this_rq->ttwu_pending)
> +               return 0;
> +
>         /*
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
>          * measure the duration of idle_balance() as idle time.
> @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                  * Stop searching for tasks to pull if there are
>                  * now runnable tasks on this rq.
>                  */
> -               if (pulled_task || this_rq->nr_running > 0)
> +               if (pulled_task || this_rq->nr_running > 0 ||
> +                   this_rq->ttwu_pending)
>                         break;
>         }
>         rcu_read_unlock();
> --
> 2.25.4
>
>
