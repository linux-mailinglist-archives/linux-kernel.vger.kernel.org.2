Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24CD3B3AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFYCBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhFYCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624586328;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9xrjA2neFZYkOY/YN2ReKWB6xiN3ijuRxghJAKKGpI=;
        b=BdmNC4A+GQbVek05geBVCK7n8HIB7PQcvuDHxgHi9niboYCjqD/ZR/rQIYgwHnSe303BQI
        6HoRQ6MfIrXxKMhvkJczU6PiJJmCWr1xKZMyiZHbGKS/+LOFbk5lgiiHVrWIPhF92OyjtO
        f9V+nEYBWaTADIrXjN09NQo3BCGTO0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-XIyPpu8-PeK_5YA8FCE_Lg-1; Thu, 24 Jun 2021 21:58:44 -0400
X-MC-Unique: XIyPpu8-PeK_5YA8FCE_Lg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11BD219057A5;
        Fri, 25 Jun 2021 01:58:43 +0000 (UTC)
Received: from [10.64.54.70] (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB605D6AB;
        Fri, 25 Jun 2021 01:58:39 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_reporting: Allow driver to specify
 reporting order
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-4-gshan@redhat.com>
 <CAKgT0UebcvDrkL8J=oZAt-N2Lg3AG0vfekw6Lknmiho00vam4g@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <ad137ea5-9fb7-d543-f841-e54dafd805b5@redhat.com>
Date:   Fri, 25 Jun 2021 14:00:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UebcvDrkL8J=oZAt-N2Lg3AG0vfekw6Lknmiho00vam4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 11:19 AM, Alexander Duyck wrote:
> On Thu, Jun 24, 2021 at 4:46 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The page reporting order (threshold) is sticky to @pageblock_order
>> by default. The page reporting can never be triggered because the
>> freeing page can't come up with a free area like that huge. The
>> situation becomes worse when the system memory becomes heavily
>> fragmented.
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
>> This allows the drivers to specify the page reporting order when the
>> page reporting device is registered. It falls back to @pageblock_order
>> if it's not specified by the driver. The existing users (hv_balloon
>> and virtio_balloon) don't specify it and @pageblock_order is still
>> taken as their page reporting order. So this shouldn't introduce any
>> functional changes.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>> ---
>>   include/linux/page_reporting.h | 3 +++
>>   mm/page_reporting.c            | 6 ++++++
>>   2 files changed, 9 insertions(+)
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
>> index 34bf4d26c2c4..382958eef8a9 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -329,6 +329,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>>                  goto err_out;
>>          }
>>
>> +       /*
>> +        * Update the page reporting order if it's specified by driver.
>> +        * Otherwise, it falls back to @pageblock_order.
>> +        */
>> +       page_reporting_order = prdev->order ? : pageblock_order;
>> +
> 
> An alternative to this would be to look at setting up some
> comparisons. I might add another variable and do something like:
> order = prdev->order ? : pageblock_order;
> if (order < page_reporting_order)
>      page_reporting_order = order;
> 
> You could essentially do something similar in the previous patch but
> just use pageblock_order directly rather than having to add a local
> variable.
> 
> That way if you need to still pull down the page reporting order you
> can do so without prdev->order or pageblock_order overwriting the
> value and pushing it back up.
> 

Thanks, Alex. Lets do both in v5, which will be posted shortly.

Thanks,
Gavin

