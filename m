Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE736D7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhD1Mu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:50:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239585AbhD1Mut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:50:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SCXH8k157896;
        Wed, 28 Apr 2021 08:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=IDjg4GaukE4TS0CR+66TfofNd5gjbr0y7g4QfU5cIn4=;
 b=Tsra2k9C8Z8NyR22sHpVOsLYQ7/xF1Rh7UNTWFHpWPZkMFYZ4efipoKhjLjxp8RC9ivD
 nZ3TtsVowhG2fvTgwll/W/xBvTo/zXyI+16W3jVfA3kEKJnOeuO1WpQzjTATKLkikrEx
 xa8vwEaxIaVgYNec/rHULY/vBLDUK9Nxz1vFNzJOe8sKqDwyPyqxEEV7GkGZjtV8mpGE
 RWek/x0OKE1LDsXLg8/9FFZQH7C1Br2QtURffJQQ7s5uMzcS8ETosHhIpM/Xfw+YFY0D
 qu2SYAmrhxuLYHBcdj0Ju31yIc1YfjWefIjOiGGU2VxaUI+8c9QmLCIfwsKeOqgUcEtQ pQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3877hds1dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 08:49:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SCSR7d000326;
        Wed, 28 Apr 2021 12:49:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh9vxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 12:49:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SCnT4X33030630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 12:49:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 123554203F;
        Wed, 28 Apr 2021 12:49:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6EE942041;
        Wed, 28 Apr 2021 12:49:26 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 28 Apr 2021 12:49:26 +0000 (GMT)
Date:   Wed, 28 Apr 2021 18:19:25 +0530
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
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH 00/10] sched/fair: wake_affine improvements
Message-ID: <20210428124925.GM2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtAuFpr05-ZBNjB9OiNNQnmgPSX3S4=Sz-A8sOnFAkr7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtAuFpr05-ZBNjB9OiNNQnmgPSX3S4=Sz-A8sOnFAkr7Tg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A-U07s19itrnCdzBqc1gUKaVyDEl01Zt
X-Proofpoint-ORIG-GUID: A-U07s19itrnCdzBqc1gUKaVyDEl01Zt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_06:2021-04-27,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=545 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2021-04-27 16:52:30]:

> Hi Srikar,

Hi Vincent, 

> On Thu, 22 Apr 2021 at 12:23, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > Recently we found that some of the benchmark numbers on Power10 were lesser
> > than expected. Some analysis showed that the problem lies in the fact that
> > L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.
> >
> >
> > Summary:
> > mc-llc outperforms, this patchset and upstream almost give similar performance.
> 
> So mc-llc patch seems to be the best approach IMHO. Although the
> hemisphere don't share cache, they share enough resources so
> cache-snooping is as efficient as sharing cache
> 

Yes, mc-llc helps just specific systems like Power10 but its shows better
numbers than my posted patchset.

However in this patchset, we are looking at areas in wakeup (aka idler llcs)
we could optimize which can help other archs too. + the fallback mechanism
is generic enough that we could use it for other Systems too.

I know that there are valid concerns raised by Mel and I working to resolve
them. Some of them are.
- How hot is idle-core
- Crashes when running tbench (I was able to reproduce with kernbench on x86)

Also I am adding some more changes with which we are getting similar
performance as mc-llc.

> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > Cc: Parth Shah <parth@linux.ibm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Rik van Riel <riel@surriel.com>
> >
> > Srikar Dronamraju (10):
> >   sched/fair: Update affine statistics when needed
> >   sched/fair: Maintain the identity of idle-core
> >   sched/fair: Update idle-core more often
> >   sched/fair: Prefer idle CPU to cache affinity
> >   sched/fair: Call wake_affine only if necessary
> >   sched/idle: Move busy_cpu accounting to idle callback
> >   sched/fair: Remove ifdefs in waker_affine_idler_llc
> >   sched/fair: Dont iterate if no idle CPUs
> >   sched/topology: Introduce fallback LLC
> >   powerpc/smp: Add fallback flag to powerpc MC domain
> >
> >  arch/powerpc/kernel/smp.c      |   7 +-
> >  include/linux/sched/sd_flags.h |   7 +
> >  include/linux/sched/topology.h |   3 +-
> >  kernel/sched/fair.c            | 229 +++++++++++++++++++++++++++------
> >  kernel/sched/features.h        |   1 +
> >  kernel/sched/idle.c            |  33 ++++-
> >  kernel/sched/sched.h           |   6 +
> >  kernel/sched/topology.c        |  54 +++++++-
> >  8 files changed, 296 insertions(+), 44 deletions(-)
> >
> > --
> > 2.18.2
> >

-- 
Thanks and Regards
Srikar Dronamraju
