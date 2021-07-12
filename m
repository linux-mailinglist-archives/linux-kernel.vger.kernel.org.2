Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD703C5C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhGLMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:52:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64432 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231420AbhGLMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:52:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCZAYZ086549;
        Mon, 12 Jul 2021 08:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=LJYI1bacdtGJL+1DHEEvi/ZzNJU//hClCL+ahCL3twY=;
 b=hjeuJdFlONaibCzfr4+ZMchWnqawJnEdKzrfU/m0xnGChAhbDzB5WXcar8ogPvZJE17p
 mSWUhXqt5+UFbv6XRZaNb8nukm7IOnyK7006qL93MgurO7o1+q+3gieLVkyRh0ODBQtU
 alxWFF7xnOj0nHRjV+w69c0AAvGAgvtLb1NbxrWSLk8cTefTLrbaGrYFam7osJmoD5X0
 PIufbmp/rrF1h60CIVOB/iyoyKIol5KYKhDaGdi9UOGRXqrrZnTEEQSPGjxUQrDzfd/R
 +bIAbBeB07vWeAaYFYsb3Khyh+HO9EXG7DwNDLjgkq1s169rsVaHiIZZCCgC6bYafBoO 9Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs48rmaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 08:49:05 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CChX0M023645;
        Mon, 12 Jul 2021 12:49:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 39q2th8dm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 12:49:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CCn0PI35717440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:49:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB369A4062;
        Mon, 12 Jul 2021 12:49:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AC30A4054;
        Mon, 12 Jul 2021 12:48:57 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 12 Jul 2021 12:48:57 +0000 (GMT)
Date:   Mon, 12 Jul 2021 18:18:56 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for
 non-online nodes
Message-ID: <20210712124856.GA3836887@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com>
 <20210701041552.112072-2-srikar@linux.vnet.ibm.com>
 <875yxu85wi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <875yxu85wi.mognet@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g3uLNbuXkP_eyoH59VlJi4Uwhkq9JcHx
X-Proofpoint-ORIG-GUID: g3uLNbuXkP_eyoH59VlJi4Uwhkq9JcHx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_07:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

> On 01/07/21 09:45, Srikar Dronamraju wrote:
> > @@ -1891,12 +1894,30 @@ void sched_init_numa(void)
> >  void sched_domains_numa_masks_set(unsigned int cpu)
> >  {
> 
> Hmph, so we're playing games with masks of offline nodes - is that really
> necessary? Your modification of sched_init_numa() still scans all of the
> nodes (regardless of their online status) to build the distance map, and
> that is never updated (sched_init_numa() is pretty much an __init
> function).
> 
> So AFAICT this is all to cope with topology_span_sane() not applying
> 'cpu_map' to its masks. That seemed fine to me back when I wrote it, but in
> light of having bogus distance values for offline nodes, not so much...
> 
> What about the below instead?
> 
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b77ad49dc14f..c2d9caad4aa6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2075,6 +2075,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  			      const struct cpumask *cpu_map, int cpu)
>  {
> +	struct cpumask *intersect = sched_domains_tmpmask;
>  	int i;
> 
>  	/* NUMA levels are allowed to overlap */
> @@ -2090,14 +2091,17 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  	for_each_cpu(i, cpu_map) {
>  		if (i == cpu)
>  			continue;
> +
>  		/*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * We shouldn't have to bother with cpu_map here, unfortunately
> +		 * some architectures (powerpc says hello) have to deal with
> +		 * offline NUMA nodes reporting bogus distance values. This can
> +		 * lead to funky NODE domain spans, but since those are offline
> +		 * we can mask them out.
>  		 */
> +		cpumask_and(intersect, tl->mask(cpu), tl->mask(i));
>  		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> +		    cpumask_intersects(intersect, cpu_map))
>  			return false;
>  	}
> 

Unfortunately this is not helping.
I tried this patch alone and also with 2/2 patch of this series where
we update/fill fake topology numbers. However both cases are still failing.

-- 
Thanks and Regards
Srikar Dronamraju
