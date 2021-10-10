Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762042837C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJJU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJJU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:26:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6002C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:24:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so59128186edv.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upi5UHXslpTMD28HId/2YrS90VRMSJOA79htf23qd38=;
        b=Ip4+f3D4yKNWWnytmgIcKWQjup07UgfcA98Hto5wrthgr42TVVpL6rsVH0zGk3jAY3
         Zzl+OlIn2ueuvws4zOyuHqwXHXcZrku7kOHaOnHZDRjILgIz5oNSOavoTh1vg5RpKsra
         +eJ7HtsaSAqhrZW6nl8Wwi/XuiCG6dr6Q09kDoZL3o2SwZfarIZriqyGdazyGktLrcVj
         nN6VljPQq0cmhfLGybbjO8ZmIlVt85EJ0apFH9txamCDMjPk4K0K0+R0m8vJt4vO3IHI
         hfk2hJtN3eO6aC58ggu2z//6zrptw06J5styLy++TxEQR6yqGeXRpEQbPVuh9HRB3jli
         I+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upi5UHXslpTMD28HId/2YrS90VRMSJOA79htf23qd38=;
        b=47LUS2pW5pDFHXnv+spxPvyXbqP/kTwMjwTCIW26/zwp7Qmpw1l6ZkolUQgBOqqWdA
         IfzeK1NdGjR2CRvNhPH6dwkiqx4kJHoXj5BnhkqUndtOzI5HoH+7WntwnXg3NhCXXo0F
         UVYfLW+/rFgUhiY8SJK/4QiK+jaH8Cp9cDiy9ASwvhfhPoDFOZPR2NSNLbaVDMBJSVuy
         UGCH+n3MGkqJ/uPKeK/PYfWVT6lcsy+dfMzx0MebBiLQoVWklNdETc/YMRxg2kzBpF5A
         HZH5F8k5LWoYljxRErUV3yx1P1coH4t0zNngdqRmecHgi3n6Fzj/vFgxllPp2wzRGpc+
         PN7w==
X-Gm-Message-State: AOAM530dj2gGezEqfpYhAFzkcErMOFbWSn5eSvk1cn9sfb769vGQyEHj
        7/NEJSLQc7HPoD0rh/cPnQZVIWdORfIbRHWui/s=
X-Google-Smtp-Source: ABdhPJwvX57CqEi5yeESL0hFzjPc5FfIee6dV+KY8SiwxjdTVsc8XFaVpnf9qrJXv6q6KEoe3ClRhXWb5cfH46OuKp4=
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr3018482edd.167.1633897460224;
 Sun, 10 Oct 2021 13:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211009180941.20458-1-tao.zhou@linux.dev> <20211009225057.GB174703@worktop.programming.kicks-ass.net>
 <YWK0yEJNGYAZ3hhD@geo.homenetwork> <CAGsJ_4xW5s-ze6QjVLJPscEcCaakdS6Np84w9Hwh8Zj_=WqhTw@mail.gmail.com>
 <YWL4TA19eFsfd4c7@geo.homenetwork>
In-Reply-To: <YWL4TA19eFsfd4c7@geo.homenetwork>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 11 Oct 2021 09:24:09 +1300
Message-ID: <CAGsJ_4zfEV0f0KX6T9mBMPGdc3T8UzmQRsh6XdTzc+3G_ZGPDg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Check idle_cpu in select_idle_core/cpu()
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 3:26 AM Tao Zhou <tao.zhou@linux.dev> wrote:
>
> Hi Barry,
>
> On Mon, Oct 11, 2021 at 01:19:57AM +1300, Barry Song wrote:
> > On Sun, Oct 10, 2021 at 10:45 PM Tao Zhou <tao.zhou@linux.dev> wrote:
> > >
> > > Hi Peter,
> > >
> > > On Sun, Oct 10, 2021 at 12:50:57AM +0200, Peter Zijlstra wrote:
> > > > On Sun, Oct 10, 2021 at 02:09:41AM +0800, Tao Zhou wrote:
> > > > > In select_idle_core(), the idle core returned may have no cpu
> > > > > allowed. I think the idle core returned for the task is the one
> > > > > that can be allowed to run. I insist on this semantics.
> > > > >
> > > > > In select_idle_cpu(), if select_idle_core() can not find the
> > > > > idle core, one reason is that the core is not allowed for the
> > > > > task, but the core itself is idle from the point of
> > > > > sds->has_idle_cores. I insist on this semantics.
> > > > >
> > > > > No others, just two additional check.
> > > > > ---
> > > > >  kernel/sched/fair.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index f6a05d9b5443..a44aca5095d3 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> > > > >                     *idle_cpu = cpu;
> > > > >     }
> > > > >
> > > > > -   if (idle)
> > > > > +   if (idle && *idle_cpu != -1)
> > > > >             return core;
> > > >
> > > > In that case, core would be nr_cpu_ids (==nr_cpumask_bits), and then the caller checks:
> > > >
> > > >       (unsigned)i < nr_cpumask_bits
> > >
> > > Thank you for reply.
> > >
> > >
> > > If (1)there is no idle core or (2)the idle core has no allowed cpu, we return -1.
> > > Originally, just (1) has happened, we return -1. The (2) is what I want to add.
> >
> > I don't understand (2). before doing
> >         for_each_cpu_wrap(cpu, cpus, target + 1) {
> >                 if (has_idle_core) {
> >                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >                         if ((unsigned int)i < nr_cpumask_bits)
> >                                 return i;
> >
> >                 } else {
> >                         if (!--nr)
> >                                 return -1;
> >                         idle_cpu = __select_idle_cpu(cpu, p);
> >                         if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >                                 break;
> >                 }
> >         }
> >
> > to select idle core, we have already done:
> >     cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >
> > so we are only scanning allowed cpus.
>
> Um.. You read top down.. and you are right.
> The function itself semantics is important to me.
>
> After a secondary recall and not thorough now, I realize that
> cpus_ptr may be changed.
>
>
> See code of this:
>
> static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
> {
>         if (likely(!p->migration_disabled))
>                 return;
>
>         if (p->cpus_ptr != &p->cpus_mask)
>                 return;
>
>         /*
>          * Violates locking rules! see comment in __do_set_cpus_allowed().
>          */
>         __do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
> }
>
>
> This change is under the light of ->pi_lock.
> That thing is quick to forget to me..
> Not sure I am right. Thank you for remind.
>
> If the cpu_ptr can be changed, you can not depend on the first AND
> operation there.

The explanation doesn't make any sense to me. We are scanning
based on the first AND operation.  select_idle_core() is returning
*idle_cpu based on the cpumask after AND operation.
Even though cpumask can change after select_idle_core() is done
or before select_idle_core() is called, the return value is not wrong.

>
> > >
> > > If we find idle core and has allowed cpu in the core, is it better to return
> > > @*idle_cpu.
> > >
> > >     if (idle && *idle_cpu != -1)
> > >             return *idle_cpu;
> > >
> > > This @*idle_cpu is the allowed cpu in the idle core. We do not promise anything
> > > about the @core(target) is the allowed cpu until we hit in select_task_rq() -->
> > > select_fallback_rq(). And the select_fallback_rq() will return a different cpu
> > > than the @core or @*idle_cpu.
> > >
> > > > >     cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > > > > @@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > > >             }
> > > > >     }
> > > > >
> > > > > -   if (has_idle_core)
> > > > > +   if (has_idle_core && *idle_cpu != -1)
> > > > >             set_idle_cores(target, false);
> > > >
> > > > And this one I'm completely failing, why shouldn't we mark the core as
> > > > non-idle when there is a single idle CPU found? That's just worng.
> > >
> > > When @has_idle_core is true, it implies for all cpu in the core the case
> > > (1) or case (2) has happened. The (1) can be mark as non-idle. I conclude
> > > to contradiction myself last time. The (2) is also seemed to be non-idle.
> > >
> > >
> > > But, I think I am totally wrong because the sds->has_idle_cores is related
> > > to the cpu not task. So, the affinity should not affect the decision of
> > > sds->has_idle_cores.
> > >
> > >
> > >
> > > Thanks,
> > > Tao
> >
> > Thanks
> > barry
>
>
>
> Thanks,
> Tao
