Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6939C8FA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEOP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:15:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEOPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:15:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B02B12FC;
        Sat,  5 Jun 2021 07:14:07 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2843F73D;
        Sat,  5 Jun 2021 07:14:05 -0700 (PDT)
Date:   Sat, 5 Jun 2021 15:14:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than
 cpu.uclamp.max
Message-ID: <20210605141403.xlizhezj556ywvg4@e107158-lin.cambridge.arm.com>
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com>
 <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
 <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
 <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 21:24, Xuewen Yan wrote:
> Hi Qais
> 
> On Sat, Jun 5, 2021 at 7:49 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > In addition，In your patch:
> > > 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
> > > https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
> > >
> > > + switch (clamp_id) {
> > > + case UCLAMP_MIN: {
> > > + struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
> > > + if (uc_req.value < uc_min.value)
> > > + return uc_min;
> > > + break;
> > >
> > > When the clamp_id = UCLAMP_MIN, why not judge the uc_req.value is
> > > bigger than task_group(p)->uclamp[UCLAMP_MAX] ?
> >
> > Because of the requirement I pointed you to in cgroup-v2.rst. We must allow any
> > value to be requested.
> >
> > Ultimately if we had
> >
> >         cpu.uclamp.min = 80
> >         cpu.uclamp.max = 50
> >
> > then we want to remember the original request but make sure the effective value
> > is capped.
> >
> > For the user in the future modifies the values such that
> >
> >         cpu.uclamp.max = max
> >
> > Then we want to remember cpu.uclamp.min = 80 and apply it since now the
> > cpu.uclamp.max was relaxed to allow the boost value.
> >
> > > Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp[UCLAMP_MAX],
> > > the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into
> > > [ task_group(p)->uclamp[UCLAMP_MAX],  task_group(p)->uclamp[UCLAMP_MAX] ].
> > >
> > > Is it necessary to fix it here？
> >
> > Nope. We must allow any combination values to be accepted and remember them so
> > if one changes we ensure the new effective value is updated accordingly.
> > This is how cgroups API works.
> 
> Sorry. I may not have expressed it clearly. In your patch (which has
> not yet merged into the mainline):
> 
> 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
>  https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
> 
> This patch will not affect p->uclamp_req, but consider the following situation:
> 
> tg->cpu.uclamp.min = 0
> tg->cpu.uclamp.max = 50%
> 
> p->uclamp_req[UCLAMP_MIN] = 60%
> p->uclamp_req[UCLAMP_MIN] = 80%
> 
> The function call process is as follows：
> uclamp_eff_value() -> uclamp_eff_get() ->uclamp_tg_restrict()
> 
> with your patch, the result is:
> 
> p->effective_uclamp_min = 60%
> p->effective_uclamp_max = 50%

Are you saying my patch introduced a regression? If there's a bug I would not
expect my patch to have had an impact in this area.

uclamp_tg_restrict() uses taskgroup(p)->uclamp[] which is the effective uclamp
that is capped in cpu_util_update_eff().

Are you statically analyzing the code or this is the outcome of an experiment
you ran on hardware?

Cheers

--
Qais Yousef

> 
> It would not affect the uclamp_task_util(p), but affect the rq:
> when p enqueued:
> rq->uclamp[UCLAMP_MIN] = 60%
> rq->uclamp[UCLAMP_MIN] = 50%
> 
> futher more,  in uclamp_rq_util_with() {
> ...
> 
> min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value); //60%
> max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);//50%
> ...
> if (unlikely(min_util >= max_util))
> return min_util;
> 
> return clamp(util, min_util, max_util);
> ...
> }
> as a result, it would return 60%.
> 
> Thanks!
> xuewen
