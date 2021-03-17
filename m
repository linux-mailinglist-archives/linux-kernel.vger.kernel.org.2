Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D634333EE13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCQKHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhCQKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615975629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBMbUNIL98a6Erxza7a1VwzaHzsaqEpqBfx8X+isFi8=;
        b=Vu8fyBnRYxWYy67NZJ83izLpzEifCQFHHe5JPHiR2oA52UnkLU/ND6svRY1ZL2uhKJlwmC
        W94qnvxClBR++b5u/9tPs8lRsQwL0sPUf3BXYdse6xWuIzeVINgIZudZ+gpxVMA4/EOK6H
        TdQu1+kgmb69o8B3VDEB3EZBmf0vjfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-f9D6mGemPYiZyWIa5S9XFw-1; Wed, 17 Mar 2021 06:07:05 -0400
X-MC-Unique: f9D6mGemPYiZyWIa5S9XFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C358D1084C97;
        Wed, 17 Mar 2021 10:07:03 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6249419703;
        Wed, 17 Mar 2021 10:07:01 +0000 (UTC)
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
 <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
 <01d2ee6a-f0aa-4580-b1f4-f0e8a2ded4f8@redhat.com>
 <20210317100518.GA16479@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d2ab8528-e2c5-b876-7ca0-03faa86fba25@redhat.com>
Date:   Wed, 17 Mar 2021 11:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317100518.GA16479@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 11:05, Oscar Salvador wrote:
> On Wed, Mar 17, 2021 at 10:48:31AM +0100, David Hildenbrand wrote:
>>> I was preparing v5, and I wanted to be sure I understood you here.
>>>
>>> Right you are that the in-use page check can be dropped, as those pages
>>> can
>>> be migrated away, and the Hugetlb page check can also be dropped since
>>> isolate_migratepages_range is now capable of dealing with those kind of
>>> pages.
>>>
>>>> b) Similarly, check for gigantic pages and/or movability/migratability.
>>>
>>> I lost you here.
>>>
>>> isolate_or_dissolve_huge_page() already bails out on hugetlb-gigantic
>>> pages.
>>>
>>> Or do you mean to place an upfront check here? (hstate_is_gigantic())?
>>
>> Yes. But I prefer a) and keeping it simple here -- just doing basic sanity
>> checks (online, zone, PageReserved()) that are absolutely necessary.
> 
> Ok, I am probably dense as I understood as if you were lean towards having
> a) + b).

Sorry, I meant either a) or b) :)

> 
> That is what I have as the last patch of the patchset:
> 
>  From e97175b7d4970cbdcbafcf8c398f72a571e817b0 Mon Sep 17 00:00:00 2001
> From: Oscar Salvador <osalvador@suse.de>
> Date: Thu, 18 Mar 2021 05:03:18 +0100
> Subject: [PATCH] mm,page_alloc: Drop unnecesary checks from
>   pfn_range_valid_contig
> 
> pfn_range_valid_contig() bails out when it finds an in-use page or a
> hugetlb page, among other things.
> We can drop the in-use page check since __alloc_contig_pages can migrate
> away those pages, and the hugetlb page check can go too since
> isolate_migratepages_range is now capable of dealing with hugetlb pages.
> 

Might want to mention that the existing checks were racy either way :)

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/page_alloc.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4cb455355f6d..50d73e68b79e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8685,12 +8685,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> 
>                  if (PageReserved(page))
>                          return false;
> -
> -               if (page_count(page) > 0)
> -                       return false;
> -
> -               if (PageHuge(page))
> -                       return false;
>          }
>          return true;
>   }
> 


-- 
Thanks,

David / dhildenb

