Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549A634AA90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhCZOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616770430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sniOXWpl3SzSr30LS38MLQ1sgZ4a8SSZHY7ekXG97xE=;
        b=M0fvLAofx4IhbmUBfEihFvah/wMQVbekVERevDtfMhkYIvvXin5MALbvqL08B2CmMheSt6
        Ipzuyi0w+hHVspjLFbNAoi0Cm5cvqk57K7+gu9zauzRIa9mJvxFKS8zLcAIKyCL1xKCknd
        92og8BqgxtnvZQ7UsOcxyFI0h1j9u48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-G0sXW3nxNQeM3W9axMD_oA-1; Fri, 26 Mar 2021 10:53:46 -0400
X-MC-Unique: G0sXW3nxNQeM3W9axMD_oA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33087A40C0;
        Fri, 26 Mar 2021 14:53:45 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED113772E0;
        Fri, 26 Mar 2021 14:53:42 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz> <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain> <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
 <YF3x8BW1+2o50mds@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <0e735ea7-b3d9-615e-6bba-fa3a16883226@redhat.com>
Date:   Fri, 26 Mar 2021 15:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YF3x8BW1+2o50mds@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 15:38, Michal Hocko wrote:
> On Fri 26-03-21 09:52:58, David Hildenbrand wrote:
> [...]
>> Something else to note:
>>
>>
>> We'll not call the memory notifier (e.g., MEM_ONLINE) for the vmemmap. The
>> result is that
>>
>> 1. We won't allocate extended struct pages for the range. Don't think this
>> is really problematic (pages are never allocated/freed, so I guess we don't
>> care - like ZONE_DEVICE code).
> 
> Agreed. I do not think we need them. Future might disagree but let's
> handle it when we have a clear demand.
> 
>> 2. We won't allocate kasan shadow memory. We most probably have to do it
>> explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
>> mm/memremap.c:pagemap_range()
> 
> I think this is similar to the above. Does kasan has to know about
> memory which will never be used for anything?

IIRC, kasan will track read/writes to the vmemmap as well. So it could 
theoretically detect if we read from the vmemmap before writing 
(initializing) it IIUC.

This is also why mm/memremap.c does a kasan_add_zero_shadow() before the 
move_pfn_range_to_zone()->memmap_init_range() for the whole region, 
including altmap space.

Now, I am no expert on KASAN, what would happen in case we have access 
to non-tracked memory.

commit 0207df4fa1a869281ddbf72db6203dbf036b3e1a
Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date:   Fri Aug 17 15:47:04 2018 -0700

     kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN

indicates that kasan will crash the system on "non-existent shadow memory"

> 
>> Further a locking rework might be necessary. We hold the device hotplug
>> lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
>> have to move that out online_pages.
> 
> Could you be more explicit why this locking is needed? What it would
> protect from for vmemmap pages?
> 

One example is in mm/kmemleak.c:kmemleak_scan(), where we scan the 
vmemmap for pointers. We don't want the vmemmap to get unmapped while we 
are working on it (-> fault).

-- 
Thanks,

David / dhildenb

