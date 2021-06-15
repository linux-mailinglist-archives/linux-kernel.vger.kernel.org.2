Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839803A8447
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFOPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhFOPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:47:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:45:39 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso14694949otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wfYzz2CmAJsu+2hnMlY0behDy08H8rMev+ao8dy4SQ=;
        b=HWV8y3DzdVXrHFfV2pgTwzn5mbUCoeyaNq9wPVqrDL9nx0X2uLUqoY6GLtQwJWk6/x
         m6AtwMZl4XjgDOjXeGH0exXFh4WQYR5yidhqrjCzftCnHTIAk4bJ9rtvOXTua8zFQtUE
         2NX5hchf07CcKzzENympkhIjPmFnMUS2ll4GR96sFadgLRo3adwCwilBFxKrEjKrkjSp
         PaGmFx5uLEcGbycSZYCOFQD16d3ha2epeCCoG7Sdm6jszjR7fzkTqh+udrMrsuh19NiN
         q430V/FCnvIBaqIDGiFghkCVHqtZPCqs6su/pZ2JqiAMzmV5hYS1Mdzx4A2mTjhMjHfw
         x7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wfYzz2CmAJsu+2hnMlY0behDy08H8rMev+ao8dy4SQ=;
        b=IfkT0bKK0Jts8ioBF78ZXflOgxKA7bSEAEdAGxSAonF/4ywMq4KoJu0rxRMgovFWub
         Lt3vyzKamcfrIHLk/VngGfd8ok9maibfeE1GXa4zSHte8Rq93NPBmr3dO4hS5QQH8niV
         PYv9ZFEfoeFj3cJfkRGOi1UHEUeUdOXDyINoAJ12F7apatDJPle+Eo2TdoJ7vhP+4Mma
         LcbY8EmvoXfMVX8nxk2iWK4rEHoKShJ4M2DzWk0WrXT0ImQr1/VzhB1noZmjciYqKzcL
         0Gl6+gg0g76CmYG5JM5S0f+yaFk+5hnaPVUuJBT9CtYw1y7nd3bFtr4SHuhomYAIQNJY
         XJjQ==
X-Gm-Message-State: AOAM5309jvLrkDq+QiDiHebgZ6SUFlM7Xhxafb/kNTRtPUokm4VBRtch
        sTSM7Cx6Foi4+pGgQrO5H2t916sNRKItMWBZt2lqeA==
X-Google-Smtp-Source: ABdhPJxy8+v77i4Ow6kkTQtrc1qQDfkfp/r4jZYUGeYD2QNQf6c37/797b0w5wrvF683e+K/oor6PdXlQUpQdNmNfmc=
X-Received: by 2002:a9d:bc4:: with SMTP id 62mr18222811oth.253.1623771938398;
 Tue, 15 Jun 2021 08:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210615121551.31138-1-laoar.shao@gmail.com> <87mtrrb2jw.mognet@arm.com>
In-Reply-To: <87mtrrb2jw.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Jun 2021 17:45:26 +0200
Message-ID: <CAKfTPtDj6E00o4ZFDJ+kJKqy8J3oLm-mVSajUnHpufFCRiX_8g@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 16:55, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> Hi,
>
> On 15/06/21 20:15, Yafang Shao wrote:
>
> > - Prev version
> >   https://lore.kernel.org/lkml/CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com/
> >
> > - Similar discussion
> >   https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
>
> I knew that sounded familiar :-)
>
> > ---
> >  kernel/sched/fair.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3248e24a90b0..597c7a940746 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                       /* Record that we found at least one task that could run on this_cpu */
> >                       env.flags &= ~LBF_ALL_PINNED;
> >
> > +                     /*
> > +                      * There may be a race between load balance starting migration
> > +                      * thread to pull the cfs running thread and the RT thread
> > +                      * waking up and preempting cfs task before migration threads
> > +                      * which then preempt the RT thread.
> > +                      * We'd better do the last minute check before starting
> > +                      * migration thread to avoid preempting latency-sensitive thread.
> > +                      */
>
> This can be summarized as in the below, no?
>
>                         /*
>                          * Don't cause a higher-than-CFS task to be preempted by
>                          * the CPU stopper.
>                          */

IMO, it's worth keeping the explanation that we are there because:
- a CFS task that was running during the 1st step :  if
(busiest->nr_running > 1) { ...
so we didn't pull the task
- but it has been preempted while lb was deciding if it needs an
active load balance

so maybe something like:
                         /*
                          * Don't kick the active_load_balance_cpu_stop,
                          * if the CFS task has been preempted by higher
                          * priority task in the meantime.
                         */


>
> > +                     if (busiest->curr->sched_class != &fair_sched_class) {
> > +                             raw_spin_unlock_irqrestore(&busiest->lock,
> > +                                                        flags);
> > +                             goto out;
>
> Since you goto out this could be moved before the
>
>   env.flags &= ~LBF_ALL_PINNED;
>
> above (it only has an impact if you'd goto out_balanced).

Good point. My comment to move this test after  env.flags &=
~LBF_ALL_PINNED; was valid only with goto out_one_pinned

>
> > +                     }
> > +
>
> Other than the above, this looks OK to me.
>
> Back then I had argued that having a >CFS task and holding the remote rq
> lock could let us invoke detach_one_task() locally (rather than on the
> stopper thread), but realistically if we got to this !ld_moved condition
> then the chances of us actually pulling something here are very slim (we'd
> depend on enqueues happening between ~detach_tasks() and here).
>
> >                       /*
> >                        * ->active_balance synchronizes accesses to
> >                        * ->active_balance_work.  Once set, it's cleared
> > --
> > 2.17.1
