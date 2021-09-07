Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45B40268A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhIGJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242655AbhIGJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631008375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ec0XhsGsDLFUF6H9oW55TW4umdjrK/glnKsmv1QEvRs=;
        b=htn5Cqe7ROgudBd46POeeek71Wj9gNAyGDrpFaKTb7i7ivHbNuHORosU4o25VaVE+fYD6N
        bDWa58X5lyoCFECPL6akDESvIH/i3OshNEjL0qcpEcU4Zkq+HAZkH1kyrCDBqGAqh4FKZq
        Cw6oHhIJ/58hbY+A4xpo7bL0CxCRD3g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-u8HW0xeoMymg3iKk9FlISw-1; Tue, 07 Sep 2021 05:52:54 -0400
X-MC-Unique: u8HW0xeoMymg3iKk9FlISw-1
Received: by mail-wm1-f70.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso901268wml.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ec0XhsGsDLFUF6H9oW55TW4umdjrK/glnKsmv1QEvRs=;
        b=PUf/IWu/pCxsEBuTjPG3pvaxiGIJTYh3C0rYjyXZcnDwPWxzC5u8muMlcva0GfkDzm
         8a9Xt3BHyipXcJ8Bx/Q7V/44OTAskUwy/fpzgwV6AAzfMxPj94OYN+dw8AUkA/HEIfK2
         BwwT62csBvbIiMFlOyXthpveoy2Y4fdZXL2uW1iYqcSmfxloF0w8U79SDTGWhHm44PgL
         tL1wPv1C+IMD63BhC74P9JqW6Z4JWi/E7Ld/dzRwc4U5qujvcpwLaYJ8l5xkuX2Feykg
         sG2DZL5drTTlYqMKDGfk6AYxaC1EFutf83I9LdLlEkUBtrDxx86n7A1ZMOKolZFHhKUl
         kSFQ==
X-Gm-Message-State: AOAM532/9d0YJTvFTcZuiI4N7pRBj7WbWiMX8k5Zte2Hy6snF/Sdq+U+
        B1MzBmxDUTfpCY9+DA9y/f6wVzAk7GiS2+oPfALOQ47l3MALcrrxuwBFwRe2c8YZfb9GmKXu7Ju
        i8OYNHbiQLl5R5CH9zpu+Ze9guvbLvEH0fzO7bNceGoy3QJ/H11k8bJ9VZoWuWlzgI1zScbkM
X-Received: by 2002:adf:9e05:: with SMTP id u5mr17347361wre.352.1631008373223;
        Tue, 07 Sep 2021 02:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEsD0WB8/viCKGE71XpFE4F5eN/VdHrPSfxW7jC2HliVmfsQMFZ8e3q2V3pyZY4uuUPkmIhA==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr17347337wre.352.1631008372931;
        Tue, 07 Sep 2021 02:52:52 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fca.dip0.t-ipconnect.de. [79.242.63.202])
        by smtp.gmail.com with ESMTPSA id w1sm1894852wmc.19.2021.09.07.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:52:52 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <57392d12-9a6c-dbb5-3c3e-39ed9ab7c31c@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <96b7c46d-8af1-4841-c97e-694abcf3b28b@redhat.com>
Date:   Tue, 7 Sep 2021 11:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <57392d12-9a6c-dbb5-3c3e-39ed9ab7c31c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 03:46, Miaohe Lin wrote:
> On 2021/9/6 20:49, David Hildenbrand wrote:
>> On 06.09.21 14:45, Miaohe Lin wrote:
>>> On 2021/9/6 20:11, David Hildenbrand wrote:
>>>> On 06.09.21 14:02, David Hildenbrand wrote:
>>>>> On 04.09.21 11:18, Miaohe Lin wrote:
>>>>>> If __isolate_free_page() failed, due to zone watermark check, the page is
>>>>>> still on the free list. But this page will be put back to free list again
>>>>>> via __putback_isolated_page() now. This may trigger page->flags checks in
>>>>>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>>>>>> because list_add() will be called for pages already on another list.
>>>>>>
>>>>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>> ---
>>>>>>      mm/page_isolation.c | 6 ++----
>>>>>>      1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>>> index 9bb562d5d194..7d70d772525c 100644
>>>>>> --- a/mm/page_isolation.c
>>>>>> +++ b/mm/page_isolation.c
>>>>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>>>>                  buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>>>                  buddy = page + (buddy_pfn - pfn);
>>>>>>      -            if (!is_migrate_isolate_page(buddy)) {
>>>>>> -                __isolate_free_page(page, order);
>>>>>> -                isolated_page = true;
>>>>>> -            }
>>>>>> +            if (!is_migrate_isolate_page(buddy))
>>>>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>>>>              }
>>>>>>          }
>>>>>>     
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>
>>>>
>>>> To make the confusion perfect (sorry) :D I tripple-checked:
>>>>
>>>> In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.
>>>>
>>>> We call __isolate_free_page() only for such pages.
>>>>
>>>> __isolate_free_page() won't perform watermark checks on is_migrate_isolate().
>>>>
>>>> Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>>>
>>>> If that's correct then we  could instead maybe add a VM_BUG_ON() and a comment why this can't fail.
>>>>
>>>>
>>>> Makes sense or am I missing something?
>>>
>>> I think you're right. __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>> as explained by you. But it might be too fragile to reply on the failure conditions of __isolate_free_page().
>>> If that changes, VM_BUG_ON() here might trigger unexpectedly. Or am I just over-worried as failure conditions
>>> of __isolate_free_page() can hardly change?
>>
>> Maybe
>>
>> isolated_page = !!__isolate_free_page(page, order);
>> /*
>>   * Isolating a free page in an isolated pageblock is expected to always
>>   * work as watermarks don't apply here.
>>   */
>> VM_BUG_ON(isolated_page);
> 
> Should this be VM_BUG_ON(!isolated_page) ?
> 

Ehm, yes :)

-- 
Thanks,

David / dhildenb

