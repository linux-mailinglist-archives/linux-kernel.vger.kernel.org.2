Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450153B3AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhFYB75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232933AbhFYB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624586254;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJNYehYQCtO8YDW37Sjtn9L+6gPkmZnTc6gkgATiy7A=;
        b=FwYuxm3cXuso3BmGVoEud2mY5WB2wl92yNFNL9KjEdlM3I3u9HcFeXSVk6YT5w2c5XtY56
        W/uXjfagk/y1TbNKvYa/4S/GxFhdE/6I7X9R8Uj5GBD0HTA6glPRECW4tlU5Lu//7mjOQR
        5biDA53yCpj+jGLTfkhG1BkvMprBLis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-9pqjGF28NtqQRkJbB8oetA-1; Thu, 24 Jun 2021 21:57:33 -0400
X-MC-Unique: 9pqjGF28NtqQRkJbB8oetA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC3B100CAB1;
        Fri, 25 Jun 2021 01:57:30 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56DBB822F6;
        Fri, 25 Jun 2021 01:57:25 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 2/4] mm/page_reporting: Export reporting order as
 module parameter
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-3-gshan@redhat.com>
 <CAKgT0UeM4nCAWUFfSrvy54X5JrY6uoULkbrVcazFMT6aOk6J8w@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d1c27b5f-2e07-e69a-4c7c-adad2511b86f@redhat.com>
Date:   Fri, 25 Jun 2021 13:58:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeM4nCAWUFfSrvy54X5JrY6uoULkbrVcazFMT6aOk6J8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 11:14 AM, Alexander Duyck wrote:
> On Thu, Jun 24, 2021 at 4:46 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The macro PAGE_REPORTING_MIN_ORDER is defined as the page reporting
>> threshold. It can't be adjusted at runtime.
>>
>> This introduces a variable (@page_reporting_order) to replace the
>> marcro (PAGE_REPORTING_MIN_ORDER). MAX_ORDER is assigned to it initially,
>> meaning the page reporting is disabled. It will be specified by driver
>> if valid one is provided. Otherwise, it will fall back to @pageblock_order.
>> It's also exported so that the page reporting order can be adjusted at
>> runtime.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> 
> So this patch looks like it is technically broken. We need a line in
> page_reporting_register that will overwrite the value with
> pageblock_order if it is less than page_reporting_order.
> 

Yes, but it's not broken after next (PATCH[3/4]) is applied.
However, It's still worthy to be fixed, to be "git bisect"
friendly. I'll update in v5.

Thanks,
Gavin

>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>   mm/page_reporting.c                             | 9 +++++++--
>>   mm/page_reporting.h                             | 5 ++---
>>   3 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index cb89dbdedc46..566c4b9af3cd 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3566,6 +3566,12 @@
>>                          off: turn off poisoning (default)
>>                          on: turn on poisoning
>>
>> +       page_reporting.page_reporting_order=
>> +                       [KNL] Minimal page reporting order
>> +                       Format: <integer>
>> +                       Adjust the minimal page reporting order. The page
>> +                       reporting is disabled when it exceeds (MAX_ORDER-1).
>> +
>>          panic=          [KNL] Kernel behaviour on panic: delay <timeout>
>>                          timeout > 0: seconds before rebooting
>>                          timeout = 0: wait forever
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index df9c5054e1b4..34bf4d26c2c4 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -4,12 +4,17 @@
>>   #include <linux/page_reporting.h>
>>   #include <linux/gfp.h>
>>   #include <linux/export.h>
>> +#include <linux/module.h>
>>   #include <linux/delay.h>
>>   #include <linux/scatterlist.h>
>>
>>   #include "page_reporting.h"
>>   #include "internal.h"
>>
>> +unsigned int page_reporting_order = MAX_ORDER;
>> +module_param(page_reporting_order, uint, 0644);
>> +MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
>> +
>>   #define PAGE_REPORTING_DELAY   (2 * HZ)
>>   static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>>
>> @@ -229,7 +234,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>>
>>          /* Generate minimum watermark to be able to guarantee progress */
>>          watermark = low_wmark_pages(zone) +
>> -                   (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
>> +                   (PAGE_REPORTING_CAPACITY << page_reporting_order);
>>
>>          /*
>>           * Cancel request if insufficient free memory or if we failed
>> @@ -239,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>>                  return err;
>>
>>          /* Process each free list starting from lowest order/mt */
>> -       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
>> +       for (order = page_reporting_order; order < MAX_ORDER; order++) {
>>                  for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>>                          /* We do not pull pages from the isolate free list */
>>                          if (is_migrate_isolate(mt))
>> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
>> index 2c385dd4ddbd..c51dbc228b94 100644
>> --- a/mm/page_reporting.h
>> +++ b/mm/page_reporting.h
>> @@ -10,10 +10,9 @@
>>   #include <linux/pgtable.h>
>>   #include <linux/scatterlist.h>
>>
>> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
>> -
>>   #ifdef CONFIG_PAGE_REPORTING
>>   DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>> +extern unsigned int page_reporting_order;
>>   void __page_reporting_notify(void);
>>
>>   static inline bool page_reported(struct page *page)
>> @@ -38,7 +37,7 @@ static inline void page_reporting_notify_free(unsigned int order)
>>                  return;
>>
>>          /* Determine if we have crossed reporting threshold */
>> -       if (order < PAGE_REPORTING_MIN_ORDER)
>> +       if (order < page_reporting_order)
>>                  return;
>>
>>          /* This will add a few cycles, but should be called infrequently */
>> --
>> 2.23.0
>>
> 

