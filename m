Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB55382A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhEQKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:42:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236273AbhEQKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:42:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HAX8xP037143;
        Mon, 17 May 2021 06:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=/JcNXxaNNQXkDmMMvv+0vqGPuYw4vUfYUaDzEcGiGG4=;
 b=KRW/pV84RZtUTYch51c1mUJqHA53CxCukgDejPeoEd89F45kMbrHuIrbWsAD5j06piB8
 DRoV8xBt0neH9yXRCYCJlNPA2oaiaStrD4Gp7IT+MnvmZNcOQBl5j6XQ2ckUCT46sp+E
 yVQESIaGuwR8oqFI0+PCKAx43L0pmY/hDyxcOYBz+6u84beXs0YxEVdnXAe20y+lKbGS
 I259P5qJLo/8kt1NnX+PAVfYXw9UgVDeF03OOj4wDabVaD2Ixng6P+K26G2e7ptHr5LS
 i5pAmxvOT1uL7eyyCqXkyh8pD6TzrgH6wxBnapLndAw+v5Swsf32EsgVqAjcjMUPrt2z /A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kggy1nmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 06:41:06 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HAbACf003580;
        Mon, 17 May 2021 10:41:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 38j5x80djs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 10:41:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HAf1RM43778366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 10:41:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC9E52050;
        Mon, 17 May 2021 10:41:01 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 81AC45204F;
        Mon, 17 May 2021 10:40:59 +0000 (GMT)
Date:   Mon, 17 May 2021 16:10:58 +0530
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
Message-ID: <20210517104058.GW2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O0-6_eg6dtOXw47bri9FdKYwda2jcKA9
X-Proofpoint-ORIG-GUID: O0-6_eg6dtOXw47bri9FdKYwda2jcKA9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_03:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:

> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
> > * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
> >> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:

<snip>

> >> Also, for those frequent context-switching tasks with very short idle,
> >> it's expensive for scheduler to mark idle/busy every time, that's why
> >> my patch only marks idle every time and marks busy ratelimited in
> >> scheduler tick.
> >>
> > 
> > I have tried few tasks with very short idle times and updating nr_busy
> > everytime, doesnt seem to be impacting. Infact, it seems to help in picking
> > the idler-llc more often.
> > 
> 
> How many CPUs in your LLC?

I have tried with X86, 48 CPUs, 2 nodes, each having 24 CPUs in LLC
+
POWER10, Multiple CPUs with 4 CPUs in LLC
+
POWER9, Multiple CPUs with 8 CPUs in LLC

> 
> This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
> domain.
> 

Okay,

> It looks like for netperf both TCP and UDP cases have the notable change
> under 2 x overcommit, it may be not interesting though.
> 
> 

I believe the extra load on this 24 core LLC could be because we may end up
trying to set the idle-core, even when there is no idle core available.

If possible, can you please give a try with v3 with the call to
set_next_idle_core commented out?


-- 
Thanks and Regards
Srikar Dronamraju
