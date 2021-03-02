Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8B32A434
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380071AbhCBK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:26:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34648 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382726AbhCBKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:06:34 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122A4xke114843;
        Tue, 2 Mar 2021 05:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=HqLHTHXwW8rBcNfn1K9a51+eOv+SrdOqAPiRIkPTBQY=;
 b=j8JUTUVK4LdRyQfGsY9FJkXZvZAG+eKDxN66ANGCdZbJxVlCaSdf5yUWwmM0FjhpHl9l
 +vk7uzYzq/X10rRCZ+mgyusjgpDUXU/QqNmimxx+iEpNC6NEPvbcME6S+3AaAgvMDfXR
 SIiEWyrLcN07H01asZMitAWad/rafqZusF95WZolCTqP6vyPNpGZNJafI6TuZHc2nAoY
 Dx8eWB66mOYSPQHlOqX4Q2sB/iLGRAjCfwW8BHgiAdQCXrvND0XGBPCAMq1XlofvXyAI
 4E4hJpfKE/psjoXD7OM5SXr7VFWL6EjjxGxHmlPQW89exFtD4z+/8x+Gnsiu5xlW34gr kg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371gvtnb68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 05:05:34 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122A3I6E025678;
        Tue, 2 Mar 2021 10:05:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 370c59srpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 10:05:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122A5UWH3015320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 10:05:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8239642047;
        Tue,  2 Mar 2021 10:05:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14BBA42049;
        Tue,  2 Mar 2021 10:05:28 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Mar 2021 10:05:27 +0000 (GMT)
Date:   Tue, 2 Mar 2021 15:35:27 +0530
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
Message-ID: <20210302100527.GN2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
 <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
 <20210301170601.GJ2028034@linux.vnet.ibm.com>
 <YD0h5I7qmDO2zlkE@hirez.programming.kicks-ass.net>
 <20210302073946.GL2028034@linux.vnet.ibm.com>
 <YD4BCDlxvn7ub+9U@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YD4BCDlxvn7ub+9U@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_03:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=894 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2021-03-02 10:10:32]:

> On Tue, Mar 02, 2021 at 01:09:46PM +0530, Srikar Dronamraju wrote:
> > > Oh, could be, I didn't grep :/ We could have core code keep track of the
> > > smt count I suppose.
> > 
> > Could we use cpumask_weight(cpu_smt_mask(this_cpu)) instead?
> 
> cpumask_weight() is potentially super expensive. With CPUMASK_OFFSTACK
> you get at least one more cache miss and then the bitmap might be really
> long.
> 
> Best to compute the results once and use it later.

Oh okay .. Noted.

-- 
Thanks and Regards
Srikar Dronamraju
