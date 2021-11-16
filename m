Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231E9452A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhKPGGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:06:05 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57971 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240150AbhKPGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:06:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwoypE-_1637042580;
Received: from 30.21.164.20(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UwoypE-_1637042580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 14:03:01 +0800
Message-ID: <71816b8f-93e5-5a2a-e616-d52a1c4d354c@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 14:03:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
 <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/16 12:21, Andrew Morton wrote:
> On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Correct the migration stats for hugetlb with using compound_nr() instead
>> of thp_nr_pages(),
> 
> It would be helpful to explain why using thp_nr_pages() was wrong.

Sure. Using thp_nr_pages() to get the number of subpages for a hugetlb 
is incorrect, since the number of subpages in te hugetlb is not always 
HPAGE_PMD_NR.

> And to explain the end user visible effects of this bug so we can

Actually not also user visible effect, but also hugetlb migration stats 
in kernel are incorrect. For he end user visible effects, like I 
described in patch 1,  the syscall move_pages() can return a 
non-migrated number larger than the number of pages the users tried to 
migrate, when a THP page is failed to migrate. This is confusing for users.

> decide whether -stable backporting is desirable.
> 
>> meanwhile change 'nr_failed_pages' to record the
>> number of normal pages failed to migrate, including THP and hugetlb,
>> and 'nr_succeeded' will record the number of normal pages migrated
>> successfully.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 9aafdab..756190b 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1436,9 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>    * It is caller's responsibility to call putback_movable_pages() to return pages
>>    * to the LRU or free list only if ret != 0.
>>    *
>> - * Returns the number of {normal page, THP} that were not migrated, or an error code.
>> - * The number of THP splits will be considered as the number of non-migrated THP,
>> - * no matter how many subpages of the THP are migrated successfully.
>> + * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
> 
> This is a bit confusing.
> 
> If migrate_pages() failed to migrate one 4k pages then it returns 1,
> yes?

Yes.

> 
> But if migrate_pages() fails to migrate one 2MB hugepage then will it
> return 1 or will it return 512?

It will return 1 too.

> 
> And how can the caller actually _use_ this return value without knowing
> the above information?

IMHO other migration scenarios do not care about the actual non-migrated 
number of pages except the memory compaction migration, and I've fixed 
the memory compaction migration in patch 3.

So for the syscall move_pages(), we can change the return value to 
return the number of {normal page, THP, hugetlb} instead, and the number 
of THP splits will be considered as the number of non-migrated THP, no 
matter how many subpages of the THP are migrated successfully.

> In other words, perhaps this function should simply return pass/fail?

I think we've returned the successful migration pages through the 
parameter '*ret_succeeded' of the migrate_pages().
