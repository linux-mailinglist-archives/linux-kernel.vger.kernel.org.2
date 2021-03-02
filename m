Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8F32A273
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446324AbhCBHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:53:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57264 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837224AbhCBHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:40:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1227YPRJ064896;
        Tue, 2 Mar 2021 02:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=lrZcISqZlyjQ40cCRjTE9prULVW+QHQqsjGSgVrqev8=;
 b=EBTsud59/1ScgrTVac0p870oZmh5kgSZp4oOGci9bSF3RkFsocVljwEQ2AnDCGlpX/MZ
 ecMWRg6xZwKZnaIX4NJHunnA3aqB/LacYiV8EalJZ+AC9GRGVkIkeMFzqGRmWY+c66r5
 uQVzOcDajJVPYEQz2Tn6WO6S9MbysiFzSRZ2O6BcBCPHuY3SOhD2eDlJso7o+hNelqH3
 uXVC24j1TdyVfIXhdqzNgZdprQ4Fsz3BNhgjjSHMCFG186rQg332NnqsxJlK/2TS+Ced
 uuwBNdlgw6ichtafoK/S7qXbQ/6jG3EEF3nKc04awXxHI8v9bQD55zJk2qUnQGZ4YmQH og== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371gvtgmgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 02:39:53 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1227XP27022917;
        Tue, 2 Mar 2021 07:39:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 36yj53192p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 07:39:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1227dZdP37617966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 07:39:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 862794203F;
        Tue,  2 Mar 2021 07:39:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3650A42049;
        Tue,  2 Mar 2021 07:39:47 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Mar 2021 07:39:47 +0000 (GMT)
Date:   Tue, 2 Mar 2021 13:09:46 +0530
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
Message-ID: <20210302073946.GL2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
 <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
 <20210301170601.GJ2028034@linux.vnet.ibm.com>
 <YD0h5I7qmDO2zlkE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YD0h5I7qmDO2zlkE@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_02:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=961 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2021-03-01 18:18:28]:

> On Mon, Mar 01, 2021 at 10:36:01PM +0530, Srikar Dronamraju wrote:
> > * Peter Zijlstra <peterz@infradead.org> [2021-03-01 16:44:42]:
> > 
> > > On Sat, Feb 27, 2021 at 02:56:07PM -0500, Rik van Riel wrote:
> > > > On Fri, 2021-02-26 at 22:10 +0530, Srikar Dronamraju wrote:
> > > 
 > > > 
> > > > Maybe we could use "tnr_busy * 4 <
> > > > tllc_size * 3" or
> > > > something like that?
> > > 
> > > How about:
> > > 
> > > 	tnr_busy < tllc_size / topology_max_smt_threads()
> > > 
> > > ?
> > 
> > Isn't topology_max_smt_threads only for x86 as of today?
> > Or Am I missing out?
> 
> Oh, could be, I didn't grep :/ We could have core code keep track of the
> smt count I suppose.

Could we use cpumask_weight(cpu_smt_mask(this_cpu)) instead?

-- 
Thanks and Regards
Srikar Dronamraju
