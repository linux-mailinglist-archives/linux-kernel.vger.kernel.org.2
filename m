Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74C37AC81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhEKQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:57:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhEKQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:57:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BGkPVu145439;
        Tue, 11 May 2021 12:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=QczvyUxovq0nnjKxWPpABlzPN2pcnKz91kSpxLMHe2g=;
 b=cWa5b7f2e3C9X8R3XKZ7Pyd/OVfKIu02F1N69+o6ZP3TeBBut1bQ9aqWsyTPHis3KEfV
 rfy0nwhoygaC8pKKKSJoiMmCYPmWopXPaHVS3iETb9u8xutJUw4dtXb4ZkSt7am4eZUH
 lyHs8pzJ/bXthivK1fWPefR49pkSU4NsDM08MivGTxrQHe3EQBk5TqISfOgKm8yXk2n2
 iV9G3xlNt3na/R1NM72vUotdcIU/N6hlM/f1gyrqRth+A4yIQgEpf+lzFIIyJIAKg1l3
 DX9f6Mfow1A8zQ93LrHhA6tuNfBA5rGcuAo7TCtqB+nLsyAd+rGX/tQiqHDRHD4Cx6hr +g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fwqyg673-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 12:55:47 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BGrFVC012847;
        Tue, 11 May 2021 16:55:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 38dj988yaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 16:55:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BGtgVI24183124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 16:55:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BEC6A4054;
        Tue, 11 May 2021 16:55:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14DFAA405B;
        Tue, 11 May 2021 16:55:40 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 11 May 2021 16:55:39 +0000 (GMT)
Date:   Tue, 11 May 2021 22:25:39 +0530
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
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
Message-ID: <20210511165539.GU2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <87tun91oaa.mognet@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tun91oaa.mognet@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sZTLpUEKv8sUNR82uLc9OeY2rsi15WQO
X-Proofpoint-ORIG-GUID: sZTLpUEKv8sUNR82uLc9OeY2rsi15WQO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Valentin Schneider <valentin.schneider@arm.com> [2021-05-11 12:51:41]:

> On 06/05/21 22:15, Srikar Dronamraju wrote:
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 8db40c8a6ad0..00e4669bb241 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
> >  #ifdef CONFIG_SCHED_SMT
> >  DEFINE_PER_CPU(int, smt_id);
> >  #endif
> > +DEFINE_PER_CPU(int, is_idle);
> 
> This + patch 8 immediately reminds me of Aubrey's patch:
> 
>   http://lore.kernel.org/r/1615872606-56087-1-git-send-email-aubrey.li@intel.com
> 
> last I looked it seemed OK, even the test bot seems happy. Aubrey, did you
> have any more work to do on that one (other than rebasing)?
> 

The above patch also is aimed at similar problems.

However I feel this patch has few differences.
- We use the nr_busy_cpus in this patchset in the wake_affine_idler_llc() to
  differentiate between 2 LLCs and choose a LLC that is lightly loaded.

- Except for the per-cpu is_idle, it gets it done with the existing
  infrastructure. (And we could move the is_idle in the rq struct too.)

- Mel had reservations on per-LLC idlecore, I would think the per-LLC idle
  mask would mean more updates and dirty. Everytime a CPU goes to idle,
  comes out of idle, the mask would be dirtied. Though the number of times
  this new per LLC CPU mask is read is probably going to be lesser than
  idle-cores with this patch series.

- In the said implementation, the idleness of a CPU is done at every check
  which may not be necessary if handled in the callbacks.

> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > @@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
> >  #ifdef CONFIG_SCHED_SMT
> >       per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> >  #endif
> > +	per_cpu(is_idle, cpu) = 1;
> >       rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> >
> >       sd = lowest_flag_domain(cpu, SD_NUMA);
> > --
> > 2.18.2

-- 
Thanks and Regards
Srikar Dronamraju
