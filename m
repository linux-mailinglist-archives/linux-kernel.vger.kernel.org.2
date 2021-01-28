Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93EA307799
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhA1ODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhA1ODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611842513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbXYp+G2hIc1hJPA+EOCFA3CI2N+wB/voZbfXFSnlvA=;
        b=SbwShjCNARPInuvA2+ldEG9SxVUQz8QS73q9GWr520ZN/x3P+9yR5a9HpJTpUrM7e/S5zQ
        iL3wA76hWvZc/PJSTjQzNF7hYOZR9HIolzwfUzQveaD1lkWa85FEugT79Ti0CN6ISVDGhM
        aCPaIL19ktsSp7B37dVPSMrxntVouAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-j3bcSDrHN7mgzQimo5NYmg-1; Thu, 28 Jan 2021 09:01:51 -0500
X-MC-Unique: j3bcSDrHN7mgzQimo5NYmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71ACD1005313;
        Thu, 28 Jan 2021 14:01:49 +0000 (UTC)
Received: from [10.36.113.207] (ovpn-113-207.ams2.redhat.com [10.36.113.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D0ED5C1BB;
        Thu, 28 Jan 2021 14:01:47 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-3-david@redhat.com>
 <20210128102234.GB5250@localhost.localdomain>
 <2246d657-4f6d-c27d-4ae2-853a8437cda9@redhat.com>
 <20210128134458.GA8136@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b423f7a4-ac2b-c325-8f5d-51fbcb733da5@redhat.com>
Date:   Thu, 28 Jan 2021 15:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210128134458.GA8136@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.21 14:44, Oscar Salvador wrote:
> On Thu, Jan 28, 2021 at 11:43:41AM +0100, David Hildenbrand wrote:
>>> My knowledge of CMA tends to be quite low, actually I though that CMA
>>> was somehow tied to ZONE_MOVABLE.
>>
>> CMA is often placed into one of the kernel zones, but can also end up in the movable zone.
> 
> Ok good to know.
> 
>>> I see how tracking CMA pages per zona might give you a clue, but what do
>>> you mean by "might behave differently - even after some of these pages might
>>> already have been allocated"
>>
>> Assume you have 4GB in ZONE_NORMAL but 1GB is assigned for CMA. You actually only have 3GB available for random kernel allocations, not 4GB.
>>
>> Currently, you can only observe the free CMA pages, excluding any pages that are already allocated. Having that information how many CMA pages we have can be helpful - similar to what we already have in /proc/meminfo.
> 
> I see, I agree that it can provide some guidance.
> 
>>> I see that NR_FREE_CMA_PAGES is there even without CONFIG_CMA, as you
>>> said, but I am not sure about adding size to a zone unconditionally.
>>> I mean, it is not terrible as IIRC, the maximum MAX_NUMNODES can get
>>> is 1024, and on x86_64 that would be (1024 * 4 zones) * 8 = 32K.
>>> So not a big deal, but still.
>>
>> I'm asking myself how many such systems will run without
>> CONFIG_CMA in the future.
> 
> I am not sure, my comment was just to point out that even the added size might
> not be that large, hiding it under CONFIG_CMA seemed the right thing to
> do.
> 
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 8ba0870ecddd..5757df4bfd45 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1559,13 +1559,15 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>>>                      "\n        spanned  %lu"
>>>                      "\n        present  %lu"
>>>                      "\n        managed  %lu",
>>> +                  "\n        cma      %lu",
>>>                      zone_page_state(zone, NR_FREE_PAGES),
>>>                      min_wmark_pages(zone),
>>>                      low_wmark_pages(zone),
>>>                      high_wmark_pages(zone),
>>>                      zone->spanned_pages,
>>>                      zone->present_pages,
>>> -                  zone->managed_pages);
>>> +                  zone->managed_pages,
>>> +                  IS_ENABLED(CONFIG_CMA) ? zone->cma_pages : 0);
>>>           seq_printf(m,
>>>                      "\n        protection: (%ld",
>>>
>>>
>>> I do not see it that ugly, but just my taste.
>>
>> IIRC, that does not work. The compiler will still complain
>> about a missing struct members. We would have to provide a
>> zone_cma_pages() helper with some ifdefery.
> 
> Of course, it seems I switched off my brain.
> 
>> We could do something like this on top
>>
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -530,7 +530,9 @@ struct zone {
>>          atomic_long_t           managed_pages;
>>          unsigned long           spanned_pages;
>>          unsigned long           present_pages;
>> +#ifdef CONFIG_CMA
>>          unsigned long           cma_pages;
>> +#endif
>>          const char              *name;
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 97fc32a53320..b753a64f099f 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1643,7 +1643,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>>                     "\n        spanned  %lu"
>>                     "\n        present  %lu"
>>                     "\n        managed  %lu"
>> -                  "\n        cma      %lu",
>> +#ifdef CONFIG_CMA
>> +                  "\n        cma      %lu"
>> +#endif
>> +                  "%s",
>>                     zone_page_state(zone, NR_FREE_PAGES),
>>                     min_wmark_pages(zone),
>>                     low_wmark_pages(zone),
>> @@ -1651,7 +1654,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>>                     zone->spanned_pages,
>>                     zone->present_pages,
>>                     zone_managed_pages(zone),
>> -                  zone->cma_pages);
>> +#ifdef CONFIG_CMA
>> +                  zone->cma_pages,
>> +#endif
>> +                  "");
>>          seq_printf(m,
>>                     "\n        protection: (%ld",
> 
> Looks good to me, but I can see how those #ifdef can raise some
> eyebrows.

We could print it further above to avoid the "%s" ... "", or print it 
separately below. Then we'd only need a single ifdef. Might make sense

> Let us see what other thinks as well.
> 
> Btw, should linux-uapi be CCed, as /proc/vmstat layout will change?

Is there a linux-uapi@ list? I know linux-api@ ("forum to discuss 
changes that affect the Linux programming interface (API or ABI)".

Good question, I can certainly cc linux-api@, although I doubt it's 
strictly necessary when adding something here.

Thanks!

-- 
Thanks,

David / dhildenb

