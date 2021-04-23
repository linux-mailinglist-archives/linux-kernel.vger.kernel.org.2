Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5233736906B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbhDWKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:32:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12342 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhDWKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:32:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NALVNT141202;
        Fri, 23 Apr 2021 06:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=l0HT5kZuJxK9XZlbj71HRQDPHmbvBdgySHh4yFtkuDk=;
 b=rGZ7qTEc/0sXacq8JoDTSVx4+vhmi0gg45lc/GGGV2i9efk3nDZpkKj3E7KwXq3OvMCN
 uSaL7VSo7Rzd8xcGSbf+xsH8wHL6x6qWhLphqySl9nIKsI1V5TTHWiRLRk8g2RsjebYv
 FWJbmcL2pbyzp2gwM5p5wurbZhTany04knpk5+YFf1hBHuMCUd5VjpmaAg+c5CWJ121u
 25W0pc8EyMgIaz03O8iSANmjXSGmbLjZ9NlJfG212x8sXKTO43OK3FoFUehrDk0ZaeoT
 F6HMjYJAUt+GaQKOVjiKKMsL8ZIwkSgNllR/mK+Aeeh0T/KlB5eYPLMrASAIjEFUdTFp EQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3838byr0mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 06:31:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13NANK7x008988;
        Fri, 23 Apr 2021 10:31:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37yqa8kav3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 10:31:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13NAVW1G30736752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 10:31:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE11AE058;
        Fri, 23 Apr 2021 10:31:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B94FAE045;
        Fri, 23 Apr 2021 10:31:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 23 Apr 2021 10:31:29 +0000 (GMT)
Date:   Fri, 23 Apr 2021 16:01:29 +0530
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
Message-ID: <20210423103129.GH2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210423082532.GA4239@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bp1T6XrCWT9vomRTwqnPhX3WNZkJwVdq
X-Proofpoint-ORIG-GUID: Bp1T6XrCWT9vomRTwqnPhX3WNZkJwVdq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_03:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=939 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2021-04-23 09:25:32]:

> On Thu, Apr 22, 2021 at 03:53:16PM +0530, Srikar Dronamraju wrote:
> > Recently we found that some of the benchmark numbers on Power10 were lesser
> > than expected. Some analysis showed that the problem lies in the fact that
> > L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.
> > 
> 
> I didn't get the chance to review this properly although I am suspicious
> of tracking idle_core and updating that more frequently. It becomes a very
> hot cache line that bounces. I did experiement with tracking an idle core
> but the data either went stale too quickly or the updates incurred more
> overhead than a reduced search saved.

Thanks a lot for trying this.

> The series also oopses a *lot* and didn't get through a run of basic
> workloads on x86 on any of three machines. An example oops is
> 

Can you pass me your failing config. I am somehow not been seeing this
either on x86 or on Powerpc on multiple systems.
Also if possible cat /proc/schedstat and cat
/proc/sys/kernel/sched_domain/cpu0/domain*/name

> [  137.770968] BUG: unable to handle page fault for address: 000000000001a5c8
> [  137.777836] #PF: supervisor read access in kernel mode
> [  137.782965] #PF: error_code(0x0000) - not-present page
> [  137.788097] PGD 8000004098a42067 P4D 8000004098a42067 PUD 4092e36067 PMD 40883ac067 PTE 0
> [  137.796261] Oops: 0000 [#1] SMP PTI
> [  137.799747] CPU: 0 PID: 14913 Comm: GC Slave Tainted: G            E     5.12.0-rc8-llcfallback-v1r1 #1
> [  137.809123] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
> [  137.816765] RIP: 0010:cpus_share_cache+0x22/0x30
> [  137.821396] Code: fc ff 0f 0b eb 80 66 90 0f 1f 44 00 00 48 63 ff 48 63 f6 48 c7 c0 c8 a5 01 00 48 8b 0c fd 00 59 9d 9a 48 8b 14 f5 00 59 9d 9a <8b> 14 02 39 14 01 0f 94 c0 c3 0f 1f 40 00 0f 1f 44 00 00 41 57 41

IP says cpus_share_cache, and it takes 2 ints,
RAX is 000000000001a5c8 but the panic says
"unable to handle page fault for address: 000000000001a5c8"
so it must have failed for "per_cpu(sd_llc_id, xx_cpu)"

> [  137.840133] RSP: 0018:ffff9e0aa26a7c60 EFLAGS: 00010086
> [  137.845360] RAX: 000000000001a5c8 RBX: ffff8bfbc65cf280 RCX: ffff8c3abf440000
> [  137.852483] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000015
> [  137.859605] RBP: ffff8bbc478b9fe0 R08: 0000000000000000 R09: 000000000001a5b8
> [  137.866730] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8bbc47c88a00
> [  137.873855] R13: 0000000000000015 R14: 0000000000000001 R15: ffff8bfde0199fc0
> [  137.880978] FS:  00007fa33c173700(0000) GS:ffff8bfabf400000(0000) knlGS:0000000000000000
> [  137.889055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  137.894794] CR2: 000000000001a5c8 CR3: 0000004096b22006 CR4: 00000000003706f0
> [  137.901918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  137.909041] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

-- 
Thanks and Regards
Srikar Dronamraju
