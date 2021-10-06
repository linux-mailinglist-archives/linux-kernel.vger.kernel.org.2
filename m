Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5742384F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhJFGsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:48:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:40643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhJFGs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633502770;
        bh=CdOZfoGkofjJohXWQOH8JuFPfL5yFkHJmJPsmyiwKLo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YMYwFFhwBljL/GQIo4yhNiv2Sh0OE50Jdx5ieAaU49/CUxt0ZKyHazK5AEAd2ACwK
         R7avhIx0QTAbTZOJxO6n5lSsWxZwFzhOybXT67zyn7UZlm8BjaudVEXTCMzOiD0J4i
         f2a3Lvfh7sb7XX1X45PTYrqUGp+M5Sj9ExCM+33g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.211]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1mnDIG3jsP-00tRJ2; Wed, 06
 Oct 2021 08:46:10 +0200
Message-ID: <0374eabd5eb0f7fe6527beb187ccb1e88965ab2b.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Barry Song <21cnbao@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Oct 2021 08:46:07 +0200
In-Reply-To: <20211005093137.GQ3959@techsingularity.net>
References: <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
         <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
         <4f571c5c759b9d356d1bb4114fb169181194a780.camel@gmx.de>
         <20211005074719.GP3959@techsingularity.net>
         <ba1195a9843add64b38fce9ceb186c0c21ef5783.camel@gmx.de>
         <20211005093137.GQ3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RKn8VE2gqRbSGZF59oumFTKgajBpUa9GznzUDM8tjZByN4Vjq1W
 I/mlhMSHxtkkHHznK7IL+tq7hQwKfy6uxbEY1sGhsA7dWQJHLEEi2AFWC1NItgy3zc/OvuA
 9EIK/3F0N90LyMZt35taMVKzmvZxSOAW7/KPaZcijDFEOLIarOMC1k32NLVy5J/o6DsWH3q
 kjzbjeqiPa3yHQ9xLUWTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aq7fDFLJUg8=:X6UiZoPRZ0etwB1BYBIcZi
 fTqZ+G1mP0IwnkbiSrP0gt3QIMRMLtt8sqqpwxVMM5QMkUa/FGmh5x3lxilxKD/sUk6+YdSUC
 cYN+HzNAmHfNLf7iGtFEsv2H6actT2oaHyXb8PsRAWCa+TdhmoSfzxNrflknT7StCeCfs1mzL
 rX5dMP1dWjVvxS8SOmvbZyWVDHb5e9Kw2pgeASA4gc2un3wchilfuGVdbvFA69TFG4wftzoX6
 6URgAxkAubnaab9hofF6qiVZxLqVslOynqhpbEoquaIbxB0BTMJpE9IfsUnjvs84bc6yD1c5V
 EhSOnlKQmkUyT/osoqLfpXAKROqZcXVgWHxwoJPxBB4gbd2ztiwxj0NIzwiB1Dc4rbbcVWIP/
 fM94+8e0MHhdRdaPPBenZ2lnFakcSvulIAxq8PMsPm+qPJc5PLxsD8DnxOMZuoO1n5L0L07tW
 6MjwTIV6rfSMiOrRLEigEA9m2KWTKENno+KpbnzHLnqAKnRcmQpf7M8C0uD+bHjOS66cK84RY
 sPH6Y3P+A13VXmjM2GhSNjxXeuf8SRzXo0z/q4LcNh2vtweMnI2R8l6Ab6xoitpBrNTcQcJap
 dJHpJybFwKYsFElTE6x+xWmPSFqzFZu8n3B+i9WNp5yvtzOT3lyuU6nMeKEVsGZCoORmR3P7Q
 YuKeH3GCgflrecNiRm7pIK2Etsv8Bl+TZnHu0kboPgfwW8GFsi+2HnX45dIz4tLLzAgztDFql
 lo91Z1NA+TAuVv4T74CkuwB80b78D42CdIbzbyQ/Mh3Fcxtb4ygBBkyIGUD0za74KC4yL3SyX
 cuyjf8UcR8evFNg5sRvA2OPpQAxivpofpfv4g9zm27oQK5t/VQWzlYkG5w4XgquQY9ZuxJBvW
 xGUz7qT+yJu7Rrryx3XMLaOh7/BKpC9ze0Rvq/YQPRNoRTbwqFPDHfYarXLPQ3gNk9PZdBhDV
 G9qNh+BItobTEP5N3IjWPGILXwy75+izmNLDV+8fiF0Fx6OE76Fj2SUB5D37Hd50Yx+9+e43d
 utH5mT8vCvUDY1SuZQDLF59REMuVAm4fIN43Sa2ktZY7VIbcOtQO03GJKLL43RVJp+usd6coO
 m8y1Yw5hNtn31s=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 10:31 +0100, Mel Gorman wrote:
>
> If you write a formal patch with a Signed-off-by, I'll use it as a basel=
ine
> for the wakegran work or submit it directly. That way, I'll get any LKP
> reports, user regression reports on lkml, any regression reports via
> openSUSE etc and deal with them.
>
> Based on the results I have so far, I would not be twiddling it further
> but that might change when a full range of machines have completed all
> of their tests. Ideally, I would do some tracing to confirm that maximum
> runqueue depth is really reduced by the path.

Ok, I amended it, adding probably way too many words for a dinky bend-
adjust.  Feel free to do whatever you like with every bit below.

sched: Make wake_wide() handle wakees with no wakee_flips

While looking into a wakeup time task stacking problem, noticed
that wake_wide() wasn't recognizing X as a waker-of-many despite
it regularly burst waking 24 QXcbEventQueue threads.  The reason
for this lies in the heuristic requiring both the multi-waker and
its minions to be earning wakee_flips, ie both wake more than one
task. X earns plenty, but the event threads rarely earn any,
allowing the lot to meet wake_affine_weight(), where its use of
slow to update load averages MAY direct the entire burst toward
the waker's CPU, where they WILL stack if SIS can't deflect them.

To combat this, have the multi-waker (X in this case) trickle
enough flips to its wakees to keep those who don't earn flips
barely eligible.  To reduce aging taking too many of the thread
pool below the limit due to periods of inactivity, continue to
wake wide IFF the waker has a markedly elevated flip frequency.

This improved things for the X+QXcbEventQueue burst, but is a
bit hacky. We need a better M:N load activity differentiator.

Note: given wake_wide()'s mission is to recognize when thread
pool activity exceeds sd_llc_size, it logically SHOULD play no
role whatsoever in boxen with a single LLC, there being no other
LLCs to expand/shrink load distribution to/from.  While this
patchlet hopefully improves M:N detection a bit in general, it
fixes nothing.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5869,6 +5869,15 @@ static void record_wakee(struct task_str
 	}

 	if (current->last_wakee !=3D p) {
+		int min =3D __this_cpu_read(sd_llc_size) << 1;
+		/*
+		 * Couple waker flips to the wakee for the case where it
+		 * doesn't accrue any of its own, taking care to not push
+		 * it high enough to break the wake_wide() waker:wakees
+		 * heuristic for those that do accrue their own flips.
+		 */
+		if (current->wakee_flips > p->wakee_flips * min)
+			p->wakee_flips++;
 		current->last_wakee =3D p;
 		current->wakee_flips++;
 	}
@@ -5899,7 +5908,7 @@ static int wake_wide(struct task_struct

 	if (master < slave)
 		swap(master, slave);
-	if (slave < factor || master < slave * factor)
+	if ((slave < factor && master < (factor>>1)*factor) || master < slave * =
factor)
 		return 0;
 	return 1;
 }

