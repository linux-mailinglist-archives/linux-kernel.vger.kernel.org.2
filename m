Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1190735EE22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbhDNHD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:03:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230110AbhDNHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:03:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13E6Xe0i152974;
        Wed, 14 Apr 2021 03:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : content-transfer-encoding : in-reply-to; s=pp1;
 bh=lOAYMTqZOaWepT1ztfk6b0cSHg3F1kq8ncstlfH7bLM=;
 b=bvSZf6/jsxUUHsPBNBJLIKTy5AV5CdZZ/YvITBUTvpE6ja41y+zBplEU0L3oPLbEaqS7
 S6oR+NivgEbFRM3UiwoKEg3/bKa+Di9JoM44T2Y3SsmbdT5ELKgo7hosTay6L2DInQ2t
 8iPPZ64huBe0FpI10dfo/qVUOKqs2U7bIjc90FhfXdJGTmC3/bXVbBswuPlMSauqAdx0
 xvCm4XxXmKQLk5wSl2gSasij/XXnGSKf5+1uMmSFl2tp75LRvxpLquDgxE1voqVGcQRK
 y5uUmMSI9rHNWiTd9LKqwKNnnmkmWHktSviJNovMDfQUphWsqpQRJKqGkgmuZ44gr5DM Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnty2sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 03:02:54 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13E6XrvV153632;
        Wed, 14 Apr 2021 03:02:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnty2s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 03:02:54 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13E6q3um018025;
        Wed, 14 Apr 2021 07:02:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 37u3n9y43q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 07:02:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13E72r7N28115218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:02:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E173124053;
        Wed, 14 Apr 2021 07:02:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F78B124054;
        Wed, 14 Apr 2021 07:02:52 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.87.221])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 07:02:52 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 732C92E2EE0; Wed, 14 Apr 2021 12:32:46 +0530 (IST)
Date:   Wed, 14 Apr 2021 12:32:46 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC
 sched-domain
Message-ID: <20210414070246.GB13782@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com>
 <20210412093722.GS3697@techsingularity.net>
 <CAKfTPtDX-p=gWAVgYzLNCNuQ2e=QP2pTeMs=BmNBo31fpGKxrg@mail.gmail.com>
 <20210412152444.GA3697@techsingularity.net>
 <20210412163355.GV6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412163355.GV6564@kitsune.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JGAET03H7GIXuuX67sgZJA16jILsxxWY
X-Proofpoint-ORIG-GUID: Z4Fb-MJOhIstzqhzxxDVSt1_SREfEIZg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_03:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 06:33:55PM +0200, Michal Suchánek wrote:
> On Mon, Apr 12, 2021 at 04:24:44PM +0100, Mel Gorman wrote:
> > On Mon, Apr 12, 2021 at 02:21:47PM +0200, Vincent Guittot wrote:
> > > > > Peter, Valentin, Vincent, Mel, etal
> > > > >
> > > > > On architectures where we have multiple levels of cache access latencies
> > > > > within a DIE, (For example: one within the current LLC or SMT core and the
> > > > > other at MC or Hemisphere, and finally across hemispheres), do you have any
> > > > > suggestions on how we could handle the same in the core scheduler?
> > >
> > > I would say that SD_SHARE_PKG_RESOURCES is there for that and doesn't
> > > only rely on cache
> > >
> >
> > From topology.c
> >
> > 	SD_SHARE_PKG_RESOURCES - describes shared caches
> >
> > I'm guessing here because I am not familiar with power10 but the central
> > problem appears to be when to prefer selecting a CPU sharing L2 or L3
> > cache and the core assumes the last-level-cache is the only relevant one.
> 
> It does not seem to be the case according to original description:
> 
> >>>> When the scheduler tries to wakeup a task, it chooses between the
> >>>> waker-CPU and the wakee's previous-CPU. Suppose this choice is called
> >>>> the "target", then in the target's LLC domain, the scheduler
> >>>> 
> >>>> a) tries to find an idle core in the LLC. This helps exploit the
> This is the same as (b) Should this be SMT^^^ ?

On POWER10, without this patch, the LLC is at SMT sched-domain
domain. The difference between a) and b) is a) searches for an idle
core, while b) searches for an idle CPU. 


> >>>>    SMT folding that the wakee task can benefit from. If an idle
> >>>>    core is found, the wakee is woken up on it.
> >>>> 
> >>>> b) Failing to find an idle core, the scheduler tries to find an idle
> >>>>    CPU in the LLC. This helps minimise the wakeup latency for the
> >>>>    wakee since it gets to run on the CPU immediately.
> >>>> 
> >>>> c) Failing this, it will wake it up on target CPU.
> >>>> 
> >>>> Thus, with P9-sched topology, since the CACHE domain comprises of two
> >>>> SMT4 cores, there is a decent chance that we get an idle core, failing
> >>>> which there is a relatively higher probability of finding an idle CPU
> >>>> among the 8 threads in the domain.
> >>>> 
> >>>> However, in P10-sched topology, since the SMT domain is the LLC and it
> >>>> contains only a single SMT4 core, the probability that we find that
> >>>> core to be idle is less. Furthermore, since there are only 4 CPUs to
> >>>> search for an idle CPU, there is lower probability that we can get an
> >>>> idle CPU to wake up the task on.
> 
> >
> > For this patch, I wondered if setting SD_SHARE_PKG_RESOURCES would have
> > unintended consequences for load balancing because load within a die may
> > not be spread between SMT4 domains if SD_SHARE_PKG_RESOURCES was set at
> > the MC level.
> 
> Not spreading load between SMT4 domains within MC is exactly what setting LLC
> at MC level would address, wouldn't it?
>
> As in on P10 we have two relevant levels but the topology as is describes only
> one, and moving the LLC level lower gives two levels the scheduler looks at
> again. Or am I missing something?

This is my current understanding as well, since with this patch we
would then be able to move tasks quickly between the SMT4 cores,
perhaps at the expense of losing out on cache-affinity. Which is why
it would be good to verify this using a test/benchmark.


> 
> Thanks
> 
> Michal
> 

--
Thanks and Regards
gautham.
