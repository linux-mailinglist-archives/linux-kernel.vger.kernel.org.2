Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC434F8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhCaGlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233694AbhCaGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617172878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLJOO2atgx+JHmVUPVt2Vsd5PrFDH/M5+OfaqMOeD1c=;
        b=agyaYKVLqZKJg6cxT0ptA2dAtqmauD6XwcJOkyNPhaDv/k4vrDv9JfCokxIMcphmvhdwB0
        arSHZngTzcFGCF9x1ZmumUq1Ae1TQ6WcZPYLAfytnihTnXY1C2H0F1CCQE61TIkvkBy5YP
        D6BDrhVjQLCxbIhXqhfPMw66x0C4E0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-r5TpdFcWMEWwxQsq_6ijwQ-1; Wed, 31 Mar 2021 02:41:09 -0400
X-MC-Unique: r5TpdFcWMEWwxQsq_6ijwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CBDF9CC00;
        Wed, 31 Mar 2021 06:41:04 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB485D740;
        Wed, 31 Mar 2021 06:41:02 +0000 (UTC)
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, linux-mm@kvack.org
References: <20210326012035.3853-1-apopple@nvidia.com>
 <3158185.bARUjMUeyn@nvdebian>
 <e910441c-73a7-b57e-1330-ead65c4ff412@redhat.com>
 <12736273.ONR6GAMRWp@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
Message-ID: <2e312099-bf47-831a-5d0e-3e95053cdb3f@redhat.com>
Date:   Wed, 31 Mar 2021 08:41:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <12736273.ONR6GAMRWp@nvdebian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 08:19, Alistair Popple wrote:
> On Tuesday, 30 March 2021 8:13:32 PM AEDT David Hildenbrand wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 29.03.21 03:37, Alistair Popple wrote:
>>> On Friday, 26 March 2021 7:57:51 PM AEDT David Hildenbrand wrote:
>>>> On 26.03.21 02:20, Alistair Popple wrote:
>>>>> request_free_mem_region() is used to find an empty range of physical
>>>>> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
>>>>> over the range of possible addresses using region_intersects() to see if
>>>>> the range is free.
>>>>
>>>> Just a high-level question: how does this iteract with memory
>>>> hot(un)plug? IOW, how defines and manages the "range of possible
>>>> addresses" ?
>>>
>>> Both the driver and the maximum physical address bits available define the
>>> range of possible addresses for device private memory. From
>>> __request_free_mem_region():
>>>
>>> end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
>>> addr = end - size + 1UL;
>>>
>>> There is no lower address range bound here so it is effectively zero. The
> code
>>> will try to allocate the highest possible physical address first and
> continue
>>> searching down for a free block. Does that answer your question?
>>
>> Oh, sorry, the fist time I had a look I got it wrong - I thought (1UL <<
>> MAX_PHYSMEM_BITS) would be the lower address limit. That looks indeed
>> problematic to me.
>>
>> You might end up reserving an iomem region that could be used e.g., by
>> memory hotplug code later. If someone plugs a DIMM or adds memory via
>> different approaches (virtio-mem), memory hotplug (via add_memory())
>> would fail.
>>
>> You never should be touching physical memory area reserved for memory
>> hotplug, i.e., via SRAT.
>>
>> What is the expectation here?
> 
> Most drivers call request_free_mem_region() with iomem_resource as the base.
> So zone device private pages currently tend to get allocated from the top of
> that.

Okay, but you could still "steal" iomem space that does not belong to 
you, and the firmware will be unaware of that (e.g., it might hotplug a 
DIMM in these spots). This is really nasty (although I guess as you 
allocate top down, it will happen rarely).

> 
> By definition ZONE_DEVICE private pages are unaddressable from the CPU. So in
> terms of expectation I think all that is really required for ZONE_DEVICE
> private pages (at least for Nouveau) is a valid range of physical addresses
> that allow page_to_pfn() and pfn_to_page() to work correctly. To make this
> work drivers add the pages via memremap_pages() -> pagemap_range() ->
> add_pages().

So you'd actually want some region above the hotpluggable/addressable 
range -- e.g., above MAX_PHYSMEM_BITS.

The maximum number of sections we can have is define by

#define SECTIONS_SHIFT (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

You'd e.g., want an extra space like (to be improved)

#define DEVMEM_BITS	1
#define SECTIONS_SHIFT (MAX_PHYSMEM_BITS + DEVMEM_BITS - SECTION_SIZE_BITS)

And do the search only within that range.

-- 
Thanks,

David / dhildenb

