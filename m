Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1473142E4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhJOAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhJOAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:00:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00165C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:58:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g10so30889091edj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UFVb+LHDU4tIip/Q4J0HRxOtD9BMr/h60Nu3D8Mz3E=;
        b=HVsWThZnWthQLibcl3apmm3r/1QchqitrOhX+P9bi7zpj2nD3x6hfmKYUbMW/XL9Y2
         Ywvyx9Q1UaOUdjMONno/iWDodAAT3Q9wqnaiTPT4mQshLFihTemH5xY2RwmoaYYgB/kd
         8ckKMiuAWa1Ez6gAm1bPNdqPcQjg0Dc+Owcr94+59mtK8MATzlukaFNpTmLwEk4fkmdC
         zqLXV29MhBoLjHpjkdfoxiXelEnlECHi/acDfk3OqxwBVHlMUni/F4uZCzBZrzgT/mwX
         5ya44CStiznKnZGZ5FFl5dZbBtD8HmcfqF2XozfGyRplpN+YzonCesN6iJUOl40kNVZ5
         Okhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UFVb+LHDU4tIip/Q4J0HRxOtD9BMr/h60Nu3D8Mz3E=;
        b=p+BCfcF/mp6EPRd1vnOxQzkQm0FFPieEFhMm0XS8J7UB+NhEtZBhWAZ9ze4+kP/vo/
         myPP9X/0xykMFwG2XWJlBVmQnqBgvQAvJC5b6wmk00kotWg/Lm8rDYoCQ4jkYUbkuUO7
         hYxsi4X+lIxE6aML5zT2JmvZuhQMpK81VtD2OYcT2otWHM8lo8zqPGaxAY7DEkoBO3Cx
         nIOdEsq0QGC0NSzYy1IW1Hl0dKvjHfjHFuAK3ZK0lCJcBGja1TnDeNoM7n4c0KovW0NW
         zkjG9360c+yvbAbrIb9vyhrA1ZyRehwN7t9Y5ox6Pe3IgXDT6cSkyUW6JlXBpNFRQKcg
         Z1sA==
X-Gm-Message-State: AOAM530fp+rTp9toBBtmyii5ht/ygOdqm73GCYY4D99Q7D1b0NDiz3VH
        dHdG3NkPKavihA5memeVBJrrSe/w/rDge5UebCKTQA==
X-Google-Smtp-Source: ABdhPJw+SwMvw4+0oDZsNoxvQ3qfo+yUncjOBG/c+GsziKgc9PSTmxmIS+AKHbU5AaAM9dCazxLOtuKEzgzYh7LDFG8=
X-Received: by 2002:a17:906:1db2:: with SMTP id u18mr2667552ejh.227.1634255907339;
 Thu, 14 Oct 2021 16:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <CA+khW7g+HbLRWTV8vuo-oQ3ROv_ZnuSNMWA_pVp-BQGqT2d9-g@mail.gmail.com>
 <CABk29NvPz3hDehsLC3z_Jpstr3BveL_XZBg_kcjqg9ewkH0RfQ@mail.gmail.com>
 <CA+khW7gMbZYr28ZYZXUJZhXJ9y-9KD+v49j9Yxr+9vk7CEGxOg@mail.gmail.com> <CABk29NtBU4EiruRtvmjrw+AKTQZEpvrY3JSVH0HR_ef9Wj3BfA@mail.gmail.com>
In-Reply-To: <CABk29NtBU4EiruRtvmjrw+AKTQZEpvrY3JSVH0HR_ef9Wj3BfA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 14 Oct 2021 16:58:15 -0700
Message-ID: <CA+khW7gKffoo3w4trftC2D1ewPc4YpK4G3S6sZb5JtOOQrRUKA@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 4:29 PM Josh Don <joshdon@google.com> wrote:
>
> On Thu, Oct 14, 2021 at 10:58 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 5:31 PM Josh Don <joshdon@google.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 10:33 AM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Thu, Oct 7, 2021 at 5:08 PM Josh Don <joshdon@google.com> wrote:
> > > > > -void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> > > > > +void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
> > > > >  {
> > > > >         rq->core->core_task_seq++;
> > > > >
> > > > > -       if (!sched_core_enqueued(p))
> > > > > -               return;
> > > > > +       if (sched_core_enqueued(p)) {
> > > > > +               rb_erase(&p->core_node, &rq->core_tree);
> > > > > +               RB_CLEAR_NODE(&p->core_node);
> > > > > +       }
> > > > >
> > > > > -       rb_erase(&p->core_node, &rq->core_tree);
> > > > > -       RB_CLEAR_NODE(&p->core_node);
> > > > > +       /*
> > > > > +        * Migrating the last task off the cpu, with the cpu in forced idle
> > > > > +        * state. Reschedule to create an accounting edge for forced idle,
> > > > > +        * and re-examine whether the core is still in forced idle state.
> > > > > +        */
> > > > > +       if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
> > > > > +           rq->core->core_forceidle && rq->curr == rq->idle)
> > > > > +               resched_curr(rq);
> > > >
> > > > Resched_curr is probably an unwanted side effect of dequeue. Maybe we
> > > > could extract the check and resched_curr out into a function, and call
> > > > the function outside of sched_core_dequeue(). In that way, the
> > > > interface of dequeue doesn't need to change.
> > >
> > > This resched is an atypical case; normal load balancing won't steal
> > > the last runnable task off a cpu. The main reasons this resched could
> > > trigger are: migration due to affinity change, and migration due to
> > > sched core doing a cookie_steal. Could bubble this up to
> > > deactivate_task(), but seems less brittle to keep this in dequeue()
> > > with the check against DEQUEUE_SAVE (since this creates an important
> > > accounting edge). Thoughts?
> > >
> >
> > I prefer bubbling it up to deactivate_task(). Depending on how many
> > callers of deactivate_task() need this resched, IMHO it is even fine
> > to put it in deactivate_task's caller. Wrapping it in a function may
> > help clarify its purpose.
>
> I'd argue against bubbling up above deactivate_task(); makes things
> much more brittle if a new use for deactivate_task() is added in the
> future.
>
> Tried both ways; IMO it seems slightly better to leave in dequeue() vs
> deactivate(); less confusing to one hook instead of two for coresched
> to handle dequeuing a task.
>

Ack. No problem. I don't have strong objections here.

> > > > >         /*
> > > > > @@ -5765,7 +5782,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > > >         for_each_cpu_wrap(i, smt_mask, cpu) {
> > > > >                 rq_i = cpu_rq(i);
> > > > >
> > > > > -               if (i != cpu)
> > > > > +               if (i != cpu && (rq_i != rq->core || !core_clock_updated))
> > > > >                         update_rq_clock(rq_i);
> > > >
> > > > Do you mean (rq_i != rq->core && !core_clock_updated)? I thought
> > > > rq->core has core_clock updated always.
> > >
> > > rq->clock is updated on entry to pick_next_task(). rq->core is only
> > > updated if rq == rq->core, or if we've done the clock update for
> > > rq->core above.
> >
> > I meant 'if (i != cpu && rq_i != rq->core)'. Because at this point,
> > core_clock should already have been updated, is that not the case?
> > Anyway, the tracking of clock updates here is too confusing to me.
>
> Added a comment here, but the logic flow is:
> - rq->clock is always updated on entry to pick_next_task()
> - rq->core->clock _may_ be updated by the time we get to this part of
> pick_next_task(). We have to be careful to avoid a double update,
> hence the need for the core_clock_updated var.

Yeah. Sync'ed offline and that cleared my confusion. Thanks.

Hao
