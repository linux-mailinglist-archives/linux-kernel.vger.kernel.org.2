Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDD632A433
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380055AbhCBK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:26:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379456AbhCBKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:05:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122A399m033891;
        Tue, 2 Mar 2021 05:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=xG1Q8xntkpqsWLtw6mW1OsuOjgSQK4G5eydDJOFmknQ=;
 b=SSnKj/SeG60Ky5b9weB09w8e1R0K7K79fytS213G6GyBx7iMv4yarLI50zRHhicmfzX2
 extVV965lVwz8fA4ZpfVmGmjWEjw8XOf4C3P9tpQd/cv2T1/gFIofFoq+WJfpn9gj0kR
 3ef7QvlvlGqBliVR78bjgWFI2cxkazrU2Z/H9VZHtNRR/jnhkT3pYdGWQo4IBhYuYMCY
 DNGEAc1JcBCh1ihYj2CVzjYXcTXLdk/k2Mg5FXje72xYzUX6UyyZyzvTOjfjOVKKDOSN
 8zjZzZ+5r4alcDmSmRS67bSsz93v4vShUEN249kk28QPAa58JU1irqFSpfescdAAk1NV Ug== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371jtm93g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 05:04:33 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122A2mrk000544;
        Tue, 2 Mar 2021 10:04:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3712v50cfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 10:04:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122A4S8d35783040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 10:04:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999544C04E;
        Tue,  2 Mar 2021 10:04:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B7C14C05A;
        Tue,  2 Mar 2021 10:04:26 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Mar 2021 10:04:26 +0000 (GMT)
Date:   Tue, 2 Mar 2021 15:34:25 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <20210302100425.GM2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <19bfd781-05f7-b220-d8a2-fde8ea2d9959@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <19bfd781-05f7-b220-d8a2-fde8ea2d9959@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_03:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=835 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dietmar Eggemann <dietmar.eggemann@arm.com> [2021-03-02 10:53:06]:

> On 26/02/2021 17:40, Srikar Dronamraju wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a8bd7b13634..d49bfcdc4a19 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5869,6 +5869,36 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> >  	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
> >  }
> > 
> > +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> > +{
> > +	struct sched_domain_shared *tsds, *psds;
> > +	int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> > +
> > +	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> > +	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> > +	tllc_size = per_cpu(sd_llc_size, this_cpu);
> > +
> > +	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> > +	pnr_busy = atomic_read(&psds->nr_busy_cpus);
> > +	pllc_size = per_cpu(sd_llc_size, prev_cpu);
> > +
> > +	/* No need to compare, if both LLCs are fully loaded */
> > +	if (pnr_busy == pllc_size && tnr_busy == pllc_size)
> 
>                                                      ^
>                                            shouldn't this be tllc_size ?

Yes, thanks for pointing out.

-- 
Thanks and Regards
Srikar Dronamraju
