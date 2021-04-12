Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862B835CF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbhDLRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:15:28 -0400
Received: from foss.arm.com ([217.140.110.172]:56306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243788AbhDLRPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:15:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B6931B;
        Mon, 12 Apr 2021 10:15:06 -0700 (PDT)
Received: from [10.57.31.161] (unknown [10.57.31.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 050E03F73B;
        Mon, 12 Apr 2021 10:15:03 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
 <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
 <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
 <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com>
 <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
Message-ID: <b4631807-9b10-ce11-c206-ba347980f771@arm.com>
Date:   Mon, 12 Apr 2021 18:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> > > >
> > > > This patch-set is not significantly improving the execution time of
> > > > feec(). The results we have so far are an improvement of 5-10% in
> > > > execution time, with feec() being executed in < 10us. So the 
> gain is not
> > > > spectacular.
> > >
> > > well， I meaned to cache all util value and compute energy with 
> caches,
> > > when
> > > (cpu==dst_cpu), use caches instead of updating util, and do not get
> > > util with function:
> > >  "effective_cpu_util()", to compute util with cache.
> > > I add more parameters into pd_cache:
> > > struct pd_cache {
> > >         unsigned long util;
> > >         unsigned long util_est;
> > >         unsigned long util_cfs;
> > >         unsigned long util_irq;
> > >         unsigned long util_rt;
> > >         unsigned long util_dl;
> > >         unsigned long bw_dl;
> > >         unsigned long freq_util;
> > >         unsigned long nrg_util;
> > > };
> > > In this way, it can avoid util update while feec. I tested with it,
> > > and the negative delta disappeared.
> > > Maybe this is not a good method, but it does work.
> > If I understand correctly, you put all the fields used by
> > core.c:effective_cpu_util() in the caches, allowing to have values not
> > subject to updates.
> Yes.
> > core.c:effective_cpu_util() isn't only called from
> > fair.c:compute_energy(). It is used in the cpufreq_schedutil.c and
> > cpufreq_cooling.c (through core.c:sched_cpu_util()).
> > Did you have to duplicate core.c:effective_cpu_util() to have a second
> > version using the caches ? If yes, I think the function was meant to be
> > unique so that all the utilization estimations go through the same path.
> >
> I defined a new function to distinguish it from the effective_cpu_util.
>
> > If your concern is to avoid negative delta, I think just bailing out
> > when this happens should be sufficient. As shown in the last message,
> > having a wrong placement should not happen that often, plus the prev_cpu
> > should be used which should be ok.
> In your patch, you didn't actually choose the prev_cpu. you return (-1);
>
> > If you want to cache the values, I think a stronger justification will
> > be asked: this seems to be a big modification compared to the initial
> > issue, knowing that another simpler solution is available (i.e. bailing
> > out). I was not able to prove there was a significant gain in the
> > find_energy_efficient_cpu() execution time, but I would be happy if you
> > can, or if you find other arguments.
> Yes, you are right, perhaps there is indeed no need for such a big 
> modification.
>
> Regards

In fair.c:select_task_rq_fair(), if feec() returns a error (< 0), then 
prev_cpu is selected. I think it's better to still let feec() signal 
that something happened and let select_task_rq_fair() select prev_cpu by 
itself.
Are you planning to submit a V2 with the bail out mechanism ?

Regards

