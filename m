Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112342021F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhJCOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 10:55:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:55103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhJCOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 10:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633272771;
        bh=+rwDZV93aFSasFp20tI0GYldViVWvkQuXoJtdlWhsXI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ZEJoVx2rTH1hPNht9ITs6f5m+N42x5avivphZwsxec0wl2upGdaGYUHPx86p6aBFC
         73lU0twyUGdppZAVLW2gY1Jb7jHe1c+C1FsoXQDufzUBTFRwii/h1eskqzJUkYp63+
         Ooo5Iw40LNlpJHsunyDA1t6SM4ybYihneYdO11xM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1mhWzN0cli-00ATYm; Sun, 03
 Oct 2021 16:52:51 +0200
Message-ID: <4713ffb37ee8f6042626904ad33fa91b5151f0d6.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 03 Oct 2021 16:52:45 +0200
In-Reply-To: <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S4BZdeOxSK8jnNBoQMkOutpOhcivLAnuayuvBuWwQ4MXJPluKCZ
 cvYoNhWIhBHFv88oQR6C09zt3UkG5gkgQFK88oZs5zxM8kpd77i5NcCZkYBBnYWh5ftDn2Q
 xa/h+GkWNh8sFh1G/RuP+ZSNAkBpbwYB+U7iy9q2A9R6lxEHqXMmDjCDI60NAUmNHgz/O6V
 IwNAu8mKx5911y2mG8QIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f0vp3CeRBZ4=:gRYz7oEGIZUSrdNSCHdiZa
 SBYKyvPzFkvydBNpv230xtt4vLxZApcH1+8papOQ9Xw+2I8scYb8TdXgqf20BdQne6LVQBS82
 bv71+sNMnQawxNB1XRiZKgCJU6LMWfSBnvAP3x9oXi/9RqmmGY2zhUDTllnxvO/VKla3kgS44
 rW8pd18Z31kljPUxCb/i88Jf3QINn4WBYM0vSCt4psuYjtp2Y3IeH5ebtnK/Q8K2DQHms1gwo
 HKS7dw9D/jKKUBUMlzkDYu6FarbZ59O39gAQfDN5vlzDrFvxzEn6OL+/2nL72IivSFm2CHpCn
 UZbDOdcZQKmAHe9UprYXSgFr2Mm1bsKc1lByZNLIn0E9zyo8S9OerXFyiGxCQBcHPxW7Pz2Dp
 SBKj/HaQ5rnl4i9FjPuKoqEixbUNNHusSzR3J2xZJi8XRBOAYDu3wSgpRLB4kD/ROr60rSiev
 eUWWS+S+48UN6llJ1Ri6kLniRKeGb5XJpd6ZMidL4pPi9Tg/pOTNWvclY9+L+QPDbyJ9tjFzL
 FpB+UlE84H1xwlThSFpbVvlVytNDiq7BKE23v6te6ew/W2sLsI0zYuEAgivo5kg+d6u3IwT7z
 Dx7LxGK+6BkRWUwG41IYK2ZegG11sV4W3mUYc5PziMCvHCeoRXrFwLefg1ucA+tGpacMgrGhX
 ZlKM6Bx4ea+6a1PtSWJyB1ZbBHFBeioXoEu7EcZj8D4O1I4+bg99o06izZAF+Bk1/hTQ38m8r
 //oOI9a6zd+aRP5GPXCC/veND+iajM9DiOjWZ+yExtkW/YdWU9yMfsN9SYzpYOP1oCOhJ8wGN
 k2qgSoB+loZ3YiD5E9g9pf4msV/3DOrjEsAtq/a6xl0k2zqMmXpIedVNe6kaDUKbztBDLs2gw
 Mh/cW39465RLjSQw3EZqYebTgkln60d5P/1iMHHGTazOK+pGy2SQ66CDowcUG6t/tcSFA7Oj2
 8hUYPCJ3rGJOuFfR/YoXqg2HGPl+0rs4662xH15SKMa5trLibkVoVLb5iM/8MdCdA2uulQ1oe
 aAPyB5c6E008DDFDwBDdOgdoKTUIRD9TgztFj5+RvzyeIg0wV6w1U1JMo/wBH8E1ecz3Sw0GI
 KnVVjRZhWdOSVg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-10-03 at 20:34 +1300, Barry Song wrote:
> >
> > I looked into that crazy stacking depth...
> >
> > static int
> > wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int this_cpu, int prev_cpu, int sy=
nc)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 this_eff_load, prev_eff=
_load;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long task_load;
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_eff_load =3D cpu_load(=
cpu_rq(this_cpu));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^=
^^^^^^^^^^^^^^^^^^^^^^^ the butler didit!
> >
> > That's pretty darn busted as it sits.=C2=A0 Between load updates, X, o=
r any
> > other waker of many, can stack wakees to a ludicrous depth.=C2=A0 Trac=
ing
> > kbuild vs firefox playing a youtube clip, I watched X stack 20 of the
> > zillion firefox minions while their previous CPUs all had 1 lousy task
> > running but a cpu_load() higher than the cpu_load() of X's CPU.=C2=A0 =
Most
> > of those prev_cpus were where X had left them when it migrated. Each
> > and every crazy depth migration was wake_affine_weight() deciding we
> > should pull based on crappy data.=C2=A0 As instantaneous load on the w=
aker
> > CPU blew through the roof in my trace snapshot, its cpu_load() did
> > finally budge.. a tiny bit.. downward.=C2=A0 No idea where the stack w=
ould
> > have topped out, my tracing_off() limit was 20.
>
> Mike, not quite sure I caught your point. It seems you mean x wakes up
> many firefoxes within a short period, so it pulls them to the CPU where =
x
> is running. Technically those pulling should increase cpu_load of x' CPU=
.
> But due to some reason, the cpu_load is not increased in time on x' CPU,
> So this makes a lot of firefoxes piled on x' CPU, but at that time,=C2=
=A0 the load
> of the cpu which firefox was running on is still larger than x' cpu with=
 a lot
> of firefoxes?

It looked like this.

X-2211    [007] d...211  2327.810997: select_task_rq_fair: this_run/load:4=
:373 prev_run/load:4:373 waking firefox:4971 CPU7 =3D=3D> CPU7
X-2211    [007] d...211  2327.811004: select_task_rq_fair: this_run/load:5=
:373 prev_run/load:1:1029 waking QXcbEventQueue:4952 CPU0 =3D=3D> CPU7
X-2211    [007] d...211  2327.811010: select_task_rq_fair: this_run/load:6=
:373 prev_run/load:1:1528 waking QXcbEventQueue:3969 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811015: select_task_rq_fair: this_run/load:7=
:373 prev_run/load:1:1029 waking evolution-alarm:3833 CPU0 =3D=3D> CPU7
X-2211    [007] d...211  2327.811021: select_task_rq_fair: this_run/load:8=
:373 prev_run/load:1:1528 waking QXcbEventQueue:3860 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811026: select_task_rq_fair: this_run/load:8=
:373 prev_run/load:1:1528 waking QXcbEventQueue:3800 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811032: select_task_rq_fair: this_run/load:9=
:373 prev_run/load:1:1528 waking xdg-desktop-por:3341 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811037: select_task_rq_fair: this_run/load:1=
0:373 prev_run/load:1:289 waking at-spi2-registr:3165 CPU4 =3D=3D> CPU7
X-2211    [007] d...211  2327.811042: select_task_rq_fair: this_run/load:1=
1:373 prev_run/load:1:1029 waking ibus-ui-gtk3:2865 CPU0 =3D=3D> CPU0
X-2211    [007] d...211  2327.811049: select_task_rq_fair: this_run/load:1=
1:373 prev_run/load:1:226 waking ibus-x11:2868 CPU2 =3D=3D> CPU2
X-2211    [007] d...211  2327.811054: select_task_rq_fair: this_run/load:1=
1:373 prev_run/load:11:373 waking ibus-extension-:2866 CPU7 =3D=3D> CPU7
X-2211    [007] d...211  2327.811059: select_task_rq_fair: this_run/load:1=
2:373 prev_run/load:1:289 waking QXcbEventQueue:2804 CPU4 =3D=3D> CPU7
X-2211    [007] d...211  2327.811063: select_task_rq_fair: this_run/load:1=
3:373 prev_run/load:1:935 waking QXcbEventQueue:2756 CPU1 =3D=3D> CPU7
X-2211    [007] d...211  2327.811068: select_task_rq_fair: this_run/load:1=
4:373 prev_run/load:1:1528 waking QXcbEventQueue:2753 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811074: select_task_rq_fair: this_run/load:1=
5:373 prev_run/load:1:1528 waking QXcbEventQueue:2741 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811079: select_task_rq_fair: this_run/load:1=
6:373 prev_run/load:1:1528 waking QXcbEventQueue:2730 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811085: select_task_rq_fair: this_run/load:1=
7:373 prev_run/load:1:5 waking QXcbEventQueue:2724 CPU0 =3D=3D> CPU0
X-2211    [007] d...211  2327.811090: select_task_rq_fair: this_run/load:1=
7:373 prev_run/load:1:1010 waking QXcbEventQueue:2721 CPU6 =3D=3D> CPU7
X-2211    [007] d...211  2327.811096: select_task_rq_fair: this_run/load:1=
8:373 prev_run/load:1:1528 waking QXcbEventQueue:2720 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811101: select_task_rq_fair: this_run/load:1=
9:373 prev_run/load:1:1528 waking QXcbEventQueue:2704 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811105: select_task_rq_fair: this_run/load:2=
0:373 prev_run/load:0:226 waking QXcbEventQueue:2705 CPU2 =3D=3D> CPU2
X-2211    [007] d...211  2327.811110: select_task_rq_fair: this_run/load:1=
9:342 prev_run/load:1:1528 waking QXcbEventQueue:2695 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811115: select_task_rq_fair: this_run/load:2=
0:342 prev_run/load:1:1528 waking QXcbEventQueue:2694 CPU5 =3D=3D> CPU7
X-2211    [007] d...211  2327.811120: select_task_rq_fair: this_run/load:2=
1:342 prev_run/load:1:1528 waking QXcbEventQueue:2679 CPU5 =3D=3D> CPU7

Legend: foo_run/load:foo->nr_running:cpu_load(foo)

Every migration to CPU7 in the above was due to wake_affine_weight()
seeing more or less static effective load numbers (the trace was wider,
showing which path was taken).

> I am wondering if this should be the responsibility of wake_wide()?

That's a good point.  I'm not so sure that would absolve use of what
appears to be stagnant state though.  If we hadn't gotten there, this
stack obviously wouldn't have happened.. but we did get there, and
state that was used did not reflect reality.  wake_wide() deflecting
this particular gaggle wouldn't improved state accuracy one whit for a
subsequent wakeup, or?

	-Mike
