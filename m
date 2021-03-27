Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD434B391
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhC0BlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 21:41:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhC0Bko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 21:40:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6hLS1fPYznbNS;
        Sat, 27 Mar 2021 09:38:08 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 09:40:39 +0800
Subject: Re: [PATCH 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        "Hillf Danton" <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-5-mike.kravetz@oracle.com>
 <ee3d6134-068b-8f21-31d6-4d13ef417ae1@huawei.com>
 <def1f500-ae75-5669-5a3d-0472865d2d4c@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8395881b-5c16-d747-aa6e-fd13b7f7f53e@huawei.com>
Date:   Sat, 27 Mar 2021 09:40:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <def1f500-ae75-5669-5a3d-0472865d2d4c@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/27 3:57, Mike Kravetz wrote:
> On 3/25/21 7:10 PM, Miaohe Lin wrote:
>> On 2021/3/25 8:28, Mike Kravetz wrote:
>>> The new remove_hugetlb_page() routine is designed to remove a hugetlb
>>> page from hugetlbfs processing.  It will remove the page from the active
>>> or free list, update global counters and set the compound page
>>> destructor to NULL so that PageHuge() will return false for the 'page'.
>>> After this call, the 'page' can be treated as a normal compound page or
>>> a collection of base size pages.
>>>
>>> remove_hugetlb_page is to be called with the hugetlb_lock held.
>>>
>>> Creating this routine and separating functionality is in preparation for
>>> restructuring code to reduce lock hold times.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb.c | 70 +++++++++++++++++++++++++++++++++-------------------
>>>  1 file changed, 45 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 404b0b1c5258..3938ec086b5c 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1327,6 +1327,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>>>  						unsigned int order) { }
>>>  #endif
>>>  
>>> +/*
>>> + * Remove hugetlb page from lists, and update dtor so that page appears
>>> + * as just a compound page.  A reference is held on the page.
>>> + * NOTE: hugetlb specific page flags stored in page->private are not
>>> + *	 automatically cleared.  These flags may be used in routines
>>> + *	 which operate on the resulting compound page.
>>
>> It seems HPageFreed and HPageTemporary is cleared. Which hugetlb specific page flags
>> is reserverd here and why? Could you please give a simple example to clarify
>> this in the comment to help understand this NOTE?
>>
> 
> I will remove that NOTE: in the comment to avoid any confusion.
> 
> The NOTE was add in the RFC that contained a separate patch to add a flag
> that tracked huge pages allocated from CMA.  That flag needed to remain
> for subsequent freeing of such pages.  This is no longer needed.
> 

Many thanks for explaination. I was confused about that NOTE. :)

>> The code looks good to me. Many thanks!
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> 

