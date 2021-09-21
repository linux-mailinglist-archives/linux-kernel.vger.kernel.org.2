Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8FE413365
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhIUMfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:35:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:60149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232542AbhIUMex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632227577;
        bh=5sWPB+IPzVy3zfsxM6C/xJp6mL92T9fMUf8uDwg7vy0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KzF93y8T/FVc9vO1EX2llo8Q0JQXJtKUVUKpSROBWs5wxWwILuOTjMS5KNt2cMtjr
         P+uxCb89iy8PE9X4b1rwVHnCcTszm1/NxBys9/6yTPIYwCWjNdS6vvE2FBm9CEzula
         56zCHZGwmxcX2ChpYVctH2b+dK4qZ0S6sIloVXnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.33]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1mo9yi2SpN-00vbti; Tue, 21
 Sep 2021 14:32:57 +0200
Message-ID: <0cf76bb7701d4a37367773881c7d7c7bfceb455e.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
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
Date:   Tue, 21 Sep 2021 14:32:54 +0200
In-Reply-To: <20210921103621.GM3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OmVrVx2ck1gbfoB4YTY746Zxwaqdy+nVdi+iLytokDXHQzeZ7yj
 mN6TtWhXa9u0fa0lf5PP8eo9BPOHmiM+HT9oXL+/UD7PuqcA0ZixI/9plB5jN82gSU9+kzL
 x0rC/EELpe1auiDjMsb5LJc+2PQT9sywONnUH0/70LdOJqrmATzVQ0ufgSGaMqryU68yQDQ
 3CDnCe4eJpnxTcT+RSDHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+d/+0Sosz4M=:h6H5r530rtr4mcsNV1CI46
 s+zzL7Jpv8JDDdC07h5oRj+79YFBmWmKZaD20nIlTbRtu3rFnjZtfPRuxPBh3IvFAtgGNMPSP
 KdOvOibydSXVpuy+nnEZBf9OTDj9OI9hePiMLYx+oLK29XGvZajoy4GA+mfeCKbKTsCaT+b2z
 FHhGwMc47Oqj0cjCKHN7byOawebXZ4BiYFA45ks2xtUhpwGdiAEVA3J1BPC0eZIPJ19JCV0dc
 Hi+a1HvV4Zc6kz/kBitqHfjWkfZ7d1F5AQWt7ArHVhnI8aI5arM4qQMFi1utaP6GnP1RdIhSz
 oJBf8HhTthFbeiYmMgjahrxJvRxZIMkWBBJT1AyEWEMLS9AUxvoV8RzcTP1Gpb330PXFazsej
 krPmn3PBCQGNtQURcFsP0g0wLYE9AuKBzdtVwj351pk+tNor6FoZF8fMnYmavi+g+j7IgiZBW
 8sYHFSUc6yF7XypP6meRjqqyeVgOUu2HUY995DfHVlYRq+m5K9fmZcUgiNw0F6o1KmXyWAe0x
 lpJeZNKsgOTXmx7OyMp3iV61dHpMHOB/4ZCIvEcdH0MeQx1cp+fM2Exp0MqbCGzriX4BJc11k
 WPGOwbTAn3c0EVOwSt6bk5Mt/4MVcl/VWriy30y/tIbbHeOEUvsaCmnR/yWBSFML4JbzX5Lmf
 0Bla4bMBBqF7nwkSXcR458kP0uQqo3zfQZut82ShCzt8dqZVa420J5JxtRiRLJgo7s/2EMj34
 LRA3zTpydE4oYKLoGqw2ob4Ecpernalwn6siwgALuZ4s3F/91HYBi5EMIyLbs9R9Izr9FDiiM
 5V92iodxBYdQ/74zOayXIxhylgZnRhkbqAPYqyvj/r8Rk+v3NfakWcLDQ+G4puiVM0jZSLEVg
 y0ZbPZvrAdAFfVKCvq2eEidgjXkKXz3u4b5ItqFE9M/5Vr9O/58N0NhEBOnjIV72b3ImPCur/
 0m+3UNniSwfO3PylYu/yai4ac1OjUkRulh1K3+iUg1ByhBEZloI+a8knUICeo5Km+bPkAzKhb
 2+M1as5f8mYKgAaTAX6N8urGlzQMFUcIJ3HmnGa/VbDO1TC/s9WPQGYVe/RL0OcGmXOfurCNn
 9+J/6IJpjwi8kI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> >
>
> > Preemption does rapidly run into diminishing return as load climbs for
> > a lot of loads, but as you know, it's a rather sticky wicket because
> > even when over-committed, preventing light control threads from slicin=
g
> > through (what can be a load's own work crew of) hogs can seriously
> > injure performance.
> >
>
> Turning this into a classic Rob Peter To Pay Paul problem.

Damn near everything you do in sched-land is rob Peter to pay Paul.

>  We don't know
> if there is a light control thread that needs to run or not that affects
> overall performance. It all depends on whether that control thread needs
> to make progress for the overall workload or whether there are a mix of
> workloads resulting in overloading.

Sure.. and operative words "we don't know" cuts both ways.

CFS came about because the O1 scheduler was unfair to the point it had
starvation problems. People pretty much across the board agreed that a
fair scheduler was a much way better way to go, and CFS was born.  It
didn't originally have the sleep credit business, but had to grow it to
become _short term_ fair.  Ingo cut the sleep credit in half because of
overscheduling, and that has worked out pretty well all told.. but now
you're pushing it more in the unfair direction, all the way to
extremely unfair for anything and everything very light.

Fairness isn't the holy grail mind you, and at some point, giving up on
short term fairness certainly isn't crazy, as proven by your hackbench
numbers and other numbers we've seen over the years, but taking bites
out of the 'CF' in the CFS that was born to be a corner-case killer
is.. worrisome.  The other shoe will drop.. it always does :)

> > <snip>
> >
> > > @@ -7044,10 +7045,22 @@ balance_fair(struct rq *rq, struct task_stru=
ct *prev, struct rq_flags *rf)
> > > =C2=A0}
> > > =C2=A0#endif /* CONFIG_SMP */
> > > =C2=A0
> > > -static unsigned long wakeup_gran(struct sched_entity *se)
> > > +static unsigned long
> > > +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long gran =
=3D sysctl_sched_wakeup_granularity;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If rq is specified, sc=
ale the granularity relative to the number
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of running tasks but n=
o more than 8ms with default
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sysctl_sched_wakeup_gr=
anularity settings. The wakeup gran
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reduces over-schedulin=
g but if tasks are stacked then the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * domain is likely overl=
oaded and over-scheduling may
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prolong the overloaded=
 state.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cfs_rq && cfs_rq->nr_=
running > 1)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0gran *=3D min(cfs_rq->nr_running >> 1, sched_nr_la=
tency);
> > > +
> >
> > Maybe things have changed while I wasn't watching closely, but...
> >
>
> Yeah, a lot has changed and unfortunately, I still lack a lot of
> historical context on why things are the way they are.
>
> > The scaled up tweakables on my little quad desktop box:
> > sched_nr_latency =3D 8
> > sched_wakeup_granularity =3D 4ms
> > sched_latency =3D 24ms
> >
> > Due to the FAIR_SLEEPERS feature, a task can only receive a max of
> > sched_latency/2 sleep credit,
>
> A task that just became runnable rather than all tasks, right?

I'm talking about tasks being enqueued during wakeup.

> > ie the delta between waking sleeper and
> > current is clipped to a max of 12 virtual ms, so the instant our
> > preempt threshold reaches 12.000ms, by human booboo or now 3 runnable
> > tasks with this change, wakeup preemption is completely disabled, or?
> >
>
> I'm having trouble reconciling this in some sensible fashion.
> sched_nr_latency is the threshold where the sched period might be stretc=
hed
> (sysctl_sched_latency/sysctl_sched_min_granularity) which is why I picke=
d
> it - (nr_running > sched_nr_latency) is a tipping point where the
> scheduler changes behaviour.

Yeah, an existing branch is as good a place as any.

> FAIR_SLEEPERS primarily affects tasks that just became runnable and the
> new task is trying to fit in without causing too much disruption based
> on sysctl_sched_latency.

No, fair sleepers is all about sleeper wakeup preemption, I think
you're thinking of fork initial placement.

> As sysctl_sched_wakeup_granularity is now debugfs and should not be
> tuned, we want to avoid that. On the other hand, we also know from the
> results that overloaded tasks may fail to make sufficient progress so,
> do we either try to dynamically adjust or do we just ignore the problem?

Good question.  Anything you do is guaranteed to be wrong for
something, which is why CFS was born.. fair doesn't have corner cases.

> If we are to dynamically adjust then what should it be? One alternative
> could be to base the tipping point on the ratio of sysctl_sched_latency =
to
> gran, take FAIR_SLEEPERS into account, sanity check the result and stick=
 it
> behind a feature flag in case it needs to be disabled to debug a preempt
> starvation problem.
>
> This on top?

Dunno.  Seeing as how it wasn't as aggressive as I thought at first
glance, maybe that original rolldown will be more or less fine.  I
don't like it much, but numbers talk, BS walks.  I trust boxen on such
matters way more than any human, myself included ;-)

	-Mike

