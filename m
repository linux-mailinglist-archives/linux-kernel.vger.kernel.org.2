Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F736B1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhDZKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:31:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17076 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbhDZKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:31:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QA3O0v123310;
        Mon, 26 Apr 2021 06:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=OY/Vz0TTSll4veQ0tws+YMGlTri+mQfL3/jPhpoTd60=;
 b=IFWfrYse1Bsr/vm2cANG0MET47LDT0ChUzKeeEh117JXh/6HvfJJYJqLMpXKEma1wCVr
 dYiPQJCDHa3x0CAbULJdBT5f2PjBTMb71P/s11FN1bmo3mW/zk+rHEeddghcV3sjZlkS
 zrEB/udupGq9Fx6y+G6cq7uD4fmryu3joQLVuBPF962lf9nrAoTmMq4rFwOmyOQ6EECJ
 EXiAvtmjpCwTYMTGnA5Jd3NvRGa8AUTVCjLDyNeafMl00Rr0wsUilnE8lg8Q1C67yVdp
 IYQbc9E0qeTuAUJvf8AZZW23Heduvo8EoukOMengyssU0YncqZgQFBxlJfzgbErem3OO Dg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385u0b9epf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 06:30:40 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QASUEN002397;
        Mon, 26 Apr 2021 10:30:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80dfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:30:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QAUZSE30802340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 10:30:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE0E52051;
        Mon, 26 Apr 2021 10:30:35 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6836B52054;
        Mon, 26 Apr 2021 10:30:33 +0000 (GMT)
Date:   Mon, 26 Apr 2021 16:00:32 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH 00/10] sched/fair: wake_affine improvements
Message-ID: <20210426103032.GI2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
 <20210423103129.GH2633526@linux.vnet.ibm.com>
 <20210423123854.GC4239@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210423123854.GC4239@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MfUx8kq-WFdmUJhH18nWD7uX7QPWAQir
X-Proofpoint-GUID: MfUx8kq-WFdmUJhH18nWD7uX7QPWAQir
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_03:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2021-04-23 13:38:55]:

Hi Mel,

> On Fri, Apr 23, 2021 at 04:01:29PM +0530, Srikar Dronamraju wrote:
> > > The series also oopses a *lot* and didn't get through a run of basic
> > > workloads on x86 on any of three machines. An example oops is
> > > 
> > 
> > Can you pass me your failing config. I am somehow not been seeing this
> > either on x86 or on Powerpc on multiple systems.
> 
> The machines have since moved onto testing something else (Rik's patch
> for newidle) but the attached config should be close enough.
> 
> > Also if possible cat /proc/schedstat and cat
> > /proc/sys/kernel/sched_domain/cpu0/domain*/name
> > 
> 
> For the vanilla kernel
> 
> SMT
> MC
> NUMA

I was able to reproduce the problem and analyze why it would panic in
cpus_share_cache.

In my patch(es), we have code snippets like this.

	if (tsds->idle_core != -1) {
		if (cpumask_test_cpu(tsds->idle_core, p->cpus_ptr))
			return tsds->idle_core;
		return this_cpu;
	}

Here when we tested the idle_core and cpumask_test_cpu,
tsds->idle_core may not have been -1; However by the time it returns,
tsds->idle_core could be -1;

cpus_share_cpus() then tries to find sd_llc_id for -1 and crashes.

Its more easier to reproduce this on a machine with more cores in a
LLC than say a Power10/Power9.  Hence we are hitting this more often
on x86.

One way could be to save the idle_core to a local variable, but that
negates the whole purpose since we may end up choosing a busy CPU.  I
will find a way to fix this problem.

-- 
Thanks and Regards
Srikar Dronamraju
