Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC740BDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhIOCmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhIOCmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:42:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37764C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:40:54 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t35so1065103qtc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3y6PCFYqiatQ4s49oD+m2XUBqAbISc2GsqWWg8ugGI=;
        b=EHumjptfJQ2oRjaxcXZdJNswyP/sNQtoFj+Yj8ouQ5YfIt0Mch5LIlXkbs3eI1Hpeh
         RthY6MNAHr2tk1QdZDjCHP50d7r72bIl94e4EbDqkfm+MH4dayOtdA+4Hp+Q4Ar++8d8
         hpmvMMaLa2LaR8if4s8VYLPv4WyOMCdErS0s4h9luXnH+uZLBxRjkwdd2ATfgFuFvwyR
         BBli5bxjwuqP5hTTGu59kaziHMnQm4KCWQ7gNnyAfEp6Ky7SC68Be+Ce+nT9HHyc2ofF
         eJvRaoWY47dvkEyspUlWkB4U2SI/8chrYUSGn2iYkG0HI7Pgr85U6RsZzr6kCgN7Xu1t
         Pv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3y6PCFYqiatQ4s49oD+m2XUBqAbISc2GsqWWg8ugGI=;
        b=4x3HR82RHeQMlUQEk36/jPK2OieUyU0kdgc6BvoVmA2316ROZx/h85sMsIKYM1kRQx
         bP+lXjDSYkKrv2nsSzb1FXPsyPuYUYoHFDSnt0pDoBUDKUjvUFEOQupuLKMLYf7VE4VC
         ZLTDygJqvoA0J89xmkTXvUE/Bh2iFWx4s8JnyWFYL7Gj/ywEgRN8WdBiOKWpVYvokeo5
         ZSmyzL2JApBdEkyhEFMT4TgsGyFn20bC9PJOzInk/ksPME6LgKXhnpd399jqcMgYeIxI
         A1r9QnxOR8KH+2VPqOhpXG6+NlHYTrWtdgfFui5U4iG6tcYgnEYqzCm24uQa6oqJkmov
         3Lpg==
X-Gm-Message-State: AOAM533EVvGbHCWCMW7lCOTp5/40swl8mGGUqOBZw6qVRCyky8vVQ+c7
        0Wni5jgYWdla8PRW/uBnOCHVOR5d7WXj/u968na1blMU
X-Google-Smtp-Source: ABdhPJyyqFkFbu1NR1zb58qcgC9ljjHbk8ISt1LmttJT+/5ipY1meGxzEXNjdvHyyg2nJuTWsyqF48s0Y1hJtmH2U0g=
X-Received: by 2002:a05:622a:1a8c:: with SMTP id s12mr7774707qtc.232.1631673653246;
 Tue, 14 Sep 2021 19:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <1631260486-6735-1-git-send-email-huangzhaoyang@gmail.com>
 <YTtbGpE8/1ZxjtP2@cmpxchg.org> <CAGWkznHBod1tCOjmGBXWmz=uzqCAanLV2HDiSaOCXH-vwtyq6w@mail.gmail.com>
In-Reply-To: <CAGWkznHBod1tCOjmGBXWmz=uzqCAanLV2HDiSaOCXH-vwtyq6w@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 15 Sep 2021 10:40:32 +0800
Message-ID: <CAGWkznEqj7ok+1Dhm1QigORrg29+8Hyb1_-AdgminzswNiPbfQ@mail.gmail.com>
Subject: Re: [PATCH] psi : calc cfs task memstall time more precisely
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, xuewen.yan@unisoc.com,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this patch?

On Mon, Sep 13, 2021 at 9:11 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> Sorry for the confusion. Actually, it is a new design which has taken
> previous advice into consideration. I agree that part of the off cpu
> time among the memstall time should be counted in, whereas, the
> preempted time by high priority tasks should NOT be, including
> RT,DEADLINE,IRQS time on cfs task.
>
> On Fri, Sep 10, 2021 at 9:16 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Please don't send new revisions without replying to previous feedback.
> >
> > On Fri, Sep 10, 2021 at 03:54:46PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > cfs task's memstall time is counted as simple as exit - entry so far, which
> > > ignore the preempted time by rt, dl and irq time. Eliminating them by calc the
> > > time growth via the proportion of cfs_rq's utilization on the whole rq.
> > >
> > > eg.
> > > Here is the scenario which this commit want to fix, that is the rt and irq consume
> > > some utilization of the whole rq. This scenario could be typical in a core
> > > which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> > > little core under EAS.
> > >
> > > Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> > > droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  kernel/sched/psi.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index cc25a3c..754a836 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> > >
> > >  static void psi_avgs_work(struct work_struct *work);
> > >
> > > +static unsigned long psi_memtime_fixup(u32 growth);
> > > +
> > >  static void group_init(struct psi_group *group)
> > >  {
> > >       int cpu;
> > > @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
> > >       return growth;
> > >  }
> > >
> > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > +{
> > > +     struct rq *rq = task_rq(current);
> > > +     unsigned long growth_fixed = (unsigned long)growth;
> > > +
> > > +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > +             return growth_fixed;
> > > +
> > > +     if (current->in_memstall)
> > > +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > +
> > > +     return growth_fixed;
> > > +}
> > > +
> > >  static void init_triggers(struct psi_group *group, u64 now)
> > >  {
> > >       struct psi_trigger *t;
> > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > >       }
> > >
> > >       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > +             delta = psi_memtime_fixup(delta);
> > >               groupc->times[PSI_MEM_SOME] += delta;
> > >               if (groupc->state_mask & (1 << PSI_MEM_FULL))
> > >                       groupc->times[PSI_MEM_FULL] += delta;
> > > @@ -928,8 +946,8 @@ void psi_memstall_leave(unsigned long *flags)
> > >        */
> > >       rq = this_rq_lock_irq(&rf);
> > >
> > > -     current->in_memstall = 0;
> > >       psi_task_change(current, TSK_MEMSTALL, 0);
> > > +     current->in_memstall = 0;
> > >
> > >       rq_unlock_irq(rq, &rf);
> > >  }
> > > --
> > > 1.9.1
> > >
