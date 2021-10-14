Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC342E09D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJNSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhJNSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:00:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79DC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:58:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w19so27408384edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzzZ9zkU/GUllV4qZRlQlXmUhGeFbkVWbMGx4KIDiWM=;
        b=inL8IE0B8R5+csw292SRTdl7ZmlAuRjKavBx4sj7PLeCF/ew7YyTPRzex2JQ8TRhAv
         uI6hWCn0HY1TCWaC6nuc+5JXEjnolA0T/YEc/yDq4ToMjXKWQwAb4Nz5l5/B/QqtlRqq
         n5Tx5VX8Lb/hWZ1zHGGvzMn7p5Ca8IHFJ5LEeFso8k8mtYl5bjIgIAxhlwksu3Bslnbu
         sEWvP5bqEAH8qbxc4KNr9/Sj+PMoDgcuCoUY7bI7MBpwwsylOa+if5KDcn9f5Or1DpjN
         e89WH00hPGPLXrveaIMeNFhirz3GRBtn+TKcbCc/pgF7ndNmAuKime+BEHyfgzjFjHKB
         ukfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzzZ9zkU/GUllV4qZRlQlXmUhGeFbkVWbMGx4KIDiWM=;
        b=OikbmiPwxAyWsc7tAwkVKj5DJ0tfUCdIsT5YCYqbc1Tqfu4Wl5bGKBMBZY5Ri8kXsy
         PUT5z32Tk4NKaVVkYBDPUsPagFxUns4MtThDEaKKLNdMRZihTfAfXBpy7bSPFEO4fUKN
         B1TzrhfXfN6TVnhNV17Zkw9q7CU03y4azF3+yn7NTX3A6Es3yvAsJwQSts2Az6njPN4n
         Cuu4x9PDItHI/CGbHpV8KXfiXpkn+AoWQK86ryge3OZsdNNCRFyyURNuHOGjG9lOWVkY
         gtOuO0Yso7cFDHjer0jYtyeP8tQSCyUDW0XxTlapCtztbt4TqF0FalllWnlPo91vRSs0
         DtTw==
X-Gm-Message-State: AOAM530pY8srIitazQLUqBx0y2u5MrmZZwoLQPIKRFUV9tEJPgC4m5Pa
        ySHi6HdENwRb3fxdSPZ7BoGAxsy86RHFPCthLxj/bA==
X-Google-Smtp-Source: ABdhPJxpvBvBy4AAtoynZ15+L/fkTAStlyZssTv8oren+5LKKzuKh3vL9jPMb0Neg1gC0cETKMTxl+JXjMSWwtgT6aI=
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr418348ejb.519.1634234277996;
 Thu, 14 Oct 2021 10:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <CA+khW7g+HbLRWTV8vuo-oQ3ROv_ZnuSNMWA_pVp-BQGqT2d9-g@mail.gmail.com>
 <CABk29NvPz3hDehsLC3z_Jpstr3BveL_XZBg_kcjqg9ewkH0RfQ@mail.gmail.com>
In-Reply-To: <CABk29NvPz3hDehsLC3z_Jpstr3BveL_XZBg_kcjqg9ewkH0RfQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 14 Oct 2021 10:57:46 -0700
Message-ID: <CA+khW7gMbZYr28ZYZXUJZhXJ9y-9KD+v49j9Yxr+9vk7CEGxOg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 5:31 PM Josh Don <joshdon@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 10:33 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Thu, Oct 7, 2021 at 5:08 PM Josh Don <joshdon@google.com> wrote:
> > > -void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> > > +void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
> > >  {
> > >         rq->core->core_task_seq++;
> > >
> > > -       if (!sched_core_enqueued(p))
> > > -               return;
> > > +       if (sched_core_enqueued(p)) {
> > > +               rb_erase(&p->core_node, &rq->core_tree);
> > > +               RB_CLEAR_NODE(&p->core_node);
> > > +       }
> > >
> > > -       rb_erase(&p->core_node, &rq->core_tree);
> > > -       RB_CLEAR_NODE(&p->core_node);
> > > +       /*
> > > +        * Migrating the last task off the cpu, with the cpu in forced idle
> > > +        * state. Reschedule to create an accounting edge for forced idle,
> > > +        * and re-examine whether the core is still in forced idle state.
> > > +        */
> > > +       if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
> > > +           rq->core->core_forceidle && rq->curr == rq->idle)
> > > +               resched_curr(rq);
> >
> > Resched_curr is probably an unwanted side effect of dequeue. Maybe we
> > could extract the check and resched_curr out into a function, and call
> > the function outside of sched_core_dequeue(). In that way, the
> > interface of dequeue doesn't need to change.
>
> This resched is an atypical case; normal load balancing won't steal
> the last runnable task off a cpu. The main reasons this resched could
> trigger are: migration due to affinity change, and migration due to
> sched core doing a cookie_steal. Could bubble this up to
> deactivate_task(), but seems less brittle to keep this in dequeue()
> with the check against DEQUEUE_SAVE (since this creates an important
> accounting edge). Thoughts?
>

I prefer bubbling it up to deactivate_task(). Depending on how many
callers of deactivate_task() need this resched, IMHO it is even fine
to put it in deactivate_task's caller. Wrapping it in a function may
help clarify its purpose.

> > >         /*
> > > @@ -5765,7 +5782,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >         for_each_cpu_wrap(i, smt_mask, cpu) {
> > >                 rq_i = cpu_rq(i);
> > >
> > > -               if (i != cpu)
> > > +               if (i != cpu && (rq_i != rq->core || !core_clock_updated))
> > >                         update_rq_clock(rq_i);
> >
> > Do you mean (rq_i != rq->core && !core_clock_updated)? I thought
> > rq->core has core_clock updated always.
>
> rq->clock is updated on entry to pick_next_task(). rq->core is only
> updated if rq == rq->core, or if we've done the clock update for
> rq->core above.

I meant 'if (i != cpu && rq_i != rq->core)'. Because at this point,
core_clock should already have been updated, is that not the case?
Anyway, the tracking of clock updates here is too confusing to me.
