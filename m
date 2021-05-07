Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE6376941
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbhEGRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:07:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236726AbhEGRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:07:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147H3wfD174952;
        Fri, 7 May 2021 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=z+GMRAxLdLXOiv0ZhaJTW5dz/i7wtXIX/9u6P8VtgLw=;
 b=NXI6Up6AnbvRaN9W/GdcatAqi45NHrrjqpr/WskI4K4dmMcnW4cT6FGe3h5KnQCovECh
 XMm8vMNKn7ZbFMQOFCr3PF81jciiFJtr4+t2W1gxYmA9NRRLh3Z8EnBjj/1OOwzf6aOf
 8F860ljEXcdJ1v/E+i5C/pmNpXMDNzIruJhWvgLlslZuOX1Cq0U4/h7a/GefaQsIY+Lr
 DUp2vlNdrny6/wKP5DXzkb+0Wd1hfIRPnAJvExEzWP1s/C7UR5eXP2L5G2JKDn2Mzkhv
 br1tfOcBGgxXjwEiEnOhQM59VG3zpwuYoxoUBIsPN2mYHRPlKw9Rv6ZaNDhJZEvxDka7 BA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38d9cq8fha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 13:05:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 147GvGQe008017;
        Fri, 7 May 2021 17:05:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38csq10dpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 17:05:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 147H5jG526673640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 May 2021 17:05:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A3AF5204E;
        Fri,  7 May 2021 17:05:45 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 2414B52059;
        Fri,  7 May 2021 17:05:42 +0000 (GMT)
Date:   Fri, 7 May 2021 22:35:42 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] sched/fair: Update affine statistics when needed
Message-ID: <20210507170542.GQ2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-2-srikar@linux.vnet.ibm.com>
 <87sg2yil1q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87sg2yil1q.mognet@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRu5mE_iS0atFZHA16CEuPnH4rn7-4qn
X-Proofpoint-ORIG-GUID: VRu5mE_iS0atFZHA16CEuPnH4rn7-4qn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_06:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=818 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Valentin Schneider <valentin.schneider@arm.com> [2021-05-07 17:08:17]:

> On 06/05/21 22:15, Srikar Dronamraju wrote:
> > wake_affine_idle() can return prev_cpu. Even in such a scenario,
> > scheduler was going ahead and updating schedstats related to wake
> > affine. i.e even if the task is not moved across LLC domains,
> > schedstats would have accounted.
> >
> > Hence add a check before updating schedstats.
> >

Thanks Valentin for taking a look at the patch.

> 
> I briefly glanced at the git history but didn't find any proper description
> of that stat. As it stands, it counts the number of times wake_affine()
> purposedly steered a task towards a particular CPU (waker or wakee's prev),
> so nr_wakeups_affine / nr_wakeups_affine_attempts is your wake_affine()
> "success rate" - how often could it make a choice with the available data.
> 
> I could see a point in only incrementing the count if wake_affine() steers
> towards the waker rather than the wakee (i.e. don't increment if choice is
> prev), but then that has no link with LLC spans

Lets say if prev CPU and this CPU were part of the same LLC, and the prev
CPU was busy (or busier than this CPU), should consider this as a wake
affine? If prev was idle, we would have surely consider prev CPU. Also since
both are part of same LLC, we cant say this CPU is more affine than prev
CPU. Or may be I am confusing wake_affine with cache_affine.

> 
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > Cc: Parth Shah <parth@linux.ibm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 794c2cb945f8..a258a84cfdfd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5884,8 +5884,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >       if (target == nr_cpumask_bits)
> >               return prev_cpu;
> >
> > -	schedstat_inc(sd->ttwu_move_affine);
> > -	schedstat_inc(p->se.statistics.nr_wakeups_affine);
> > +	if (!cpus_share_cache(prev_cpu, target)) {
> 
> Per the above, why? Why not just if(target == this_cpu) ?

We could use target == this_cpu. However if prev CPU and this CPU share the
same LLC, then should we consider moving to this_cpu as an affine wakeup?

I could have probably moved this patch a later in the patch series, but one
of the patch that introduces wake_affine_idler_llc() may end up returning
neither this_cpu, prev_cpu or nr_cpumask_bits. In such a case where it
returns a CPU closer to this_cpu, then I would still mark it as wake_affine.

> 
> > +		schedstat_inc(sd->ttwu_move_affine);
> > +		schedstat_inc(p->se.statistics.nr_wakeups_affine);
> > +	}
> >       return target;
> >  }
> >
> > --
> > 2.18.2

-- 
Thanks and Regards
Srikar Dronamraju
