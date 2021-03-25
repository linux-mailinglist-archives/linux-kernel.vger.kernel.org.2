Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B0348E94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCYLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbhCYLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616670532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rQiSQhOepB0YWYVbYm6m/u8MoxDOz3b0raAhip7+HQ=;
        b=c5OhcZr2R7uTE3YBoEvevItyInlrfEGYIUSHrXi234X9oBcWzO3Az8qPi0WJ9FoXVK/Kfm
        Ck3szVHCz73Bm23CYEcCgoPL+0AH3OCH2KRfYrYysUSc93QyFYGJqa4++zv7z3SOAlCd1w
        EfZNZJXxFohVS92uVSgZCt0tUY1uy3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Gn4qqs2RO_GlWKusopfZMg-1; Thu, 25 Mar 2021 07:08:47 -0400
X-MC-Unique: Gn4qqs2RO_GlWKusopfZMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 403338030D6;
        Thu, 25 Mar 2021 11:08:46 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E678488F02;
        Thu, 25 Mar 2021 11:08:43 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz> <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz> <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain> <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
Date:   Thu, 25 Mar 2021 12:08:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFxsBRORtgqUF/FZ@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 11:55, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 10:17:33AM +0100, Michal Hocko wrote:
>> Why do you think it is wrong to initialize/account pages when they are
>> used? Keep in mind that offline pages are not used until they are
>> onlined. But vmemmap pages are used since the vmemmap is established
>> which happens in the hotadd stage.
> 
> Yes, that is true.
> vmemmap pages are used right when we populate the vmemmap space.
> 

Note: I once herd of a corner-case use case where people offline memory 
blocks to then use the "free" memory via /dev/mem for other purposes 
("large physical memory"). Not that I encourage such use cases, but they 
would be fundamentally broken if the vmemmap ends up on offline memory 
and is supposed to keep its state ...

>>> plus the fact that I dislike to place those pages in
>>> ZONE_NORMAL, although they are not movable.
>>> But I think the vmemmap pages should lay within the same zone the pages
>>> they describe, doing so simplifies things, and I do not see any outright
>>> downside.
>>
>> Well, both ways likely have its pros and cons. Nevertheless, if the
>> vmemmap storage is independent (which is the case for normal hotplug)
>> then the state is consistent over hotadd, {online, offline} N times,
>> hotremove cycles.  Which is conceptually reasonable as vmemmap doesn't
>> go away on each offline.
>>
>> If you are going to bind accounting to the online/offline stages then
>> the accounting changes each time you go through the cycle and depending
>> on the onlining type it would travel among zones. I find it quite
>> confusing as the storage for vmemmap hasn't changed any of its
>> properties.
> 
> That is a good point I guess.
> vmemmap pages do not really go away until the memory is unplugged.
> 
> But I see some questions to raise:
> 
> - As I said, I really dislike it tiding vmemmap memory to ZONE_NORMAL
>    unconditionally and this might result in the problems David mentioned.
>    I remember David and I discussed such problems but the problems with
>    zones not being contiguos have also been discussed in the past and
>    IIRC, we reached the conclusion that a maximal effort should be made
>    to keep them that way, otherwise other things suffer e.g: compaction
>    code.
>    So if we really want to move the initialization/account to the
>    hot-add/hot-remove stage, I would really like to be able to set the
>    proper zone in there (that is, the same zone where the memory will lay).

Determining the zone when hot-adding does not make too much sense: you 
don't know what user space might end up deciding (online_kernel, 
online_movable...).

> 
> - When moving the initialization/accounting to hot-add/hot-remove,
>    the section containing the vmemmap pages will remain offline.
>    It might get onlined once the pages get online in online_pages(),
>    or not if vmemmap pages span a whole section.
>    I remember (but maybe David rmemeber better) that that was a problem
>    wrt. pfn_to_online_page() and hybernation/kdump.
>    So, if that is really a problem, we would have to care of ot setting
>    the section to the right state.

Good memory. Indeed, hibernation/kdump won't save the state of the 
vmemmap, because the memory is marked as offline and, thus, logically 
without any valuable content.

> 
> - AFAICS, doing all the above brings us to former times were some
>    initialization/accounting was done in a previous stage, and I remember
>    it was pushed hard to move those in online/offline_pages().
>    Are we ok with that?
>    As I said, we might have to set the right zone in hot-add stage, as
>    otherwise problems might come up.
>    Being that case, would not that also be conflating different concepts
>    at a wrong phases?
> 

I expressed my opinion already, no need to repeat. Sub-section online 
maps would make it cleaner, but I am still not convinced we want/need that.

> Do not take me wrong, I quite like Michal's idea, and from a
> conceptually point of view I guess it is the right thing to do.
> But when evualating risks/difficulty, I am not really sure.
> 
> If we can pull that off while setting the right zone (and must be seen
> what about the section state), and the outcome is not ugly, I am all for
> it.
> Also a middel-ground might be something like I previously mentioned(having
> a helper in memory_block_action() to do the right thing, so
> offline/online_pages() do not get pouled.

As I said, having soemthing like 
memory_block_online()/memory_block_offline() could be one way to tackle 
it. We only support onlining/offlining of memory blocks and I ripped out 
all code that was abusing online_pages/offline_pages ...

So have memory_block_online() call online_pages() and do the accounting 
of the vmemmap, with a big fat comment that sections are actually set 
online/offline in online_pages/offline_pages(). Could be a simple 
cleanup on top of this series ...


-- 
Thanks,

David / dhildenb

