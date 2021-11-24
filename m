Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953845B987
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhKXMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhKXMBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:01:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D13CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:57:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t5so9439903edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UblpD9H6Bq7X6zD+cZXYcy45CrIeDupfVdQlSo/Y35E=;
        b=RQnsgS47xAb52qU3FR92Vdmt2N+KIB85yVjDreDCV50MUAPVDAB0tKvI3o6zhP69H8
         EtxaWmMqSMGJe18/J3RxHm2L6OjW9GAO24K3DKuGwx8evAhG75ViqPUt8gmgMkEcQ9/X
         kpBrFaD7aZE/pJcenCuYlCRClWdEdQSe+pcH3LLRd6o01Z/kxxpUmQjAJkoNDJsSBOll
         gwsjBiGMTFTADpYoODHa4yDRYfbsCT1dWMlkzRpEuI+b2CkhWkveUf17kMOZPnVCKnlE
         2fZL5CxUKw0sC75L/Yva8wxyjycrjTVspPe2KhhXiKvdUgdnVYhi4AQ0xN6nKy3NMdUV
         WqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UblpD9H6Bq7X6zD+cZXYcy45CrIeDupfVdQlSo/Y35E=;
        b=mtcmhYWkiEqEW3CRLCu5RktF0/BiEljBqkct8C/y1A1188+5RtqQE8nSktFvGOC3qe
         agOAhiHyaGeM+y7AUH5e+S3OtiYotMCEy5+cvEGGoS3+XU4VmLX6FIq+7UPVBfY6J9FR
         dWhkXQ1dZLH8X4FEAahWVMoaWL26etfOx6oEmxWLwdJAwWSSh+CGdN4YsH/iWpFXtrMq
         rfHaF59OUkRiy39iKmC5Mwzr9wd9uEQyD2PapBot9ddWrjgyYrF024VaDR1l+Lxc1Da0
         /DVwqF2tLzxSDg54fCaBImvJbQWgnKWtDB1l//A+0KOrrhNIOTu1B2y9rdgAu4jp5I0S
         7H5w==
X-Gm-Message-State: AOAM532HjlTfXoXYwE07Pzt3aG4KzCh6ndmGPDoRK1yjCvJSd/MfKQvd
        CGkyEsedFgSTmRrVVgR4pmqpxkcUIeRbkJz02rs=
X-Google-Smtp-Source: ABdhPJzOF5W8bqzAvP9BMwNiifMHd4+U+uAtZihhxHrPK2XXDhPHfUx7skm4/1AeUVaJqgmlqETJQeL6frWrsJSUAec=
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr19386216ejj.559.1637755072792;
 Wed, 24 Nov 2021 03:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20211124091546.5072-1-21cnbao@gmail.com> <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
 <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 25 Nov 2021 00:57:41 +1300
Message-ID: <CAGsJ_4yHToqZZ9R59jd0391mE0tAzxDFSvhSV24gx9c5JNvO4w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:49 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 12:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 24, 2021 at 05:15:46PM +0800, Barry Song wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6e476f6..8cd23f1 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6278,6 +6278,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >               time = cpu_clock(this);
> > >       }
> > >
> > > +     --nr;
> > >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> > >               if (has_idle_core) {
> > >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > @@ -6285,11 +6286,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >                               return i;
> > >
> > >               } else {
> > > -                     if (!--nr)
> > > -                             return -1;
> > >                       idle_cpu = __select_idle_cpu(cpu, p);
> > >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > >                               break;
> > > +                     if (!--nr)
> > > +                             return -1;
> > >               }
> > >       }
> >
> > This way nr can never be 1 for a single iteration -- it current isn't,
> > but that's besides the point.
>
> Yep. nr=1 seems to be a corner case.
> if nr=1, the original code will return -1 directly without scanning
> any cpu. but the new code will scan
> one  time because I haven't checked if(!--nr)  and return before
> for_each_cpu_wrap(). so this changes
> the behaviour for this corner case.
>
> but if i change "--nr" to "nr--", this new code will scan nr  times
> rather than nr-1, this changes the behaviour
> for all cases besides nr!=1. The original code was looping nr times
> but scanning nr-1 times only.
>
> so you prefer here the codes should scan nr times and change the
> scanning amount from nr-1
> to nr?

Let me make it clearer. if nr=5, the original code will  loop 5 times,
but in the 5th loop, it returns directly, so  __select_idle_cpu is
only done 4 times.

if nr=1, the original code will  loop 1 time, but in the 1st loop,
it returns directly, so  __select_idle_cpu is  done 0 times.

if i change the code to if(!nr--), while nr=5, the new code will
do  __select_idle_cpu() 5 times rather than 4 times in the
original code.

but of course the new code changes the  __select_idle_cpu
from zero to one time for the corner case nr==1.
>
> Thanks
> Barry
