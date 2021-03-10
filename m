Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4877E3341B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhCJPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhCJPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:37:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:37:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so34135939lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl5TWeyuZTMt1cgpit698eWdy4xdbmLgJGIjyn/Jnmk=;
        b=WCUmx3W/XDcG/YCS15uRNC7ugzCGiDrP8UQX8eDE3UafW5htyWiLOxMZj5JTB2fgnP
         +OYrwhDcdSXrpfPdUyKBhvw01CB/t1/0GUWgvB3i/xhXkGIBG5Mhoh4iaM2hVD0FhTMn
         Tuxmdu7npXf5V9Uo6GBmYk7GFrk29VqTZohXWEa8rGxCCHogMVVFK88+1FB7IjjgOypb
         9Pk7qyhAsNJBLxmYKpHbHAt/Bme0sdv3H8vbHzWM/pFLxnbt88Kr/ro/U/CpxqDE5J2i
         ahQCPHiIgQwSSYticWF4CDEpfTeAJCA83vnptT6gU1OHqZK6wnK3rOwdRWXBfdalLkNX
         pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl5TWeyuZTMt1cgpit698eWdy4xdbmLgJGIjyn/Jnmk=;
        b=HdAEp+GNMBtEjVeh+p0J86kt8bhGw5uWVQlzIpWWMS61zjuhImN7SX6HeB+Zoxwl6u
         GaBVfbAMVEjn4jc5mKXO2Pf3CH6uv2LzrBdILheROuu0c0TQa/KAKbskYQeA/S+A4DGY
         ykiBRDxtGUO6DUO/g4S+FNbdIJn3kxG2KMoBa4S5SMcF1ewIqnFz9ZDXpYu+Q2x2aN/i
         Zrz6UaGeFS8IAgoHUsBPZr7/wJ6d1NWuzQFmfhY4Bv72VW+zT7+XRIGXwVSR2zQB1lma
         igZDOiyMqByjUFzFAYfv0teEXHznFxV2h8Cnwa106HbkRurK+hd8LR5edK8pqTlrxUDh
         sxpw==
X-Gm-Message-State: AOAM531p5Q3ZjFHCNHjFIgo2HQa36t7TrZISQ+zhYs8FJRVYO/yCCFfC
        uVzFQLmB3NSLonwQ05wYGrz1AOBc0A8KstFaAhEoOw==
X-Google-Smtp-Source: ABdhPJzaXCshYNb7Z1TUX8X0IXxc5L6SUNEwTJJsQ/OvYGshV3cCPqCuJ1aXHRAEo+rGngFy0wA2RBpl4LeKnG7en6M=
X-Received: by 2002:a19:f812:: with SMTP id a18mr2430527lff.254.1615390647271;
 Wed, 10 Mar 2021 07:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtA2XSmqt1L2X9WvdtdA5eqNYuhSws8jDOr1HA1xqXWfDQ@mail.gmail.com> <20210310055241.GO2028034@linux.vnet.ibm.com>
In-Reply-To: <20210310055241.GO2028034@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Mar 2021 16:37:15 +0100
Message-ID: <CAKfTPtB6a=QSqiUSTDEpzZ00vn-_=j1MCSQnxw_v_oJtJksW7Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 at 06:53, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2021-03-08 14:52:39]:
>
> > On Fri, 26 Feb 2021 at 17:41, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
>
> Thanks Vincent for your review comments.
>
> > > +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> > > +{
> > > +       struct sched_domain_shared *tsds, *psds;
> > > +       int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> > > +
> > > +       tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> > > +       tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> > > +       tllc_size = per_cpu(sd_llc_size, this_cpu);
> > > +
> > > +       psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> > > +       pnr_busy = atomic_read(&psds->nr_busy_cpus);
> > > +       pllc_size = per_cpu(sd_llc_size, prev_cpu);
> > > +
> > > +       /* No need to compare, if both LLCs are fully loaded */
> > > +       if (pnr_busy == pllc_size && tnr_busy == pllc_size)
> > > +               return nr_cpumask_bits;
> > > +
> > > +       if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > > +               return this_cpu;
> >
> > Why have you chosen to favor this_cpu instead of prev_cpu unlike for wake_idle ?
>
> At this point, we know the waker running on this_cpu and wakee which was
> running on prev_cpu are affine to each other and this_cpu and prev_cpu dont
> share cache. I chose to move them close to each other to benefit from the
> cache sharing. Based on feedback from Peter and Rik, I made the check more
> conservative i.e tnr_busy <= tllc_size/smt_weight (where smt_weight is the
> cpumask weight of smt domain for this_cpu) i.e if we have a free core in

yeah make sense

> this llc domain, chose this_cpu.  select_idle_sibling() should pick an idle
> cpu/core/smt within the llc domain for this_cpu.
>
> Do you feel, this may not be the correct option?

I was worried that we end up pulling tasks in same llc but the
condition above and wake_wide should prevent such behavior

>
> We are also experimenting with another option, were we call prefer_idler_cpu
> after wa_weight. I.e
> 1. if wake_affine_weight choses this_cpu but llc in prev_cpu has an idle
> smt/CPU but there are no idle smt/CPU in this_cpu, then chose idle smt/CPU
> in prev_cpu
> 2. if wake_affine_weight choses nr_cpumask(aka prev_cpu) but llc in this_cpu
> has an idle smt/CPU but there are no idle smt/CPU in prev_cpu, then chose
> idle smt/CPU in this_cpu
>
>
> > > +
> > > +       /* For better wakeup latency, prefer idler LLC to cache affinity */
> > > +       diff = tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
> > > +       if (!diff)
> > > +               return nr_cpumask_bits;
> > > +       if (diff < 0)
> > > +               return this_cpu;
> > > +
> > > +       return prev_cpu;
> > > +}
> > > +
> > >  static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >                        int this_cpu, int prev_cpu, int sync)
> > >  {
> > > @@ -5877,6 +5907,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >         if (sched_feat(WA_IDLE))
> > >                 target = wake_affine_idle(this_cpu, prev_cpu, sync);
> > >
> > > +       if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits &&
> > > +                               !cpus_share_cache(this_cpu, prev_cpu))
> > > +               target = prefer_idler_llc(this_cpu, prev_cpu, sync);
> >
> > could you use the same naming convention as others function ?
> > wake_affine_llc as an example
>
> I guess you meant s/prefer_idler_llc/wake_affine_llc/

yes

> Sure. I can modify.
>
> >
> > > +
> > >         if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
> > >                 target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
> > >
> > > @@ -5884,8 +5918,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >         if (target == nr_cpumask_bits)
> > >                 return prev_cpu;
> > >
> > > -       schedstat_inc(sd->ttwu_move_affine);
> > > -       schedstat_inc(p->se.statistics.nr_wakeups_affine);
> > > +       if (target == this_cpu) {
> >
> > How is this condition related to $subject ?
>
> Before this change, wake_affine_weight and wake_affine_idle would either
> return this_cpu or nr_cpumask_bits. Just before this check, we check if
> target is nr_cpumask_bits and return prev_cpu. So the stats were only
> incremented when target was this_cpu.
>
> However with prefer_idler_llc, we may return this_cpu, prev_cpu or
> nr_cpumask_bits. Now we only to update stats when we have chosen to migrate
> the task to this_cpu. Hence I had this check.

ok got it.

May be return earlier in this case like for  if (target ==
nr_cpumask_bits) above

>
> If we use the slightly lazier approach which is check for wa_weight first
> before wa_idler_llc, then we may not need this change at all.
>
> --
> Thanks and Regards
> Srikar Dronamraju
