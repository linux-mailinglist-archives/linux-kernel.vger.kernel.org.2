Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E995429E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJLHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhJLHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:13:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16502C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:11:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v195so44648202ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP6Qy9gQtGBBneauhLfHQbSP9qq+M0x5gu0JWMIXMBQ=;
        b=UJtm0pVcZiMwakE5NkAECBsvqCIzHJlg5t5inshftOS7oVG2zR/5fDNcgZ6E1t740X
         oPLNrFP5AlOUzxxWT5TxTmL8aExZvpuZcFKNqR1J2D1nC1SZLzD9hAwBTVLq8MhthRwu
         iVJ/69yka/CrzUnAz7nt0U05BmiP2H/HS3J+XvTVzZ+ZQqM6JmUae1lrC7EzV+1xYHpL
         QL0buzlBrxCZNIfsv2wKgoGb7s/vk2sRGt6YNf7R1yaQMGuZjDTP3Fri+OmbydbREgnr
         DlajjmM3h55PJHG7JUA5J7d/JLPOfsYVSSnLNC/in59oOpv4Zy/12o0Ni8pXVg741kL2
         D2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP6Qy9gQtGBBneauhLfHQbSP9qq+M0x5gu0JWMIXMBQ=;
        b=ixBIVtD6S8LzvzFlxfxjMDh6w6KO1N1lia+0pvHcntMMhCGr32xXm7CX60OpaGo65s
         uzFNks02Gq4U6YQ7Er/WXKtMrDHC/TFQDi4BhncJPHGXrJ85S3401zmel28w8Q5aQezK
         V2A8arI0APK8Dq62evo4N9u20QZ8vD16A31iLBYsWgrmybWsdWzPkbSA9kvEX+7vKObJ
         +kvo8I7C6mG8J6mLlvlBQL+pA/rg80SMnHODhEH21akEhcjDR5FayQirHTQscaJ4xFjT
         Jdw6Sx1MYkaCQDpjduMFSOK2hDLc6Ewgx4oobZEfRvxsdmnbQ+SIwGFcjMYxMd3ROJgw
         lGIA==
X-Gm-Message-State: AOAM532LrhUU1SlSnzPNkHzs5qzd4ztG0Wf5aMAayyGO3etRuoPWRM0h
        hoIiIC4Z/nDOp2m9Le9+Whe+/1IwT+yyhIrWnKFvbw==
X-Google-Smtp-Source: ABdhPJx7KLlDyXonnoO6EMpsX208orTZiRCzCQiI5X69FzZlUCfbPBEPJ1ZOx+7geo23vMpWgwe1NFCekNzNY+F2VZU=
X-Received: by 2002:a25:2f8e:: with SMTP id v136mr25936783ybv.350.1634022694262;
 Tue, 12 Oct 2021 00:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211009181055.20512-1-tao.zhou@linux.dev> <20211011105802.344b907c@gandalf.local.home>
 <YWRqbKc0nY29/Qiz@geo.homenetwork>
In-Reply-To: <YWRqbKc0nY29/Qiz@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Oct 2021 09:11:23 +0200
Message-ID: <CAKfTPtAY0oE+BFgFGx1jKRrtanO80XwT-Ee9GATSDm55ZbFv-A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use this_sd->weight to calculate span_avg
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 18:45, Tao Zhou <tao.zhou@linux.dev> wrote:
>
> Hi Steven,
>
> On Mon, Oct 11, 2021 at 10:58:02AM -0400, Steven Rostedt wrote:
> > On Sun, 10 Oct 2021 02:10:55 +0800
> > Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > > avg_idle, avg_cost got from this_rq and this_sd. I think
> > > use this_sd->weight to calculate and estimate the number
> > > of loop cpus in the target domain.
> >
> > If that's the case, then shouldn't the CPUs to be checked come from this_sd
> > as well? I mean, at the beginning of the function we have:
> >
> >       this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> >       if (!this_sd)
> >               return -1;
> >
> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >
> > Where "cpus" comes from sd, and not this_sd.
>
> Thank you for reply.
>
>
> Cycles are spent on this CPU(and in this Domain) if I am not wrong.
> If T1(on this CPU) want to try to wake up T2 on another CPU, Kernel
> (on this CPU) should evaluate that not spend much time in finding
> idle siblings. And the avg_idle and span_avg are two fators to compare
> with. avg_idle is the CPU average idle time of this rq and avg_cost
> is the last time this Domain was being looped and the recorded avg
> cost time. Two values are history averaged. So, use the history to
> evaluate future that we do *now* the another Domain cpu search to not
> let this CPU(and in this Domain) too busy. This is what I want to say.
> Not sure yet.

this_rq->wake_avg_idle is used to guest estimate how much busy is this_cpu
this_sd->avg_scan_cost is used to estimate how much time was spent in
average looking at an idle cpu at this domain level on this cpu
and sd->span_weight is is used to take into account the size of the
target domain on which it is going to loop. But we don't really care
about the size of the domain of the this_cpu

>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index f6a05d9b5443..7fab7b70814c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6300,7 +6300,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >             avg_idle = this_rq->wake_avg_idle;
> > >             avg_cost = this_sd->avg_scan_cost + 1;
> > >
> > > -           span_avg = sd->span_weight * avg_idle;
> > > +           span_avg = this_sd->span_weight * avg_idle;
> > >             if (span_avg > 4*avg_cost)
> > >                     nr = div_u64(span_avg, avg_cost);
> > >             else
> >
> >
> > And after this code, the nr that is determined from the above, is for
> > limiting the looping over those CPUs from sd, not this_sd:
> >
> >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> >               if (has_idle_core) {
> >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >                       if ((unsigned int)i < nr_cpumask_bits)
> >                               return i;
> >
> >               } else {
> >                       if (!--nr)
> >                               return -1;
> >                       idle_cpu = __select_idle_cpu(cpu, p);
> >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >                               break;
> >               }
> >       }
> >
> > I'm guessing there's nothing wrong here. But, I don't fully understand it
> > myself.
>
> I replied to Barry and not say that I missed that AND operation.
>
> Here is another go.
>
> @cpus is per-cpu and irq disable. I am not sure irq disable can
> be preempt in in RT. If that is possiable, cpu_ptr is not safe.
> Based on the code and comments in __do_set_cpus_allowed(), he will
> not use ->pi_lock to change affinity(eg. SCA_MIGRATE_DISABLE).
>
> If the cpu_ptr not get changed(I must be right and wrong more 5 time)
> @core is not in @cpu_ptr mask, BUT, the cpu in smt mask of @core is
> the one that we use to call select_idle_core() and @core is in this
> smt mask but is not allowed and we get @*idle_cpu and @idle is true
> we return the @core. Another not sure.
>
> If the @cpu_ptr can changed in eg. just before the @core loop.
> It is possible that @*idle_cpu == -1 and all cpu in smt mask
> of @core is seemed to be not allowed. And, we return @core.
> This case is what I just look at select_idle_core() semantics
> and missed that AND operation.
>
> > -- Steve
>
>
>
>
> Thanks,
> Tao
