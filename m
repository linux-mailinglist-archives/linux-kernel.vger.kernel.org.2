Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE834E38B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhC3IxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhC3Iwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617094367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpI+VCeNJT/ookoDx9elc7YUBCm5rqIvOw+8bExHEfQ=;
        b=IJEc+PTVi/zPxcU41Y/QDnyNeHCyiW8yU1m9r5R0iyD0wZ8F44UHOC5A+HzTZLeZE3uYQG
        1E/b2W724XD2BS4j0ykI3nuk9dSoxbduZMiCNy6oMW1+LNN8/W4uIQZmKySAftXMvJuZis
        GgAnY5siezPWSX+EraWLZ9Wj7wBesgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Z2yoihf0OueiN9p0CR_1ag-1; Tue, 30 Mar 2021 04:52:42 -0400
X-MC-Unique: Z2yoihf0OueiN9p0CR_1ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F6DF81744F;
        Tue, 30 Mar 2021 08:52:41 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9DE7607CB;
        Tue, 30 Mar 2021 08:52:38 +0000 (UTC)
To:     Hyunsoon Kim <h10.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dseok.yi@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
 <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
 <61a2df08-2681-34fc-3407-921993c8a1f5@redhat.com>
 <20210330014439.GA53009@ubuntu>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on
 alloc
Message-ID: <928f43b1-54ab-e4e4-20f4-b7bd662eb4b1@redhat.com>
Date:   Tue, 30 Mar 2021 10:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330014439.GA53009@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.21 03:44, Hyunsoon Kim wrote:
> On Mon, Mar 29, 2021 at 12:53:48PM +0200, David Hildenbrand wrote:
>> On 29.03.21 07:29, Hyunsoon Kim wrote:
>>> This patch allows programmer to avoid zero initialization on page
>>> allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
>>> is enabled. The configuration is made to prevent uninitialized
>>> heap memory flaws, and Android has applied this for security and
>>> deterministic execution times. Please refer to below.
>>>
>>> https://android-review.googlesource.com/c/kernel/common/+/1235132
>>>
>>> However, there is a case that the zeroing page memory is unnecessary
>>> when the page is used on specific purpose and will be zeroed
>>> automatically by hardware that accesses the memory through DMA.
>>> For instance, page allocation used for IP packet reception from Exynos
>>> modem is solely used for packet reception. Although the page will be
>>> freed eventually and reused for some other purpose, initialization at
>>> that moment of reuse will be sufficient to avoid uninitialized heap
>>> memory flaws. To support this kind of control, this patch creates new
>>> gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
>>> of page allocation, called by many related APIs such as page_frag_alloc,
>>> alloc_pages, etc.
>>>
>>> Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
>>> ---
>>>   include/linux/gfp.h | 2 ++
>>>   include/linux/mm.h  | 4 +++-
>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index 8572a14..4ddd947 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -58,6 +58,8 @@ struct vm_area_struct;
>>>   #else
>>>   #define ___GFP_NOLOCKDEP	0
>>>   #endif
>>> +#define ___GFP_NOINIT		0x1000000u
>>> +
>>>   /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>>>   /*
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 8ba4342..06a23bb 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2907,7 +2907,9 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>>>   DECLARE_STATIC_KEY_FALSE(init_on_alloc);
>>>   static inline bool want_init_on_alloc(gfp_t flags)
>>>   {
>>> -	if (static_branch_unlikely(&init_on_alloc))
>>> +	if (flags & ___GFP_NOINIT)
>>> +		return false;
>>> +	else if (static_branch_unlikely(&init_on_alloc))
>>>   		return true;
>>>   	return flags & __GFP_ZERO;
>>>   }
>>>
>>
>> We discussed that in the past - whatever leaves the buddy shall be
>> initialized. This is a security feature, not something random kernel modules
>> should be able to hack around.
>>
>> We also discussed back then to allow other allocators to eventually be able
>> to optimize in the future if we are sure it really makes sense. Then,
>> however, we need a new API that is not available to random modules, instead
>> of exposing ___GFP_NOINIT to anybody out there in the system.
>>
>> Nacked-by: David Hildenbrand <david@redhat.com>
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
> 
> If you don't mind, may i ask you exactly what security flaws you are expecting
> from uninitialized value allocation? I can think of below scenario:
> 
> 1. Security related value is freed by security system.
> 2. Malicious module get allocation to the memory region that is freed by above.
> 3. Malicious module uses that uninitialized value, and breach the security.
> 

I think one of the most important cases are "Content of process A is 
leaked via driver/mechanism X to process B". Or "Kernel content is 
leaked via driver/mechanism X to process Y".

> Could you please confirm that I am think in the right way? If so, isn't it
> possible to make the security system to zero on free? I am not talking about
> CONFIG_INIT_ON_FREE_DEFAULT_ON. I am just suggesting that isn't it better to
> make programs that generate important values to be forced to initialize on
> free, instead of making whole system to zeroing on alloc always, resulting
> in performance downgrade? I think this approach can make enhancement.

Well, it's not that easy. Then it's up to the freeing context to decide 
if a page should better be freed. Similarly, if you have a BUG (e.g., 
random put_page() from context X frees a user space page to the buddy) 
there, the whole security feature is - again - moot. That's why really 
only "init_on_free" vs "init_on_alloc" make sense - for anything that 
enters/leaves the buddy. As soon as you start poking holes you start 
opening the door for such security issues.

Enabling init_on_free has the downside that system boots gets slower, as 
everything that enters the buddy (== all memory) has to be zeroed out.

-- 
Thanks,

David / dhildenb

