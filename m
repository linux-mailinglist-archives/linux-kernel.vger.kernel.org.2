Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848A2346F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhCXCD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:03:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14513 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhCXCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:03:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4s0W52g9zPlZp;
        Wed, 24 Mar 2021 10:01:15 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:03:41 +0800
Subject: Re: [PATCH v2 5/5] mm/migrate.c: fix potential deadlock in NUMA
 balancing shared exec THP case
To:     Yang Shi <shy828301@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210323135405.65059-1-linmiaohe@huawei.com>
 <20210323135405.65059-6-linmiaohe@huawei.com>
 <CAHbLzkoSsPWSdyZQBR03NbU8i3AG_DTL4P-efYULvuYmWzyYbg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9037968-4e46-b02a-88c0-60a6fe01aacf@huawei.com>
Date:   Wed, 24 Mar 2021 10:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoSsPWSdyZQBR03NbU8i3AG_DTL4P-efYULvuYmWzyYbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 1:17, Yang Shi wrote:
> On Tue, Mar 23, 2021 at 6:55 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> Since commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
>> balancing"), the NUMA balancing would skip shared exec transhuge page.
>> But this enhancement is not suitable for transhuge page. Because it's
>> required that page_mapcount() must be 1 due to no migration pte dance
>> is done here. On the other hand, the shared exec transhuge page will
>> leave the migrate_misplaced_page() with pte entry untouched and page
>> locked. Thus pagefault for NUMA will be triggered again and deadlock
>> occurs when we start waiting for the page lock held by ourselves.
> 
> Thanks for catching this. By relooking the code I think the other
> important reason for removing this is
> migrate_misplaced_transhuge_page() actually can't see shared exec file
> THP at all since page_lock_anon_vma_read() is called before and if
> page is not anonymous page it will just restore the PMD without
> migrating anything.
> 
> The pages for private mapped file vma may be anonymous pages due to
> COW but they can't be THP so it won't trigger THP numa fault at all. I
> think this is why no bug was reported. I overlooked this in the first
> place.
> 
> Your fix is correct, and please add the above justification to your commit log.
> 

Will do. Many thanks for your review!

> Reviewed-by: Yang Shi <shy828301@gmail.com>
> 
>>
>> Fixes: c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA balancing")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 5357a8527ca2..68bfa1625898 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2192,9 +2192,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>>         int page_lru = page_is_file_lru(page);
>>         unsigned long start = address & HPAGE_PMD_MASK;
>>
>> -       if (is_shared_exec_page(vma, page))
>> -               goto out;
>> -
>>         new_page = alloc_pages_node(node,
>>                 (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>>                 HPAGE_PMD_ORDER);
>> @@ -2306,7 +2303,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>>
>>  out_unlock:
>>         unlock_page(page);
>> -out:
>>         put_page(page);
>>         return 0;
>>  }
>> --
>> 2.19.1
>>
> .
> 

