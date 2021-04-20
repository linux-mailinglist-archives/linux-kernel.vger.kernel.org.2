Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A036571E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhDTLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:07:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhDTLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:07:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KB4KWS027025;
        Tue, 20 Apr 2021 07:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FxXhJo4dvTVFdBPimLKmaGk7uwN9tVw3FqLs96pXkKc=;
 b=DJbehQNs6qWWzUpQYKbpKBrKrv8oFRRjdeUPjrp+IWQ4mv9n88hAkfrzr9DOSCATAS73
 8WcDHscf2yb8BMzUZJLDsd7KnKqCYpAUW01mpIlKs9PDWnXn1d4VqbAj1re6B6HD/K15
 mpNri+ZikjjqH9s1jfTJybhogSF+Z2Gw9zCLeQv/sGxDoIqJwHMHnxs0Y/3Tgiy0Rgwg
 wS3eYhYIBgfX0rvGRN/AkNlkry3jbRhHx8nWj9kfZCNV5qiPp7ThVX/CmwsotSJNfvwe
 qhZAiJ6Qq4lnYnlTftMPljhg1cixgW8dZpdaW9aAscicO2v2YH/TrmE+4XCinfchbjdd tg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381sy5ykm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 07:07:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KAvxXs011176;
        Tue, 20 Apr 2021 11:07:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 37yqa88wg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 11:07:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KB79KK31457694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:07:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABCFDAE053;
        Tue, 20 Apr 2021 11:07:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D9D8AE045;
        Tue, 20 Apr 2021 11:07:08 +0000 (GMT)
Received: from [9.102.29.44] (unknown [9.102.29.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 11:07:08 +0000 (GMT)
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210419225047.3415425-1-dennis@kernel.org>
 <YH4KzmddTHWx9Gih@google.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <8a1fa15c-3373-6357-2a2e-4a2b8b3bfb06@linux.ibm.com>
Date:   Tue, 20 Apr 2021 16:37:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YH4KzmddTHWx9Gih@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qP3pvFurK7jP4Z4UcABBSQGtNaqp8eZa
X-Proofpoint-ORIG-GUID: qP3pvFurK7jP4Z4UcABBSQGtNaqp8eZa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/04/21 4:27 am, Dennis Zhou wrote:
> On Mon, Apr 19, 2021 at 10:50:43PM +0000, Dennis Zhou wrote:
>> Hello,
>>
>> This series is a continuation of Roman's series in [1]. It aims to solve
>> chunks holding onto free pages by adding a reclaim process to the percpu
>> balance work item.
>>
>> The main difference is that the nr_empty_pop_pages is now managed at
>> time of isolation instead of intermixed. This helps with deciding which
>> chunks to free instead of having to interleave returning chunks to
>> active duty.
>>
>> The allocation priority is as follows:
>>    1) appropriate chunk slot increasing until fit
>>    2) sidelined chunks
>>    3) full free chunks
>>
>> The last slot for to_depopulate is never used for allocations.
>>
>> A big thanks to Roman for initiating the work and being available for
>> iterating on these ideas.
>>
>> This patchset contains the following 4 patches:
>>    0001-percpu-factor-out-pcpu_check_block_hint.patch
>>    0002-percpu-use-pcpu_free_slot-instead-of-pcpu_nr_slots-1.patch
>>    0003-percpu-implement-partial-chunk-depopulation.patch
>>    0004-percpu-use-reclaim-threshold-instead-of-running-for-.patch
>>
>> 0001 and 0002 are clean ups. 0003 implement partial chunk depopulation
>> initially from Roman. 0004 adds a reclaim threshold so we do not need to
>> schedule for every page freed.
>>
>> This series is on top of percpu$for-5.14 67c2669d69fb.
>>
>> diffstats below:
>>
>> Dennis Zhou (2):
>>    percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
>>    percpu: use reclaim threshold instead of running for every page
>>
>> Roman Gushchin (2):
>>    percpu: factor out pcpu_check_block_hint()
>>    percpu: implement partial chunk depopulation
>>
>>   mm/percpu-internal.h |   5 +
>>   mm/percpu-km.c       |   5 +
>>   mm/percpu-stats.c    |  20 ++--
>>   mm/percpu-vm.c       |  30 ++++++
>>   mm/percpu.c          | 252 ++++++++++++++++++++++++++++++++++++++-----
>>   5 files changed, 278 insertions(+), 34 deletions(-)
>>
>> Thanks,
>> Dennis
> Hello Pratik,
>
> Do you mind testing this series again on POWER9? The base is available
> here:
> https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-5.14
>
> Thanks,
> Dennis

Hello Dennis, I have tested this patchset on POWER9.

I have tried variations of the percpu_test in the top level and nested cgroups
creation as the test with 1000:10 didn't show any benefits.

The following example shows more consistent benefits with the de-allocation
strategy.
Outer: 1000
Inner: 50
# ./percpu_test.sh
Percpu:             6912 kB
Percpu:           532736 kB
Percpu:           278784 kB

I believe it could be a result of bulk freeing within "free_unref_page_commit",
where pages are only free'd if pcp->count >= pcp->high. As POWER has a larger
page size it would end up creating lesser number of pages but with the
effects of fragmentation.

Having said that, the patchset and its behavior does look good to me.

Thanks!
Pratik



