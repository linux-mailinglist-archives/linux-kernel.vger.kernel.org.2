Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECB3872FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbhERHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:21:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241083AbhERHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:21:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14I7DbNN035089;
        Tue, 18 May 2021 03:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=0ZPBUZUkOrTcW6YPM/YRI0Amr8obvw69ulniybDxJIg=;
 b=NnOkR40WEgT6XTnJQ/27F9lAgpXSMBJSvPtwCUhsNcYB9mNB6/9W5yeH+ASTe5bW9mr9
 1LraIRzX1QsaNrMeVT/VuIdGx6MF7jXhuU3ux63orBW5G+Gm3bpKqXpLN/1XUg4+IWyH
 d2ByA7cj42LjzCXp7jNeNHtFRnknOpgdJ5vSKuBMYP7TOeErM2nkU1Ma83EtmXemeJC+
 UptcGb7l9rLhgtdbzNEnipXjQx90jnl6Xqegpin8Y7EfM1DKnOwzFLkF3bMTP+eXnKJS
 C5asDbC7KmEkM8vin6JLlVBn3ccd5l31tGu0toYA+MXseWokIEMWBH9LLr9y7HVW5Ya5 Mg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38m90mr3wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 03:18:51 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14I7HTge013816;
        Tue, 18 May 2021 07:18:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgs8xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 07:18:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14I7IkgP29884734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 07:18:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E39F42047;
        Tue, 18 May 2021 07:18:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F07042045;
        Tue, 18 May 2021 07:18:44 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 18 May 2021 07:18:44 +0000 (GMT)
Date:   Tue, 18 May 2021 12:48:43 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
Message-ID: <20210518071843.GZ2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
 <20210517125727.GX2633526@linux.vnet.ibm.com>
 <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
 <20210518040024.GY2633526@linux.vnet.ibm.com>
 <ce4eba7e-dc2e-1c67-d04d-579f04c2040b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ce4eba7e-dc2e-1c67-d04d-579f04c2040b@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G8vc8ih0-N40VvRJCLBAhgvOEXU5o1CM
X-Proofpoint-GUID: G8vc8ih0-N40VvRJCLBAhgvOEXU5o1CM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_03:2021-05-17,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-18 14:05:56]:

> On 5/18/21 12:00 PM, Srikar Dronamraju wrote:
> > * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-18 08:59:00]:
> > 
> >> On 5/17/21 8:57 PM, Srikar Dronamraju wrote:
> >>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-17 20:48:46]:
> >>>
> >>>> On 5/17/21 6:40 PM, Srikar Dronamraju wrote:
> >>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:
> >>>>>
> >>>>>> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
> >>>>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
> >>>>>>>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
> >>>>>

<snip>
> >>
> >> This is v3. It looks like hackbench gets better. And netperf still has
> >> some notable changes under 2 x overcommit cases.
> >>
> > 
> > Thanks Aubrey for the results. netperf (2X) case does seem to regress.
> > I was actually expecting the results to get better with overcommit.
> > Can you confirm if this was just v3 or with v3 + set_next_idle_core
> > disabled?
> 
> Do you mean set_idle_cores(not set_next_idle_core) actually? Gautham's patch
> changed "this" to "target" in set_idle_cores, and I removed it to apply
> v3-2-8-sched-fair-Maintain-the-identity-of-idle-core.patch for tip/sched/core
> commit-id 915a2bc3c6b7.

Thats correct,

In the 3rd patch, I had introduced set_next_idle_core
which is suppose to set idle_cores in the LLC.
What I suspected was is this one is causing issues in your 48 CPU LLC.

I am expecting set_next_idle_core to be spending much time in your scenario.
I was planning for something like the below on top of my patch.
With this we dont look for an idle-core if we already know that we dont find one.
But in the mean while I had asked if you could have dropped the call to
set_next_idle_core.

-- 
Thanks and Regards
Srikar Dronamraju

------------>8-----------------8<--------------------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bee8e5225d99..2e2113262647 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6207,6 +6207,9 @@ static void set_next_idle_core(int target)
 	if (!sd)
 		return;
 
+	if (atomic_read(&sd->shared->nr_busy_cpus) * 2 >=  per_cpu(sd_llc_size, target))
+		goto out;
+
 	cpumask_andnot(cpus, sched_domain_span(sd), cpu_smt_mask(target));
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
@@ -6225,6 +6228,7 @@ static void set_next_idle_core(int target)
 
 		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
+out:
 	set_idle_core(target, -2);
 }
 

