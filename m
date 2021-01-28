Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50463073FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA1KpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhA1KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611830628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dw9zDJQiGZ1YCHqJQvqME8NDU//TGGhOg7spnlegjY8=;
        b=FvOjFMYGBZfcMslsofEmhkmwQD5XKIr+IsODsBkxRoEqDzu2Cytu31oIvqohl7JGhvsRHY
        8qP30jhtG6uOtJmUzCBxwi+Rd7JAIuchvvhgtDtXEF5+TDkk8aOIWYHGL5AKWl1fC+pJ8b
        NrBMUFEzX9YbFTig8Yq2ajPs6tS3FLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-nbLBKEOSNeaDEXhqLmPqwg-1; Thu, 28 Jan 2021 05:43:46 -0500
X-MC-Unique: nbLBKEOSNeaDEXhqLmPqwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BED2107ACE4;
        Thu, 28 Jan 2021 10:43:44 +0000 (UTC)
Received: from [10.36.113.207] (ovpn-113-207.ams2.redhat.com [10.36.113.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A21E27D54A;
        Thu, 28 Jan 2021 10:43:42 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 2/2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
Message-ID: <2246d657-4f6d-c27d-4ae2-853a8437cda9@redhat.com>
Date:   Thu, 28 Jan 2021 11:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210128102234.GB5250@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.21 11:22, Oscar Salvador wrote:
> On Wed, Jan 27, 2021 at 11:18:13AM +0100, David Hildenbrand wrote:
>> Let's count the number of CMA pages per zone and print them in
>> /proc/zoneinfo.
>>
>> Having access to the total number of CMA pages per zone is helpful for
>> debugging purposes to know where exactly the CMA pages ended up, and to
>> figure out how many pages of a zone might behave differently (e.g., like
>> ZONE_MOVABLE) - even after some of these pages might already have been
>> allocated.
> 
> My knowledge of CMA tends to be quite low, actually I though that CMA
> was somehow tied to ZONE_MOVABLE.

CMA is often placed into one of the kernel zones, but can also end up in the movable zone.

> 
> I see how tracking CMA pages per zona might give you a clue, but what do
> you mean by "might behave differently - even after some of these pages might
> already have been allocated"

Assume you have 4GB in ZONE_NORMAL but 1GB is assigned for CMA. You actually only have 3GB available for random kernel allocations, not 4GB.

Currently, you can only observe the free CMA pages, excluding any pages that are already allocated. Having that information how many CMA pages we have can be helpful - similar to what we already have in /proc/meminfo.

> 
>> For now, we are only able to get the global nr+free cma pages from
>> /proc/meminfo and the free cma pages per zone from /proc/zoneinfo.
>>
>> Note: Track/print that information even without CONFIG_CMA, similar to
>> "nr_free_cma" in /proc/zoneinfo. This is different to /proc/meminfo -
>> maybe we want to make that consistent in the future (however, changing
>> /proc/zoneinfo output might uglify the code a bit).
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/mmzone.h | 4 ++++
>>   mm/page_alloc.c        | 1 +
>>   mm/vmstat.c            | 6 ++++--
>>   3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index ae588b2f87ef..3bc18c9976fd 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -503,6 +503,9 @@ struct zone {
>>   	 * bootmem allocator):
>>   	 *	managed_pages = present_pages - reserved_pages;
>>   	 *
>> +	 * cma pages is present pages that are assigned for CMA use
>> +	 * (MIGRATE_CMA).
>> +	 *
>>   	 * So present_pages may be used by memory hotplug or memory power
>>   	 * management logic to figure out unmanaged pages by checking
>>   	 * (present_pages - managed_pages). And managed_pages should be used
>> @@ -527,6 +530,7 @@ struct zone {
>>   	atomic_long_t		managed_pages;
>>   	unsigned long		spanned_pages;
>>   	unsigned long		present_pages;
>> +	unsigned long		cma_pages;
> 
> I see that NR_FREE_CMA_PAGES is there even without CONFIG_CMA, as you
> said, but I am not sure about adding size to a zone unconditionally.
> I mean, it is not terrible as IIRC, the maximum MAX_NUMNODES can get
> is 1024, and on x86_64 that would be (1024 * 4 zones) * 8 = 32K.
> So not a big deal, but still.

I'm asking myself how many such systems will run without
CONFIG_CMA in the future.

> 
> Besides following NR_FREE_CMA_PAGES, is there any reason for not doing:
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1e22d96734e0..2d8a830d168d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -436,6 +436,9 @@ struct zone {
>          unsigned long           managed_pages;
>          unsigned long           spanned_pages;
>          unsigned long           present_pages;
> +#ifdef CONFIG_CMA
> +       unsigned long           cma_pages;
> +#endif
>   
>          const char              *name;
>   
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8ba0870ecddd..5757df4bfd45 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1559,13 +1559,15 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>                     "\n        spanned  %lu"
>                     "\n        present  %lu"
>                     "\n        managed  %lu",
> +                  "\n        cma      %lu",
>                     zone_page_state(zone, NR_FREE_PAGES),
>                     min_wmark_pages(zone),
>                     low_wmark_pages(zone),
>                     high_wmark_pages(zone),
>                     zone->spanned_pages,
>                     zone->present_pages,
> -                  zone->managed_pages);
> +                  zone->managed_pages,
> +                  IS_ENABLED(CONFIG_CMA) ? zone->cma_pages : 0);
>   
>          seq_printf(m,
>                     "\n        protection: (%ld",
> 
> 
> I do not see it that ugly, but just my taste.

IIRC, that does not work. The compiler will still complain
about a missing struct members. We would have to provide a
zone_cma_pages() helper with some ifdefery.



We could do something like this on top

--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -530,7 +530,9 @@ struct zone {
         atomic_long_t           managed_pages;
         unsigned long           spanned_pages;
         unsigned long           present_pages;
+#ifdef CONFIG_CMA
         unsigned long           cma_pages;
+#endif
  
         const char              *name;
  
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 97fc32a53320..b753a64f099f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1643,7 +1643,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
                    "\n        spanned  %lu"
                    "\n        present  %lu"
                    "\n        managed  %lu"
-                  "\n        cma      %lu",
+#ifdef CONFIG_CMA
+                  "\n        cma      %lu"
+#endif
+                  "%s",
                    zone_page_state(zone, NR_FREE_PAGES),
                    min_wmark_pages(zone),
                    low_wmark_pages(zone),
@@ -1651,7 +1654,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
                    zone->spanned_pages,
                    zone->present_pages,
                    zone_managed_pages(zone),
-                  zone->cma_pages);
+#ifdef CONFIG_CMA
+                  zone->cma_pages,
+#endif
+                  "");
  
         seq_printf(m,
                    "\n        protection: (%ld",


Getting rid of NR_FREE_CMA_PAGES will be more ugly.

-- 
Thanks,

David / dhildenb

