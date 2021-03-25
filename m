Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34CC34923F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhCYMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230239AbhCYMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616676054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOKQNCijii7AvVDUdkRjAl0wBlJEDwK56PtHxBH068U=;
        b=Mx22iVg5S9fgnUMQsHQJO6wc8cOvHT9eK4IsRfEb9plQr8Hp9Od7ebOqQsILvcsORavy0X
        cOwDwHazpagaeDPssJ6vouS2ooaDwOEXRId/+Fays5feZC09JX8VF8pfkZJzTopdzXzJKa
        sJX9/5gLRTuEn5IQU6M4tbfxgxzjyf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-vhZ3or8tPvKgo6MfvPI6dA-1; Thu, 25 Mar 2021 08:40:50 -0400
X-MC-Unique: vhZ3or8tPvKgo6MfvPI6dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1984D814256;
        Thu, 25 Mar 2021 12:40:49 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB46E60CCF;
        Thu, 25 Mar 2021 12:40:46 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210324101259.GB16560@linux> <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain> <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
Date:   Thu, 25 Mar 2021 13:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 13:35, Michal Hocko wrote:
> On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
>> On 25.03.21 11:55, Oscar Salvador wrote:
>>> On Thu, Mar 25, 2021 at 10:17:33AM +0100, Michal Hocko wrote:
>>>> Why do you think it is wrong to initialize/account pages when they are
>>>> used? Keep in mind that offline pages are not used until they are
>>>> onlined. But vmemmap pages are used since the vmemmap is established
>>>> which happens in the hotadd stage.
>>>
>>> Yes, that is true.
>>> vmemmap pages are used right when we populate the vmemmap space.
>>>
>>
>> Note: I once herd of a corner-case use case where people offline memory
>> blocks to then use the "free" memory via /dev/mem for other purposes ("large
>> physical memory"). Not that I encourage such use cases, but they would be
>> fundamentally broken if the vmemmap ends up on offline memory and is
>> supposed to keep its state ...
> 
> I am not aware of such a use case, it surely sounds, ehm creative, but
> nothing really new. But such a usecase sounds quite incompatible with
> this feature whether we account vmemmap at hotadd or hotremove because
> they would need to understand that part of the memory they have hotadded
> is not useable.

I think they can use it just fine via /dev/mem, which explicitly avoids 
any kind of "struct page" references IIRC. They would be overwriting the 
vmemmap, but that part scan happily read/write until onlining, where the 
vmemmap would get reinitialized and set online - from which point on 
pfn_to_online_page() would succeed also on the vmemmap itself.

> 
> [...]
>>> - When moving the initialization/accounting to hot-add/hot-remove,
>>>     the section containing the vmemmap pages will remain offline.
>>>     It might get onlined once the pages get online in online_pages(),
>>>     or not if vmemmap pages span a whole section.
>>>     I remember (but maybe David rmemeber better) that that was a problem
>>>     wrt. pfn_to_online_page() and hybernation/kdump.
>>>     So, if that is really a problem, we would have to care of ot setting
>>>     the section to the right state.
>>
>> Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
>> because the memory is marked as offline and, thus, logically without any
>> valuable content.
> 
> Could you point me to the respective hibernation code please? I always
> get lost in that area. Anyway, we do have the same problem even if the
> whole accounting is handled during {on,off}lining, no?

kernel/power/snapshot.c:saveable_page().

> 
> I am not really worried about kdump though. As the memory is offline
> then losing itse vmemmap is a mere annoyance.

Yep, kdump was relevant in our previous discussions when we were talking 
about memory blocks having their altmap located on other memory blocks.

> 
> 
>>> - AFAICS, doing all the above brings us to former times were some
>>>     initialization/accounting was done in a previous stage, and I remember
>>>     it was pushed hard to move those in online/offline_pages().
>>>     Are we ok with that?
>>>     As I said, we might have to set the right zone in hot-add stage, as
>>>     otherwise problems might come up.
>>>     Being that case, would not that also be conflating different concepts
>>>     at a wrong phases?
>>>
>>
>> I expressed my opinion already, no need to repeat. Sub-section online maps
>> would make it cleaner, but I am still not convinced we want/need that.
> 
> Nah, subsections are more tricky than necessary and if we can live
> without them and have it just as pmem weirdness is more than enough ;)

Yes, absolutely :)

-- 
Thanks,

David / dhildenb

