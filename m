Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8973291CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhCAUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:33:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236780AbhCARHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:07:35 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121H5S4e086163;
        Mon, 1 Mar 2021 12:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Wdm3eMJllX+CAw+oYxrLR2rUHAOl7IFKsKKtF3ISOsg=;
 b=G4fQngY3IqOaaDZClfqJnCK395q5eKyAT2xM8teHmwlr7iG0N3fLp+74QS6nK59OrC+H
 0Dmnkcv1+RA5m5+ftnulc5AqH7Ue/47a526ig1ZwugdDcSn2ZntvHrXyKtrsfAJ3ptRA
 1naC6upYduOhxzsV6RsilnmsoNn3tIHWrg4BsIRQShOLpkD9JEIu2V5Rwpfn2ZsPheKR
 qK5BYjQHSzl3Uz/KT/r8ysQB2L1d91SYbBQDt3ez0AtdTMG2iki94kf48mG+8tqZCpux
 KHZK+6UJjhXCoti5fQUj6fzHxr7vr63jbMsRq1AylPBtf6tE+Ocmz5YSbWjQJJoGaQTs +A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 370xxaa8a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 12:06:14 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121Gwkac021656;
        Mon, 1 Mar 2021 17:06:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 370c59s4dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 17:06:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121H64jU19202444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 17:06:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1F17A405F;
        Mon,  1 Mar 2021 17:06:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41BBCA405B;
        Mon,  1 Mar 2021 17:06:02 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  1 Mar 2021 17:06:02 +0000 (GMT)
Date:   Mon, 1 Mar 2021 22:36:01 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <20210301170601.GJ2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
 <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_11:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=981 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2021-03-01 16:44:42]:

> On Sat, Feb 27, 2021 at 02:56:07PM -0500, Rik van Riel wrote:
> > On Fri, 2021-02-26 at 22:10 +0530, Srikar Dronamraju wrote:
> 
> > > +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > > +		return this_cpu;
> > 
> > I wonder if we need to use a slightly lower threshold on
> > very large LLCs, both to account for the fact that the
> > select_idle_cpu code may not find the single idle CPU
> > among a dozen busy ones, or because on a system with
> > hyperthreading we may often be better off picking another
> > LLC for HT contention issues?
> > 
> > Maybe we could use "tnr_busy * 4 <
> > tllc_size * 3" or
> > something like that?
> 
> How about:
> 
> 	tnr_busy < tllc_size / topology_max_smt_threads()
> 
> ?

Isn't topology_max_smt_threads only for x86 as of today?
Or Am I missing out?


-- 
Thanks and Regards
Srikar Dronamraju
