Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40941ADAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhI1LSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240258AbhI1LSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632827802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9Fw/+zsA3lSTpQmibIL0kcuxCZFnG650L+/dDhTSd0=;
        b=ZchqFIc+bpoVITiukVf7YizxlGt+PY4l7wuUguSQrN72OGMw7W3hglhvwqKua9Wh3rjmRH
        n5IisvnUjevzM7c5ysBB+R57WefaMcU3DLu1FiORqe2P+UWGchicTwCK1eyyhuW9Q7bh4K
        +OIrGFC64+D+k9B/F9SkhrwljNlQSB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-UCCkfeotPA-jmBZwy7RyNQ-1; Tue, 28 Sep 2021 07:16:41 -0400
X-MC-Unique: UCCkfeotPA-jmBZwy7RyNQ-1
Received: by mail-wm1-f71.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso972320wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g9Fw/+zsA3lSTpQmibIL0kcuxCZFnG650L+/dDhTSd0=;
        b=yEq3hjOjWfQigxEp0McM4ko4W8VjLSBTBHqm2ek/nvXAHJI80sQ2y/E2RkA3NqDAuO
         P6CZQA8PcEl8qJ8gWxCS4X4Ix8ESpoDZF9oI0EJCp6bHe36o5AIH/WDkxgl7T7jtJ6KR
         ZhcMYVr4X0pukhesdNbP+gMt5KYRVSYJ7oHNOL2buTC3QnQumIA1HDd5T+RnhxIuvUvw
         CylkwdNbrkxtQzSJP0x8zzMfk1En3y1rWXh/V4VBn2MnfZ7V81J27a2jxFP9sIDwLbGe
         13yELLIEg4VKJv/RvuzIk+xoTXvWO99LGN8NnSIcKOGtSMMAGhSYRY+XL+OWSlinGXVH
         RMyQ==
X-Gm-Message-State: AOAM531N623bON9PWR8sQ9GDJ3v47gSaJUSG7dkjUvNsyvV7IIMccWWo
        d5ip3yHYO7fduwr515Lt30f/EHrb6Y83PD5ALJ/dd/RMiYc8se9z78v4A1RvwdDngGfq2d/dANI
        UquEVlToTvmu+DNdFF+tI52/F
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr4045381wmc.141.1632827799984;
        Tue, 28 Sep 2021 04:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypdRCaBXjp3Oo8Frl+bwCBde3/2kGEgoQygCIPajaTje2x49VvX1uag/OSEf1dohFvvrJGgA==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr4045364wmc.141.1632827799748;
        Tue, 28 Sep 2021 04:16:39 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aaf.dip0.t-ipconnect.de. [79.242.58.175])
        by smtp.gmail.com with ESMTPSA id x5sm2991943wmk.32.2021.09.28.04.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:16:39 -0700 (PDT)
Subject: Re: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
 <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
 <0149edd5-fe7f-2786-413c-6de2eab3e30c@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ab7a9fb0-a3e7-0cb8-6dbd-40a68e6fd299@redhat.com>
Date:   Tue, 28 Sep 2021 13:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0149edd5-fe7f-2786-413c-6de2eab3e30c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.21 12:53, Faiyaz Mohammed wrote:
> 
> 
> On 9/28/2021 4:09 PM, David Hildenbrand wrote:
>> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>>> For INITRD and initmem memory is reserved through "memblock_reserve"
>>> during boot up but it is free via "free_reserved_area" instead
>>> of "memblock_free".
>>> For example:
>>> [    0.294848] Freeing initrd memory: 12K.
>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>
>>> To get the start and end address of the above freed memory and to account
>>> proper memblock added memblock_dbg log in "free_reserved_area".
>>> After adding log:
>>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>>> free_initrd_mem+0x20/0x28
>>> [    0.294848] Freeing initrd memory: 12K.
>>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>>> free_initmem+0x70/0xc8
>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>
>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>> ---
>>>    mm/page_alloc.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index b37435c..f85c3b2 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start,
>>> void *end, int poison, const char
>>>            pr_info("Freeing %s memory: %ldK\n",
>>>                s, pages << (PAGE_SHIFT - 10));
>>>    +#ifdef CONFIG_HAVE_MEMBLOCK
>>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>>> +#endif
>>
>> IMHO, the "memblock_free" part is misleading. Something was allocated
>> early via memblock, then we transitioned to the buddy, now we're freeing
>> that early allocation via the buddy.
>> Yes, we're freeing the early allocation via buddy, but for proper
> memblock accounting we need this debug print.
> 

What do you mean with "accounting" ? These are debug statements.


-- 
Thanks,

David / dhildenb

