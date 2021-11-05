Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8B44620F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhKEKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:19:22 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:59484 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232693AbhKEKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:19:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uv9ZLH3_1636107389;
Received: from 30.21.164.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uv9ZLH3_1636107389)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Nov 2021 18:16:30 +0800
Subject: Re: [RFC PATCH 1/3] mm: migrate: Fix the return value of
 migrate_pages()
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
 <81ED0EF7-779F-4977-AF09-665FF750319C@nvidia.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <1b05ce4f-059e-94bc-3753-f11d0c32693d@linux.alibaba.com>
Date:   Fri, 5 Nov 2021 18:17:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <81ED0EF7-779F-4977-AF09-665FF750319C@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/4 23:33, Zi Yan wrote:
> On 3 Nov 2021, at 6:51, Baolin Wang wrote:
> 
>> As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
>> number larger than the number of pages the users tried to migrate, when a
>> THP page is failed to migrate. This is confusing for users.
>>
>> Since other migration scenarios do not care about the actual non-migrated
>> number of pages except the memory compaction migration which will fix in
>> following patch. Thus we can change the return value to return the number
>> of {normal page, THP, hugetlb} instead to avoid this issue, meanwhile we
>> should still keep the migration counters using the number of normal pages.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a11e948..00b8922 100644
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
>> @@ -1436,7 +1436,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>>    * It is caller's responsibility to call putback_movable_pages() to return pages
>>    * to the LRU or free list only if ret != 0.
>>    *
>> - * Returns the number of pages that were not migrated, or an error code.
>> + * Returns the number of {normal page, THP} that were not migrated, or an error code.
>>    */
>>   int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   		free_page_t put_new_page, unsigned long private,
>> @@ -1445,6 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int retry = 1;
>>   	int thp_retry = 1;
>>   	int nr_failed = 0;
>> +	int nr_failed_pages = 0;
>>   	int nr_succeeded = 0;
>>   	int nr_thp_succeeded = 0;
>>   	int nr_thp_failed = 0;
>> @@ -1517,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   					}
>>
>>   					nr_thp_failed++;
>> -					nr_failed += nr_subpages;
>> +					nr_failed_pages += nr_subpages;
>>   					break;
>>   				}
>>
>> @@ -1537,7 +1538,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   					}
>>
>>   					nr_thp_failed++;
>> -					nr_failed += nr_subpages;
>> +					nr_failed_pages += nr_subpages;
>>   					goto out;
>>   				}
>>   				nr_failed++;
>> @@ -1566,7 +1567,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				 */
>>   				if (is_thp) {
>>   					nr_thp_failed++;
>> -					nr_failed += nr_subpages;
>> +					nr_failed_pages += nr_subpages;
>>   					break;
>>   				}
>>   				nr_failed++;
>> @@ -1575,8 +1576,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   		}
>>   	}
>>   	nr_failed += retry + thp_retry;
> 
> This line can probably go away, since we do not want to count retried pages.

OK.

> 
>> +	nr_failed_pages += nr_failed;
>>   	nr_thp_failed += thp_retry;
>> -	rc = nr_failed;
>> +	rc = nr_failed + nr_thp_failed;
>>   out:
>>   	/*
>>   	 * Put the permanent failure page back to migration list, they
>> @@ -1585,11 +1587,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	list_splice(&ret_pages, from);
>>
>>   	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>> -	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>>   	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>   	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>   	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>>   			       nr_thp_failed, nr_thp_split, mode, reason);
>>
>>   	if (!swapwrite)
>> -- 
>> 1.8.3.1
> 
> Thank you for the patch!
> 
> In general, this looks good to me. But like you said in other email, when a THP fails to
> migrate and gets split, the number of nr_failed will still be inflated by the number of
> failed subpage migrations. What I can think of is to split THPs to a separate list and
> stop increasing nr_failed when the pages from the new list is under migration. Let me
> know how it sounds to you.

Thanks for your patch, but I think it does not cover all the cases.

Firstly, what confuses me is that if we return 1 to users when failed to 
migrate 1 THP page, but actually we may have migrated some normal pages 
successfaully if the THP page is split. Anyway we can add some comments 
for migrate_pages() to explain it if this is acceptable.

Another concern about your patch is that, if the first round migration 
all pages are migrated successfaully (nr_failed = 0), but if failed to 
migrate the subpages of the THP in the second round, we will still 
return 0 to users, which is incorrect. Further more, if the subpages of 
the THP are migrated partially in the second round, what the number of 
non-migrated should be returned?  Suppose multiple THP pages have been 
split?

Last concern is that, we will try to migrate subpages of the THP in the 
second round, but if some non-migrated pages are still remained in the 
'from' list, we will do another redundant migration for these 
failed-migration pages and no failed counting for them. We can fix this 
issue by moving the remained non-migrated pages to 'ret_pages' list, 
which will put back to 'from' list when returning from this function.

if (!list_empty(&thp_split_pages)) {
+	list_splice(from, &ret_pages);
	list_splice(&thp_split_pages, from);
	no_failed_counting = true;
	goto thp_subpage_migration;
}

The concern 2 is more complicated, or we can just use 'nr_thp_split' to 
return if some subpages are failed to be migrated to simplify the case, 
no matter how many subpages are failed?

rc = nr_failed + nr_thp_failed + nr_thp_split;

> An untested but compiled patch (please apply it before this one) looks like:
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1852d787e6ab..f7e424f8e647 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1457,13 +1457,16 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>          int swapwrite = current->flags & PF_SWAPWRITE;
>          int rc, nr_subpages;
>          LIST_HEAD(ret_pages);
> +       LIST_HEAD(thp_split_pages);
>          bool nosplit = (reason == MR_NUMA_MISPLACED);
> +       bool no_failed_counting = false;
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
> @@ -1512,7 +1515,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                          case -ENOSYS:
>                                  /* THP migration is unsupported */
>                                  if (is_thp) {
> -                                       if (!try_split_thp(page, &page2, from)) {
> +                                       if (!try_split_thp(page, &page2, &thp_split_pages)) {
>                                                  nr_thp_split++;
>                                                  goto retry;
>                                          }
> @@ -1523,7 +1526,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                  }
> 
>                                  /* Hugetlb migration is unsupported */
> -                               nr_failed++;
> +                               if (!no_failed_counting)
> +                                       nr_failed++;
>                                  break;
>                          case -ENOMEM:
>                                  /*
> @@ -1532,7 +1536,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                   * THP NUMA faulting doesn't split THP to retry.
>                                   */
>                                  if (is_thp && !nosplit) {
> -                                       if (!try_split_thp(page, &page2, from)) {
> +                                       if (!try_split_thp(page, &page2, &thp_split_pages)) {
>                                                  nr_thp_split++;
>                                                  goto retry;
>                                          }
> @@ -1541,7 +1545,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                          nr_failed += nr_subpages;
>                                          goto out;
>                                  }
> -                               nr_failed++;
> +                               if (!no_failed_counting)
> +                                       nr_failed++;
>                                  goto out;
>                          case -EAGAIN:
>                                  if (is_thp) {
> @@ -1570,13 +1575,24 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                          nr_failed += nr_subpages;
>                                          break;
>                                  }
> -                               nr_failed++;
> +                               if (!no_failed_counting)
> +                                       nr_failed++;
>                                  break;
>                          }
>                  }
>          }
> -       nr_failed += retry + thp_retry;
> +       /* get thp_retry before it can be reset in THP subpage migration. */
>          nr_thp_failed += thp_retry;
> +       /* try to migrate subpages of fail-to-migrate THPs, no nr_failed
> +        * counting in this round, since all subpages of a THP is counted as
> +        * 1 failure in the first round. */
> +       if (!list_empty(&thp_split_pages)) {
> +               list_splice(from, &thp_split_pages);

Should be list_splice(&thp_split_pages, from)?

> +               no_failed_counting = true;
> +               goto thp_subpage_migration;
> +       }
> +
> +       nr_failed += retry + thp_retry;
>          rc = nr_failed;
>   out:
>          /*
> --
> Best Regards,
> Yan, Zi
> 
