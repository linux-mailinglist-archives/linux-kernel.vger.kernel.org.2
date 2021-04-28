Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4074D36D7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhD1M7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239609AbhD1M7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:59:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SCXxGb031943;
        Wed, 28 Apr 2021 08:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=J2I+hwCHjV9umsEzi9Rs7cVpTyGdijx4/DSsl0GA6Fc=;
 b=EvQMpUCVW8kNqYuP8qPgF10Zsr+FZdCfBh0EOPt/QuxJa6/ONvls4KftUNvzt6iSz2Y/
 3T79WyDp9hUWNnncs18oYaOhWdGlj5RRGHhz6FfOQdf5nQCyYEs/3amtcTV+dWbA/rB2
 boe9l55S28iXSbv3yMo7VKlaBOYfnSjd3X3pPmSR0T2FUSzOCIyDtzcNf0f/BPm4N6zo
 579Ju+oGatabPYVvV98nnVaQbVEXqDqz8YOmT4ttuv9bZj53SMzSOH/McR0Tg7Jktspn
 fRJ+sHr8goPrmV++BLu4e+YgcQnis/r0HFmnKbz0jvZnYkRWYj71yiiFKBp9yYs8HoUV LQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3876re2r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 08:57:41 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SCvC7N018771;
        Wed, 28 Apr 2021 12:57:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 384ay892ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 12:57:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SCvBha35193284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 12:57:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30F674203F;
        Wed, 28 Apr 2021 12:57:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C407042049;
        Wed, 28 Apr 2021 12:57:33 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 28 Apr 2021 12:57:33 +0000 (GMT)
Date:   Wed, 28 Apr 2021 18:27:33 +0530
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
Message-ID: <20210428125733.GN2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
 <20210426103940.GJ2633526@linux.vnet.ibm.com>
 <20210426114112.GE4239@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210426114112.GE4239@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bBHjnYjVa7b9UV76u5ngm2BoE--UHm9O
X-Proofpoint-GUID: bBHjnYjVa7b9UV76u5ngm2BoE--UHm9O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_05:2021-04-27,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2021-04-26 12:41:12]:

> On Mon, Apr 26, 2021 at 04:09:40PM +0530, Srikar Dronamraju wrote:
> > * Mel Gorman <mgorman@techsingularity.net> [2021-04-23 09:25:32]:

<snip>

> > 
> > This change does increase the number of times we read the idle-core.  There
> > are also more places where we try to update the idle-core. However I feel
> > the number of times, we actually update the idle-core now will be much
> > lesser than previous, because we are mostly doing a conditional update. i.e
> > we are updating the idle-core only if the waking up CPU happens to be part
> > of our core.
> > 
> 
> Increased cache misses may be detectable from perf.

I will get some cache miss numbers pre and post the patchset.
Since we may be altering the selection of CPUs esp on Systems that have a
small LLCs, I was thinking the cache misses could be different between pre
and post patchset.

> 
> > Also if the system is mostly lightly loaded, we check for
> > available_idle_cpu, so we may not look for an idle-core. If the system is
> > running a CPU intensive task, then the idle-core will most likely to be -1.
> > Its only the cases where the system utilization keeps swinging between
> > lightly loaded to heavy load, that we would end up checking and setting
> > idle-core.
> > 
> 
> But this is a "how long is a piece of string" question because the benefit
> of tracking an idle core depends on both the interarrival time of wakeups,
> the domain utilisation and the length of time tasks are running. When
> I was looking at the area, I tracked the SIS efficiency to see how much
> each change was helping. The patch no longer applies but the stats are
> understood by mmtests if you wanted to forward port it.  It's possible
> you would do something similar but specific to idle_core -- e.g. track
> how often it's updated, how often it's read, how often a CPU is returned
> and how often it's still an idle core and use those stats to calculate
> hit/miss ratios.
> 
> However, I would caution against conflating the "fallback search domain"
> with the patches tracking idle core because they should be independent
> of each other.
> 
> Old patch that no longer applies that was the basis for some SIS work
> over a year ago is below
> 

Thanks Mel for sharing this, I will build a prototype patch similar to this
and see what inputs it will come up with.

> ---8<---
> From c791354b92a5723b0da14d050f942f61f0c12857 Mon Sep 17 00:00:00 2001
> From: Mel Gorman <mgorman@techsingularity.net>
> Date: Fri, 14 Feb 2020 19:11:16 +0000
> Subject: [PATCH] sched/fair: Track efficiency of select_idle_sibling
> 
<snip>

-- 
Thanks and Regards
Srikar Dronamraju
