Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1E39C7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhFELvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 07:51:01 -0400
Received: from foss.arm.com ([217.140.110.172]:60000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFELvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707FB2B;
        Sat,  5 Jun 2021 04:49:12 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FE693F73D;
        Sat,  5 Jun 2021 04:49:10 -0700 (PDT)
Date:   Sat, 5 Jun 2021 12:49:08 +0100
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
Message-ID: <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com>
 <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 10:12, Xuewen Yan wrote:
> Hi Qais,
> 
> On Sat, Jun 5, 2021 at 12:08 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 06/03/21 10:24, Xuewen Yan wrote:
> > > +CC Qais
> >
> > Thanks for the CC :)
> >
> > >
> > >
> > > Hi Quentin
> > >
> > > On Wed, Jun 2, 2021 at 9:22 PM Quentin Perret <qperret@google.com> wrote:
> > > >
> > > > +CC Patrick and Tejun
> > > >
> > > > On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
> > > > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > >
> > > > > When setting cpu.uclamp.min/max in cgroup, there is no validating
> > > > > like uclamp_validate() in __sched_setscheduler(). It may cause the
> > > > > cpu.uclamp.min is bigger than cpu.uclamp.max.
> > > >
> > > > ISTR this was intentional. We also allow child groups to ask for
> > > > whatever clamps they want, but that is always limited by the parent, and
> > > > reflected in the 'effective' values, as per the cgroup delegation model.
> >
> > As Quentin said. This intentional to comply with cgroup model.
> >
> > See Limits and Protections sections in Documentation/admin-guide/cgroup-v2.rst
> >
> > Specifically
> >
> >         "all configuration combinations are valid"
> >
> > So user can set cpu.uclamp.min higher than cpu.uclamp.max. But when we apply
> > the setting, cpu.uclamp.min will be capped by cpu.uclamp.max. I can see you
> > found the cpu_util_update_eff() logic.
> >
> 
> Thanks a lot for your patience to explain, sorry for my ignorance of
> Documentation/admin-guide/cgroup-v2.rst.

No problem :)

> 
> > >
> > > It does not affect the 'effective' value. That because there is
> > > protection in cpu_util_update_eff():
> > > /* Ensure protection is always capped by limit */
> > > eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
> > >
> > > When users set the cpu.uclamp.min > cpu.uclamp.max:
> > > cpu.uclamp.max = 50;
> > > to set : cpu.uclamp.min = 60;
> > > That would make the uclamp_req[UCLAMP_MIN].value = 1024* 60% = 614,
> > > uclamp_req[UCLAMP_MAX].value = 1024* 50% = 512;
> > > But finally, the  uclamp[UCLAMP_MIN].value = uclamp[UCLAMP_MAX].value
> > > = 1024* 50% = 512;
> > >
> > > Is it deliberately set not to validate because of the above?
> >
> > Sorry I'm not following you here. What code paths were you trying to explain
> > here?
> >
> > Did you actually hit any problem here?
> 
> I just gave an example of the difference of uclamp_req and uclamp
> without my patch, and can ignore it.

Cool.

> 
> >
> In addition，In your patch:
> 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
> https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
> 
> + switch (clamp_id) {
> + case UCLAMP_MIN: {
> + struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
> + if (uc_req.value < uc_min.value)
> + return uc_min;
> + break;
> 
> When the clamp_id = UCLAMP_MIN, why not judge the uc_req.value is
> bigger than task_group(p)->uclamp[UCLAMP_MAX] ?

Because of the requirement I pointed you to in cgroup-v2.rst. We must allow any
value to be requested.

Ultimately if we had

	cpu.uclamp.min = 80
	cpu.uclamp.max = 50

then we want to remember the original request but make sure the effective value
is capped.

For the user in the future modifies the values such that

	cpu.uclamp.max = max

Then we want to remember cpu.uclamp.min = 80 and apply it since now the
cpu.uclamp.max was relaxed to allow the boost value.

> Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp[UCLAMP_MAX],
> the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into
> [ task_group(p)->uclamp[UCLAMP_MAX],  task_group(p)->uclamp[UCLAMP_MAX] ].
> 
> Is it necessary to fix it here？

Nope. We must allow any combination values to be accepted and remember them so
if one changes we ensure the new effective value is updated accordingly.
This is how cgroups API works.

Hope this makes sense.

Cheers

--
Qais Yousef
