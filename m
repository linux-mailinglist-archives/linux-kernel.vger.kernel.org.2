Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006063940D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhE1K0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:26:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235980AbhE1K0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:26:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SA4e2d102689;
        Fri, 28 May 2021 06:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Z6lcHy6aGWxJlPfk7tCin0oxhF5b1WPhGbBruXDVGrs=;
 b=RdA7S1OvpJDoUbCSpY6h1ujohLRdy+cBtqdz7fW3PHDP1TDgLIjAJYoM3922BcmmgtVH
 m8t1vsfm18UjSUEu4K1A+/HDPJBr+ylg8Y/8+6lPUiEgg0o+yI+9qSvP0JdvHsh+zjpY
 LwQ7up8VTk0e5NRG4psjd6fyPpUSHGrWBfjBrcNjCkxJPjBaQpwSHiW0qnoqoHX6dq/J
 IHpUDqIb6Hv6I7xBPpCcUJMytOAJHRQa05xgG9C3LAzMOw2Ox+1XE0/5+K4BOwfVMG/s
 HDTiOUIkUnkHRe7AWaMWl7bR4uCxQE4PCuVpbV7Jx1ce7FEED48+al0K5OXzhDd/MyFB aQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38txcurnt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:24:44 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14SADntJ015075;
        Fri, 28 May 2021 10:24:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 38s1ht0xmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 10:24:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14SAOc8p21430636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 10:24:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1445EA4055;
        Fri, 28 May 2021 10:24:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D314A404D;
        Fri, 28 May 2021 10:24:35 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 May 2021 10:24:35 +0000 (GMT)
Date:   Fri, 28 May 2021 15:54:34 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Subject: Re: [PATCH 1/3] sched/topology: Allow archs to populate distance map
Message-ID: <20210528102434.GO2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210520154427.1041031-1-srikar@linux.vnet.ibm.com>
 <20210520154427.1041031-2-srikar@linux.vnet.ibm.com>
 <YKaw33d71FpHjGnR@hirez.programming.kicks-ass.net>
 <20210521023802.GE2633526@linux.vnet.ibm.com>
 <YKdr0g6+eIHncqej@hirez.programming.kicks-ass.net>
 <20210521092830.GF2633526@linux.vnet.ibm.com>
 <87k0no6wuu.mognet@arm.com>
 <20210524161829.GL2633526@linux.vnet.ibm.com>
 <YLCtKziUgPTvPh1j@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YLCtKziUgPTvPh1j@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJYMMV5Bn8BoegNCOJpNlmJbCA_TZWXn
X-Proofpoint-ORIG-GUID: aJYMMV5Bn8BoegNCOJpNlmJbCA_TZWXn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 adultscore=0 malwarescore=0
 spamscore=2 mlxscore=2 lowpriorityscore=0 mlxlogscore=167 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2021-05-28 10:43:23]:

> On Mon, May 24, 2021 at 09:48:29PM +0530, Srikar Dronamraju wrote:
> > * Valentin Schneider <valentin.schneider@arm.com> [2021-05-24 15:16:09]:
> 
> > > I suppose one way to avoid the hook would be to write some "fake" distance
> > > values into your distance_lookup_table[] for offline nodes using your
> > > distance_ref_point_depth thing, i.e. ensure an iteration of
> > > node_distance(a, b) covers all distance values [1]. You can then keep patch
> > > 3 around, and that should roughly be it.
> > > 
> > 
> > Yes, this would suffice but to me its not very clean.
> > static int found[distance_ref_point_depth];
> > 
> > for_each_node(node){
> > 	int i, nd, distance = LOCAL_DISTANCE;
> > 		goto out;
> > 
> > 	nd = node_distance(node, first_online_node)
> > 	for (i=0; i < distance_ref_point_depth; i++, distance *= 2) {
> > 		if (node_online) {
> > 			if (distance != nd)
> > 				continue;
> > 			found[i] ++;
> > 			break;
> > 		}
> > 		if (found[i])
> > 			continue;
> > 		distance_lookup_table[node][i] = distance_lookup_table[first_online_node][i];
> > 		found[i] ++;
> > 		break;
> > 	}
> > }
> > 
> > But do note: We are setting a precedent for node distance between two nodes
> > to change.
> 
> Not really; or rather not more than already is the case AFAICT. Because
> currently your distance table will have *something* in it
> (LOCAL_DISTANCE afaict) for nodes that have never been online, which is
> what triggered the whole problem to begin with.
> 
> Only after the node has come online for the first time, will it contain
> the right value.
> 
> So both before and after this proposal the actual distance value changes
> after the first time a node goes online.
> 
> Yes that's unfortunate, but I don't see a problem with pre-filling it
> with something useful in order to avoid aditional arch hooks.
> 
> 

Okay,

Will post a v2 with prefilling.
Thanks for the update.

-- 
Thanks and Regards
Srikar Dronamraju
