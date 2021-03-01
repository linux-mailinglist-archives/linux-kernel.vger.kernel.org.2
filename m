Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82DE327FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhCANjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:39:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235814AbhCANi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:38:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121DXoNa152652;
        Mon, 1 Mar 2021 08:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Hp7lJ1n0zWGSbHrNoQ8FxBZVbyeKMOkZBpIQglBzsGc=;
 b=DYdCfCRjTwlc3pbMxiU30n/Odm5ETyLjKmhY/ZQWQuOh/JbYuCRbqwLHt96IBiQ/4gca
 I2vn1tqecN0FYYDwA5VAySTckT9GjRyRzC6WJvLiYEqFMk/91Lcj4kU+9cwjh4+ftxHE
 JafCvSUZjkmrR/PoEgvLsh5OOTlKfYEucywAoVBIvE8kE2KsCdW5cqr8mKfpPiPFWkt0
 +MiH6ehBn0N+K0ZVXeY44Xln8/sM3uKLgOx/iI4xDg75D4OTGViR5p/odV54jyUFWxG2
 +zTKjQDnCOPEiTyug3Day7Ifj9T0tmoNf37JLOz4H/FKOdPC7F85SQz4TA/6m4JG5tmV LA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710tk14ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:37:28 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121DXE8M004548;
        Mon, 1 Mar 2021 13:37:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 36yj530wdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:37:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121DbOYw33096190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 13:37:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29998AE053;
        Mon,  1 Mar 2021 13:37:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6AAAE057;
        Mon,  1 Mar 2021 13:37:21 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  1 Mar 2021 13:37:21 +0000 (GMT)
Date:   Mon, 1 Mar 2021 19:07:20 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210301133720.GI2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_08:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel <riel@surriel.com> [2021-02-27 14:56:07]:

> > In the current situation where waker and previous CPUs are busy, but
> > only one of its LLC has an idle CPU, Scheduler may end up picking a
> > LLC
> > with no idle CPUs. To mitigate this, add a new step between 1 and 2
> > where Scheduler compares idle CPUs in waker and previous LLCs and
> > picks
> > the appropriate one.
> 
> I like that idea a lot. That could also solve some of the

Thanks.

> issues sometimes observed on multi-node x86 systems, and
> probably on the newer AMD chips with several LLCs on chip.
> 

Okay.

> > +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > +		return this_cpu;
> 
> I wonder if we need to use a slightly lower threshold on
> very large LLCs, both to account for the fact that the
> select_idle_cpu code may not find the single idle CPU
> among a dozen busy ones, or because on a system with
> hyperthreading we may often be better off picking another
> LLC for HT contention issues?

> 
> Maybe we could use "tnr_busy * 4 <
> tllc_size * 3" or
> something like that?
> 
> That way we will only try to find the last 5 idle
> CPUs
> in a 22 CPU LLC if the other LLC also has fewer than 6
> idle cores.
> 
> That might increase our chances of finding an idle CPU
> with SIS_PROP enabled, and might allow WA_WAKER to be
> true by default.

Agree we need to be conservative esp if we want to make WA_WAKER on by
default. I would still like to hear from other people if they think its ok
to enable it by default. I wonder if enabling it by default can cause some
load imbalances leading to more active load balance down the line.  I
haven't benchmarked with WA_WAKER enabled.

Thanks Rik for your inputs.

-- 
Thanks and Regards
Srikar Dronamraju
