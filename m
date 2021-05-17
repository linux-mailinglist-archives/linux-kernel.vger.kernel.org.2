Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815C9382CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhEQM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:59:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234141AbhEQM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:59:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HCj5Sq066330;
        Mon, 17 May 2021 08:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=asxJpFhkqXmPyphsVqEp6/B0KkzL+c35FmJLjxLyLq4=;
 b=J6dTpEUo9EcK6nxllk3GwW5bdGr9h+QN0KglzQvqG9giI7LUMopus4z1hPQGysJF+nmP
 y2CsB8JqgGrYpZYH6RGlqqNX8VLI7bwlbdLxP5/YxNFs7yy4YVW6uDlNf08IxiROMca2
 aXWwm9UiklR2+6IxrImq+o6DHe1jIB6zoSyImwP2IISw4KbRZ6iLCsDeHDTS2Tf+GGbj
 0hSVebAyps43+IWHiRx31KVhjhdoiQWLy/EwX73TALRIlj/W+XbDNqo2eFaYot2K03d+
 TJacWatftf+qqDFwkudwtr7jkY+uaEldAJRoV2NYWZhbV4XyKRbp+jXWYfDqW4aP4JED /g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38krrtrb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 08:57:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HCpoKP031843;
        Mon, 17 May 2021 12:57:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38j5x7rtep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 12:57:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HCvUtK29622706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 12:57:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF9A5205A;
        Mon, 17 May 2021 12:57:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 952C65204E;
        Mon, 17 May 2021 12:57:28 +0000 (GMT)
Date:   Mon, 17 May 2021 18:27:27 +0530
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
Message-ID: <20210517125727.GX2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XG-woPjBhLR7gWM9XgtR-2Uuv-_5g3xc
X-Proofpoint-ORIG-GUID: XG-woPjBhLR7gWM9XgtR-2Uuv-_5g3xc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_05:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-17 20:48:46]:

> On 5/17/21 6:40 PM, Srikar Dronamraju wrote:
> > * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:
> > 
> >> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
> >>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
> >>>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
> > 
> > <snip>
> > 
> >>>> Also, for those frequent context-switching tasks with very short idle,
> >>>> it's expensive for scheduler to mark idle/busy every time, that's why
> >>>> my patch only marks idle every time and marks busy ratelimited in
> >>>> scheduler tick.
> >>>>
> >>>
> >>> I have tried few tasks with very short idle times and updating nr_busy
> >>> everytime, doesnt seem to be impacting. Infact, it seems to help in picking
> >>> the idler-llc more often.
> >>>
> >>
> >> How many CPUs in your LLC?
> > 
> > I have tried with X86, 48 CPUs, 2 nodes, each having 24 CPUs in LLC
> > +
> > POWER10, Multiple CPUs with 4 CPUs in LLC
> > +
> > POWER9, Multiple CPUs with 8 CPUs in LLC
> > 
> >>
> >> This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
> >> domain.
> >>
> > 
> > Okay,
> > 
> >> It looks like for netperf both TCP and UDP cases have the notable change
> >> under 2 x overcommit, it may be not interesting though.
> >>
> >>
> > 
> > I believe the extra load on this 24 core LLC could be because we may end up
> > trying to set the idle-core, even when there is no idle core available.
> > 
> > If possible, can you please give a try with v3 with the call to
> > set_next_idle_core commented out?
> > 
> > 
> 
> v3 seems not be applicable on tip/sched/core 915a2bc3c6b7?

I had applied on top of 2ea46c6fc9452ac100ad907b051d797225847e33
which was tag: sched-core-2021-04-28

The only conflict you get on today's tip is Gautham's one line patch.
Gautham's patch replaced 'this' with 'target'.

The 2nd patch does away with that line

-- 
Thanks and Regards
Srikar Dronamraju
