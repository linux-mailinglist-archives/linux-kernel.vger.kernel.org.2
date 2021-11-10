Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1A44BD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhKJJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:07:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:04:36 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bk22so1843408qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfmFNwr+aVtdehKioEcpUngJUmRgTzAF3GcrUhygPBc=;
        b=lPHB8F/JVchkS0M1d9X4iOqu8LGGmPWqijuWSfWDuJVgfua/d7PF2mB4BU1cswgZh3
         VeU17KVNzCHED+9ja+0WGteSoOXimLD2x9u74BoSY4hT6+K1H6vz74u6isrzpObHLiya
         ljud+uOnmHrtgXTq/ZcCFpOOEENRpr90e3d8aTu7ZgKIUa/JfIvZGXHxXQwBoxqYbJZn
         AycQ1IWyIP+PADqEOn/bkEumhtca2RRCZwDsB0V8oqfjDC9BjaUBNNzqdOIXMlr9AVnY
         kgHrm9l4EPXKQkIYoA6vfaW2ljuGcQBCrmaDcyrnMBYopHOsy82TH5DJyCYSfF+NenLL
         GwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfmFNwr+aVtdehKioEcpUngJUmRgTzAF3GcrUhygPBc=;
        b=FuL6JOIhepNfojVTibttbWxfn79NBizlvKOfh/VN5FnVxkHnSm+Tojd/FdpANcOTUz
         eEAgy/pGmEcN9Nz2rr/VNraQ8Mg8NyCAYfWAsw/ArMF9/3Z+Ha/QjPrUzSi5R1QuaC76
         7vaRvzrOdFlg6Vpj/RgMXPMDNKS19mBOHqqwXMihDa7/G+CUun6MFQy61pcGbj02XWYI
         HZaId8vrcpKmBxe75hf7zbHe2q6R0lfFHaYXDiXjsEWRg+ZKx8t7hcwLZ8H/80n3ncUJ
         kATkSKetd+K9BAZOaxp+ecjCXxow2DFv251qlyBFWaHIDHtzeTN2zrzbaAnMZ9kNqteH
         iecQ==
X-Gm-Message-State: AOAM5305CjeAt8UsHWKWlHR7xQPI1zVvTXTc+RE5HZ0o1IYl8Nt+eaEB
        hu8ibcItON+iJkCsYJ87vFDxrzgfSjcNJX05iNU=
X-Google-Smtp-Source: ABdhPJxXZI3RG/ewp+YCny9S+xPFxMW+JahhkmYAalGpHIIOv/XBRAMhua860RZgfTHKB6d6lS5zo0luPqBTLf6YU+U=
X-Received: by 2002:a37:4041:: with SMTP id n62mr10973112qka.225.1636535075083;
 Wed, 10 Nov 2021 01:04:35 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
 <CAKfTPtAVQ+mtYkGv5xJnbjBO9L9z7jSKOvzhObd0MvVpxakezw@mail.gmail.com>
In-Reply-To: <CAKfTPtAVQ+mtYkGv5xJnbjBO9L9z7jSKOvzhObd0MvVpxakezw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 10 Nov 2021 17:04:14 +0800
Message-ID: <CAGWkznFQxzykv=WEB7QJY4zz8WaWFzF1ZTyFGinvEPZKKgZbwg@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 4:49 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 9 Nov 2021 at 15:56, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > > CC peterz as well for rt and timekeeping magic
> > >
> > > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > In an EAS enabled system, there are two scenarios discordant to current design,
> > > >
> > > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > > RT task usually preempts CFS task in little core.
> > > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > > ignore the preempted time by RT, DL and Irqs.
> >
> > It ignores preemption full-stop. I don't see why RT/IRQ should be
> > special cased here.
> >
> > > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > > via the proportion of cfs_rq's utilization on the whole rq.
> >
> >
> > > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > > +{
> > > > +   struct rq *rq = task_rq(current);
> > > > +   unsigned long growth_fixed = (unsigned long)growth;
> > > > +
> > > > +   if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > > +           return growth_fixed;
> > > > +
> > > > +   if (current->in_memstall)
> > > > +           growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > > +                                   - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > > +
> > > > +   return growth_fixed;
> > > > +}
> > > > +
> > > >  static void init_triggers(struct psi_group *group, u64 now)
> > > >  {
> > > >     struct psi_trigger *t;
> > > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > > >     }
> > > >
> > > >     if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > > +           delta = psi_memtime_fixup(delta);
> > >
> > > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > > period of an active reclaimer, since it's technically not stalled on
> > > memory during this time but on CPU.
> > >
> > > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > > are sleeping on refaults swapins, since they are not affected by what
> > > is going on on the CPU.
> >
> > I think that focus on RT/IRQ is mis-guided here, and the implementation
> > is horrendous.
> >
> > So the fundamental question seems to be; and I think Johannes is the one
> > to answer that: What time-base do these metrics want to use?
> >
> > Do some of these states want to account in task-time instead of
> > wall-time perhaps? I can't quite remember, but vague memories are
> > telling me most of the PSI accounting was about blocked tasks, not
> > running tasks, which makes all this rather more complicated.
>
> I tend to agree with this.
> Using rq_clock_task(rq) instead of cpu_clock(cpu) will remove the time
> spent under interrupt as an example
> and AFAICT, rq->clock_task is updated before calling psi function
thanks vincent. Could rq_clock_task help on removing the preempted
time of CFS task by RT/DL, which is the mainly part we want to solve
on memstall time.
>
> >
> > Randomly scaling time as proposed seems almost certainly wrong. What
> > would that make the stats mean?
