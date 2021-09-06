Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CA401AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbhIFMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239993AbhIFMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630930276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/0cBLFiznJ6Fvq3kXjYhjOOMH40oHjozjc2X00+//g=;
        b=XF1XvtGeuetbO9jdyKjRkDBxQMDfyyabOB9IssYpZuDaXquFT1uNimRM/Mlxc7rzNEDRRJ
        m9h1uI0WBx2pjHT/CP8GeZanZrP7W4zJ4XJAryzHfaV9pau5whECrTMWJFFZHtKeRJqtP1
        yvy49eZ/mTZYXdqpGmpL4kqBYBZXEi8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-OfrozpmQOvCtEVIc55-obg-1; Mon, 06 Sep 2021 08:11:15 -0400
X-MC-Unique: OfrozpmQOvCtEVIc55-obg-1
Received: by mail-wr1-f71.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso1140496wrs.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C/0cBLFiznJ6Fvq3kXjYhjOOMH40oHjozjc2X00+//g=;
        b=WtKzVEGjhFWDU2SnytK10TChytS04KdvgsXZf8ZdJ5Alr+ViII1JK0bUvIbvyvaEJp
         N4su25lgCggaiKGCuzNyrUwMFsENY+SDy8ZxsqIgNcRNIaGHa5mcTxyfEh7zIuTfc8MV
         ZMYpknFAQBFDZtpLaTr70rll1Lmjlgj8m6kiQcsP/AwXt+4lM4S5yiPsLRDQbTnqbozb
         t032x+iQCnQPkiAs57LpFL3iqY1j6AQbsYzmAM2Erp8CbeygQC4V2GXWZD6Hq1X+jAw0
         wztEF7m/4O4hD9NWNUL4fhDk1b0IwD4+m1hwgCA0qEyNgNq5LPZtzD9Jjo/L+EUN6oLX
         TGdQ==
X-Gm-Message-State: AOAM531gcvVPmN5qV4BB+YkVzZiEJsH4dNc/iKZSRnQv/DPwuDLWc1FR
        83lVWezBscc11ksHXEdvNAdc88/LKIA8oa6jjdQweCJ6iNbwWqJ8POY8QLN1zOVQ6OU0woQYQV7
        ACeNyfSeVp6srRYcBk5QZ6jta7b/fNHdDOk4PWERTIBztpiefCTeTxuAw3RukjF9MWCRpzN2V
X-Received: by 2002:a05:600c:898:: with SMTP id l24mr10951987wmp.90.1630930274653;
        Mon, 06 Sep 2021 05:11:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfgI+rbNP4kbdReXP9uYukFckJDkLN9KYAWm+fMHx9wqmCPrtIt37vru3RhAYnpwKpU+3Q1Q==
X-Received: by 2002:a05:600c:898:: with SMTP id l24mr10951958wmp.90.1630930274409;
        Mon, 06 Sep 2021 05:11:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id a10sm7117098wmj.44.2021.09.06.05.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:11:14 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
From:   David Hildenbrand <david@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
Organization: Red Hat
Message-ID: <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
Date:   Mon, 6 Sep 2021 14:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 14:02, David Hildenbrand wrote:
> On 04.09.21 11:18, Miaohe Lin wrote:
>> If __isolate_free_page() failed, due to zone watermark check, the page is
>> still on the free list. But this page will be put back to free list again
>> via __putback_isolated_page() now. This may trigger page->flags checks in
>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>> because list_add() will be called for pages already on another list.
>>
>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>    mm/page_isolation.c | 6 ++----
>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 9bb562d5d194..7d70d772525c 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>    			buddy_pfn = __find_buddy_pfn(pfn, order);
>>    			buddy = page + (buddy_pfn - pfn);
>>    
>> -			if (!is_migrate_isolate_page(buddy)) {
>> -				__isolate_free_page(page, order);
>> -				isolated_page = true;
>> -			}
>> +			if (!is_migrate_isolate_page(buddy))
>> +				isolated_page = !!__isolate_free_page(page, order);
>>    		}
>>    	}
>>    
>>
> 
> Thanks!
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

To make the confusion perfect (sorry) :D I tripple-checked:

In unset_migratetype_isolate() we check that 
is_migrate_isolate_page(page) holds, otherwise we return.

We call __isolate_free_page() only for such pages.

__isolate_free_page() won't perform watermark checks on 
is_migrate_isolate().

Consequently, __isolate_free_page() should never fail when called from 
unset_migratetype_isolate()

If that's correct then we  could instead maybe add a VM_BUG_ON() and a 
comment why this can't fail.


Makes sense or am I missing something?

-- 
Thanks,

David / dhildenb

