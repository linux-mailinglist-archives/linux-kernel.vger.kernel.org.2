Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED0354D24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhDFG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:56:08 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39028 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233519AbhDFG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:56:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UUfx7M0_1617692155;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UUfx7M0_1617692155)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 14:55:56 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 4/4] mm/page_reporting: Fix possible user allocation
 failure
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
 <1616751898-58393-5-git-send-email-xlpang@linux.alibaba.com>
 <CAKgT0UeHFXEp4Gx4cq5Z7Ekg2iqUgHXqE-5no=hEfybYiUJqng@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <2d780895-eb7d-4a26-6256-5180c58095d6@linux.alibaba.com>
Date:   Tue, 6 Apr 2021 14:55:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeHFXEp4Gx4cq5Z7Ekg2iqUgHXqE-5no=hEfybYiUJqng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/21 3:55 AM, Alexander Duyck wrote:
> On Fri, Mar 26, 2021 at 2:45 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>> We encountered user memory allocation failure(OOM) on our
>> 512MiB tiny instances, it didn't happen after turning off
>> the page reporting.
>>
>> After some debugging, it turns out 32*4MB=128MB(order-10)
>> free pages were isolated during reporting window resulting
>> in no free available.
>>
>> Actually this might also happen on large instances when
>> having a few free memory.
>>
>> This patch introduces a rule to limit reporting capacity
>> according to current free memory, and reduce accordingly
>> for higher orders which could break this rule.
>>
>> For example,
>>  100MiB free, sgl capacity for different orders are:
>>    order-9 : 32
>>    order-10: 16
>>
>> Reported-by: Helin Guo <helinguo@linux.alibaba.com>
>> Tested-by: Helin Guo <helinguo@linux.alibaba.com>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> 
> I'm curious how much of this would be solved by just making it so that
> we reduce the capacity by half if we increase the order? So
> specifically if we did something such as:
>   capacity = (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER) >> order;
> 
> We just have to make sure the capacity is greater than zero before
> entering the processing loop.
> 
> An alternative that occured to me while I reviewed this is to look at
> just adding a reserve. That would be something like:
>   reserve = PAGE_REPORTING_CAPACITY - capacity;
> 
> Basically the reserve would take up some space at the start of the
> list so that you wouldn't need to actually change the capacity
> directly. It would just be a matter of making certain we deducted it
> and updated the offsets of the scatterlist as necessary.
> 
> 
>> ---
>>  mm/page_reporting.c | 89 +++++++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 72 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index 6ffedb8..2ec0ec0 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -129,8 +129,8 @@ void __page_reporting_notify(void)
>>   */
>>  static int
>>  page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>> -                    unsigned int order, unsigned int mt,
>> -                    struct scatterlist *sgl, unsigned int *offset)
>> +                    unsigned int order, unsigned int mt, struct scatterlist *sgl,
>> +                    const unsigned int capacity, unsigned int *offset)
>>  {
>>         struct free_area *area = &zone->free_area[order];
>>         struct list_head *list = &area->free_list[mt];
>> @@ -161,10 +161,10 @@ void __page_reporting_notify(void)
>>          * list processed. This should result in us reporting all pages on
>>          * an idle system in about 30 seconds.
>>          *
>> -        * The division here should be cheap since PAGE_REPORTING_CAPACITY
>> -        * should always be a power of 2.
>> +        * The division here should be cheap since capacity should
>> +        * always be a power of 2.
>>          */
>> -       budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
>> +       budget = DIV_ROUND_UP(area->nr_free, capacity * 16);
> 
> So the comment here is no longer valid when capacity became a
> variable. An alternative to look at if we were to assume the shift
> approach I mentioned above would be to then shift the budget based on
> the reduced capacity.
> 
>>         /* loop through free list adding unreported pages to sg list */
>>         list_for_each_entry_safe(page, next, list, lru) {
>> @@ -196,7 +196,7 @@ void __page_reporting_notify(void)
>>                         --(*offset);
>>                         sg_set_page(&sgl[*offset], page, page_len, 0);
>>
>> -                       nr_pages = (PAGE_REPORTING_CAPACITY - *offset) << order;
>> +                       nr_pages = (capacity - *offset) << order;
>>                         if (zone->reported_pages + nr_pages >= threshold) {
>>                                 err = 1;
>>                                 break;
> 
> Rather than adding a capacity value it might work better to add a
> "reserve" value so that we are just padding the start of the
> scatterlist rather than having to reset it every time we change the
> total capacity of the scatterlist. The advantage to that is that you
> could drop all the changes where you are having to reset the list and
> change the capacity.
> 
> Instead you would just need to update the check to "*offset <=
> reserve" and the call to report/drain so that they take into account
> the reserve offset.
> 
>> @@ -217,10 +217,10 @@ void __page_reporting_notify(void)
>>                 spin_unlock_irq(&zone->lock);
>>
>>                 /* begin processing pages in local list */
>> -               err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
>> +               err = prdev->report(prdev, sgl, capacity);
>>
> 
> Assuming the change to "reserve" then this would be "&sgl[*offset],
> PAGE_REPORTING_CAPACITY - *offset", or you could look at copying the
> approach taken in the "leftover" path in page_reporting_process_zone.
> 
>>                 /* reset offset since the full list was reported */
>> -               *offset = PAGE_REPORTING_CAPACITY;
>> +               *offset = capacity;
>>
>>                 /* update budget to reflect call to report function */
>>                 budget--;
>> @@ -229,7 +229,7 @@ void __page_reporting_notify(void)
>>                 spin_lock_irq(&zone->lock);
>>
>>                 /* flush reported pages from the sg list */
>> -               page_reporting_drain(prdev, sgl, zone, PAGE_REPORTING_CAPACITY, !err);
>> +               page_reporting_drain(prdev, sgl, zone, capacity, !err);
> 
> Same here. The general idea is you want to avoid having to flush every
> time you want to change the reserve and instead just trigger a flush
> should your offset value fall below what is reserved.
> 
>>                 /*
>>                  * Reset next to first entry, the old next isn't valid
>> @@ -251,12 +251,39 @@ void __page_reporting_notify(void)
>>         return err;
>>  }
> 
> So all of the code below seems to be the result of the added
> complexity I mentioned above due to the capacity being changed rather
> than some portion of the list becoming reserved.
> 
> I think it would be much more interesting to explore the approach of
> just reserving some portion of the start of the scatterlist rather
> than trying to change the capacity. By doing that much of the code
> change seen here can be avoided as you are having to restructure the
> entire list and are introducing other possible issues since one of the
> things I was doing by using the approach I did is always making sure
> the sg_end was already set for the scatterlist end whereas that is
> gone now with these changes.
> 
>> +/*
>> + * For guest with little free memory, we should tune reporting capacity
>> + * correctly to avoid reporting too much once, otherwise user allocation
>> + * may fail and OOM during reporting window between __isolate_free_page()
>> + * and page_reporting_drain().
>> + *
>> + * Calculate from which order we begin to reduce the scatterlist capacity,
>> + * in order not to isolate too many pages to fail the user allocation.
>> + */
>> +static unsigned int calculate_zone_order_threshold(struct zone *z)
>> +{
>> +       unsigned int order;
>> +       long pages_threshold;
>> +
>> +       pages_threshold = zone_page_state(z, NR_FREE_PAGES) - low_wmark_pages(z);
>> +       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
>> +               if ((PAGE_REPORTING_CAPACITY << order) > pages_threshold)
>> +                       break;
>> +       }
>> +
>> +       return order;
>> +}
>> +
>>  static int
>>  page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>>                             struct scatterlist *sgl, struct zone *zone)
>>  {
>> -       unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
>> +       unsigned int order, mt, leftover, offset;
>>         unsigned long watermark, threshold;
>> +       unsigned int capacity = PAGE_REPORTING_CAPACITY;
>> +       unsigned int capacity_curr;
>> +       struct scatterlist *sgl_curr;
>> +       unsigned int order_threshold;
>>         int err = 0;
>>
>>         threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
>> @@ -274,15 +301,28 @@ void __page_reporting_notify(void)
>>         if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
>>                 return err;
>>
>> +       sgl_curr = sgl;
>> +       capacity_curr = offset = capacity;
>> +       order_threshold = calculate_zone_order_threshold(zone);
>>         /* Process each free list starting from lowest order/mt */
>>         for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
>> +               /* try to reduce unexpected high order's reporting capacity */
>> +               if (order >= order_threshold) {
>> +                       capacity_curr = capacity >> (order - order_threshold + 1);
>> +                       if (capacity_curr == 0)
>> +                               capacity_curr = 1;
>> +                       sgl_curr = sgl + capacity - capacity_curr;
>> +                       offset = capacity_curr;
>> +                       sg_init_table(sgl_curr, capacity_curr);
>> +               }
>> +
> 
> The problem here is you are assuming the order threshold will not
> change during processing. Your order_threshold value could become
> stale while you are processing the zone so I am not sure having it
> provides much value.
> 
> I think we might be better off just assuming that we need to halve
> capacity as the order increases.
> 
>>                 for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>>                         /* We do not pull pages from the isolate free list */
>>                         if (is_migrate_isolate(mt))
>>                                 continue;
>>
>>                         err = page_reporting_cycle(prdev, zone, order, mt,
>> -                                                  sgl, &offset);
>> +                                                  sgl_curr, capacity_curr, &offset);
>>                         /* Exceed threshold go to report leftover */
>>                         if (err > 0) {
>>                                 err = 0;
>> @@ -292,18 +332,34 @@ void __page_reporting_notify(void)
>>                         if (err)
>>                                 return err;
>>                 }
>> +
>> +               /* report the leftover pages for next orders with reduced capacity */
>> +               leftover = capacity_curr - offset;
>> +               if (leftover && order + 1 >= order_threshold) {
>> +                       sgl_curr = &sgl_curr[offset];
>> +                       err = prdev->report(prdev, sgl_curr, leftover);
>> +                       offset = capacity_curr;
>> +
>> +                       /* flush any remaining pages out from the last report */
>> +                       spin_lock_irq(&zone->lock);
>> +                       page_reporting_drain(prdev, sgl_curr, zone, leftover, !err);
>> +                       spin_unlock_irq(&zone->lock);
>> +
>> +                       if (err)
>> +                               return err;
>> +               }
>>         }
>>
>>  leftover:
>>         /* report the leftover pages before going idle */
>> -       leftover = PAGE_REPORTING_CAPACITY - offset;
>> +       leftover = capacity_curr - offset;
>>         if (leftover) {
>> -               sgl = &sgl[offset];
>> -               err = prdev->report(prdev, sgl, leftover);
>> +               sgl_curr = &sgl_curr[offset];
>> +               err = prdev->report(prdev, sgl_curr, leftover);
>>
>>                 /* flush any remaining pages out from the last report */
>>                 spin_lock_irq(&zone->lock);
>> -               page_reporting_drain(prdev, sgl, zone, leftover, !err);
>> +               page_reporting_drain(prdev, sgl_curr, zone, leftover, !err);
>>                 spin_unlock_irq(&zone->lock);
>>         }
>>
>> @@ -332,9 +388,8 @@ static void page_reporting_process(struct work_struct *work)
>>         if (!sgl)
>>                 goto err_out;
>>
>> -       sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
>> -
>>         for_each_zone(zone) {
>> +               sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
>>                 err = page_reporting_process_zone(prdev, sgl, zone);
>>                 if (err)
>>                         break;
>> --
>> 1.8.3.1
>>
>>

Great, will try to improve it according to your suggestions.
Thanks for all the valuable comments.
