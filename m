Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B5354D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhDFGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:53:56 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19981 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhDFGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:53:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UUg-950_1617692015;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UUg-950_1617692015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 14:53:36 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/4] mm/page_reporting: Introduce free page reporting
 factor
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
 <1616751898-58393-3-git-send-email-xlpang@linux.alibaba.com>
 <CAKgT0Ud872rkrHrn8kaweL83Lg0Uo6cxwRpZUg-5TM9kUyjgSQ@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <886910ff-f19d-0aa4-e0ad-0aa9072526ee@linux.alibaba.com>
Date:   Tue, 6 Apr 2021 14:53:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud872rkrHrn8kaweL83Lg0Uo6cxwRpZUg-5TM9kUyjgSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/21 2:56 AM, Alexander Duyck wrote:
> On Fri, Mar 26, 2021 at 2:45 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>> Add new "/sys/kernel/mm/page_reporting/reporting_factor"
>> within [0, 100], and stop page reporting when it reaches
>> the configured threshold. Default is 100 which means no
>> limitation is imposed. Percentile is adopted to reflect
>> the fact that it reports on the per-zone basis.
>>
>> We can control the total number of reporting pages via
>> this knob to avoid EPT violations which may affect the
>> performance of the business, imagine the guest memory
>> allocation burst or host long-tail memory reclaiming
>> really hurt.
> 
> I'm not a fan of the concept as I don't think it really does what it
> was meant to do. The way page reporting was meant to work is that when
> we have enough free pages we will cycle through memory a few pages at
> a time reporting what is unused to the hypervisor. It was meant to be
> a scan more than something that just would stop once it touched a
> certain part of the memory.
> 
> If you are wanting to truly reserve some amount of memory so that it
> is always left held by the guest then it might make more sense to make
> the value a fixed amount of memory rather than trying to do it as a
> percentage.
> 
> Also we may need to look at adding some sort of
> linearization/defragmentation logic for the reported pages. One issue
> is that there are several things that will add pages to the end of the
> free page lists. One of the reasons why I was processing the entire
> list when I was processing reported pages was because the page freeing
> functions will normally cause pages to be interleaved with the
> reported pages on the end of the list. So if you are wanting to
> reserve some pages as being non-reported we may need to add something
> sort the lists periodically.

Yes, agreed. To make the counter accurate, I also noticed this problem,
I'm going to figure out a way to handle it, e.g. maybe adding a new
migratetype for reported free_list is a good choice, this also helps
reduce the zone lock latency during the report procedue on large VM,
which can be in milliseconds.

> 
>> This knob can help make customized control policies according
>> to VM priority, it is also useful for testing, gray-release, etc.
> 
> As far as the knob itself it would make sense to combine this with
> patch 3 since they are just different versions of the same control
> 
>> ---
>>  mm/page_reporting.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index ba195ea..86c6479 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -11,6 +11,8 @@
>>  #include "page_reporting.h"
>>  #include "internal.h"
>>
>> +static int reporting_factor = 100;
>> +
>>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>>
>> @@ -134,6 +136,7 @@ void __page_reporting_notify(void)
>>         struct list_head *list = &area->free_list[mt];
>>         unsigned int page_len = PAGE_SIZE << order;
>>         struct page *page, *next;
>> +       unsigned long threshold;
>>         long budget;
>>         int err = 0;
>>
>> @@ -144,6 +147,7 @@ void __page_reporting_notify(void)
>>         if (list_empty(list))
>>                 return err;
>>
>> +       threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
> 
> So at 0 you are setting this threshold to 0, however based on the code
> below you are still pulling at least one page.
> 
>>         spin_lock_irq(&zone->lock);
>>
>>         /*
>> @@ -181,6 +185,8 @@ void __page_reporting_notify(void)
>>
>>                 /* Attempt to pull page from list and place in scatterlist */
>>                 if (*offset) {
>> +                       unsigned long nr_pages;
>> +
>>                         if (!__isolate_free_page(page, order)) {
>>                                 next = page;
>>                                 break;
>> @@ -190,6 +196,12 @@ void __page_reporting_notify(void)
>>                         --(*offset);
>>                         sg_set_page(&sgl[*offset], page, page_len, 0);
>>
>> +                       nr_pages = (PAGE_REPORTING_CAPACITY - *offset) << order;
>> +                       if (zone->reported_pages + nr_pages >= threshold) {
>> +                               err = 1;
>> +                               break;
>> +                       }
>> +
> 
> So here we are checking the threshold after we have already pulled the
> page. With this being the case it might make more sense to either
> allow for the full capacity of pages to be pulled and then check this
> after they have been reported, or to move this check up to somewhere
> before you start processing the pages. What you want to avoid is
> having to perform this check for every individual page.
> 
>>                         continue;
>>                 }
>>
>> @@ -244,9 +256,13 @@ void __page_reporting_notify(void)
>>                             struct scatterlist *sgl, struct zone *zone)
>>  {
>>         unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
>> -       unsigned long watermark;
>> +       unsigned long watermark, threshold;
>>         int err = 0;
>>
>> +       threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
>> +       if (zone->reported_pages >= threshold)
>> +               return err;
>> +
> 
> Rather than having to calculate the threshold in multiple spots it
> might make more sense to move this to the start of
> page_reporting_cycle and have it performed again before we reacquire
> the spinlock and run page_reporting_drain.
> 
>>         /* Generate minimum watermark to be able to guarantee progress */
>>         watermark = low_wmark_pages(zone) +
>>                     (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
>> @@ -267,11 +283,18 @@ void __page_reporting_notify(void)
>>
>>                         err = page_reporting_cycle(prdev, zone, order, mt,
>>                                                    sgl, &offset);
>> +                       /* Exceed threshold go to report leftover */
>> +                       if (err > 0) {
>> +                               err = 0;
>> +                               goto leftover;
>> +                       }
>> +
>>                         if (err)
>>                                 return err;
>>                 }
>>         }
>>
>> +leftover:
>>         /* report the leftover pages before going idle */
>>         leftover = PAGE_REPORTING_CAPACITY - offset;
>>         if (leftover) {
> 
> You should optimize for processing full batches rather than chopping
> things up into smaller groupings.
> 
>> @@ -435,9 +458,44 @@ static ssize_t refault_kbytes_store(struct kobject *kobj,
>>  }
>>  REPORTING_ATTR(refault_kbytes);
>>
>> +static ssize_t reporting_factor_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sprintf(buf, "%u\n", reporting_factor);
>> +}
>> +
>> +static ssize_t reporting_factor_store(struct kobject *kobj,
>> +               struct kobj_attribute *attr,
>> +               const char *buf, size_t count)
>> +{
>> +       int new, old, err;
>> +       struct page *page;
>> +
>> +       err = kstrtoint(buf, 10, &new);
>> +       if (err || (new < 0 || new > 100))
>> +               return -EINVAL;
>> +
>> +       old = reporting_factor;
>> +       reporting_factor = new;
>> +
>> +       if (new <= old)
>> +               goto out;
>> +
>> +       /* Trigger reporting with new larger reporting_factor */
>> +       page = alloc_pages(__GFP_HIGHMEM | __GFP_NOWARN,
>> +                       PAGE_REPORTING_MIN_ORDER);
>> +       if (page)
>> +               __free_pages(page, PAGE_REPORTING_MIN_ORDER);
>> +
>> +out:
>> +       return count;
>> +}
>> +REPORTING_ATTR(reporting_factor);
>> +
>>  static struct attribute *reporting_attrs[] = {
>>         &reported_kbytes_attr.attr,
>>         &refault_kbytes_attr.attr,
>> +       &reporting_factor_attr.attr,
>>         NULL,
>>  };
>>
>> --
>> 1.8.3.1
>>
>>
