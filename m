Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF433481C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhCXTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237943AbhCXTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616613486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6QfMU6ICmnSA0e3EzDjVM0dhhad75vCN7chXuQhF9w=;
        b=UOozatgP5mYyV6Pa2qrrJM5L2oomrPhromtKR3XwXpXhuqZDa7e9WA9H6fgc3q/HiaXcLP
        si1o7rVsVgHFTY19uE6dR6W/dUUMS1iNOfqPuNOalbF6EfX+qdugxpWZorpzhk3lEoc77T
        gWFWFq3NTN9Dda+2DqCvFdNZvAAerLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-rNCPKapKMgqOwm393TehQA-1; Wed, 24 Mar 2021 15:18:02 -0400
X-MC-Unique: rNCPKapKMgqOwm393TehQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CCD21020357;
        Wed, 24 Mar 2021 19:16:57 +0000 (UTC)
Received: from [10.36.115.66] (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DABA25D9CA;
        Wed, 24 Mar 2021 19:16:54 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de> <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux> <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
Date:   Wed, 24 Mar 2021 20:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 17:04, Michal Hocko wrote:
> On Wed 24-03-21 15:52:38, David Hildenbrand wrote:
>> On 24.03.21 15:42, Michal Hocko wrote:
>>> On Wed 24-03-21 13:03:29, Michal Hocko wrote:
>>>> On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
>>> [...]
>>>>> I kind of understand to be reluctant to use vmemmap_pages terminology here, but
>>>>> unfortunately we need to know about it.
>>>>> We could rename nr_vmemmap_pages to offset_buddy_pages or something like that.
>>>>
>>>> I am not convinced. It seems you are justr trying to graft the new
>>>> functionality in. But I still believe that {on,off}lining shouldn't care
>>>> about where their vmemmaps come from at all. It should be a
>>>> responsibility of the code which reserves that space to compansate for
>>>> accounting. Otherwise we will end up with a hard to maintain code
>>>> because expectations would be spread at way too many places. Not to
>>>> mention different pfns that the code should care about.
>>>
>>> The below is a quick hack on top of this patch to illustrate my
>>> thinking. I have dug out all the vmemmap pieces out of the
>>> {on,off}lining and hooked all the accounting when the space is reserved.
>>> This just compiles without any deeper look so there are likely some
>>> minor problems but I haven't really encountered any major problems or
>>> hacks to introduce into the code. The separation seems to be possible.
>>> The diffstat also looks promising. Am I missing something fundamental in
>>> this?
>>>
>>
>>  From a quick glimpse, this touches on two things discussed in the past:
>>
>> 1. If the underlying memory block is offline, all sections are offline. Zone
>> shrinking code will happily skip over the vmemmap pages and you can end up
>> with out-of-zone pages assigned to the zone. Can happen in corner cases.
> 
> You are right. But do we really care? Those pages should be of no
> interest to anybody iterating through zones/nodes anyway.

Well, we were just discussing getting zone/node links + span right for 
all pages (including for special reserved pages), because it already 
resulted in BUGs. So I am not convinced that we *don't* have to care.

However, I agree that most code that cares about node/zone spans 
shouldn't care - e.g., never call set_pfnblock_flags_mask() on such blocks.

But I guess there are corner cases where we would end up with 
zone_is_empty() == true, not sure what that effect would be ... at least 
the node cannot vanish as we disallow offlining it while we have a 
memory block linked to it.


Another thing that comes to my mind is that our zone shrinking code 
currently searches in PAGES_PER_SUBSECTION (2 MiB IIRC) increments. In 
case our vmemmap pages would be less than that, we could accidentally 
shrink the !vmemmap part too much, as we are mis-detecting the type for 
a PAGES_PER_SUBSECTION block.

IIRC, this would apply for memory block sizes < 128 MiB. Not relevant on 
x86 and arm64. Could be relevant for ppc64, if we'd ever want to support 
memmap_on_memory there. Or if we'd ever reduce the section size on some 
arch below 128 MiB. At least we would have to fence it somehow.


> 
>> There is no way to know that the memmap of these pages was initialized and
>> is of value.
>>
>> 2. You heavily fragment zone layout although you might end up with
>> consecutive zones (e.g., online all hotplugged memory movable)
> 
> What would be consequences?

IIRC, set_zone_contiguous() will leave zone->contiguous = false.

This, in turn, will force pageblock_pfn_to_page() via the slow path, 
turning page isolation a bit slower.

Not a deal breaker, but obviously something where Oscar's original patch 
can do better.


I yet have to think again about other issues (I remember most issues we 
discussed back then were related to having the vmemmap only within the 
same memory block). I think 2) might be tolerable, although unfortunate. 
Regarding 1), we'll have to dive into more details.

-- 
Thanks,

David / dhildenb

