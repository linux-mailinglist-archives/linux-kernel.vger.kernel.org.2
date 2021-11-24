Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1645B85F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhKXKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:33:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57027 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241151AbhKXKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:33:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uy7GoT3_1637749807;
Received: from 30.21.164.55(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uy7GoT3_1637749807)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Nov 2021 18:30:08 +0800
Message-ID: <76c241cc-5de7-d083-312c-373645ee8a77@linux.alibaba.com>
Date:   Wed, 24 Nov 2021 18:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
 <13b2c5d1-ef3b-3e29-32fe-cb4294bb1531@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <13b2c5d1-ef3b-3e29-32fe-cb4294bb1531@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/24 2:46, Mike Kravetz wrote:
> On 11/7/21 01:57, Baolin Wang wrote:
>> As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
>> number larger than the number of pages the users tried to migrate, when a
>> THP page is failed to migrate. This is confusing for users.
>>
>> Since other migration scenarios do not care about the actual non-migrated
>> number of pages except the memory compaction migration which will fix in
>> following patch. Thus we can change the return value to return the number
>> of {normal page, THP, hugetlb} instead to avoid this issue, and the number
>> of THP splits will be considered as the number of non-migrated THP, no matter
>> how many subpages of the THP are migrated successfully. Meanwhile we should
>> still keep the migration counters using the number of normal pages.
>>
>> Co-developed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 47 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a11e948..9aafdab 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>    * @mode:		The migration mode that specifies the constraints for
>>    *			page migration, if any.
>>    * @reason:		The reason for page migration.
>> - * @ret_succeeded:	Set to the number of pages migrated successfully if
>> + * @ret_succeeded:	Set to the number of normal pages migrated successfully if
>>    *			the caller passes a non-NULL pointer.
>>    *
>>    * The function returns after 10 attempts or if no pages are movable any more
>> @@ -1436,7 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>    * It is caller's responsibility to call putback_movable_pages() to return pages
>>    * to the LRU or free list only if ret != 0.
>>    *
>> - * Returns the number of pages that were not migrated, or an error code.
>> + * Returns the number of {normal page, THP} that were not migrated, or an error code.
>> + * The number of THP splits will be considered as the number of non-migrated THP,
>> + * no matter how many subpages of the THP are migrated successfully.
>>    */
>>   int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   		free_page_t put_new_page, unsigned long private,
>> @@ -1445,6 +1447,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int retry = 1;
>>   	int thp_retry = 1;
>>   	int nr_failed = 0;
>> +	int nr_failed_pages = 0;
>>   	int nr_succeeded = 0;
>>   	int nr_thp_succeeded = 0;
>>   	int nr_thp_failed = 0;
>> @@ -1456,13 +1459,16 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int swapwrite = current->flags & PF_SWAPWRITE;
>>   	int rc, nr_subpages;
>>   	LIST_HEAD(ret_pages);
>> +	LIST_HEAD(thp_split_pages);
>>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
>> +	bool no_subpage_counting = false;
>>   
>>   	trace_mm_migrate_pages_start(mode, reason);
>>   
>>   	if (!swapwrite)
>>   		current->flags |= PF_SWAPWRITE;
>>   
>> +thp_subpage_migration:
>>   	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>>   		retry = 0;
>>   		thp_retry = 0;
>> @@ -1511,18 +1517,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   			case -ENOSYS:
>>   				/* THP migration is unsupported */
>>   				if (is_thp) {
>> -					if (!try_split_thp(page, &page2, from)) {
>> +					nr_thp_failed++;
>> +					if (!try_split_thp(page, &page2, &thp_split_pages)) {
> 
> Does thp_split_pages need to be initialized before this call?

The declaration "LIST_HEAD(thp_split_pages);" already did list 
initialization, right?
