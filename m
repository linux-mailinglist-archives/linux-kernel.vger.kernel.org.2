Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94157401B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhIFMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231287AbhIFMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630932576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3lWIrnS4IU6EaVGNxP/JlVlx9dhdVj9Z2t/pFXpVHk=;
        b=cf5z9CB6IIICFd2doa9CCzYH6F92Z9L6ECUhcz+gHpxthxOPFuWREWNhP1IQo7Im9ebFLl
        R89ptvMVYF63dg4Vwfa/DU4gDYHtd16jYJFr22SLb/jECkRvC4BBqJyjcH0cwXb9JS+Nw3
        5s58Fks0dWg/0c+6x7CqrdyRpPBmD1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-neky_jIHOxmWO9shvw-yhQ-1; Mon, 06 Sep 2021 08:49:35 -0400
X-MC-Unique: neky_jIHOxmWO9shvw-yhQ-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so2302287wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w3lWIrnS4IU6EaVGNxP/JlVlx9dhdVj9Z2t/pFXpVHk=;
        b=je9q6cq1faIKa0X9JuZevHimPawTiSmk3eWGfLfeszc9I7gZEHI+7bjovvMXgBl5dR
         Blf+V/cAxpuSdgDuFKTCf8r6xCKvZ4Ka/GNJnFCsfWm7+CcOLkVJcxZdVheIWho3a2+C
         I90D4vvAtGGIg474cBWdB5lGBkbwJ8s3IBnBtNzwuRcVn9LL5ujMih0Feh6/zqqcT0Il
         Nqrjf8TtCk0H+siokxbuw7afs3zLQKYXbwv7LrRw+KuKDDiIEHDcZo/JfyKqViCa2ao/
         KV5xZQfJKQlSLmxKhm83FcdPon5TgMP5SwavXTLo5Zb/dn/bBoRBBdXEma8xpXSJ2DNN
         nXSA==
X-Gm-Message-State: AOAM530fSGTGa6GnoFeg+y3Fj9z6SN36kpqczjxBbEh2wm7pZFh2V2nm
        /OhHvJJpl8xnJ9GzAMjspw7PUVx9F8Mu4KtIqi81bc++VPdHv+Ft6erlwJYqYsucmTXcdkBecug
        jqvsLKMWi5ZI7JgCPBG9muV/RujwVrc9D20voSuFqXairudH/YYj6fJFfRJolpTQ6xsTZVpVG
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr13286969wrs.271.1630932574433;
        Mon, 06 Sep 2021 05:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy99Agc4M6U82V2MdhN4KHKhybZwOeh0IbeY9hb3sX8oXCojEvq6t5Ns3q21bqSzW0/uHvh5g==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr13286940wrs.271.1630932574174;
        Mon, 06 Sep 2021 05:49:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id a133sm7106812wme.5.2021.09.06.05.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:49:33 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
Date:   Mon, 6 Sep 2021 14:49:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 14:45, Miaohe Lin wrote:
> On 2021/9/6 20:11, David Hildenbrand wrote:
>> On 06.09.21 14:02, David Hildenbrand wrote:
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
>>>>     mm/page_isolation.c | 6 ++----
>>>>     1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>> index 9bb562d5d194..7d70d772525c 100644
>>>> --- a/mm/page_isolation.c
>>>> +++ b/mm/page_isolation.c
>>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>                 buddy = page + (buddy_pfn - pfn);
>>>>     -            if (!is_migrate_isolate_page(buddy)) {
>>>> -                __isolate_free_page(page, order);
>>>> -                isolated_page = true;
>>>> -            }
>>>> +            if (!is_migrate_isolate_page(buddy))
>>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>>             }
>>>>         }
>>>>    
>>>
>>> Thanks!
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>
>>
>> To make the confusion perfect (sorry) :D I tripple-checked:
>>
>> In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.
>>
>> We call __isolate_free_page() only for such pages.
>>
>> __isolate_free_page() won't perform watermark checks on is_migrate_isolate().
>>
>> Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>
>> If that's correct then we  could instead maybe add a VM_BUG_ON() and a comment why this can't fail.
>>
>>
>> Makes sense or am I missing something?
> 
> I think you're right. __isolate_free_page() should never fail when called from unset_migratetype_isolate()
> as explained by you. But it might be too fragile to reply on the failure conditions of __isolate_free_page().
> If that changes, VM_BUG_ON() here might trigger unexpectedly. Or am I just over-worried as failure conditions
> of __isolate_free_page() can hardly change?

Maybe

isolated_page = !!__isolate_free_page(page, order);
/*
  * Isolating a free page in an isolated pageblock is expected to always
  * work as watermarks don't apply here.
  */
VM_BUG_ON(isolated_page);


VM_BUG_ON() allows us to detect any issues when testing. Combined with 
the comment it tells everybody messing with __isolate_free_page() what 
we expect in this function.

In production system, we would handle it gracefully.

-- 
Thanks,

David / dhildenb

