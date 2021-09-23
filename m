Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96290415532
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbhIWBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:49:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:49537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238177AbhIWBtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632361652;
        bh=9rj0wRbsRka/mqdZWeaS364ql8AvDUlzY/e1FId8R5E=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=a3u3nYov9mr36WNFwmc3Z7fWCnyb9EJJa201Q9NRotDr5qcIEPb1RmvnZCQx+YtRD
         tKwqfIem+XodvCbQiKl/eV3qFPxOf3/vMbO7zBbYgfyRQnfiHJUgqeuAOGN8NpBM1c
         VuXO5znnJ/Gxz+FP1GolJ3WmME4/4geWeKNehL4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.175]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1mDjFU0r28-00OFsT; Thu, 23
 Sep 2021 03:47:32 +0200
Message-ID: <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Sep 2021 03:47:30 +0200
In-Reply-To: <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <20210922132002.GX3959@techsingularity.net>
         <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
         <20210922150457.GA3959@techsingularity.net>
         <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
         <20210922173853.GB3959@techsingularity.net>
         <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8IfYZu/IAaSTN9249HczCCLmJcCV9aXk6k4XZsq9bf/NOvbRo1
 jWaFC9J/X+ce+hJmlaXbVfoxt4sa0mO5Sv9jK6ig3DEQxXtHVq2xdpE+Zd0hARu/EVxrWW8
 1tJ9XzgPVMalVi3no0bzi42B4iPEjT0qoUPIaorGjNPNlQIveEpC3nxGnZMt9PuI5qUoPcl
 r1DOId9pt4BnfNx35OUSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V7r5zrQ+5Pc=:TIdvRg8HldsK7eLu6WVo5H
 FXturr0Qzklf7kmhCo6kV8bfW49Fa3oH1b7L8eIAIWp7vWv9KGkm4T1oeIrf5QTouR5HzIQ3J
 prd6uI1JLnTR87Kw6S/+mmK6sQylpyhCp7Wd49Ya+/iRl1agUGTBgchu50M0JhTz6qhO3RjZx
 3SDz52nCAyx2mdJIyxtZ/luW38jM4WRuCniHNEZF9c1KoBhdk4X819kukrDxcNb+Sh5IWjEn7
 xMf1tOIMg8648f4Twycgg+nqaXWJXtSTAF84WlEMggPS+HFoDmTJahVMmI+/aBE/XXHzBwK/T
 f0mqjvn+vMMy77ljmHo6oGlagTVllvPjTaClo4N6STfEW+4ObnZw+k7oJwJb+h6DOsf0NzRw9
 THh7h/Vcrpej2OKfbkFE/YfYh2ximrugv8LJrWGIj6VQ3r4mSZ5mpav7o3hAKpqPUqZZf4xca
 iklZilCU6KTt18lcYYdLt/bArs5ykXy/nZcvahnKu7j1MYNx/PlWbYBAf+h8YdiA+qQk5YV91
 41nkzjfl5i+PSZuiCFz7B0knVxjJFg6vMgfYqDKAgFQUnJBZQZnqYkNCwF9NriR1feL1HhxMx
 qMMvIp6wucFSTzBaIZf8ohVwsJpMuRHXu34YFvozw2csk+4LKkWp4cMC+9UEM97j7tgVYp9IQ
 EvdIGKNCGogOmsi9SCtkvrNfudY/zZVbucmKjFSUk6qEWyTDheON78FEIHT0hM0NaKtFdordQ
 cqIfUu/XojfMQBa6o7p7aQdLd1YJ6a0eXhdFd6CjdDP4lov34GklBLpTQyOsvpDnD1flNba46
 Gk1u/7X/wOhvObCfTFyKXczYUhlfKm+PnjBTrF+HrDOQkbhIbeQxhoC1G/B8LrDZIPZu3qZRZ
 dc02Q4j4vYtoT862piNQzO+4QG790g203jhPkl3Gmk0bw4PD3Ngloukhyc1DSBGdGD0mSvr2S
 ccoIfnL/tQuEPI+jC01S0IxvG7+pR5VebuYizxFBblfCm01d7FyV2/kwEAYU2gSmw+8LcujQm
 tE37wad46VjOh/B+x+oTnI1sr/idsAeL5PEU6L/tFl+HDScf5Vyls7tve0/BoVA5ziqRzfDqr
 97bQtc8BjTnQOM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 20:22 +0200, Vincent Guittot wrote:
> On Wed, 22 Sept 2021 at 19:38, Mel Gorman <mgorman@techsingularity.net> =
wrote:
> >
> >
> > I'm not seeing an alternative suggestion that could be turned into
> > an implementation. The current value for sched_wakeup_granularity
> > was set 12 years ago was exposed for tuning which is no longer
> > the case. The intent was to allow some dynamic adjustment between
> > sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> > over-scheduling in the worst case without disabling preemption entirel=
y
> > (which the first version did).

I don't think those knobs were ever _intended_ for general purpose
tuning, but they did get used that way by some folks.

> >
> > Should we just ignore this problem and hope it goes away or just let
> > people keep poking silly values into debugfs via tuned?
>
> We should certainly not add a bandaid because people will continue to
> poke silly value at the end. And increasing
> sysctl_sched_wakeup_granularity based on the number of running threads
> is not the right solution.

Watching my desktop box stack up large piles of very short running
threads, I agree, instantaneous load looks like a non-starter.

>  According to the description of your
> problem that the current task doesn't get enough time to move forward,
> sysctl_sched_min_granularity should be part of the solution. Something
> like below will ensure that current got a chance to move forward

Nah, progress is guaranteed, the issue is a zillion very similar short
running threads preempting each other with no win to be had, thus
spending cycles in the scheduler that are utterly wasted.  It's a valid
issue, trouble is teaching the scheduler to recognize that situation
without mucking up other situations where there IS a win for even very
short running threads say, doing a synchronous handoff; preemption is
cheaper than scheduling off if the waker is going be awakened again in
very short order.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9bf540f04c2d..39d4e4827d3d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7102,6 +7102,7 @@ static void check_preempt_wakeup(struct rq *rq,
> struct task_struct *p, int wake_
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int scale =3D cfs_rq->nr_runn=
ing >=3D sched_nr_latency;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int next_buddy_marked =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cse_is_idle, pse_is_idle;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long delta_exec;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(se =3D=3D pse))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
> @@ -7161,6 +7162,13 @@ static void check_preempt_wakeup(struct rq *rq,
> struct task_struct *p, int wake_
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_curr(cfs_rq_of(se));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta_exec =3D se->sum_exec_runtim=
e - se->prev_sum_exec_runtime;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that current got a =
chance to move forward
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (delta_exec < sysctl_sched_min_=
granularity)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wakeup_preempt_entity(se,=
 pse) =3D=3D 1) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Bias pick_next to pick the sched entity that is

Yikes!  If you do that, you may as well go the extra nanometer and rip
wakeup preemption out entirely, same result, impressive diffstat.

	-Mike
