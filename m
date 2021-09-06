Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6370401AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbhIFMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241354AbhIFMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630929706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuyGBwVghtHZV0seQC79tTuw8tExgTCVH1JSTwg1MiY=;
        b=cZl3DKbUifzLQ1ReTtYnI1X+wJ4vEpgRp0/kBDRClg/lbguqWwRBp9uISC2X/JKG7+CYtD
        af/z9cije6K8L2QbUiG7oCtPXai80vClnSqACqjZKrGPXZGnI53cw6Dt8GSLNfv0A6ombE
        GBh68W8E5DBi9W8FdXWfFa7CZLBeb5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-rmnQmveHNImYL_JbZt8n_Q-1; Mon, 06 Sep 2021 08:01:45 -0400
X-MC-Unique: rmnQmveHNImYL_JbZt8n_Q-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020a5d42cf000000b001565f9c9ee8so1147916wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BuyGBwVghtHZV0seQC79tTuw8tExgTCVH1JSTwg1MiY=;
        b=ugNmQ+8eXLIILEgnkGFIufMlaGH7rS5MnvczafcNG9gLUj1fagh4G0rOHCYuQpwTDT
         VIRDk/tWssMA6EuF+I0ozXkMEqjSlCM1OYCAZ5YbnsC99a5w4t1rUOhk1L814bH7lgwF
         4LL+AGIWHsmUiR6gqOx5ScJZmB0dS1hfj9AAco0HfdcEBMlACKjyL73YlOdKI/dxvAX6
         3HOPMJuNmNhDfYeTyAmW23KAcdDNBDMUfzajq19kaz5lB3+KMqI6pBvrQxTqMm1mt35U
         TUY08i5bhapWhQ8PfP0bU962si9qHmEyKmor4kxMROHIaW9CNulK11+RmXZ/E3GJ8Pid
         u2UQ==
X-Gm-Message-State: AOAM531SQPTZqahTik53zZQesNkSHzSp9AZPMaQXlFPaVRiJ7S0oXzJP
        wn7UqCEvVbzjGEwX0yblHW9ScapiBPbXkyAZRaeCmahKu3xlssX3Kzgq4rilpOMy7P6wk+DvXqH
        QEu2zIMuIGUhI1JkcovRa6rnXlW1cRwbMqpDkIevi8quW+GNMhjTAT8XxEdPNDJQK7exn0t9o
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr11141440wme.67.1630929704216;
        Mon, 06 Sep 2021 05:01:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3azGe78Ig10C/NTLF77N0FWpuI3FxG9bOS6v/kbRj8pHvaNRahGdtoEQ9fb1yPtZI8kJJPw==
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr11141404wme.67.1630929703915;
        Mon, 06 Sep 2021 05:01:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id l26sm7054854wmi.13.2021.09.06.05.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:01:43 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
From:   David Hildenbrand <david@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <e060283a-6295-9191-9b92-a3c183e9de02@redhat.com>
 <b533742e-e82a-a721-9a24-4087688dd812@huawei.com>
 <5f7c4ac9-d17a-5af3-0326-1152cca38465@redhat.com>
Organization: Red Hat
Message-ID: <2b103abc-2921-9d8a-7280-1d6b451c34f4@redhat.com>
Date:   Mon, 6 Sep 2021 14:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5f7c4ac9-d17a-5af3-0326-1152cca38465@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 13:50, David Hildenbrand wrote:
> On 06.09.21 13:32, Miaohe Lin wrote:
>> On 2021/9/6 17:40, David Hildenbrand wrote:
>>> On 04.09.21 11:18, Miaohe Lin wrote:
>>>> If __isolate_free_page() failed, due to zone watermark check, the page is
>>>> still on the free list. But this page will be put back to free list again
>>>> via __putback_isolated_page() now. This may trigger page->flags checks in
>>>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>>>> because list_add() will be called for pages already on another list.
>>>>
>>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>     mm/page_isolation.c | 6 ++----
>>>>     1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>> index 9bb562d5d194..7d70d772525c 100644
>>>> --- a/mm/page_isolation.c
>>>> +++ b/mm/page_isolation.c
>>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>                 buddy = page + (buddy_pfn - pfn);
>>>>     -            if (!is_migrate_isolate_page(buddy)) {
>>>> -                __isolate_free_page(page, order);
>>>> -                isolated_page = true;
>>>> -            }
>>>> +            if (!is_migrate_isolate_page(buddy))
>>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>>             }
>>>>         }
>>>>    
>>>
>>> Shouldn't we much rather force to ignore watermarks here and make sure __isolate_free_page() never fails?
>>
>> It seems it is not easy to force to ignore watermarks here. And it's not a problem
>> if __isolate_free_page() fails because we can do move_freepages_block() anyway.
>> What do you think? Many thanks.
> 
> I'm wondering if all this complexity in this function is even required. What about something like this: (completely untested)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index bddf788f45bf..29ff2fcb339c 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -66,12 +66,10 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>    
>    static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>    {
> +       bool buddy_merge_possible = false;
>           struct zone *zone;
>           unsigned long flags, nr_pages;
> -       bool isolated_page = false;
>           unsigned int order;
> -       unsigned long pfn, buddy_pfn;
> -       struct page *buddy;
>    
>           zone = page_zone(page);
>           spin_lock_irqsave(&zone->lock, flags);
> @@ -79,26 +77,15 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>                   goto out;
>    
>           /*
> -        * Because freepage with more than pageblock_order on isolated
> -        * pageblock is restricted to merge due to freepage counting problem,
> -        * it is possible that there is free buddy page.
> -        * move_freepages_block() doesn't care of merge so we need other
> -        * approach in order to merge them. Isolation and free will make
> -        * these pages to be merged.
> +        * If our free page spans at least this whole pageblock and could
> +        * eventually get merged into an even bigger page, go via
> +        * __putback_isolated_page(), because move_freepages_block() won't
> +        * trigger merging of free pages.
>            */
>           if (PageBuddy(page)) {
>                   order = buddy_order(page);
> -               if (order >= pageblock_order && order < MAX_ORDER - 1) {
> -                       pfn = page_to_pfn(page);
> -                       buddy_pfn = __find_buddy_pfn(pfn, order);
> -                       buddy = page + (buddy_pfn - pfn);
> -
> -                       if (pfn_valid_within(buddy_pfn) &&
> -                           !is_migrate_isolate_page(buddy)) {
> -                               __isolate_free_page(page, order);
> -                               isolated_page = true;
> -                       }
> -               }
> +               if (order >= pageblock_order && order < MAX_ORDER - 1)
> +                       buddy_merge_possible = true;
>           }
>    
>           /*
> @@ -111,12 +98,12 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>            * onlining - just onlined memory won't immediately be considered for
>            * allocation.
>            */
> -       if (!isolated_page) {
> +       if (!buddy_merge_possible) {
>                   nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>                   __mod_zone_freepage_state(zone, nr_pages, migratetype);
>           }
>           set_pageblock_migratetype(page, migratetype);
> -       if (isolated_page)
> +       if (buddy_merge_possible)
>                   __putback_isolated_page(page, order, migratetype);
>           zone->nr_isolate_pageblock--;
>    out:

Okay, I just had another look -- that won't work because as you 
correctly said, it still is on the freelist ...

So your fix is certainly correct :)

-- 
Thanks,

David / dhildenb

