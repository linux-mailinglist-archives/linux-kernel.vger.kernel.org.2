Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC03292DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbhCAUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:53:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237138AbhCARKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:10:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121H3tcm159164;
        Mon, 1 Mar 2021 12:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=tUITBLLGrO998CeK21GFLsqWb+0czuIx/92TvP387X8=;
 b=HcxUuhp7rSZotnl1Sf9uPXSaHPswNj39dfSj8Wl6P74kzaCWkSUhQ5HiZxxo968uRqFa
 6V6lGwq3EgXKYfMoiAV5VvdopEqeqQRo/UrqtbOQDBnwNnIhAOzukg+0kCxkiXXjgH3/
 8ggUMJG7fqsUxBM+GmuwEMkdKWd00h6XtP6YLzZyRLWx+CxNSBiDBFyCaqwZqD/O8nPy
 wCWm1iJkOXtM4Tvv37SFuwUC6UhbThx7rpI3swoULj60MNSI9zQyv5HyGPXSGSxLB2at
 04St1mqt2kUnA0T9ko/gVMp2IVgoWwIQ/UxFDnLwbQk7Bqprc33Le1+11PGwR8I5AAPm uQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3713ku1xgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 12:08:56 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121H7JNn027326;
        Mon, 1 Mar 2021 17:08:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3713s9r0g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 17:08:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121H8q3B44171682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 17:08:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29D5F4C044;
        Mon,  1 Mar 2021 17:08:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C15984C040;
        Mon,  1 Mar 2021 17:08:49 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  1 Mar 2021 17:08:49 +0000 (GMT)
Date:   Mon, 1 Mar 2021 22:38:49 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <20210301170849.GK2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <YD0K8Sal4KbxWD23@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YD0K8Sal4KbxWD23@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_12:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103010137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2021-03-01 16:40:33]:

> On Fri, Feb 26, 2021 at 10:10:29PM +0530, Srikar Dronamraju wrote:
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
> 
> nr_busy_cpus is NO_HZ_COMMON So this code that consumes it should be
> too.

Thanks Peter, will take care of this along with other changes including
calling within rcu_read_lock and checking for tsds and psds after
rcu_dereference.

-- 
Thanks and Regards
Srikar Dronamraju
