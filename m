Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2642E4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhJNXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhJNXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:31:52 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14711C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:29:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g6so18462580ybb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsDpkkM48w55tAC+PAM7opPGkWH4d4hVmNbpW7NKStI=;
        b=lBQC67EIWE6Ugi69EFl2W1j2T+DvsujkRxl8O2TcKWIhoKpk/Jimhj20Qtotb/2e/m
         mf+2IewHH9uaEk+jTMSI65e8Uc/Rkm/PNhDq4a0yAMRk1Z2p+t38kOo/AFCtOk+85fhO
         W1/9gX1V+mZrySoY9AFME9y7did+bT+1Bw25n3g2rvp+/dc0IjvI+ikKAP4Y42eSClxW
         rLj0zkpUmuu/KnqFuBNrPt4+0KwuyyOU9VFeci8z5pyHQiSW17SEwkzWJ6QgE5Wmcw7Z
         waTToFaZItmunteD0k6+y5CiIiIr5C0a+WV5iSby1Jvuhv9M4kR6YbZBOkRgjjZIYiJ4
         YKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsDpkkM48w55tAC+PAM7opPGkWH4d4hVmNbpW7NKStI=;
        b=AeW60CFJIEBE4N2weQ04AfrRSxoyjaaIW1CU85m991crhMkkA98DvHuVGoHU7RTZUO
         oYfz/DDw3a9bpZuU3N0fBeBHnScGLX/0NSHqj8cByB9dVe2zbmoso2n8TQAPk6UAQj5I
         eCPXpO6EZwE0TV9idLMGMeooi/bGgwAfLvxrvAEPqecTWWtTL7QBi8wgATu3SAjwrKv0
         SmXGO02LpxAEIut3883kFCTxjo2nYr7AbEio4RXfOkOTxg6Vlzp5jP6UeAluvoZA4u9e
         3jF6jQ3pZL5x0NKF+UaYoqAmondC5FFwYWDvlI/RtgkqY5pR+Pu/JKBeXtKI292359q2
         CVUQ==
X-Gm-Message-State: AOAM531OUHPhuupjtz3rG0MPlov0tvou+LiX5+CB2LGwGy50jQgr21J4
        hqS2jd4ZhS1pPHyv0sktm+1t5aMHgwZIvc4rw51Xlw==
X-Google-Smtp-Source: ABdhPJw+WZl2OFqIvRJYy4IBi4VAAVbJmN/0bHcQO3Si7SjuVVEmqe9alHcxFnz949nQvNjyf5aKzLcvVlhgVrr7kUQ=
X-Received: by 2002:a25:9847:: with SMTP id k7mr9535993ybo.170.1634254185767;
 Thu, 14 Oct 2021 16:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <CA+khW7g+HbLRWTV8vuo-oQ3ROv_ZnuSNMWA_pVp-BQGqT2d9-g@mail.gmail.com>
 <CABk29NvPz3hDehsLC3z_Jpstr3BveL_XZBg_kcjqg9ewkH0RfQ@mail.gmail.com> <CA+khW7gMbZYr28ZYZXUJZhXJ9y-9KD+v49j9Yxr+9vk7CEGxOg@mail.gmail.com>
In-Reply-To: <CA+khW7gMbZYr28ZYZXUJZhXJ9y-9KD+v49j9Yxr+9vk7CEGxOg@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 14 Oct 2021 16:29:34 -0700
Message-ID: <CABk29NtBU4EiruRtvmjrw+AKTQZEpvrY3JSVH0HR_ef9Wj3BfA@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 10:58 AM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 5:31 PM Josh Don <joshdon@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 10:33 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Thu, Oct 7, 2021 at 5:08 PM Josh Don <joshdon@google.com> wrote:
> > > > -void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> > > > +void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
> > > >  {
> > > >         rq->core->core_task_seq++;
> > > >
> > > > -       if (!sched_core_enqueued(p))
> > > > -               return;
> > > > +       if (sched_core_enqueued(p)) {
> > > > +               rb_erase(&p->core_node, &rq->core_tree);
> > > > +               RB_CLEAR_NODE(&p->core_node);
> > > > +       }
> > > >
> > > > -       rb_erase(&p->core_node, &rq->core_tree);
> > > > -       RB_CLEAR_NODE(&p->core_node);
> > > > +       /*
> > > > +        * Migrating the last task off the cpu, with the cpu in forced idle
> > > > +        * state. Reschedule to create an accounting edge for forced idle,
> > > > +        * and re-examine whether the core is still in forced idle state.
> > > > +        */
> > > > +       if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
> > > > +           rq->core->core_forceidle && rq->curr == rq->idle)
> > > > +               resched_curr(rq);
> > >
> > > Resched_curr is probably an unwanted side effect of dequeue. Maybe we
> > > could extract the check and resched_curr out into a function, and call
> > > the function outside of sched_core_dequeue(). In that way, the
> > > interface of dequeue doesn't need to change.
> >
> > This resched is an atypical case; normal load balancing won't steal
> > the last runnable task off a cpu. The main reasons this resched could
> > trigger are: migration due to affinity change, and migration due to
> > sched core doing a cookie_steal. Could bubble this up to
> > deactivate_task(), but seems less brittle to keep this in dequeue()
> > with the check against DEQUEUE_SAVE (since this creates an important
> > accounting edge). Thoughts?
> >
>
> I prefer bubbling it up to deactivate_task(). Depending on how many
> callers of deactivate_task() need this resched, IMHO it is even fine
> to put it in deactivate_task's caller. Wrapping it in a function may
> help clarify its purpose.

I'd argue against bubbling up above deactivate_task(); makes things
much more brittle if a new use for deactivate_task() is added in the
future.

Tried both ways; IMO it seems slightly better to leave in dequeue() vs
deactivate(); less confusing to one hook instead of two for coresched
to handle dequeuing a task.

> > > >         /*
> > > > @@ -5765,7 +5782,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > >         for_each_cpu_wrap(i, smt_mask, cpu) {
> > > >                 rq_i = cpu_rq(i);
> > > >
> > > > -               if (i != cpu)
> > > > +               if (i != cpu && (rq_i != rq->core || !core_clock_updated))
> > > >                         update_rq_clock(rq_i);
> > >
> > > Do you mean (rq_i != rq->core && !core_clock_updated)? I thought
> > > rq->core has core_clock updated always.
> >
> > rq->clock is updated on entry to pick_next_task(). rq->core is only
> > updated if rq == rq->core, or if we've done the clock update for
> > rq->core above.
>
> I meant 'if (i != cpu && rq_i != rq->core)'. Because at this point,
> core_clock should already have been updated, is that not the case?
> Anyway, the tracking of clock updates here is too confusing to me.

Added a comment here, but the logic flow is:
- rq->clock is always updated on entry to pick_next_task()
- rq->core->clock _may_ be updated by the time we get to this part of
pick_next_task(). We have to be careful to avoid a double update,
hence the need for the core_clock_updated var.
