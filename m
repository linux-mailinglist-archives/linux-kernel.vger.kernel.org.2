Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351A1401AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhIFLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238449AbhIFLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630929013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXE8dWQl68fSLFYKCn3Z80ZMxW3TXAEFPhGPj75Fg9E=;
        b=DiZJwsYOzDsBY/pT0HZaQIqUBlgWwaLWzlFtgr/W/eUL1GVFT5F1d0iuS5Cl2DLPJgXvHO
        gXxew7myMZth3jbzi/JqkCmBtsf/iHCDFNr7ANfFFNWEtBZ9duR8qQ79itLdz0m38rjBdA
        xeXbEGiFgqk83qNlr5pEMU0NkmRsx08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-rxGhVG62NbaZ1QTjhYr6Rg-1; Mon, 06 Sep 2021 07:50:12 -0400
X-MC-Unique: rxGhVG62NbaZ1QTjhYr6Rg-1
Received: by mail-wm1-f71.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so3131064wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 04:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zXE8dWQl68fSLFYKCn3Z80ZMxW3TXAEFPhGPj75Fg9E=;
        b=Yl4Np3I4tMCQX7vXnbYsa/vtwhMnDZXrAfu5X5wdoYARFoU3qJHQeSpY6BRPWCnDY5
         cLPLCQWV+c2AuDqAUTQVp1VPAbstQDcDD8T4GCGwnqw9TWfBC0orCcEhboVYUY3Jicq2
         jWE/L7ypffZ6TseLqYri79DdiEiQOkpKSZAxI87Bh2uFtG3vAwoGnOi4qpMa+3BEqrIC
         IeNcbIjwcWv0JKJNEvZV4xkAS/056f0+QLTDh8nr4EZQ/OMi41LdEygrO31OdT5h3m+L
         jXkdRQ6HYYsZPFBeQoYwh/N/2KPOgiA2VxLT/HXAXPLtaiy+cLzFSStGb+fx4iqlD24g
         Tswg==
X-Gm-Message-State: AOAM533jnyvdjl0S6tXv47TIBBDX6pysa6ADJ0sopDYqbWn9OGmuz5Ps
        QUoaNxlbXNBrYdRk57ekng0q3HI5jfpDl+X5jhfcNkXBcsjxwDX6qVvme2ZQ3Eim3Kw2zZWiOzH
        gcy9XG+WTkTrfhLPQEjCdn8YXEngbcBQZVOykmGA83u7NN5RDkjXXd4lLIClscrIIT/WpAtVr
X-Received: by 2002:adf:c513:: with SMTP id q19mr13053594wrf.20.1630929011478;
        Mon, 06 Sep 2021 04:50:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgonJlqWQp4Qp86UDMlbso1fC+0d73CbwXDTwyOFY3/SDiXIxxZ4LZ+gKFdzV0MgpLyeS0SA==
X-Received: by 2002:adf:c513:: with SMTP id q19mr13053567wrf.20.1630929011181;
        Mon, 06 Sep 2021 04:50:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id l11sm7891776wrb.15.2021.09.06.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 04:50:10 -0700 (PDT)
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <e060283a-6295-9191-9b92-a3c183e9de02@redhat.com>
 <b533742e-e82a-a721-9a24-4087688dd812@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
Message-ID: <5f7c4ac9-d17a-5af3-0326-1152cca38465@redhat.com>
Date:   Mon, 6 Sep 2021 13:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b533742e-e82a-a721-9a24-4087688dd812@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 13:32, Miaohe Lin wrote:
> On 2021/9/6 17:40, David Hildenbrand wrote:
>> On 04.09.21 11:18, Miaohe Lin wrote:
>>> If __isolate_free_page() failed, due to zone watermark check, the page is
>>> still on the free list. But this page will be put back to free list again
>>> via __putback_isolated_page() now. This may trigger page->flags checks in
>>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>>> because list_add() will be called for pages already on another list.
>>>
>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/page_isolation.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index 9bb562d5d194..7d70d772525c 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>                buddy_pfn = __find_buddy_pfn(pfn, order);
>>>                buddy = page + (buddy_pfn - pfn);
>>>    -            if (!is_migrate_isolate_page(buddy)) {
>>> -                __isolate_free_page(page, order);
>>> -                isolated_page = true;
>>> -            }
>>> +            if (!is_migrate_isolate_page(buddy))
>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>            }
>>>        }
>>>   
>>
>> Shouldn't we much rather force to ignore watermarks here and make sure __isolate_free_page() never fails?
> 
> It seems it is not easy to force to ignore watermarks here. And it's not a problem
> if __isolate_free_page() fails because we can do move_freepages_block() anyway.
> What do you think? Many thanks.

I'm wondering if all this complexity in this function is even required. What about something like this: (completely untested)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bddf788f45bf..29ff2fcb339c 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -66,12 +66,10 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
  
  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
  {
+       bool buddy_merge_possible = false;
         struct zone *zone;
         unsigned long flags, nr_pages;
-       bool isolated_page = false;
         unsigned int order;
-       unsigned long pfn, buddy_pfn;
-       struct page *buddy;
  
         zone = page_zone(page);
         spin_lock_irqsave(&zone->lock, flags);
@@ -79,26 +77,15 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
                 goto out;
  
         /*
-        * Because freepage with more than pageblock_order on isolated
-        * pageblock is restricted to merge due to freepage counting problem,
-        * it is possible that there is free buddy page.
-        * move_freepages_block() doesn't care of merge so we need other
-        * approach in order to merge them. Isolation and free will make
-        * these pages to be merged.
+        * If our free page spans at least this whole pageblock and could
+        * eventually get merged into an even bigger page, go via
+        * __putback_isolated_page(), because move_freepages_block() won't
+        * trigger merging of free pages.
          */
         if (PageBuddy(page)) {
                 order = buddy_order(page);
-               if (order >= pageblock_order && order < MAX_ORDER - 1) {
-                       pfn = page_to_pfn(page);
-                       buddy_pfn = __find_buddy_pfn(pfn, order);
-                       buddy = page + (buddy_pfn - pfn);
-
-                       if (pfn_valid_within(buddy_pfn) &&
-                           !is_migrate_isolate_page(buddy)) {
-                               __isolate_free_page(page, order);
-                               isolated_page = true;
-                       }
-               }
+               if (order >= pageblock_order && order < MAX_ORDER - 1)
+                       buddy_merge_possible = true;
         }
  
         /*
@@ -111,12 +98,12 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
          * onlining - just onlined memory won't immediately be considered for
          * allocation.
          */
-       if (!isolated_page) {
+       if (!buddy_merge_possible) {
                 nr_pages = move_freepages_block(zone, page, migratetype, NULL);
                 __mod_zone_freepage_state(zone, nr_pages, migratetype);
         }
         set_pageblock_migratetype(page, migratetype);
-       if (isolated_page)
+       if (buddy_merge_possible)
                 __putback_isolated_page(page, order, migratetype);
         zone->nr_isolate_pageblock--;
  out:



-- 
Thanks,

David / dhildenb

