Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C647F37ABE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhEKQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231454AbhEKQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:28:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BG4nYi184437;
        Tue, 11 May 2021 12:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=ukEE5lWbcpWFggGo8+3ThPWwYeaji+TUNdWM9T4XUkI=;
 b=PVSH4J63PU+egF7fG0VPZIl/GUhosRy056VkRn5ovKMzgbEe2QYghBGmY2T2Rer3I4vJ
 +skcszGJRG50OWiOjZ7YDHoPEV4MpjSoexOIRe2SAoBwq9LMLICiEP0o6UGZivE6q6qY
 6kQAfGPN+JQy3HE1e1iPQRN05JmkOq4BzyBTQ6I05PcmbJX1thQeqczmO0v8cCG8YTZw
 cLsTK4awj7pWpBrhfu3G/oV/bVkSDTWN4etwkCs9zdpCgzZ5aM33go6oT20lF3OgsfJ3
 iSdJo7UlnxGA3Njh1+j0ZDy65zK8Tn3fklJ6S46G7Si2d2mx1t23BverWg+DOVDZo0rg SA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fvvt94bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 12:27:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BGH2gw024803;
        Tue, 11 May 2021 16:27:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 38dj988y7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 16:27:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BGQhaY23134528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 16:26:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD20AE053;
        Tue, 11 May 2021 16:27:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82AB7AE045;
        Tue, 11 May 2021 16:27:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 11 May 2021 16:27:08 +0000 (GMT)
Date:   Tue, 11 May 2021 21:57:07 +0530
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
Subject: Re: [PATCH v2 2/8] sched/fair: Maintain the identity of idle-core
Message-ID: <20210511162707.GT2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-3-srikar@linux.vnet.ibm.com>
 <87v97p1oap.mognet@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87v97p1oap.mognet@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A1T1Rodvvh-W_F0EIASNEkRtXR3n3X7Z
X-Proofpoint-ORIG-GUID: A1T1Rodvvh-W_F0EIASNEkRtXR3n3X7Z
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=977 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Valentin Schneider <valentin.schneider@arm.com> [2021-05-11 12:51:26]:

> On 06/05/21 22:15, Srikar Dronamraju wrote:
> > Scheduler maintains a per LLC info which tells if there is any idle core
> > in that LLC. However this information doesn't provide which core is idle.
> >
> 

<snip>

> > On the converse, if a task is pinned, and has a restricted
> > cpus_allowed_list and LLC has multiple idle-cores, but select_idle_core
> > cannot find a idle-core, LLC will no more maintain that it has an
> > idle-core.
> >
> 
> This however does sound icky.
> 

<snip>

> > @@ -6127,7 +6129,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  {
> >       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > -	bool smt = test_idle_cores(target, false);
> > +	int idle_core = get_idle_core(target, -1);
> > +	bool smt = (idle_core != -1);
> 
> test_idle_cores() tells you if there's at least one idle core in the
> target's LLC. AFAICT get_idle_core() only tells you whether the target's
> core is idle, which is not the same thing.
> 
> Note that this code has recently been changed by Rik in
> 
>   c722f35b513f ("sched/fair: Bring back select_idle_smt(), but differently")
> 
> so as annoying as it is you should probably go try this out / rebase your
> series on top of it (as a rule of thumb for core scheduler stuff you should
> use https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git -b
> tip/sched/core as a base).

Yes I did notice it, I will rebase the next version on top of tip/sched/core

-- 
Thanks and Regards
Srikar Dronamraju
