Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2E423D96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhJFMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238326AbhJFMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeW4XUXFrLRRjkI5JwIeK/O8BTLACXNB4vxVnuS9PKM=;
        b=TrXNtAHGgQJTxGUJs/5NIWK5x12LIP3emQwNJjWbd+riqEng/xigB9FNQwHER/nuRA7ICz
        DkzgSzOXbHAdNW2hx6emVsstSZ9X09YZFnoN9N6MQuImKT+Px4f1HEemH2YWtFgk+DuYeS
        kLMMsSRwZbA554k/vDm33rXSXHGwQDk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-eG3g4pNWMDWxHsFjmqMyiQ-1; Wed, 06 Oct 2021 08:18:47 -0400
X-MC-Unique: eG3g4pNWMDWxHsFjmqMyiQ-1
Received: by mail-wr1-f72.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so1099429wrc.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oeW4XUXFrLRRjkI5JwIeK/O8BTLACXNB4vxVnuS9PKM=;
        b=utZxEOP6Hiqe0L5bBioqwXY2INajFwRpCabddtSw1ureee+P/Ez9XhVa+pDclJcJnV
         Eb+D731mn360l2aidQi/66sjYqRv5WDj8cLnTDjc543u8qnKvAqMLIOi0/Oat3MP+8wA
         QDYVAq2Q6dSHhV/VJ9LKojeaZbQcmpktuJM1CHdeAQVwPhnNgD4/mqBnihdSo58FPFB8
         v67l99hUn+DQEZ+oJn1ZrXMgAc69+E3HW6Dqus3BZOZjRLSjXm9M+Q0/SInfzELY5cK7
         z7ZP1twd4fIUVEtKDYVxlXswkLr8u0oA3mhui5+4wBLjA7qH9XIISCY6+QoFmFklubfK
         TlNA==
X-Gm-Message-State: AOAM5315USvjqNkRKENI5O9WO/BOOoQeERjSwyaP66S3CdPTRsFTZuS4
        gBDwWO4bq1+rKC4dRwEYbwqvP9WtQNpTBe8OqLtCnFkjPO1JH7GU8ZYLtv9v1j8+wS9ih9oek87
        OOx8WzDewxSAkuVpai8jO4LG1
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr9428558wmf.124.1633522726797;
        Wed, 06 Oct 2021 05:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxflITgygSizV1S+GboAVyuNdISDFKtTP9efFwWM5U8Gz4Tu3T997UtGlecOp0W0idpvdKhQw==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr9428533wmf.124.1633522726600;
        Wed, 06 Oct 2021 05:18:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id l17sm20842009wrx.24.2021.10.06.05.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 05:18:46 -0700 (PDT)
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
 <d5a2e107-70e2-30b5-6723-9eea6650517a@redhat.com>
 <88df48af-901b-5765-d92c-6d14c2b1f73e@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <aee9523c-4930-7980-e498-00f671b7d336@redhat.com>
Date:   Wed, 6 Oct 2021 14:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <88df48af-901b-5765-d92c-6d14c2b1f73e@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 14:13, Faiyaz Mohammed wrote:
> Hi,
> 
> Sorry for delayed response.
> 
> On 9/29/2021 10:33 PM, David Hildenbrand wrote:
>> On 29.09.21 10:58, Faiyaz Mohammed wrote:
>>>
>>>
>>> On 9/28/2021 4:46 PM, David Hildenbrand wrote:
>>>> On 28.09.21 12:53, Faiyaz Mohammed wrote:
>>>>>
>>>>>
>>>>> On 9/28/2021 4:09 PM, David Hildenbrand wrote:
>>>>>> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>>>>>>> For INITRD and initmem memory is reserved through "memblock_reserve"
>>>>>>> during boot up but it is free via "free_reserved_area" instead
>>>>>>> of "memblock_free".
>>>>>>> For example:
>>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>>
>>>>>>> To get the start and end address of the above freed memory and to
>>>>>>> account
>>>>>>> proper memblock added memblock_dbg log in "free_reserved_area".
>>>>>>> After adding log:
>>>>>>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>>>>>>> free_initrd_mem+0x20/0x28
>>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>>>>>>> free_initmem+0x70/0xc8
>>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>>
>>>>>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>>>>>> ---
>>>>>>>      mm/page_alloc.c | 5 +++++
>>>>>>>      1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>> index b37435c..f85c3b2 100644
>>>>>>> --- a/mm/page_alloc.c
>>>>>>> +++ b/mm/page_alloc.c
>>>>>>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start,
>>>>>>> void *end, int poison, const char
>>>>>>>              pr_info("Freeing %s memory: %ldK\n",
>>>>>>>                  s, pages << (PAGE_SHIFT - 10));
>>>>>>>      +#ifdef CONFIG_HAVE_MEMBLOCK
>>>>>>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>>>>>>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>>>>>>> +#endif
>>>>>>
>>>>>> IMHO, the "memblock_free" part is misleading. Something was allocated
>>>>>> early via memblock, then we transitioned to the buddy, now we're
>>>>>> freeing
>>>>>> that early allocation via the buddy.
>>>>>> Yes, we're freeing the early allocation via buddy, but for proper
>>>>> memblock accounting we need this debug print.
>>>>>
>>>>
>>>> What do you mean with "accounting" ? These are debug statements.
>>>>
>>>>
>>> Yes, these are debug statements, which help to know the a-b address
>>> belongs to x callsite. This info is required when memblock=debug is
>>> passed through command line and CONFIG_HAVE_MEMBLOCK is enabled.
>>
>> The issue I'm having is talking in the name of memblock "memblock_dbg,
>> memblock_free", when memblock might no longer be around. We have other
>> places where we free early memblock allocations back to the buddy.
> I didn't find place where we free early memblock allocation back to the
> buddy.

One example I know is

section_deactivate()->free_map_bootmem()->vmemmap_free()-> ... 
free_pagetable()->free_reserved_page().

when we free the vmemmap allocated via memblock back to the buddy.

> 
> Why "memblock_dbg" print with "memblock_free" string?.
> - After buddy took over, buddy will free memblock reserved memory
> through free_reserved_area and it will print the freed memory size, but
> the freed memory through buddy still be part of memblock.reserved.regions.
> - To know the address ranges, added the "memblock_dbg" print along with
> "membloc_free" string.
> - If it is misleading or confusing, we can remove the "memblock_free"
> string from the "memblock_dgb" print and we can just print the address
> range when "memlock=debug" pass through command line.

That would be better, but do we really have to depend on 
"memlock=debug"? Can't we do pr_debug() ?

-- 
Thanks,

David / dhildenb

