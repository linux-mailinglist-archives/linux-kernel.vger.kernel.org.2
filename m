Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345CA429A78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhJLAeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhJLAeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:34:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7664C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:31:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s4so42810279ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3S62nvOHjceE7OYCQfU8AzRtrSAtZeU322vT6Q84Ffk=;
        b=XHQTeHQPS0PjyB1Vm5EaNuYtJemY2DtY3b2aoOM1jPIXuy2FYfGrVklvUz4WycyF3m
         /+y2RZ6Q1B7r65FNFTUMdJ4zEFFnFQYQOYpkt/rOjtZaMYBobDDFeijXtdhlatRGkqBc
         gvovPmjfIxB3ikKZKInFvUTrnemtgV0mwbgSImuL+RI7Z5sunNDEbRJnWV+g6R9/ud2B
         y6b2vdX5PtLT1xzy0BIc9SP9OQX8lHU7pInxDCX2ivCq1pzv1+tRa5x5QdWJDBEwVltd
         DZnUoCnaCi5VM+SvHwfU2RMBdDfJ7Z3mh8hlRX6GiKnuuDJXEynPuBaXc+keWPqBRhbA
         yCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3S62nvOHjceE7OYCQfU8AzRtrSAtZeU322vT6Q84Ffk=;
        b=qyh6BIQ3HV9zhVd5zg4fHRyex86zcAhazOVzx56HejaweANh5nD/9c6h/kVyu3dCkb
         1aBtKjOXGUGKg2XCGndlP4Iysa96EZJzTGSXtZWkoF1A7Zl0vdaMUPrw4YyFCa7cmPLm
         jW33wxIUsnpPF49NOVojQoc0rHAq8iaPzfnHGhJy7/sGhvKXFQwDEQXyGrKVf0DppFmK
         XGw8KVDxDYZwycfAGt6aIx6Qrm6tWrn0wKG80R/dr4J/7ssy3+kswBCI3gTncccJquJG
         dal+J0xR9DMbaf1SqnsjjnivnPrmDRM4Zi388K801rUKU2/8eMISXbV//bFy9BdsaCJW
         sUzw==
X-Gm-Message-State: AOAM531QZ7QlDCBxwGo3Gy2rNgJS/qsM1bYTckaj0xS+RjmZW52ShpUw
        PKPNUTrLDwMoFVjmgsmh8hTmqVzjUxVhwuKPHCCung==
X-Google-Smtp-Source: ABdhPJzlvFm5xgBenGw3cXmywxLZcwEbpxxUcVyY1uvZhTm+uV/Sw7dcxz3GDgSmH0Hnm+l2wjW/unwzv4W279GdJVo=
X-Received: by 2002:a25:1346:: with SMTP id 67mr25663864ybt.405.1633998712255;
 Mon, 11 Oct 2021 17:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <CA+khW7g+HbLRWTV8vuo-oQ3ROv_ZnuSNMWA_pVp-BQGqT2d9-g@mail.gmail.com>
In-Reply-To: <CA+khW7g+HbLRWTV8vuo-oQ3ROv_ZnuSNMWA_pVp-BQGqT2d9-g@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 11 Oct 2021 17:31:41 -0700
Message-ID: <CABk29NvPz3hDehsLC3z_Jpstr3BveL_XZBg_kcjqg9ewkH0RfQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Hao Luo <haoluo@google.com>
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

On Mon, Oct 11, 2021 at 10:33 AM Hao Luo <haoluo@google.com> wrote:
>
> On Thu, Oct 7, 2021 at 5:08 PM Josh Don <joshdon@google.com> wrote:
> > -void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> > +void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >         rq->core->core_task_seq++;
> >
> > -       if (!sched_core_enqueued(p))
> > -               return;
> > +       if (sched_core_enqueued(p)) {
> > +               rb_erase(&p->core_node, &rq->core_tree);
> > +               RB_CLEAR_NODE(&p->core_node);
> > +       }
> >
> > -       rb_erase(&p->core_node, &rq->core_tree);
> > -       RB_CLEAR_NODE(&p->core_node);
> > +       /*
> > +        * Migrating the last task off the cpu, with the cpu in forced idle
> > +        * state. Reschedule to create an accounting edge for forced idle,
> > +        * and re-examine whether the core is still in forced idle state.
> > +        */
> > +       if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
> > +           rq->core->core_forceidle && rq->curr == rq->idle)
> > +               resched_curr(rq);
>
> Resched_curr is probably an unwanted side effect of dequeue. Maybe we
> could extract the check and resched_curr out into a function, and call
> the function outside of sched_core_dequeue(). In that way, the
> interface of dequeue doesn't need to change.

This resched is an atypical case; normal load balancing won't steal
the last runnable task off a cpu. The main reasons this resched could
trigger are: migration due to affinity change, and migration due to
sched core doing a cookie_steal. Could bubble this up to
deactivate_task(), but seems less brittle to keep this in dequeue()
with the check against DEQUEUE_SAVE (since this creates an important
accounting edge). Thoughts?

> >         /*
> > @@ -5765,7 +5782,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >         for_each_cpu_wrap(i, smt_mask, cpu) {
> >                 rq_i = cpu_rq(i);
> >
> > -               if (i != cpu)
> > +               if (i != cpu && (rq_i != rq->core || !core_clock_updated))
> >                         update_rq_clock(rq_i);
>
> Do you mean (rq_i != rq->core && !core_clock_updated)? I thought
> rq->core has core_clock updated always.

rq->clock is updated on entry to pick_next_task(). rq->core is only
updated if rq == rq->core, or if we've done the clock update for
rq->core above.
