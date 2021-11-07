Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A244724D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 10:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhKGJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:10:08 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36935 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhKGJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:10:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UvOFVuS_1636276040;
Received: from 30.30.76.41(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvOFVuS_1636276040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Nov 2021 17:07:22 +0800
Subject: Re: [RFC PATCH 1/3] mm: migrate: Fix the return value of
 migrate_pages()
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
 <81ED0EF7-779F-4977-AF09-665FF750319C@nvidia.com>
 <1b05ce4f-059e-94bc-3753-f11d0c32693d@linux.alibaba.com>
 <6730F418-6BAA-435E-B790-7C77C22E21A3@nvidia.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <1a45492e-3372-844b-93ca-143c0ef3fe6c@linux.alibaba.com>
Date:   Sun, 7 Nov 2021 17:08:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6730F418-6BAA-435E-B790-7C77C22E21A3@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/5 23:21, Zi Yan wrote:
> On 5 Nov 2021, at 6:17, Baolin Wang wrote:
> 
>> On 2021/11/4 23:33, Zi Yan wrote:
>>> On 3 Nov 2021, at 6:51, Baolin Wang wrote:
>>>
>>>> As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
>>>> number larger than the number of pages the users tried to migrate, when a
>>>> THP page is failed to migrate. This is confusing for users.
>>>>
>>>> Since other migration scenarios do not care about the actual non-migrated
>>>> number of pages except the memory compaction migration which will fix in
>>>> following patch. Thus we can change the return value to return the number
>>>> of {normal page, THP, hugetlb} instead to avoid this issue, meanwhile we
>>>> should still keep the migration counters using the number of normal pages.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/migrate.c | 18 ++++++++++--------
>>>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index a11e948..00b8922 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>>>     * @mode:		The migration mode that specifies the constraints for
>>>>     *			page migration, if any.
>>>>     * @reason:		The reason for page migration.
>>>> - * @ret_succeeded:	Set to the number of pages migrated successfully if
>>>> + * @ret_succeeded:	Set to the number of normal pages migrated successfully if
>>>>     *			the caller passes a non-NULL pointer.
>>>>     *
>>>>     * The function returns after 10 attempts or if no pages are movable any more
>>>> @@ -1436,7 +1436,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>>>     * It is caller's responsibility to call putback_movable_pages() to return pages
>>>>     * to the LRU or free list only if ret != 0.
>>>>     *
>>>> - * Returns the number of pages that were not migrated, or an error code.
>>>> + * Returns the number of {normal page, THP} that were not migrated, or an error code.
>>>>     */
>>>>    int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    		free_page_t put_new_page, unsigned long private,
>>>> @@ -1445,6 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    	int retry = 1;
>>>>    	int thp_retry = 1;
>>>>    	int nr_failed = 0;
>>>> +	int nr_failed_pages = 0;
>>>>    	int nr_succeeded = 0;
>>>>    	int nr_thp_succeeded = 0;
>>>>    	int nr_thp_failed = 0;
>>>> @@ -1517,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    					}
>>>>
>>>>    					nr_thp_failed++;
>>>> -					nr_failed += nr_subpages;
>>>> +					nr_failed_pages += nr_subpages;
>>>>    					break;
>>>>    				}
>>>>
>>>> @@ -1537,7 +1538,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    					}
>>>>
>>>>    					nr_thp_failed++;
>>>> -					nr_failed += nr_subpages;
>>>> +					nr_failed_pages += nr_subpages;
>>>>    					goto out;
>>>>    				}
>>>>    				nr_failed++;
>>>> @@ -1566,7 +1567,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    				 */
>>>>    				if (is_thp) {
>>>>    					nr_thp_failed++;
>>>> -					nr_failed += nr_subpages;
>>>> +					nr_failed_pages += nr_subpages;
>>>>    					break;
>>>>    				}
>>>>    				nr_failed++;
>>>> @@ -1575,8 +1576,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    		}
>>>>    	}
>>>>    	nr_failed += retry + thp_retry;
>>>
>>> This line can probably go away, since we do not want to count retried pages.
>>
>> OK.
> 
> My bad, I misread the code. This should stay, since each -EAGIN does not
> increase nr_failed or nr_thp_failed and after the for loop, retry and thp_retry
> give the number of pages that fail to migrate after 10 retries.

Ah, right.

>>
>>>
>>>> +	nr_failed_pages += nr_failed;
>>>>    	nr_thp_failed += thp_retry;
>>>> -	rc = nr_failed;
>>>> +	rc = nr_failed + nr_thp_failed;
>>>>    out:
>>>>    	/*
>>>>    	 * Put the permanent failure page back to migration list, they
>>>> @@ -1585,11 +1587,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    	list_splice(&ret_pages, from);
>>>>
>>>>    	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>>> -	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>>>>    	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>>>    	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>>>    	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>>>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>>>>    			       nr_thp_failed, nr_thp_split, mode, reason);
>>>>
>>>>    	if (!swapwrite)
>>>> -- 
>>>> 1.8.3.1
>>>
>>> Thank you for the patch!
>>>
>>> In general, this looks good to me. But like you said in other email, when a THP fails to
>>> migrate and gets split, the number of nr_failed will still be inflated by the number of
>>> failed subpage migrations. What I can think of is to split THPs to a separate list and
>>> stop increasing nr_failed when the pages from the new list is under migration. Let me
>>> know how it sounds to you.
>>
>> Thanks for your patch, but I think it does not cover all the cases.
>>
>> Firstly, what confuses me is that if we return 1 to users when failed to migrate 1 THP page, but actually we may have migrated some normal pages successfaully if the THP page is split. Anyway we can add some comments for migrate_pages() to explain it if this is acceptable.
> 
> Sure.
> 
>>
>> Another concern about your patch is that, if the first round migration all pages are migrated successfaully (nr_failed = 0), but if failed to migrate the subpages of the THP in the second round, we will still return 0 to users, which is incorrect. Further more, if the
> 
> Ah, I missed this. We should increase nr_thp_failed when THP is split.
> 
>> subpages of the THP are migrated partially in the second round, what the number of non-migrated should be returned?  Suppose multiple THP pages have been split?
> 
> Assuming users do not know/care what kinds of pages are in their migration list, we can
> just return 1 if a THP is split, no matter how many subpages are migrated successfully.
> If they do want to know the details, they probably can check the tracepoints.
OK.

> 
>>
>> Last concern is that, we will try to migrate subpages of the THP in the second round, but if some non-migrated pages are still remained in the 'from' list, we will do another redundant migration for these failed-migration pages and no failed counting for them. We can fix this issue by moving the remained non-migrated pages to 'ret_pages' list, which will put back to 'from' list when returning from this function.
>>
>> if (!list_empty(&thp_split_pages)) {
>> +	list_splice(from, &ret_pages);
>> 	list_splice(&thp_split_pages, from);
>> 	no_failed_counting = true;
>> 	goto thp_subpage_migration;
>> }
> 
> You are right. At this point, pages in the from list have been retried 10 times,
> no need to migrate them again.
> 
>>
>> The concern 2 is more complicated, or we can just use 'nr_thp_split' to return if some subpages are failed to be migrated to simplify the case, no matter how many subpages are failed?
>>
>> rc = nr_failed + nr_thp_failed + nr_thp_split;
> 
> Like I said above, I would just increase nr_thp_failed when a THP is split. Here is the patch
> I come up with based on your feedback above. This time I incorporated your patch above. Please
> let me know how it looks. Thanks.

Overall it looks good, but I found some issues as below when I did some 
testing, otherwise it looks good to me. I've folded this into my new 
patch set, please help to review again. Thanks.

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1852d787e6ab..a5fad22259a3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1429,7 +1429,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>    * @mode:              The migration mode that specifies the constraints for
>    *                     page migration, if any.
>    * @reason:            The reason for page migration.
> - * @ret_succeeded:     Set to the number of pages migrated successfully if
> + * @ret_succeeded:     Set to the number of normal pages migrated successfully if
>    *                     the caller passes a non-NULL pointer.
>    *
>    * The function returns after 10 attempts or if no pages are movable any more
> @@ -1437,7 +1437,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>    * It is caller's responsibility to call putback_movable_pages() to return pages
>    * to the LRU or free list only if ret != 0.
>    *
> - * Returns the number of pages that were not migrated, or an error code.
> + * Returns the number of {normal page, THP} that were not migrated, or an error code.
>    */
>   int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                  free_page_t put_new_page, unsigned long private,
> @@ -1446,6 +1446,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>          int retry = 1;
>          int thp_retry = 1;
>          int nr_failed = 0;
> +       int nr_failed_pages = 0;
>          int nr_succeeded = 0;
>          int nr_thp_succeeded = 0;
>          int nr_thp_failed = 0;
> @@ -1457,13 +1458,16 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>          int swapwrite = current->flags & PF_SWAPWRITE;
>          int rc, nr_subpages;
>          LIST_HEAD(ret_pages);
> +       LIST_HEAD(thp_split_pages);
>          bool nosplit = (reason == MR_NUMA_MISPLACED);
> +       bool dont_count_failed_subpage = false;
> 
>          trace_mm_migrate_pages_start(mode, reason);
> 
>          if (!swapwrite)
>                  current->flags |= PF_SWAPWRITE;
> 
> +thp_subpage_migration:
>          for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>                  retry = 0;
>                  thp_retry = 0;
> @@ -1512,18 +1516,21 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                          case -ENOSYS:
>                                  /* THP migration is unsupported */
>                                  if (is_thp) {
> -                                       if (!try_split_thp(page, &page2, from)) {
> +                                       nr_thp_failed++;
> +                                       if (!try_split_thp(page, &page2, &thp_split_pages)) {
>                                                  nr_thp_split++;
>                                                  goto retry;
>                                          }
> 
> -                                       nr_thp_failed++;
> -                                       nr_failed += nr_subpages;
> +                                       nr_failed_pages += nr_subpages;
>                                          break;
>                                  }
> 
>                                  /* Hugetlb migration is unsupported */
> -                               nr_failed++;
> +                               if (!dont_count_failed_subpage) {
> +                                       nr_failed++;
> +                                       nr_failed_pages++;
> +                               }

Shoule be:
	if (!dont_count_failed_subpage)
		nr_failed++;
	nr_failed_pages++;

Since we still need count the number of normal pages into 
"nr_failed_pages" in the second round.

>                                  break;
>                          case -ENOMEM:
>                                  /*
> @@ -1532,16 +1539,19 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                   * THP NUMA faulting doesn't split THP to retry.
>                                   */
>                                  if (is_thp && !nosplit) {
> -                                       if (!try_split_thp(page, &page2, from)) {
> +                                       nr_thp_failed++;
> +                                       if (!try_split_thp(page, &page2, &thp_split_pages)) {
>                                                  nr_thp_split++;
>                                                  goto retry;
>                                          }
> 
> -                                       nr_thp_failed++;
> -                                       nr_failed += nr_subpages;
> +                                       nr_failed_pages += nr_subpages;
>                                          goto out;
>                                  }
> -                               nr_failed++;
> +                               if (!dont_count_failed_subpage) {
> +                                       nr_failed++;
> +                                       nr_failed_pages++;
> +                               }

Ditto

>                                  goto out;
>                          case -EAGAIN:
>                                  if (is_thp) {
> @@ -1567,17 +1577,34 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                   */
>                                  if (is_thp) {
>                                          nr_thp_failed++;
> -                                       nr_failed += nr_subpages;
> +                                       nr_failed_pages += nr_subpages;
>                                          break;
>                                  }
> -                               nr_failed++;
> +                               if (!dont_count_failed_subpage) {
> +                                       nr_failed++;
> +                                       nr_failed_pages++;
> +                               }

Ditto.

>                                  break;
>                          }
>                  }
>          }
>          nr_failed += retry + thp_retry;
>          nr_thp_failed += thp_retry;
> -       rc = nr_failed;
> +       /*
> +        * try to migrate subpages of fail-to-migrate THPs, no nr_failed
> +        * counting in this round, since all subpages of a THP is counted as
> +        * 1 failure in the first round.
> +        */
> +       if (!list_empty(&thp_split_pages)) {
> +               /*
> +                * move non-migrated pages (after 10 retries) to ret_pages to
> +                * avoid migrating them again.
> +                */
> +               list_splice(from, &ret_pages);
> +               list_splice(&thp_split_pages, from);

should be:
	list_splice_init(from, &ret_pages);
	list_splice_init(&thp_split_pages, from);

Since the 'from' and  'thp_split_pages' will be reused, otherwise will 
cause dead-loop.

> +               dont_count_failed_subpage = true;

Should add 'retry = 1;' here, otherwise it will not try to migrate subpages.

> +               goto thp_subpage_migration;
> +       }
> +
> +       rc = nr_failed + nr_thp_failed;
>   out:
>          /*
>           * Put the permanent failure page back to migration list, they
> @@ -1586,11 +1613,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>          list_splice(&ret_pages, from);
> 
>          count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> -       count_vm_events(PGMIGRATE_FAIL, nr_failed);
> +       count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>          count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>          count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>          count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -       trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +       trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>                                 nr_thp_failed, nr_thp_split, mode, reason);
> 
>          if (!swapwrite)
> 
> --
> Best Regards,
> Yan, Zi
> 
