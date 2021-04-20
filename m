Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098F365C24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhDTP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:26:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232976AbhDTPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:25:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KF4ijp131864;
        Tue, 20 Apr 2021 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1cAoKPhAMJrTdVkX3BhENYRBsO4E4RPePzawTShHQYM=;
 b=rGpOcThDCaqgp7/bWUCPtII/nYdMv4ZYD11NT5OO1LJRpIGi3bcNO9Gknj5o+70yf1uM
 AxduDZPSTSvVh/mvOeauBEwQAN0wJXxMWmDtuFF2hUcwhVWGHv/ACPMQSvE8zXK2tdOB
 5h0xCu9U01Qo0S1qNDdJHTPYC4kM4C09TwbtsdyXnoh831diH5h2NWG9vHmu8eKqClKq
 hX7CQtAzihLgbsdjge2xDo/s2w8AVBEcTGfxBfCwC0MfEbpuw4NdfNm5vNbSJzqmndN4
 Su02raRFpy21oOF78IPvPkkX3/zmAPzNAVdwNE6KwRZ0+D7i54xSWWm5TUoXaQfVb0EA JA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38217vgsh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 11:25:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KF41tg025246;
        Tue, 20 Apr 2021 15:25:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37yt2rsr92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 15:25:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KFPF0u11010442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 15:25:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38589AE055;
        Tue, 20 Apr 2021 15:25:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2495BAE04D;
        Tue, 20 Apr 2021 15:25:14 +0000 (GMT)
Received: from [9.102.29.44] (unknown [9.102.29.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 15:25:13 +0000 (GMT)
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210419225047.3415425-1-dennis@kernel.org>
 <YH4KzmddTHWx9Gih@google.com>
 <8a1fa15c-3373-6357-2a2e-4a2b8b3bfb06@linux.ibm.com>
 <YH7niMfDo3AzF7lG@google.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <da8288f7-f6c6-00da-fcbc-5c70c42359bc@linux.ibm.com>
Date:   Tue, 20 Apr 2021 20:55:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YH7niMfDo3AzF7lG@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XVVfzfwsDIJz9OjEGE3McJp6e5vxds12
X-Proofpoint-GUID: XVVfzfwsDIJz9OjEGE3McJp6e5vxds12
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_07:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dennis,


On 20/04/21 8:09 pm, Dennis Zhou wrote:
> On Tue, Apr 20, 2021 at 04:37:02PM +0530, Pratik Sampat wrote:
>> On 20/04/21 4:27 am, Dennis Zhou wrote:
>>> On Mon, Apr 19, 2021 at 10:50:43PM +0000, Dennis Zhou wrote:
>>>> Hello,
>>>>
>>>> This series is a continuation of Roman's series in [1]. It aims to solve
>>>> chunks holding onto free pages by adding a reclaim process to the percpu
>>>> balance work item.
>>>>
>>>> The main difference is that the nr_empty_pop_pages is now managed at
>>>> time of isolation instead of intermixed. This helps with deciding which
>>>> chunks to free instead of having to interleave returning chunks to
>>>> active duty.
>>>>
>>>> The allocation priority is as follows:
>>>>     1) appropriate chunk slot increasing until fit
>>>>     2) sidelined chunks
>>>>     3) full free chunks
>>>>
>>>> The last slot for to_depopulate is never used for allocations.
>>>>
>>>> A big thanks to Roman for initiating the work and being available for
>>>> iterating on these ideas.
>>>>
>>>> This patchset contains the following 4 patches:
>>>>     0001-percpu-factor-out-pcpu_check_block_hint.patch
>>>>     0002-percpu-use-pcpu_free_slot-instead-of-pcpu_nr_slots-1.patch
>>>>     0003-percpu-implement-partial-chunk-depopulation.patch
>>>>     0004-percpu-use-reclaim-threshold-instead-of-running-for-.patch
>>>>
>>>> 0001 and 0002 are clean ups. 0003 implement partial chunk depopulation
>>>> initially from Roman. 0004 adds a reclaim threshold so we do not need to
>>>> schedule for every page freed.
>>>>
>>>> This series is on top of percpu$for-5.14 67c2669d69fb.
>>>>
>>>> diffstats below:
>>>>
>>>> Dennis Zhou (2):
>>>>     percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
>>>>     percpu: use reclaim threshold instead of running for every page
>>>>
>>>> Roman Gushchin (2):
>>>>     percpu: factor out pcpu_check_block_hint()
>>>>     percpu: implement partial chunk depopulation
>>>>
>>>>    mm/percpu-internal.h |   5 +
>>>>    mm/percpu-km.c       |   5 +
>>>>    mm/percpu-stats.c    |  20 ++--
>>>>    mm/percpu-vm.c       |  30 ++++++
>>>>    mm/percpu.c          | 252 ++++++++++++++++++++++++++++++++++++++-----
>>>>    5 files changed, 278 insertions(+), 34 deletions(-)
>>>>
>>>> Thanks,
>>>> Dennis
>>> Hello Pratik,
>>>
>>> Do you mind testing this series again on POWER9? The base is available
>>> here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-5.14
>>>
>>> Thanks,
>>> Dennis
>> Hello Dennis, I have tested this patchset on POWER9.
>>
>> I have tried variations of the percpu_test in the top level and nested cgroups
>> creation as the test with 1000:10 didn't show any benefits.
> This is most likely because the 1 in every 11 still pins every page
> while 1 in 50 does not. Can you try the patch below on top? I think it
> may show slightly better perf as well. If it doesn't I'll just drop it.

I did try it out, although my test spanned only across varying the inner cgroup
folders; it didn't seem to show any benefit over the previous test without the
patch for being being able to spawn as little memory cgroup folders and seeing
partial memory depopulation.

>> The following example shows more consistent benefits with the de-allocation
>> strategy.
>> Outer: 1000
>> Inner: 50
>> # ./percpu_test.sh
>> Percpu:             6912 kB
>> Percpu:           532736 kB
>> Percpu:           278784 kB
>>
>> I believe it could be a result of bulk freeing within "free_unref_page_commit",
>> where pages are only free'd if pcp->count >= pcp->high. As POWER has a larger
>> page size it would end up creating lesser number of pages but with the
>> effects of fragmentation.
> This is unrelated to per cpu pages in slab/slub. Percpu is a separate
> memory allocator.
>
You're right, I was actually referencing incorrect code.

>> Having said that, the patchset and its behavior does look good to me.
> Thanks, can I throw the following on the appropriate patches? In the
> future it's good to be explicit about this because some prefer to credit
> different emails.
>
> Tested-by: Pratik Sampat <psampat@linux.ibm.com>

Sure thing please feel free to add a tested-by wherever you feel appropriate.
I'll be more explicit about them in the future. Thanks!

> Thanks,
> Dennis
>
> The following may do a little better on power9:
> ---
>  From a1464c4d5900cca68fd95b935178d72bb74837d5 Mon Sep 17 00:00:00 2001
> From: Dennis Zhou <dennis@kernel.org>
> Date: Tue, 20 Apr 2021 14:25:20 +0000
> Subject: [PATCH] percpu: convert free page float to bytes
>
> The percpu memory allocator keeps around a minimum number of free pages
> to ensure we can satisfy atomic allocations. However, we've always kept
> this number in terms of pages. On certain architectures like arm and
> powerpc, the default page size could be 64k instead of 4k. So, start
> with a target number of free bytes and then convert to pages.
>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>   mm/percpu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/percpu.c b/mm/percpu.c
> index ba13e683d022..287fe3091244 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -80,6 +80,7 @@
>   #include <linux/mutex.h>
>   #include <linux/percpu.h>
>   #include <linux/pfn.h>
> +#include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/vmalloc.h>
> @@ -107,11 +108,12 @@
>   /* chunks in slots below this are subject to being sidelined on failed alloc */
>   #define PCPU_SLOT_FAIL_THRESHOLD	3
>   
> -#define PCPU_EMPTY_POP_PAGES_LOW	2
> -#define PCPU_EMPTY_POP_PAGES_HIGH	4
> +#define PCPU_EMPTY_POP_PAGES_LOW	(max_t(int, (SZ_8K) / PAGE_SIZE, 1))
> +#define PCPU_EMPTY_POP_PAGES_HIGH	(max_t(int, (SZ_16K) / PAGE_SIZE, \
> +					       PCPU_EMPTY_POP_PAGES_LOW + 1))
>   
>   /* only schedule reclaim if there are at least N empty pop pages sidelined */
> -#define PCPU_EMPTY_POP_RECLAIM_THRESHOLD	4
> +#define PCPU_EMPTY_POP_RECLAIM_THRESHOLD	(PCPU_EMPTY_POP_PAGES_HIGH)
>   
>   #ifdef CONFIG_SMP
>   /* default addr <-> pcpu_ptr mapping, override in asm/percpu.h if necessary */

Thanks,
Pratik

