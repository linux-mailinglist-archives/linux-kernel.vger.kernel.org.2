Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBED412D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 05:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhIUDyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 23:54:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:47815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhIUDye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 23:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632196355;
        bh=r3xl6ViXZ8jgRjOEtQO4whBlrs8Seet1iwhiVgObEe4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aYUAwglq1MFT5nK4GczHCkIIrKBj/lhWWtjEqv64oFPi1PBMIpq3cnUEDxo2McZXq
         fmfavDtNkw/PWQCjxq9sg3PFAgg8+YzuULBilqrQHIqql9w9rC4Otvp8ut/gPyPH89
         0F+8rUL0nbnmo4MmOFs1kzfk70Mhqu0fnto1e+kU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.33]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1mArSN0lAO-00HcVP; Tue, 21
 Sep 2021 05:52:35 +0200
Message-ID: <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Sep 2021 05:52:32 +0200
In-Reply-To: <20210920142614.4891-3-mgorman@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9t0pnDVoamktI2GrIJ23ADQ3eimqjSO43/Q15i5jfR/LWP54snE
 eAfTWf7z6NaOvvRMAPbQSCjU55WwVUEFP5C7gX0VXIrEfR8NvBTpYPZxuCXAl6NhUn4Y0iB
 M0096XOVu5qFgi9LOaQ4iWkTzazxWhFGRqnyc+oi2ChhcVBxpE8V6laTge6GlvX8xH4Jaeg
 fiBOnu2uvEgtahY48abew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Odmo0F2+fAY=:9Iday6/sSCWy6U0EcJhRfn
 vqvja/EIqn7CKRM/8GaoSqHAV0l9GdNEdsfyC05I78w83Iia9ydY1s2+UjJnYgLSrXLWs+Jo1
 HM5YCF3sGbY6OZ0KfX8cFDLBQnNPeJ3mTRqNXDIhESy7aTbZ8bXzZ4Chu8eoXdwF4cXQ3IpA2
 pr/GZMvn0z9Qp9MTnmxGnH5/D3edAK14S3a1oOh0HfDb0zIJVLMxoGI+90vKVob7XYiuc4bLc
 oUnx70xQigfcYo4M+FPD+YhAMnFfusRgG5RNHKeUH7XIxmuKVTJ1Yu1hKxi5PHCz58hBzMRfz
 optusi+PWMILMZRijmnbgp7seL+VYNJVpqDQ/RpiIg9eGgRiMA+Tc7zlE2G5UAd/x7p39JgPN
 pqOq+yiCkoz/ggkHVVHAedqC5ZQ6KMrQY+ZegyWnbhoNHXQ1gxOeQvRp0pgL+5tJopEscc7yp
 9eQu/VrS3yehrWUyP4Ywjjy4ObaNy0qeK6rtUTL12kU1KE+qtKjiz7GRZXCj0ffeJIZhqDbDS
 af3VE2eIHMTHlTUQTehj6ygxhYxhLi02ZjBVJR2cXnBUHatBGxry3Vq9SH84TvIXah4wpfZHM
 pDkvmGw02faPLpX2DTqgZHLSqjTtUUj0MSO6jtB1hhX5/J2ee3SoHzDpnAuSRjj5paCDvYXP+
 jFFxo+V/tLZmBMZTqCMPgfRBTDf5g/DkMAKu8pSLAnAP/RXdEuxgbgmHWEkqM65iy4V7dnsIC
 d3I0D5l+BvGWpyvEfoI+oJjfdxQvvY5Xb5Mggedp6ZPf+V8FUNffwD2VmCmy4eq1tC0AmXUaK
 s+K1OlL5VJWtUrGuzOUc1NQVr9LQb+Hkb2wVmpT2iswtE12DQZpsb4C+CnoJo2wJ5CjPT+T34
 7/hD+Lh5t6P3j3RMHlXPoSSd4r0DPGIPquBUn/eWpGs2PJ1fjRUiYwejcEKVcfQHZRp5cPWg2
 lmUNsik/JqNM42VO/tLeYP0wL093iE/J5ClvCwnXc+SmyKbLFe4f5dI1WQIxbI0AAWgOIJPsz
 3EiLzX+K9YUK/xcLZ1WCWkmHQ3uLwZhzGJI/L3s4UtTq6YZRxHK8KSLqqBmH5L7zZza9HG3ec
 8wP+rruistigPg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-20 at 15:26 +0100, Mel Gorman wrote:
>
> This patch scales the wakeup granularity based on the number of running
> tasks on the CPU up to a max of 8ms by default.=C2=A0 The intent is to
> allow tasks to run for longer while overloaded so that some tasks may
> complete faster and reduce the degree a domain is overloaded. Note that
> the TuneD throughput-performance profile allows up to 15ms but there
> is no explanation why such a long period was necessary so this patch is
> conservative and uses the value that check_preempt_wakeup() also takes
> into account.=C2=A0 An internet search for instances where this paramete=
r are
> tuned to high values offer either no explanation or a broken one.
>
> This improved hackbench on a range of machines when communicating via
> pipes (sockets show little to no difference). For a 2-socket CascadeLake
> machine, the results were

Twiddling wakeup preemption based upon the performance of a fugly fork
bomb seems like a pretty bad idea to me.

Preemption does rapidly run into diminishing return as load climbs for
a lot of loads, but as you know, it's a rather sticky wicket because
even when over-committed, preventing light control threads from slicing
through (what can be a load's own work crew of) hogs can seriously
injure performance.

<snip>

> @@ -7044,10 +7045,22 @@ balance_fair(struct rq *rq, struct task_struct *=
prev, struct rq_flags *rf)
> =C2=A0}
> =C2=A0#endif /* CONFIG_SMP */
> =C2=A0
> -static unsigned long wakeup_gran(struct sched_entity *se)
> +static unsigned long
> +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long gran =3D s=
ysctl_sched_wakeup_granularity;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If rq is specified, scale =
the granularity relative to the number
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of running tasks but no mo=
re than 8ms with default
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sysctl_sched_wakeup_granul=
arity settings. The wakeup gran
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reduces over-scheduling bu=
t if tasks are stacked then the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * domain is likely overloade=
d and over-scheduling may
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prolong the overloaded sta=
te.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cfs_rq && cfs_rq->nr_runn=
ing > 1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0gran *=3D min(cfs_rq->nr_running >> 1, sched_nr_laten=
cy);
> +

Maybe things have changed while I wasn't watching closely, but...

The scaled up tweakables on my little quad desktop box:
sched_nr_latency =3D 8
sched_wakeup_granularity =3D 4ms
sched_latency =3D 24ms

Due to the FAIR_SLEEPERS feature, a task can only receive a max of
sched_latency/2 sleep credit, ie the delta between waking sleeper and
current is clipped to a max of 12 virtual ms, so the instant our
preempt threshold reaches 12.000ms, by human booboo or now 3 runnable
tasks with this change, wakeup preemption is completely disabled, or?

	-Mike
