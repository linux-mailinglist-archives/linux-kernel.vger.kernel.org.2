Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99686305C99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbhA0NLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhA0NIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:08:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:08:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o10so2516097lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFFmRHIE/SnNYtk3YEbcRDXV5XFOgor/4ow6T7DYKkc=;
        b=Lkyx5qf9sVTXUYvWagRik8I5qftRlu4qHv4uUd+aMmTO/7SLDuBcLPxa25pphUcU5Z
         KvWTS3wEpczKHA1fAqhaZqbulT1x4nNS+m5D0PDysGdc5jCqnV55skN96V3y2mXyQBWA
         yOCCOmpXXx0q582iPpiaZptXgMTUXYXTfyV2bhczohUHt/RmuCDhMXaPr6RzYZveugdp
         GgmOUo9ihJ+LMd700cOIk/k6Kk9kVz0Yl5yZBygtX4JCRe/GEBkz5tnLMOrGCrxEHqpk
         kapljOmqcC3h5o56BxbN1BnGbA9v+C5yIFaYqHslUi0JJgxYA2o5CnKbsB4Ev9ls57xb
         s+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFFmRHIE/SnNYtk3YEbcRDXV5XFOgor/4ow6T7DYKkc=;
        b=PiB2Ozj/GKUL5+B50ZmlFzLQaXIg0h9HViV1HDKCBSrV7PpXgzmB1NjHWf/I6qeGpx
         rbNr5FJIoLuv2DQRmTcZdOeU9TXWrWfhut7uMKelIuu/giMAHeRSRKLCsD9o7/6FFmy2
         i6dhJz7zBF/7XNDaDjeK/awTdUT0BkWak2AcyBrFJyQXTqQmQ69rLP3c1JzieZcIIWDT
         g6/XAsFPpLu/VAvavqbI6KGUCI+OhyeD17RXSN91NGsRNWyWRGLcjW/EElnJ6+x+4vC0
         kRKnLpPzIJXMF108/MRIcsEf9mWa/y6jMDswAUT1WyyZMVpAZM+CtSyQQuvX7s9iEa3i
         nVeQ==
X-Gm-Message-State: AOAM531gM/oR5vbDEZBo4dZAlYOY6BxWLxDPXTTuUf1S3326chhj74PM
        bMBO5nLe4fq2ENVYIGFcamVXhJprBMHGrNB5gtncvw==
X-Google-Smtp-Source: ABdhPJymHdgzV8FR0Nhw+qoHHvERhiAsR0Hnxs0SYSo1Q5WepYHZjKfm9moG7zaTQkSsJ7G4seGQw2R2tbrs2JVtI9s=
X-Received: by 2002:a19:83d3:: with SMTP id f202mr5168107lfd.277.1611752881651;
 Wed, 27 Jan 2021 05:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20210125085909.4600-1-mgorman@techsingularity.net>
 <20210125085909.4600-5-mgorman@techsingularity.net> <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
 <20210127120245.GC3592@techsingularity.net>
In-Reply-To: <20210127120245.GC3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 14:07:50 +0100
Message-ID: <CAKfTPtB=vh0FzszeOS5ND4Voq3ck2AQgruF-4zC-K1hSSsbT_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 at 13:02, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 27, 2021 at 11:43:22AM +0100, Vincent Guittot wrote:
> > > @@ -6149,18 +6161,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >         }
> > >
> > >         for_each_cpu_wrap(cpu, cpus, target) {
> > > -               if (!--nr)
> > > -                       return -1;
> > > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > -                       break;
> > > +               if (smt) {
> > > +                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > +                       if ((unsigned int)i < nr_cpumask_bits)
> > > +                               return i;
> > > +
> > > +               } else {
> > > +                       if (!--nr)
> > > +                               return -1;
> > > +                       i = __select_idle_cpu(cpu);
> >
> > you should use idle_cpu directly instead of this intermediate i variable
> >
> > +                       idle_cpu = __select_idle_cpu(cpu);
> > +                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > +                               break;
> >
> > Apart ths small comment above, the patch looks good to me and I
> > haven't any performance regression anymore
> >
>
> It's matching the code sequence in the SMT block. If we are going to make
> that change, then go the full way with this?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 52a650aa2108..01e40e36c386 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6129,7 +6129,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       int cpu, idle_cpu = -1, nr = INT_MAX;
>         bool smt = test_idle_cores(target, false);
>         int this = smp_processor_id();
>         struct sched_domain *this_sd;
> @@ -6162,18 +6162,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (smt) {
> -                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> -                       if ((unsigned int)i < nr_cpumask_bits)
> -                               return i;
> +                       idle_cpu = select_idle_core(p, cpu, cpus, &idle_cpu);

but how do you differentiate idle core (return value) and an idle cpu
in the core set in &idle_cpu

You will return as soon as a cpu is idle and before testing all cores

> +                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                               return idle_cpu;
>
>                 } else {
>                         if (!--nr)
>                                 return -1;
> -                       i = __select_idle_cpu(cpu);
> -                       if ((unsigned int)i < nr_cpumask_bits) {
> -                               idle_cpu = i;
> +                       idle_cpu = __select_idle_cpu(cpu);
> +                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
>                                 break;
> -                       }
>                 }
>         }
>
>
> --
> Mel Gorman
> SUSE Labs
