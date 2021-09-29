Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5370F41CAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbhI2RFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243396AbhI2RFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632935034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTE5zFleGLnTuyLrFqdFPMU22BAwoJNwUb4warb1Xi4=;
        b=XCmS5QXOna/fo3c3BLu8WIZZAC60SDfXCdspTe1Cy6nJLp0zaYqrFPPy9ewcOOYR/SesJa
        7tu3u9X92YzNotctq5CCEY8jWFjGkzI7IlBCbrMj30LzfsdJOdJSsCv8SB+q8TInSfUjE0
        E6YLGIGmTt0dQeiFIOsfW4oCp0YaFHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-_UBuHAyHOVyAKFnFjKEe0A-1; Wed, 29 Sep 2021 13:03:53 -0400
X-MC-Unique: _UBuHAyHOVyAKFnFjKEe0A-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1514928wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 10:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hTE5zFleGLnTuyLrFqdFPMU22BAwoJNwUb4warb1Xi4=;
        b=zbXT6C8+tuVBF3G9cONPWUt6kV38BiTvaZ58iYSrN64LyY6FGNi4JPEuEcP4e5eesJ
         qu5UZriTIukixQjSTCya1bxu+8/Foplh5h5Dixk5cUMU7i4/ew2TqWAy0P6lCHSbdoir
         buav95/5ixueYbKrW7+jPA4nULJCmEZLFMUmR6Z8UL/QSRn2DKL1WwhN6aSSLIot8r19
         BLkl09UNR2wraXBcysLqVwUdzAlKdS+8Sa0MoH4UyINeI8CXynpweKG3dSlM0ZElzoyO
         FIYUWbHKrLUAjPwSFKgbjQzhCvhUlva+aSmXgt9TvguZrJByUyxs2Ldbk3n6PKeo8zz7
         6itQ==
X-Gm-Message-State: AOAM530OT/yfvYU2JQUhZAXR4lOGedcLvGkXl9PHI3BDsOoJUd2dAkeA
        pRoXI1W1RqTs04NaJz/ksPTLzjkQmMgPEXmWJZfhc9q+PfBXyAUkN+ITF0v4c3POwv82y1VYFhf
        ot1hr4EzHM3zRlHH5YgetNFFR
X-Received: by 2002:a05:600c:3b26:: with SMTP id m38mr1065215wms.176.1632935031977;
        Wed, 29 Sep 2021 10:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFT3c0vb/qzy1G4SkbQIPZPlSnrPV+5jondgwEWp4VtQKpRxeIjZOjfnGgAlQfz4Cp6i/4Yw==
X-Received: by 2002:a05:600c:3b26:: with SMTP id m38mr1065198wms.176.1632935031786;
        Wed, 29 Sep 2021 10:03:51 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id o15sm372589wmc.21.2021.09.29.10.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 10:03:51 -0700 (PDT)
Subject: Re: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
 <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
 <0149edd5-fe7f-2786-413c-6de2eab3e30c@codeaurora.org>
 <ab7a9fb0-a3e7-0cb8-6dbd-40a68e6fd299@redhat.com>
 <1f6708d2-1ca8-6d1f-d9f0-855f2df755ed@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d5a2e107-70e2-30b5-6723-9eea6650517a@redhat.com>
Date:   Wed, 29 Sep 2021 19:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1f6708d2-1ca8-6d1f-d9f0-855f2df755ed@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 10:58, Faiyaz Mohammed wrote:
> 
> 
> On 9/28/2021 4:46 PM, David Hildenbrand wrote:
>> On 28.09.21 12:53, Faiyaz Mohammed wrote:
>>>
>>>
>>> On 9/28/2021 4:09 PM, David Hildenbrand wrote:
>>>> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>>>>> For INITRD and initmem memory is reserved through "memblock_reserve"
>>>>> during boot up but it is free via "free_reserved_area" instead
>>>>> of "memblock_free".
>>>>> For example:
>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>
>>>>> To get the start and end address of the above freed memory and to
>>>>> account
>>>>> proper memblock added memblock_dbg log in "free_reserved_area".
>>>>> After adding log:
>>>>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>>>>> free_initrd_mem+0x20/0x28
>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>>>>> free_initmem+0x70/0xc8
>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>
>>>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>>>> ---
>>>>>     mm/page_alloc.c | 5 +++++
>>>>>     1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index b37435c..f85c3b2 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start,
>>>>> void *end, int poison, const char
>>>>>             pr_info("Freeing %s memory: %ldK\n",
>>>>>                 s, pages << (PAGE_SHIFT - 10));
>>>>>     +#ifdef CONFIG_HAVE_MEMBLOCK
>>>>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>>>>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>>>>> +#endif
>>>>
>>>> IMHO, the "memblock_free" part is misleading. Something was allocated
>>>> early via memblock, then we transitioned to the buddy, now we're freeing
>>>> that early allocation via the buddy.
>>>> Yes, we're freeing the early allocation via buddy, but for proper
>>> memblock accounting we need this debug print.
>>>
>>
>> What do you mean with "accounting" ? These are debug statements.
>>
>>
> Yes, these are debug statements, which help to know the a-b address
> belongs to x callsite. This info is required when memblock=debug is
> passed through command line and CONFIG_HAVE_MEMBLOCK is enabled.

The issue I'm having is talking in the name of memblock "memblock_dbg, 
memblock_free", when memblock might no longer be around. We have other 
places where we free early memblock allocations back to the buddy.

-- 
Thanks,

David / dhildenb

