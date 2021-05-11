Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8737ABD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhEKQY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:24:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231920AbhEKQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:24:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BG441W147301;
        Tue, 11 May 2021 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=MX/pe2X8Lj0OwytIdDUlgjVyW5DRpANBNnHL+GxaeGY=;
 b=GAAaYEjxsSDePPo8O89YTaPoijyZch88ly0N8gYvJrHYjrd38lvvH9VdAeoHZmCFEuJN
 NOCv7SSQ5MX0oLw89ami3sUnfx4boJFS65LiAx3Z8Nt0IMS6AQIf/QADCIjha7Ucfgmr
 n8FAH0VAy4PGDl1MJ7XhVfIth8wFkWWToUKUCQIWbEoQDjWaI8XakLshbeoVOUHNw/rS
 BadFy+WNCy89HW5wH7lVsLFdAY2eue4TxKbCllB7hvXC8ao8B9cMFyfWjUj510LYbiRx
 NINc+lwTRZtESjxqUjJzkfBX6R+xAWQVryWokHpfyrx7cSDnynZ5hr5C6C8t7TPrF50z nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fve320r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 12:22:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BGI9ud016942;
        Tue, 11 May 2021 16:22:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj989s3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 16:22:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BGMN9U34144600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 16:22:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B404203F;
        Tue, 11 May 2021 16:22:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28A9942049;
        Tue, 11 May 2021 16:22:48 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 11 May 2021 16:22:47 +0000 (GMT)
Date:   Tue, 11 May 2021 21:52:47 +0530
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
Message-ID: <20210511162247.GS2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-2-srikar@linux.vnet.ibm.com>
 <87sg2yil1q.mognet@arm.com>
 <20210507170542.GQ2633526@linux.vnet.ibm.com>
 <87sg2t1o9z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87sg2t1o9z.mognet@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EVXYIadUXl2Szavm1yEXLxubzyQP1STB
X-Proofpoint-ORIG-GUID: EVXYIadUXl2Szavm1yEXLxubzyQP1STB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=847 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Valentin Schneider <valentin.schneider@arm.com> [2021-05-11 12:51:52]:

> On 07/05/21 22:35, Srikar Dronamraju wrote:
> > * Valentin Schneider <valentin.schneider@arm.com> [2021-05-07 17:08:17]:
> >
> >> On 06/05/21 22:15, Srikar Dronamraju wrote:
> >> > wake_affine_idle() can return prev_cpu. Even in such a scenario,
> >> > scheduler was going ahead and updating schedstats related to wake
> >> > affine. i.e even if the task is not moved across LLC domains,
> >> > schedstats would have accounted.
> >
<snip>
> > Lets say if prev CPU and this CPU were part of the same LLC, and the prev
> > CPU was busy (or busier than this CPU), should consider this as a wake
> > affine? If prev was idle, we would have surely consider prev CPU. Also since
> > both are part of same LLC, we cant say this CPU is more affine than prev
> > CPU. Or may be I am confusing wake_affine with cache_affine.
> >
> 
> SD_WAKE_AFFINE says: "Consider waking task on waking CPU.", with that I
> read wake_affine() as: "should I place the wakee close to the waker or
> close to its previous CPU?". This can be yes or no even if both are in the
> same LLC.
> 

Okay.

<snip>

> >> > --- a/kernel/sched/fair.c
> >> > +++ b/kernel/sched/fair.c
> >> > @@ -5884,8 +5884,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >> >       if (target == nr_cpumask_bits)
> >> >               return prev_cpu;
> >> >
> >> > -	schedstat_inc(sd->ttwu_move_affine);
> >> > -	schedstat_inc(p->se.statistics.nr_wakeups_affine);
> >> > +	if (!cpus_share_cache(prev_cpu, target)) {
> >>
> >> Per the above, why? Why not just if(target == this_cpu) ?
> >
> > We could use target == this_cpu. However if prev CPU and this CPU share the
> > same LLC, then should we consider moving to this_cpu as an affine wakeup?
> >
> 
> It would make sense if it's a sync wakeup, which wake_affine() does try to
> do ATM (regardless of LLC actually, if I'm reading it correctly).

Okay, I will replace the cpus_share_cache check with target == this_cpu.

-- 
Thanks and Regards
Srikar Dronamraju
