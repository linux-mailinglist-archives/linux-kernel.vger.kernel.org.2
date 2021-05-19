Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE373894AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhESRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:36:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhESRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:36:22 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JHYDup107656;
        Wed, 19 May 2021 13:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=PKv7RKLlUzBIixbMZKM5e9HCA0ivzChTFiCUSw8ca9w=;
 b=rVrrf8urS+n5ZyN83dsbYwMM27Wt0X9jp4Bmj7OjOBbOmq6TfyFtg4FAZLc0lU3/NY0a
 0Ew8JJ+GVDG5g0p9IJi5G0qLjZ/cyiMo5r+y31p4b2d847jpLSiCH+EbUj2+ogXhHOqj
 IYmLUqUmTgcx4NQuKQBsYEtKm+YmXZTJy4IS8vtSShm3Gj+soAb6KgfqspxxghHjolf4
 QpaEhFmbglz20la7qlmXTDxit2OTQkLtZuu5m82kVkzyuQMuL4+UgViLen9jIrfRTykX
 Rke/+7GsVOMP4yGkCpBVWorfbpdE7FZR6tcOJlX7g9T9QyMRtOi1dhW02P5k3z3RvDzy 3Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n71q073x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:34:38 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JHSvQK008201;
        Wed, 19 May 2021 17:34:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 38m1gv0m0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 17:34:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JHYXu111665802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 17:34:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B81E42041;
        Wed, 19 May 2021 17:34:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 663A74204B;
        Wed, 19 May 2021 17:34:31 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 19 May 2021 17:34:31 +0000 (GMT)
Date:   Wed, 19 May 2021 23:04:30 +0530
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
Message-ID: <20210519173430.GB2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
 <20210517125727.GX2633526@linux.vnet.ibm.com>
 <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
 <20210518040024.GY2633526@linux.vnet.ibm.com>
 <ce4eba7e-dc2e-1c67-d04d-579f04c2040b@linux.intel.com>
 <20210518071843.GZ2633526@linux.vnet.ibm.com>
 <32b98350-35e4-7475-2d19-9101f50ecc63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <32b98350-35e4-7475-2d19-9101f50ecc63@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fms2HdjF0VzqeuR56lQZFd9hvg-5-_bQ
X-Proofpoint-ORIG-GUID: fms2HdjF0VzqeuR56lQZFd9hvg-5-_bQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_09:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-19 17:43:55]:

> On 5/18/21 3:18 PM, Srikar Dronamraju wrote:
> 
> >>>> This is v3. It looks like hackbench gets better. And netperf still has
> >>>> some notable changes under 2 x overcommit cases.
> >>>>
> >>>
> >>> Thanks Aubrey for the results. netperf (2X) case does seem to regress.
> >>> I was actually expecting the results to get better with overcommit.
> >>> Can you confirm if this was just v3 or with v3 + set_next_idle_core
> >>> disabled?
> >>
> >> Do you mean set_idle_cores(not set_next_idle_core) actually? Gautham's patch
> >> changed "this" to "target" in set_idle_cores, and I removed it to apply
> >> v3-2-8-sched-fair-Maintain-the-identity-of-idle-core.patch for tip/sched/core
> >> commit-id 915a2bc3c6b7.
> > 
> > Thats correct,
> > 
> > In the 3rd patch, I had introduced set_next_idle_core
> > which is suppose to set idle_cores in the LLC.
> > What I suspected was is this one is causing issues in your 48 CPU LLC.
> > 
> > I am expecting set_next_idle_core to be spending much time in your scenario.
> > I was planning for something like the below on top of my patch.
> > With this we dont look for an idle-core if we already know that we dont find one.
> > But in the mean while I had asked if you could have dropped the call to
> > set_next_idle_core.
> > 
> 
> +	if (atomic_read(&sd->shared->nr_busy_cpus) * 2 >=  per_cpu(sd_llc_size, target))
> +		goto out;
> 
> Does this has side effect if waker and wakee are coalesced on a portion of cores?
> Also, is 2 a SMT2 assumption?

The above line was just a hack to see if things change by not spending time
searching for an idle-core. Since you were running on Intel, I had
hard-coded it to 2.

> 
> I did a quick testing on this, it looks like the regression of netperf 2x cases are 
> improved indeed, but hackbench two mid-load cases get worse.
> 

In the mid-loaded, case, there was a chance of idle-core being around, Since
we dont set it to an idle-core or -2, i.e idle-core is set to -1, it may or
may not get selected.

> process-sockets 	group-2 	 1.00 (  5.32)	-18.40 (  7.32)
> threads-sockets 	group-2 	 1.00 (  5.44)	-20.44 (  4.60)
> 
> Thanks,
> -Aubrey

-- 
Thanks and Regards
Srikar Dronamraju
