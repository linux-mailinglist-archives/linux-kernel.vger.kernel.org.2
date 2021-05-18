Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6238706E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhERECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:02:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229448AbhERECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:02:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14I3hnAB019814;
        Tue, 18 May 2021 00:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Fos9fNoWaHwoZvG/NqC2E3FtJDQDWnrP7Ol1W/9GThM=;
 b=CwUdMi1vaVDN3/5zzg9nRyOsy94U9Y0dzXI/xom313X3uNdH8FPqA+OIPXep02RtZn+a
 BZ/Q8LfZOx0TXa0f9HrFnPGBAjopWoTeMO3qQct/63Z/Wl52iYPmRXqXmx7pNX/haxTm
 haU7NATp/oB7JkE/ZoQZqoNg5s8yX0izGoXfqoGU5v4cfCIBnVxK2qmSJ39GHNcKHxUk
 mMKOjOmb4vY5FohSTvCgL/9d2PQZwPgb1OegOKYFgx6jsifn4fhLSJuduVRZ1TdiL/Cj
 zIGYocJBCMy49tvbyZq93IpjuIN2bOU1oUqBNNJHkelV/1nAAe/UsPtjBlFE2QVQQ4KW Yw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38m5b4gy53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 00:00:31 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14I3xNN4002572;
        Tue, 18 May 2021 04:00:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 38m19sr1hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 04:00:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14I3xxqW30343592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 03:59:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1168AA406E;
        Tue, 18 May 2021 04:00:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D907BA4083;
        Tue, 18 May 2021 04:00:24 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 18 May 2021 04:00:24 +0000 (GMT)
Date:   Tue, 18 May 2021 09:30:24 +0530
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
Message-ID: <20210518040024.GY2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
 <20210517125727.GX2633526@linux.vnet.ibm.com>
 <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w1ThXOqvJvEerE4lJoTrpSfs1rkPF1c-
X-Proofpoint-ORIG-GUID: w1ThXOqvJvEerE4lJoTrpSfs1rkPF1c-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_02:2021-05-17,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-18 08:59:00]:

> On 5/17/21 8:57 PM, Srikar Dronamraju wrote:
> > * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-17 20:48:46]:
> > 
> >> On 5/17/21 6:40 PM, Srikar Dronamraju wrote:
> >>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:
> >>>
> >>>> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
> >>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
> >>>>>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
> >>>
> >>> <snip>
> >>>
> >>>>>> Also, for those frequent context-switching tasks with very short idle,
> >>>>>> it's expensive for scheduler to mark idle/busy every time, that's why
> >>>>>> my patch only marks idle every time and marks busy ratelimited in
> >>>>>> scheduler tick.
> >>>>>>
> >>>>>
> >>>>> I have tried few tasks with very short idle times and updating nr_busy
> >>>>> everytime, doesnt seem to be impacting. Infact, it seems to help in picking
> >>>>> the idler-llc more often.
> >>>>>
> >>>>
> >>>> How many CPUs in your LLC?
> >>>
> >>> I have tried with X86, 48 CPUs, 2 nodes, each having 24 CPUs in LLC
> >>> +
> >>> POWER10, Multiple CPUs with 4 CPUs in LLC
> >>> +
> >>> POWER9, Multiple CPUs with 8 CPUs in LLC
> >>>
> >>>>
> >>>> This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
> >>>> domain.
> >>>>
> >>>
> >>> Okay,
> >>>
> >>>> It looks like for netperf both TCP and UDP cases have the notable change
> >>>> under 2 x overcommit, it may be not interesting though.
> >>>>
> >>>>
> >>>
> >>> I believe the extra load on this 24 core LLC could be because we may end up
> >>> trying to set the idle-core, even when there is no idle core available.
> >>>
> >>> If possible, can you please give a try with v3 with the call to
> >>> set_next_idle_core commented out?
> >>>
> >>>
> >>
> >> v3 seems not be applicable on tip/sched/core 915a2bc3c6b7?
> > 
> > I had applied on top of 2ea46c6fc9452ac100ad907b051d797225847e33
> > which was tag: sched-core-2021-04-28
> > 
> > The only conflict you get on today's tip is Gautham's one line patch.
> > Gautham's patch replaced 'this' with 'target'.
> > 
> > The 2nd patch does away with that line
> > 
> 
> This is v3. It looks like hackbench gets better. And netperf still has
> some notable changes under 2 x overcommit cases.
> 

Thanks Aubrey for the results. netperf (2X) case does seem to regress.
I was actually expecting the results to get better with overcommit.
Can you confirm if this was just v3 or with v3 + set_next_idle_core
disabled?

> 
> hackbench (48 tasks per group)
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	group-1 	 1.00 (  4.51)	 +1.36 (  4.26)
> process-pipe    	group-2 	 1.00 ( 18.73)	 -9.66 ( 31.15)
> process-pipe    	group-3 	 1.00 ( 23.67)	 +8.52 ( 21.13)
> process-pipe    	group-4 	 1.00 ( 14.65)	+17.12 ( 25.23)
> process-pipe    	group-8 	 1.00 (  3.11)	+16.41 (  5.94)
> process-sockets 	group-1 	 1.00 (  8.83)	 +1.53 ( 11.93)
> process-sockets 	group-2 	 1.00 (  5.32)	-15.43 (  7.17)
> process-sockets 	group-3 	 1.00 (  4.79)	 -4.14 (  1.90)
> process-sockets 	group-4 	 1.00 (  2.39)	 +4.37 (  1.31)
> process-sockets 	group-8 	 1.00 (  0.38)	 +4.41 (  0.05)
> threads-pipe    	group-1 	 1.00 (  3.06)	 -1.57 (  3.71)
> threads-pipe    	group-2 	 1.00 ( 17.41)	 -2.16 ( 15.29)
> threads-pipe    	group-3 	 1.00 ( 17.94)	+19.86 ( 13.24)
> threads-pipe    	group-4 	 1.00 ( 15.38)	 +3.71 ( 11.97)
> threads-pipe    	group-8 	 1.00 (  2.72)	+13.40 (  8.43)
> threads-sockets 	group-1 	 1.00 (  8.51)	 -2.73 ( 17.48)
> threads-sockets 	group-2 	 1.00 (  5.44)	-12.04 (  5.91)
> threads-sockets 	group-3 	 1.00 (  4.38)	 -5.00 (  1.48)
> threads-sockets 	group-4 	 1.00 (  1.08)	 +4.46 (  1.15)
> threads-sockets 	group-8 	 1.00 (  0.61)	 +5.12 (  0.20)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	thread-48	 1.00 (  3.79)	 +4.69 (  4.03)
> TCP_RR          	thread-96	 1.00 (  4.98)	 -6.74 (  3.59)
> TCP_RR          	thread-144	 1.00 (  6.04)	 -2.36 (  3.57)
> TCP_RR          	thread-192	 1.00 (  4.97)	 -0.44 (  4.89)
> TCP_RR          	thread-384	 1.00 ( 19.87)	-19.12 ( 28.99)
> UDP_RR          	thread-48	 1.00 ( 12.54)	 -2.73 (  1.59)
> UDP_RR          	thread-96	 1.00 (  6.51)	 -6.66 ( 10.42)
> UDP_RR          	thread-144	 1.00 ( 45.41)	 -3.81 ( 31.37)
> UDP_RR          	thread-192	 1.00 ( 32.06)	 +3.07 ( 71.89)
> UDP_RR          	thread-384	 1.00 ( 29.57)	-21.52 ( 35.50)

-- 
Thanks and Regards
Srikar Dronamraju
