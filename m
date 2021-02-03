Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6232730D836
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhBCLLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:11:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhBCLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:11:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 113B6qwm066319;
        Wed, 3 Feb 2021 06:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=19Lhn8kGu/qNpBf9SF5zOAXBweaoRQzhquVmgZLibsg=;
 b=bViY4aWh4+wjRkSZNr/ShYcB891prrvu1n6aWq98OUDGhSo7dK5LPJcbnO9mFE7Ge2vv
 ITBDkPFJiL2HLgkChpMF8rDiAgJ65Yx1FBCsXavsy1ibK8vLIu62iYdYGgMGAqzfmFl6
 au/U3bkRlL9HM9EOW7PKTBnC0ovhcOiwrh2WxMZ1YvOJSf8IlURr/CSox/7BDcdBLw4d
 3LmIM3cqRzuAsMS9UUMLAGrINm172+NiwMEFc92z/0V+NZrHas3GY7GLkOJcizUOYaoT
 44RMjO/m1bq/E19+uBZWIaCtR/1ZmsCYglKEojrTuCIcUD1W3VCi+BljyDnEpu2mTCR0 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ftexrdc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:10:20 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 113BAKuL091968;
        Wed, 3 Feb 2021 06:10:20 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ftexrdb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:10:19 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 113B9HRM019765;
        Wed, 3 Feb 2021 11:10:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 36evvf1e8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 11:10:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 113BAFrg41681250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Feb 2021 11:10:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25DC74C050;
        Wed,  3 Feb 2021 11:10:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 618F04C04A;
        Wed,  3 Feb 2021 11:10:12 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.60.215])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Feb 2021 11:10:12 +0000 (GMT)
Date:   Wed, 3 Feb 2021 16:40:09 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210203111009.GB2869122@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
 <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
 <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
 <20210126230305.GD30941@willie-the-truck>
 <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
 <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_04:2021-02-03,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:04:01PM +0100, Vlastimil Babka wrote:
> On 1/27/21 10:10 AM, Christoph Lameter wrote:
> > On Tue, 26 Jan 2021, Will Deacon wrote:
> > 
> >> > Hm, but booting the secondaries is just a software (kernel) action? They are
> >> > already physically there, so it seems to me as if the cpu_present_mask is not
> >> > populated correctly on arm64, and it's just a mirror of cpu_online_mask?
> >>
> >> I think the present_mask retains CPUs if they are hotplugged off, whereas
> >> the online mask does not. We can't really do any better on arm64, as there's
> >> no way of telling that a CPU is present until we've seen it.
> > 
> > The order of each page in a kmem cache --and therefore also the number
> > of objects in a slab page-- can be different because that information is
> > stored in the page struct.
> > 
> > Therefore it is possible to retune the order while the cache is in operaton.
> 
> Yes, but it's tricky to do the retuning safely, e.g. if freelist randomization
> is enabled, see [1].
> 
> But as a quick fix for the regression, the heuristic idea could work reasonably
> on all architectures?
> - if num_present_cpus() is > 1, trust that it doesn't have the issue such as
> arm64, and use it
> - otherwise use nr_cpu_ids
> 
> Long-term we can attempt to do the retuning safe, or decide that number of cpus
> shouldn't determine the order...
> 
> [1] https://lore.kernel.org/linux-mm/d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz/

So what is preferrable here now? Above or other quick fix or reverting
the original commit?

Regards,
Bharata.
