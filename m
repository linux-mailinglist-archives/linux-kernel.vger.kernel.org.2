Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6D44BD49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKJIwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhKJIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:52:43 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440ADC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:49:56 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so4599767ybc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdY7UHYrrQKUh664qRerLGbjRpq6Ut9+FyTMES+mZMA=;
        b=adkFPVgInFqFZaK3aYlFhHDbqe1L/NtOxaJNQDr6Mtb6K0LJTBb1HjR6ZuL21GX0HS
         0vldBJFBDAvrwoyMnYkbLuJJzjU7HI9+/M527Q1B8eIyro2wVZBR5FGVcqin18SGDUoE
         qmWMJfe4BKuUEEKy5RoxUuJqJYv2slbA7uBqN8DU/5Nojf7LP8MS42SCBFK4KgA46WFY
         p5Ai/URphyJiuQyHuWY4gtqnBWMX7iydkJaN9xIv+DuCUSPD2ve+G8UHcZbCnCghulqy
         pxPSyhAoOvlrWMG7k93Dan66vODdgbMPKaLW9/YJuXop4Vkv1tqOZnZcvh0GPClgTV8D
         1KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdY7UHYrrQKUh664qRerLGbjRpq6Ut9+FyTMES+mZMA=;
        b=D6DznaZm0b5/7S3HIdQ4FQRY0+ynVcOZ6sSfzZHMllX9IxIZ1GeIxnjpo/QASlULfM
         Elmt9TVPBPNwe59dJby0NbXpb8BscGlTuxTk7hUDkEp7rX8MUrmFhRMh1yVACU1XBQbP
         ZqBvut/598DtlF9ky8NaiZlJeJvqgfFelJ1pFswFDmdgusitYcOu6rfvLIslHdAlNOz2
         j9UeFte9CjTmB2ly7U58jNGJGcQ9hb9CzPN3z/lDF7/c8l/7uPT/okyBVQ/qfHazu0yE
         iiKZfNzpXj25sXSdDm9THFuT4wTKI4eE90gM2HiIvQXfg7IJT8EpFq/eVovmGF/tLx7s
         nyfQ==
X-Gm-Message-State: AOAM532bzfmcvCXlJJGWXTJU0FNZGclvXmvAy94EXe/fVhNHPzzOwD3R
        3n3mb/cyXxZtpDMKy+YcZmfsvbyhshTl8Lcm7i+0ieFJVLkBgQ==
X-Google-Smtp-Source: ABdhPJyiByNSWYWf4OWZb3PV1Mje8S/tHcHo299QTRuWZG5r1Tj6CfGJov0W5akiZe9Gtq+/t5qYWaZrzCFi2s2swYE=
X-Received: by 2002:a25:d707:: with SMTP id o7mr16002187ybg.546.1636534195291;
 Wed, 10 Nov 2021 00:49:55 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
In-Reply-To: <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Nov 2021 09:49:44 +0100
Message-ID: <CAKfTPtAVQ+mtYkGv5xJnbjBO9L9z7jSKOvzhObd0MvVpxakezw@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 15:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > CC peterz as well for rt and timekeeping magic
> >
> > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > In an EAS enabled system, there are two scenarios discordant to current design,
> > >
> > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > RT task usually preempts CFS task in little core.
> > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > ignore the preempted time by RT, DL and Irqs.
>
> It ignores preemption full-stop. I don't see why RT/IRQ should be
> special cased here.
>
> > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > via the proportion of cfs_rq's utilization on the whole rq.
>
>
> > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > +{
> > > +   struct rq *rq = task_rq(current);
> > > +   unsigned long growth_fixed = (unsigned long)growth;
> > > +
> > > +   if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > +           return growth_fixed;
> > > +
> > > +   if (current->in_memstall)
> > > +           growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > +                                   - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > +
> > > +   return growth_fixed;
> > > +}
> > > +
> > >  static void init_triggers(struct psi_group *group, u64 now)
> > >  {
> > >     struct psi_trigger *t;
> > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > >     }
> > >
> > >     if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > +           delta = psi_memtime_fixup(delta);
> >
> > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > period of an active reclaimer, since it's technically not stalled on
> > memory during this time but on CPU.
> >
> > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > are sleeping on refaults swapins, since they are not affected by what
> > is going on on the CPU.
>
> I think that focus on RT/IRQ is mis-guided here, and the implementation
> is horrendous.
>
> So the fundamental question seems to be; and I think Johannes is the one
> to answer that: What time-base do these metrics want to use?
>
> Do some of these states want to account in task-time instead of
> wall-time perhaps? I can't quite remember, but vague memories are
> telling me most of the PSI accounting was about blocked tasks, not
> running tasks, which makes all this rather more complicated.

I tend to agree with this.
Using rq_clock_task(rq) instead of cpu_clock(cpu) will remove the time
spent under interrupt as an example
and AFAICT, rq->clock_task is updated before calling psi function

>
> Randomly scaling time as proposed seems almost certainly wrong. What
> would that make the stats mean?
