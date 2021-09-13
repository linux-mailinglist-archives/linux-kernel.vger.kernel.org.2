Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B164440827A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhIMBNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 21:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhIMBNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 21:13:20 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB394C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 18:12:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m21so8832752qkm.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEhRnE237B8QIVkmLvgcJTZVLxORa61csCgWecGhzwM=;
        b=ia70fbHiwFCeLKoe47VV4reDo/3CyaqW4Vi8QiBFK2RVC5YTWpoxw3gNPYe+9NgctY
         O+zdLj3x0PelNrAh2EBsWuuLDbopCa0djRVKOwFfksbRgKXFE1tdfRZre0wA0BXKRfks
         rrNMmNhQKKjmaNtccCfjOOcQERuQmb6pXCEzIqsjh+821MytWYU4pB8GlJ8kdQbXcofR
         tGuCLfPuP2qLbxWlh/+gPozXuOPNFEAy+kj5GcQvQLWhvjrxBimdpuu0i94o5dS8nQF7
         61eIdV5KD1u5s14pHuW9pYdPO1u3RZRSu0lVFGrkqGQbjI/Ns/n3doX1sI0neeAOx/PX
         Zh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEhRnE237B8QIVkmLvgcJTZVLxORa61csCgWecGhzwM=;
        b=MIi0W1/kquCzm56RybdmL5TTBqQ5d+AKjpv58EG8OkdB5/+k8g0AXJgP3TCJxc5Ieg
         RKGCtgLM0Esqp0s5skRBxnXDW16TQMtkkDmeLXbgLRZkVZFopKSe6ajDN5yJE+gBIgnj
         Wg8xnaDHtvnbPwdYN8PURFdbja72H2L9BBkOhkuq9VPrzPyFgUDP0HTM+eovgwag+RYK
         2htsoIY25+13vlLEmWwm+jeEaGG5wcDWo/2tMCeP6vENfvW3JlBy/R4g4Dix5XpCPXGV
         SZ56qzT0jwiIndpgzJydeDFQhZtFM8JUYb2rEqUooSSDIChEwayiMaje+3t2HATg5Jeh
         M1mg==
X-Gm-Message-State: AOAM532C1rRBEW8k5JzyS0xY+VZVnLUCDmkCMI1r6OHte9BDJ30abIyN
        7zSG51b8WtcFz4d0VIJ/noumzdWakA7tc0vsReO+sivZ
X-Google-Smtp-Source: ABdhPJwJuBjlIRnQWbvztYg/upXFj4Ihzvs9ktMMMSN0kTNh/YbFt0XlCcHCBmMbhs+IXwGfQ3EcxDbcJM3/R3IQXks=
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr7719816qkf.225.1631495525100;
 Sun, 12 Sep 2021 18:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <1631260486-6735-1-git-send-email-huangzhaoyang@gmail.com> <YTtbGpE8/1ZxjtP2@cmpxchg.org>
In-Reply-To: <YTtbGpE8/1ZxjtP2@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 13 Sep 2021 09:11:44 +0800
Message-ID: <CAGWkznHBod1tCOjmGBXWmz=uzqCAanLV2HDiSaOCXH-vwtyq6w@mail.gmail.com>
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

Sorry for the confusion. Actually, it is a new design which has taken
previous advice into consideration. I agree that part of the off cpu
time among the memstall time should be counted in, whereas, the
preempted time by high priority tasks should NOT be, including
RT,DEADLINE,IRQS time on cfs task.

On Fri, Sep 10, 2021 at 9:16 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Please don't send new revisions without replying to previous feedback.
>
> On Fri, Sep 10, 2021 at 03:54:46PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > cfs task's memstall time is counted as simple as exit - entry so far, which
> > ignore the preempted time by rt, dl and irq time. Eliminating them by calc the
> > time growth via the proportion of cfs_rq's utilization on the whole rq.
> >
> > eg.
> > Here is the scenario which this commit want to fix, that is the rt and irq consume
> > some utilization of the whole rq. This scenario could be typical in a core
> > which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> > little core under EAS.
> >
> > Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> > droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  kernel/sched/psi.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3c..754a836 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> >
> >  static void psi_avgs_work(struct work_struct *work);
> >
> > +static unsigned long psi_memtime_fixup(u32 growth);
> > +
> >  static void group_init(struct psi_group *group)
> >  {
> >       int cpu;
> > @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
> >       return growth;
> >  }
> >
> > +static unsigned long psi_memtime_fixup(u32 growth)
> > +{
> > +     struct rq *rq = task_rq(current);
> > +     unsigned long growth_fixed = (unsigned long)growth;
> > +
> > +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > +             return growth_fixed;
> > +
> > +     if (current->in_memstall)
> > +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> > +
> > +     return growth_fixed;
> > +}
> > +
> >  static void init_triggers(struct psi_group *group, u64 now)
> >  {
> >       struct psi_trigger *t;
> > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> >       }
> >
> >       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > +             delta = psi_memtime_fixup(delta);
> >               groupc->times[PSI_MEM_SOME] += delta;
> >               if (groupc->state_mask & (1 << PSI_MEM_FULL))
> >                       groupc->times[PSI_MEM_FULL] += delta;
> > @@ -928,8 +946,8 @@ void psi_memstall_leave(unsigned long *flags)
> >        */
> >       rq = this_rq_lock_irq(&rf);
> >
> > -     current->in_memstall = 0;
> >       psi_task_change(current, TSK_MEMSTALL, 0);
> > +     current->in_memstall = 0;
> >
> >       rq_unlock_irq(rq, &rf);
> >  }
> > --
> > 1.9.1
> >
