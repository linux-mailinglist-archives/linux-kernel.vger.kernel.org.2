Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0A42812F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJJMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhJJMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:22:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D4C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 05:20:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g8so55905463edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6gACDj/nR9KQ5fYNRZFJLVHSwItch9IypvQdL4rOY0=;
        b=YF4qb1ACARvxAYxTiMkd76XzDZqXnYwRf06zPmoD3XEjlNpzUgQIX1uaP9xKYVRN9F
         I2gINWIRyu/fhlyqMq/LAzOIoiRqAKLdz3BuUC2IbAVpYhhLtRlG43uNMosnuSVM+ech
         WUOY5f0hu8VAMNvsEP6krYwGEoD9rP8rvQ4cgZa7dhHgy5eIqmsb6MJd0C2mDEaPGXyZ
         fBCqCyd3czbboaK6pTSalR2hYCSPUNpe4HY7ll9jk7Eioi1UVhLDgbdp7ucq4ON7kjHi
         GLMhZZlRJghjK8dNUy/og90nRRXFSrWK/2pzamXr9pasTQANjuFO3uQg95E4TnlnVGiZ
         iNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6gACDj/nR9KQ5fYNRZFJLVHSwItch9IypvQdL4rOY0=;
        b=eQK/+ENWPlGxEfcgvqEeOsWWkixtnVQUo/Msu/fJjNMLEPm2BSxyu7LtHlaNCcJnFy
         qDOTJvM6l29vo+nvpKNA45fm1UuFyBmwNqLSwqZYC8xdXPCchJbvE5QUI/zygMQfMumB
         KhGt/deJ/pdBbhWbgluLuH2meLuyYRkPOaKpI9x8ameYtOZQHcAlwZ1t0DYBuj4dV7BU
         5tFrVNdgyvG08PQST8hervQLM7Ux/gMyEGvsYvhONUqpeG4Uq99u7U2AmEWtxCSvhLYA
         WwyUO8kJ6hT4VqoWrXRl+a9Ivsqx3jpqktggRxkfjbhAiecnyoRbwcUFOwqGlsy90T+O
         7DKg==
X-Gm-Message-State: AOAM532oHe9CCjjqc3fuyB1+V0LViBL1I5g9KLWApqT/Z1YcHyoHI77k
        dC7ArivwDrVhSgUBODfKAIy9IEy9X8thXzQok5g=
X-Google-Smtp-Source: ABdhPJwfPRtabb5w6tNVnQgK788NOjDyTZKeEPrI+v9iZIY6/DW6RJyxuPOLwvKqbPgHccP5ulyUNcuBcligIzvoMLk=
X-Received: by 2002:a17:907:767a:: with SMTP id kk26mr18006411ejc.134.1633868409786;
 Sun, 10 Oct 2021 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211009180941.20458-1-tao.zhou@linux.dev> <20211009225057.GB174703@worktop.programming.kicks-ass.net>
 <YWK0yEJNGYAZ3hhD@geo.homenetwork>
In-Reply-To: <YWK0yEJNGYAZ3hhD@geo.homenetwork>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 11 Oct 2021 01:19:57 +1300
Message-ID: <CAGsJ_4xW5s-ze6QjVLJPscEcCaakdS6Np84w9Hwh8Zj_=WqhTw@mail.gmail.com>
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

On Sun, Oct 10, 2021 at 10:45 PM Tao Zhou <tao.zhou@linux.dev> wrote:
>
> Hi Peter,
>
> On Sun, Oct 10, 2021 at 12:50:57AM +0200, Peter Zijlstra wrote:
> > On Sun, Oct 10, 2021 at 02:09:41AM +0800, Tao Zhou wrote:
> > > In select_idle_core(), the idle core returned may have no cpu
> > > allowed. I think the idle core returned for the task is the one
> > > that can be allowed to run. I insist on this semantics.
> > >
> > > In select_idle_cpu(), if select_idle_core() can not find the
> > > idle core, one reason is that the core is not allowed for the
> > > task, but the core itself is idle from the point of
> > > sds->has_idle_cores. I insist on this semantics.
> > >
> > > No others, just two additional check.
> > > ---
> > >  kernel/sched/fair.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index f6a05d9b5443..a44aca5095d3 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> > >                     *idle_cpu = cpu;
> > >     }
> > >
> > > -   if (idle)
> > > +   if (idle && *idle_cpu != -1)
> > >             return core;
> >
> > In that case, core would be nr_cpu_ids (==nr_cpumask_bits), and then the caller checks:
> >
> >       (unsigned)i < nr_cpumask_bits
>
> Thank you for reply.
>
>
> If (1)there is no idle core or (2)the idle core has no allowed cpu, we return -1.
> Originally, just (1) has happened, we return -1. The (2) is what I want to add.

I don't understand (2). before doing
        for_each_cpu_wrap(cpu, cpus, target + 1) {
                if (has_idle_core) {
                        i = select_idle_core(p, cpu, cpus, &idle_cpu);
                        if ((unsigned int)i < nr_cpumask_bits)
                                return i;

                } else {
                        if (!--nr)
                                return -1;
                        idle_cpu = __select_idle_cpu(cpu, p);
                        if ((unsigned int)idle_cpu < nr_cpumask_bits)
                                break;
                }
        }

to select idle core, we have already done:
    cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);

so we are only scanning allowed cpus.

>
> If we find idle core and has allowed cpu in the core, is it better to return
> @*idle_cpu.
>
>     if (idle && *idle_cpu != -1)
>             return *idle_cpu;
>
> This @*idle_cpu is the allowed cpu in the idle core. We do not promise anything
> about the @core(target) is the allowed cpu until we hit in select_task_rq() -->
> select_fallback_rq(). And the select_fallback_rq() will return a different cpu
> than the @core or @*idle_cpu.
>
> > >     cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > > @@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >             }
> > >     }
> > >
> > > -   if (has_idle_core)
> > > +   if (has_idle_core && *idle_cpu != -1)
> > >             set_idle_cores(target, false);
> >
> > And this one I'm completely failing, why shouldn't we mark the core as
> > non-idle when there is a single idle CPU found? That's just worng.
>
> When @has_idle_core is true, it implies for all cpu in the core the case
> (1) or case (2) has happened. The (1) can be mark as non-idle. I conclude
> to contradiction myself last time. The (2) is also seemed to be non-idle.
>
>
> But, I think I am totally wrong because the sds->has_idle_cores is related
> to the cpu not task. So, the affinity should not affect the decision of
> sds->has_idle_cores.
>
>
>
> Thanks,
> Tao

Thanks
barry
