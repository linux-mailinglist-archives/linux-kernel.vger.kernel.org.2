Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71834AC39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCZQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhCZQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616774601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZnm8HdGFNCRnMNSn+oQG/RYs2IjqgWrYp8rf77mRGU=;
        b=KvMnHQIbj5ASRNXIo3INItTAYpK0fbMQ8FdJ1D+HboHNKJ3Qu1/SDy1nkQWXcPt6a0qU4Y
        Vcscpljo0AXYTM47VbvS2qYDSYlGrnVGg+nHnCbyWBQrzUXnfxW1d/bme0iVWdvYejYM7G
        5ME+d5qQNPzo/XrmC0OLHB1aG9BI4RQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-JiLdBBZXPm60hUQHLoHDfg-1; Fri, 26 Mar 2021 12:03:16 -0400
X-MC-Unique: JiLdBBZXPm60hUQHLoHDfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76DC9EC1A0;
        Fri, 26 Mar 2021 16:03:15 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49FFD19CB2;
        Fri, 26 Mar 2021 16:03:13 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz> <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain> <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
 <YF3x8BW1+2o50mds@dhcp22.suse.cz>
 <0e735ea7-b3d9-615e-6bba-fa3a16883226@redhat.com>
 <YF3+OWstWA9LIX95@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3739470f-3b96-fa39-34dc-1ce46a68f1da@redhat.com>
Date:   Fri, 26 Mar 2021 17:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YF3+OWstWA9LIX95@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 16:31, Michal Hocko wrote:
> On Fri 26-03-21 15:53:41, David Hildenbrand wrote:
>> On 26.03.21 15:38, Michal Hocko wrote:
>>> On Fri 26-03-21 09:52:58, David Hildenbrand wrote:
> [...]
>>>> 2. We won't allocate kasan shadow memory. We most probably have to do it
>>>> explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
>>>> mm/memremap.c:pagemap_range()
>>>
>>> I think this is similar to the above. Does kasan has to know about
>>> memory which will never be used for anything?
>>
>> IIRC, kasan will track read/writes to the vmemmap as well. So it could
>> theoretically detect if we read from the vmemmap before writing
>> (initializing) it IIUC.
>> This is also why mm/memremap.c does a kasan_add_zero_shadow() before the
>> move_pfn_range_to_zone()->memmap_init_range() for the whole region,
>> including altmap space.
>>
>> Now, I am no expert on KASAN, what would happen in case we have access to
>> non-tracked memory.
>>
>> commit 0207df4fa1a869281ddbf72db6203dbf036b3e1a
>> Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>> Date:   Fri Aug 17 15:47:04 2018 -0700
>>
>>      kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN
>>
>> indicates that kasan will crash the system on "non-existent shadow memory"
> 
> Interesting. Thanks for the pointer.
> 
>>>> Further a locking rework might be necessary. We hold the device hotplug
>>>> lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
>>>> have to move that out online_pages.
>>>
>>> Could you be more explicit why this locking is needed? What it would
>>> protect from for vmemmap pages?
>>>
>>
>> One example is in mm/kmemleak.c:kmemleak_scan(), where we scan the vmemmap
>> for pointers. We don't want the vmemmap to get unmapped while we are working
>> on it (-> fault).
>   
> Hmm, but they are not going away during offline. They just have a less
> defined state. Or what exactly do you mean by unmapped?

Hmm, also true. We should double check if we're touching other code that 
should better be synchronized with the memory hotplug lock.

-- 
Thanks,

David / dhildenb

