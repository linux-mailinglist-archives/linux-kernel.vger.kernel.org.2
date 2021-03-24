Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2847C347A32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhCXOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235709AbhCXOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616594764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxKMGYIWB97pteYfLN/BCjD+zXG96m+SO6JR3kyE8DA=;
        b=XlzABvta1BEq3lD72MqALekembbvVHB3WZst8LvA2OcU6g7T0yEpU9GkP/Hma0mFmM7V9d
        AR9k+mrUlMNFREmCJ4UZiLho3GKKcz2wxC8Us23Nkt8dPaflmPKHTqCffIFy6Q8PaVdSyD
        +d9eLNlHEfZH34tB4TKqhWmgid75PuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-JCmqapBqNbWTEGUf43xqKA-1; Wed, 24 Mar 2021 10:05:59 -0400
X-MC-Unique: JCmqapBqNbWTEGUf43xqKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1633480BCA6;
        Wed, 24 Mar 2021 14:05:58 +0000 (UTC)
Received: from [10.36.115.66] (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95CDF18A9E;
        Wed, 24 Mar 2021 14:05:55 +0000 (UTC)
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
 <YFssRr7gZEPfHieA@dhcp22.suse.cz>
 <c3ff7038-a694-d311-c246-b881a2f55be7@redhat.com>
 <YFsydJNF63OEcCaY@dhcp22.suse.cz>
 <32bc6e31-0200-1e8c-895c-3f60ed072fc2@redhat.com>
 <YFtBTeBBCPnBesQ5@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <0e58dce3-d68f-f8cb-936e-c7ae49c1eeaa@redhat.com>
Date:   Wed, 24 Mar 2021 15:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFtBTeBBCPnBesQ5@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 14:40, Michal Hocko wrote:
> On Wed 24-03-21 14:13:31, David Hildenbrand wrote:
>> On 24.03.21 13:37, Michal Hocko wrote:
>>> On Wed 24-03-21 13:23:47, David Hildenbrand wrote:
>>>> On 24.03.21 13:10, Michal Hocko wrote:
>>>>> On Wed 24-03-21 13:03:29, Michal Hocko wrote:
>>>>>> On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
>>>>> [...]
>>>>>
>>>>> an additional remark
>>>>>
>>>>>>> - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
>>>>>>> - online_pages()->zone->present_pages += nr_pages;
>>>>>
>>>>> I am pretty sure you shouldn't account vmmemmap pages to the target zone
>>>>> in some cases - e.g. vmemmap cannot be part of the movable zone, can it?
>>>>> So this would be yet another special casing. This patch has got it wrong
>>>>> unless I have missed some special casing.
>>>>>
>>>>
>>>> It's a bit unfortunate that we have to discuss the very basic design
>>>> decisions again.
>>>
>>> It would be great to have those basic design decisions layed out in the
>>> changelog.
>>>
>>>> @Oscar, maybe you can share the links where we discussed all this and add
>>>> some of it to the patch description.
>>>>
>>>> I think what we have right here is good enough for an initial version, from
>>>> where on we can improve things without having to modify calling code.
>>>
>>> I have to say I really dislike vmemmap proliferation into
>>> {on,off}lining. It just doesn't belong there from a layering POV. All
>>> this code should care about is to hand over pages to the allocator and
>>> make them visible.
>>
>> Well, someone has to initialize the vmemmap of the vmemmap pages ( which is
>> itself :) ),
> 
> Yeah, and I would expect this to be done when the vmemmap space is
> reserved. This is at the hotadd time and we do not know the zone but
> that shouldn't really matter because their zone can be quite arbitrary
> kernel zone. As mentioned previously I do not think associating those
> with zone movable is a good idea as they are fundamentally not movable.

I don't think that's an issue. Just another special case to keep things 
simple. (and not completely fragment zones, mess with zone shrinking etc.)

> It is likely that the zone doesn't really matter for these pages anyway
> and the only think we do care about is that they are not poisoned and
> there is at least something but again it would be much better to have a
> single place where all those details are done (including accounting)
> rather than trying to wrap head around different pfns when onlining
> pages and grow potential and suble bugs there.

Exactly, as you said, the zone doesn't really matter - thus, this patch 
just handles it as simple as possible: keep them in the same zone as the 
hole memory block. No fragmented zones. no special casing. simple.

Details are actually pretty much all at a single place when 
onlining/offlining().

> 
>> and as the vemmap does not span complete sections things can
>> get very weird as we can only set whole sections online (there was more to
>> that, I think it's buried in previous discussions).
> 
> Yes the section can only online as whole. This is an important "detail"
> and it would deserve some more clarification in the changelog as well.

Indeed.

> You have invested quite some energy into code consolidation and checks
> to make sure that hotplugged code doesn't have holes and this work bends
> those rules. vmemmap is effectivelly a hole in a memblock/section. I
> think we should re-evaluate some of those constrains rather than try to
> work them around somehow.
It's an offset in the beginning, so it's a special case. And the 
question is if there is a real benefit in handling it differently, for 
example, messing with online sections, messing with zones .. I am not 
convinced that the added complexity gives us a real benefit. But I shall 
be taught otherwise.


BTW: I once thought about having 
online_memory_block(block)/offline_memory_block(block) as separate 
functions instead of having pretty generic (error prone?) 
online_pages()/offline_pages(). Then, these details would just go in 
there and memory blocks + online/offline logic would simply be 
self-contained.

-- 
Thanks,

David / dhildenb

