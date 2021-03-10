Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55D333598
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhCJFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:53:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCJFxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:53:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A5WxUC182649;
        Wed, 10 Mar 2021 00:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=9JpVg7aTOVQ4fp+YnR+/y7NKUVon7nuBy31an7KLqjI=;
 b=WJCgLGwHcakd6h6lyr92Th9Nfr/91E83wD295NIdNs1UV5o0CDkbpCRgAFA/GfhevKP+
 SCgoLCltV5oqfDoEPiQBbMnZgWyBIRbPRfE/+q9e8k7xhjfyERkPAER/EDZl5ClWLkxL
 vg2ZO3RLgEpCyymji40zphNnUfdgDQ1yXzyXLFAwQ6nmSHe5xtV/nNuLznprwZlQCuz8
 3tlvGtqUnR5fI2RmSia3NE5QANR8o/x/cb+d3Z9oxzX7HckgyQuzyQ1uM/bqyq9QlyYV
 H4m9/B4Yl3akV8o4vuK4T/8s+Z22wC4RruI8fjicLHQiBzCW+8Um1epdEkChKmXbvVzh 3A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 376j2kfv0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 00:52:49 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12A5hZmk028949;
        Wed, 10 Mar 2021 05:52:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 376agr09yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 05:52:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12A5qiM944957984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 05:52:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AFBB5204F;
        Wed, 10 Mar 2021 05:52:44 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 4D07152054;
        Wed, 10 Mar 2021 05:52:42 +0000 (GMT)
Date:   Wed, 10 Mar 2021 11:22:41 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <20210310055241.GO2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtA2XSmqt1L2X9WvdtdA5eqNYuhSws8jDOr1HA1xqXWfDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtA2XSmqt1L2X9WvdtdA5eqNYuhSws8jDOr1HA1xqXWfDQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2021-03-08 14:52:39]:

> On Fri, 26 Feb 2021 at 17:41, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >

Thanks Vincent for your review comments.

> > +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> > +{
> > +       struct sched_domain_shared *tsds, *psds;
> > +       int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> > +
> > +       tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> > +       tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> > +       tllc_size = per_cpu(sd_llc_size, this_cpu);
> > +
> > +       psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> > +       pnr_busy = atomic_read(&psds->nr_busy_cpus);
> > +       pllc_size = per_cpu(sd_llc_size, prev_cpu);
> > +
> > +       /* No need to compare, if both LLCs are fully loaded */
> > +       if (pnr_busy == pllc_size && tnr_busy == pllc_size)
> > +               return nr_cpumask_bits;
> > +
> > +       if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > +               return this_cpu;
> 
> Why have you chosen to favor this_cpu instead of prev_cpu unlike for wake_idle ?

At this point, we know the waker running on this_cpu and wakee which was
running on prev_cpu are affine to each other and this_cpu and prev_cpu dont
share cache. I chose to move them close to each other to benefit from the
cache sharing. Based on feedback from Peter and Rik, I made the check more
conservative i.e tnr_busy <= tllc_size/smt_weight (where smt_weight is the
cpumask weight of smt domain for this_cpu) i.e if we have a free core in
this llc domain, chose this_cpu.  select_idle_sibling() should pick an idle
cpu/core/smt within the llc domain for this_cpu.

Do you feel, this may not be the correct option?

We are also experimenting with another option, were we call prefer_idler_cpu
after wa_weight. I.e 
1. if wake_affine_weight choses this_cpu but llc in prev_cpu has an idle
smt/CPU but there are no idle smt/CPU in this_cpu, then chose idle smt/CPU
in prev_cpu
2. if wake_affine_weight choses nr_cpumask(aka prev_cpu) but llc in this_cpu
has an idle smt/CPU but there are no idle smt/CPU in prev_cpu, then chose
idle smt/CPU in this_cpu


> > +
> > +       /* For better wakeup latency, prefer idler LLC to cache affinity */
> > +       diff = tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
> > +       if (!diff)
> > +               return nr_cpumask_bits;
> > +       if (diff < 0)
> > +               return this_cpu;
> > +
> > +       return prev_cpu;
> > +}
> > +
> >  static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >                        int this_cpu, int prev_cpu, int sync)
> >  {
> > @@ -5877,6 +5907,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >         if (sched_feat(WA_IDLE))
> >                 target = wake_affine_idle(this_cpu, prev_cpu, sync);
> >
> > +       if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits &&
> > +                               !cpus_share_cache(this_cpu, prev_cpu))
> > +               target = prefer_idler_llc(this_cpu, prev_cpu, sync);
> 
> could you use the same naming convention as others function ?
> wake_affine_llc as an example

I guess you meant s/prefer_idler_llc/wake_affine_llc/
Sure. I can modify.

> 
> > +
> >         if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
> >                 target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
> >
> > @@ -5884,8 +5918,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >         if (target == nr_cpumask_bits)
> >                 return prev_cpu;
> >
> > -       schedstat_inc(sd->ttwu_move_affine);
> > -       schedstat_inc(p->se.statistics.nr_wakeups_affine);
> > +       if (target == this_cpu) {
> 
> How is this condition related to $subject ?

Before this change, wake_affine_weight and wake_affine_idle would either
return this_cpu or nr_cpumask_bits. Just before this check, we check if
target is nr_cpumask_bits and return prev_cpu. So the stats were only
incremented when target was this_cpu.

However with prefer_idler_llc, we may return this_cpu, prev_cpu or
nr_cpumask_bits. Now we only to update stats when we have chosen to migrate
the task to this_cpu. Hence I had this check.

If we use the slightly lazier approach which is check for wa_weight first
before wa_idler_llc, then we may not need this change at all.

-- 
Thanks and Regards
Srikar Dronamraju
