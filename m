Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7275336B1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhDZKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:41:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbhDZKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:40:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QAXB4n032175;
        Mon, 26 Apr 2021 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=YV33U4MsIKsMOWjMTEzE+UkygN9rxeIPamVaxi8unD0=;
 b=KmnR2IQ7nBgcEKc+NQP4ZfPVNJC87CuXytLO9SWweSQIyEas/Cn3ehuLFWo5ufhSN5S0
 xWpUpY8miACJDxscdqMTH1TOMV5id9rVubQa+o/BqT4QmywAWdXTKj3re2U+Ex0nJuED
 8pRJc4twPSaAOyt95ATAz2OPStBulaDJJ0+q3nZx5MFckoDP906EAWb33jdPjAu3e76s
 iFWI+KhZ5+iVgsjgN3CcnQR6cwhqUvggDNnsiVykuS+UzHunePZYOymAKTS3etuadBNK
 3Ri4r+UwyA4MSHMCeoX6WGabNnv3wTWq+Vobf3sJFO5ctknwxK2hA5nTSkNyAVfPixpw dw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385q8aqw8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 06:39:48 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QAd6O5015852;
        Mon, 26 Apr 2021 10:39:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh8r49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:39:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QAdh0Z11469284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 10:39:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE7C4C04E;
        Mon, 26 Apr 2021 10:39:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E864C062;
        Mon, 26 Apr 2021 10:39:40 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 26 Apr 2021 10:39:40 +0000 (GMT)
Date:   Mon, 26 Apr 2021 16:09:40 +0530
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
Message-ID: <20210426103940.GJ2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210423082532.GA4239@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LRMwzKHVvMJq8A6potO_V-ftjgUOr3MQ
X-Proofpoint-ORIG-GUID: LRMwzKHVvMJq8A6potO_V-ftjgUOr3MQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_03:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260077
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
> 

This change does increase the number of times we read the idle-core.  There
are also more places where we try to update the idle-core. However I feel
the number of times, we actually update the idle-core now will be much
lesser than previous, because we are mostly doing a conditional update. i.e
we are updating the idle-core only if the waking up CPU happens to be part
of our core.

Also if the system is mostly lightly loaded, we check for
available_idle_cpu, so we may not look for an idle-core. If the system is
running a CPU intensive task, then the idle-core will most likely to be -1.
Its only the cases where the system utilization keeps swinging between
lightly loaded to heavy load, that we would end up checking and setting
idle-core.

Do let me know your thoughts.

-- 
Thanks and Regards
Srikar Dronamraju
