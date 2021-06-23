Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C953B103B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhFVWyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhFVWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624402348;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUnWSTpegV9V02wr/VObzXlEQjcaase6+yZNO7VFkA8=;
        b=e6LgHB0OULNZFuNZJbQoCKRnzzSKH9YKSYLOWnwznvW30Bw893Q9upjFmV1fNEK3FYQJ+u
        /MpAz6H5LbrbmN2066SemL3EolNuM9PGDTNUv548qvA74fy4W456wvFwkH8h8M0vLz9wSz
        +9m0R+EfgL4JImlaDs/GjDB85jQhCqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-W_Ade6nlOHa38g0tBLbG2g-1; Tue, 22 Jun 2021 18:52:24 -0400
X-MC-Unique: W_Ade6nlOHa38g0tBLbG2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55DFE81CCBC;
        Tue, 22 Jun 2021 22:42:57 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC3819C66;
        Tue, 22 Jun 2021 22:42:47 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 2/3] mm/page_reporting: Allow driver to specify
 threshold
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210622074926.333223-1-gshan@redhat.com>
 <20210622074926.333223-3-gshan@redhat.com>
 <CAKgT0UfXfqUhm5P-2J4ftgU9xmy9GixJdFnpUP-ppXih1yZXyQ@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d2e0c1a4-1ef1-d895-300b-179d33b83b41@redhat.com>
Date:   Wed, 23 Jun 2021 10:43:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfXfqUhm5P-2J4ftgU9xmy9GixJdFnpUP-ppXih1yZXyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 3:39 AM, Alexander Duyck wrote:
> On Mon, Jun 21, 2021 at 10:48 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The page reporting threshold is currently sticky to @pageblock_order.
>> The page reporting can never be triggered because the freeing page
>> can't come up with a free area like that huge. The situation becomes
>> worse when the system memory becomes heavily fragmented.
>>
>> For example, the following configurations are used on ARM64 when 64KB
>> base page size is enabled. In this specific case, the page reporting
>> won't be triggered until the freeing page comes up with a 512MB free
>> area. That's hard to be met, especially when the system memory becomes
>> heavily fragmented.
>>
>>     PAGE_SIZE:          64KB
>>     HPAGE_SIZE:         512MB
>>     pageblock_order:    13       (512MB)
>>     MAX_ORDER:          14
>>
>> This allows the drivers to specify the threshold when the page
>> reporting device is registered. The threshold falls back to
>> @pageblock_order if it's not specified by the driver. The existing
>> users (hv_balloon and virtio_balloon) don't specify the threshold
>> and @pageblock_order is still taken as their page reporting order.
>> So this shouldn't introduce functional changes.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   include/linux/page_reporting.h |  3 +++
>>   mm/page_reporting.c            | 14 ++++++++++----
>>   mm/page_reporting.h            | 10 ++--------
>>   3 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
>> index 3b99e0ec24f2..fe648dfa3a7c 100644
>> --- a/include/linux/page_reporting.h
>> +++ b/include/linux/page_reporting.h
>> @@ -18,6 +18,9 @@ struct page_reporting_dev_info {
>>
>>          /* Current state of page reporting */
>>          atomic_t state;
>> +
>> +       /* Minimal order of page reporting */
>> +       unsigned int order;
>>   };
>>
>>   /* Tear-down and bring-up for page reporting devices */
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index df9c5054e1b4..27670360bae6 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
> 
> <snip>
> 
>> @@ -324,6 +324,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>>                  goto err_out;
>>          }
>>
>> +       /*
>> +        * We need to choose the minimal order of page reporting if it's
>> +        * not specified by the driver.
>> +        */
>> +       prdev->order = prdev->order ? prdev->order : pageblock_order;
>> +
>>          /* initialize state and work structures */
>>          atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
>>          INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
> 
> Rather than using prdev->order directly it might be better to have a
> reporting_order value you could export for use by
> page_reporting_notify_free. That way you avoid the overhead of having
> to make a function call per page freed.
> 

Yes, I obviously missed the point to reduce the overhead because of
function call. In next revision, I will introduce @page_reporting_order
for this. Besides, it will be exported as a module parameter so that
it can be changed dynamically, as David suggested before.

>> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
>> index 2c385dd4ddbd..d9f972e72649 100644
>> --- a/mm/page_reporting.h
>> +++ b/mm/page_reporting.h
>> @@ -10,11 +10,9 @@
>>   #include <linux/pgtable.h>
>>   #include <linux/scatterlist.h>
>>
>> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
>> -
>>   #ifdef CONFIG_PAGE_REPORTING
>>   DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>> -void __page_reporting_notify(void);
>> +void __page_reporting_notify(unsigned int order);
>>
>>   static inline bool page_reported(struct page *page)
>>   {
>> @@ -37,12 +35,8 @@ static inline void page_reporting_notify_free(unsigned int order)
>>          if (!static_branch_unlikely(&page_reporting_enabled))
>>                  return;
>>
>> -       /* Determine if we have crossed reporting threshold */
>> -       if (order < PAGE_REPORTING_MIN_ORDER)
>> -               return;
>> -
>>          /* This will add a few cycles, but should be called infrequently */
>> -       __page_reporting_notify();
>> +       __page_reporting_notify(order);
>>   }
>>   #else /* CONFIG_PAGE_REPORTING */
>>   #define page_reported(_page)   false
> 
> With us making the function call per page freed we are likely to have
> a much more significant impact on performance with page reporting
> enabled. Ideally we want to limit this impact so that we only take the
> cost for the conditional check on the lower order pages.
> 

Yep, thanks for the explanation, Alex.

Thanks,
Gavin

