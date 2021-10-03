Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6E41FF64
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 05:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhJCDKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 23:10:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:39759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJCDKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633230482;
        bh=BiR0TTSaFVrNTJ0x8SGCwGU7RsgK2/SRIgCA7sUDQ7o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Jsg33M8UdauoGzbdi9RSOZo3gbQ1OYLvrSEVft2q+X8QZnbm5hbllb68o07MP8qxA
         97Ogqv1nARV94YkRKrVVDy/22IsN45PYZNa2r5iQ0VcuxbNj7jnilEhtYi5om97ZM6
         +sxbiVPBEoPNozoPYFHDzapRz/Z/+JNYEzr4OYKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1mbpfk1byU-00Dn35; Sun, 03
 Oct 2021 05:08:02 +0200
Message-ID: <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
Subject: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2] sched/fair:
 Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 03 Oct 2021 05:07:58 +0200
In-Reply-To: <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:94FRYWdzqDYHffzo7NoOI23FyA7ivTfzTzfETT//7E0Uav7OCqO
 QP1BSqAWfd8Pf2vd8o8y7ycOn2lK60TdHWinTxVoZ9Wnt+h4YY1JPRrtO7+RVyAjtASQwmz
 o9/24/kgM1Oaepy/ue55STa7A7iNSPcu+gMn5KVaUqkkGxK5hOL21lY//3g7nl1RLeD3equ
 jG7v7SsDXxVAu5CWrO0IA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5OPVQVE6Xx0=:i5ZcLdelLo/hB5D/4MRfeo
 +prLpdIcyHM2/mkOcgVmPkW+fHaATCTc7sLZumLsr/RFJLxM2Q9yWfT6ZGjKpxRQhnx9EXpkx
 oqxNIlR6LXOXJgt0exaN6giJ+ovoT9hVj5n2cvDrTqlJO04bA/SKffwNZxwm/KcKZH4YNZsJj
 x0YIrSdIbliaTtn0CAvDINtJYbLJj1lvbdqOboLfxtkkC7QZMTfMRPfzeiLw0Q1g5L044i5bL
 SuPHDNtTMD7An4cKNceUCvVRmxb/6La474gYnnNRXVdIVi7UhRE7MaDspqDJ48uS60W3dLJwz
 fwrSWZfWvFTN1KL059RcZNy3MOdDXKZYSWwEG1QSQIzQHreVxxePLQYkX+C2W6CxxQxE2r54T
 WI8/Y8H+lfF1d4hpMH2izhnN6hgwmK3qRwyT0skD1Pv8fgrLkaJshekMiRR6vT/RgVANVfRVN
 MdOsYnmQAkWZ344qWExvi2y0vceV4U6OPOPh8R9x04wNV0R93Q8gtoHwmXG5P1iCfwllYr5BC
 OR/PO92Nb7NnBfq5+YktOU2jyKeb881p+6xa1YsKQ4tRvXszkG8rLVA2CXbOQ11DdvlOnPaMK
 oK1ILFrAN4Ei3yy7f5wbzeIiX0oeoV4SDdrlcTPrxdnL9nu7DcdPPtf+TrDSVGr/QAUUaEf46
 z1Q8U4/T6FKrJciiyyrabLMIORbj5q7LU83fNPi5MPwSSenFiCbNRd1/i2wICDUATcHeQgNB7
 5jkPwFHuVx6QKzbN9DW46VphQI1W83LHydx7CvYNs+ZZZJMWRO8kjgJgowYSnJb2DyEr2o6Ro
 LrIFaOcp7hnSk8oiJnvdFBnmbnhiYJ4OkXg3/F+saDmwduO3txcwRMTq0CfSgHQRLsq26Kxmf
 +NsVdJNWh2JsAwzOD6M+9CePsMzr4LD1YbW75Ex3bgrXT/ZCia8jgb1QI5+FJ53/ADJ9h4Tb1
 eAZrK10qVkR3ZQnKMdm0RDj8ONXo9seTSuTt52AugUJZ96OpjjNw7YYTXhkrglOVlcRBfGGbh
 qTZ/UmUUmVpH9FyrA95XN9/oAeAfrWL5XlWtL4IVPq46PkVKe/xNHzANkhTj76CX7I6fRnyVV
 VhXPlgWQy3CTTY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 07:22 +0200, Mike Galbraith wrote:
> On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> >
> >
> > > Preemption does rapidly run into diminishing return as load climbs f=
or
> > > a lot of loads, but as you know, it's a rather sticky wicket because
> > > even when over-committed, preventing light control threads from slic=
ing
> > > through (what can be a load's own work crew of) hogs can seriously
> > > injure performance.
> > >
> >
> > Turning this into a classic Rob Peter To Pay Paul problem. We don't kn=
ow
> > if there is a light control thread that needs to run or not that affec=
ts
> > overall performance. It all depends on whether that control thread nee=
ds
> > to make progress for the overall workload or whether there are a mix o=
f
> > workloads resulting in overloading.
>
> WRT overload, and our good buddies Peter and Paul :) I added...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (gran >=3D sysctl_sch=
ed_latency >> 1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0trace_printk("runnable:%d preempt disabled\n",cfs_=
rq->nr_running);
> ...to watch, and met the below when I.. logged in.=C2=A0
>
> homer:..debug/tracing # tail -20 trace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
322: wakeup_gran: runnable:9 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
325: wakeup_gran: runnable:10 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
330: wakeup_gran: runnable:11 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
363: wakeup_gran: runnable:13 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
377: wakeup_gran: runnable:14 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
390: wakeup_gran: runnable:15 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
404: wakeup_gran: runnable:16 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
425: wakeup_gran: runnable:9 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksmserver-2694=C2=A0=C2=A0=C2=A0 [0=
03] d..3.=C2=A0=C2=A0=C2=A0 60.690432: wakeup_gran: runnable:6 preempt dis=
abled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ksmserver-2694=C2=A0=C2=A0=C2=A0 [0=
03] d..3.=C2=A0=C2=A0=C2=A0 60.690436: wakeup_gran: runnable:7 preempt dis=
abled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
451: wakeup_gran: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [002] d..5.=C2=A0=C2=A0=C2=A0 60.690=
465: wakeup_gran: runnable:7 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmix-=
2736=C2=A0=C2=A0=C2=A0 [000] d..3.=C2=A0=C2=A0=C2=A0 60.690491: wakeup_gra=
n: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
635: wakeup_gran: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
675: wakeup_gran: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
863: wakeup_gran: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
944: wakeup_gran: runnable:6 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
957: wakeup_gran: runnable:7 preempt disabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 X-2229=C2=A0=C2=A0=C2=A0 [004] d..5.=C2=A0=C2=A0=C2=A0 92.889=
968: wakeup_gran: runnable:8 preempt disabled
> =C2=A0 QXcbEventQueue-2740=C2=A0=C2=A0=C2=A0 [000] d..4.=C2=A0=C2=A0=C2=
=A0 92.890025: wakeup_gran: runnable:6 preempt disabled
> homer:..debug/tracing
>
> Watching 'while sleep 1; do clear;tail trace; done' with nothing but a
> kbuild running is like watching top.=C2=A0 There's enough stacking durin=
g
> routine use of my desktop box that it runs into the tick granularity
> wall pretty much continuously, so 'overload' may want redefining.

I looked into that crazy stacking depth...

static int
wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
                   int this_cpu, int prev_cpu, int sync)
{
        s64 this_eff_load, prev_eff_load;
        unsigned long task_load;

        this_eff_load =3D cpu_load(cpu_rq(this_cpu));
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ the butler didit!

That's pretty darn busted as it sits.  Between load updates, X, or any
other waker of many, can stack wakees to a ludicrous depth.  Tracing
kbuild vs firefox playing a youtube clip, I watched X stack 20 of the
zillion firefox minions while their previous CPUs all had 1 lousy task
running but a cpu_load() higher than the cpu_load() of X's CPU.  Most
of those prev_cpus were where X had left them when it migrated. Each
and every crazy depth migration was wake_affine_weight() deciding we
should pull based on crappy data.  As instantaneous load on the waker
CPU blew through the roof in my trace snapshot, its cpu_load() did
finally budge.. a tiny bit.. downward.  No idea where the stack would
have topped out, my tracing_off() limit was 20.

Hohum, my box grew a WA_INST companion to SIS_MIN_LAT cache cold task
distribulator feature ;-)  Not particularly lovely, but it knocks over
the leaning tower of minions.

	-Mike
