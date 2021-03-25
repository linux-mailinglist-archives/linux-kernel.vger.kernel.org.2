Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6334947A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCYOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhCYOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616683591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dchsKoS2hatPZ8CWZWHmKwa7mr1Z7EkRjZQTq43V0Rg=;
        b=H/VcpvQfsUQo2XVCp0OeyfVIKD6cREYmnC4iGRl34ruwhgaCM/M3kRT4035y5rF1YKhdht
        HQFfbTO37QZ8rLaOlPQwg6v0CFREaYpzOUFfD3La5oTfrR0G2A9HiwXzo6OEMfTi6xttEW
        QGIuaAWAiAFSW2jEshdu0NcS9hFzzqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-G6YmT2LVNjKee9LulUPAsQ-1; Thu, 25 Mar 2021 10:46:27 -0400
X-MC-Unique: G6YmT2LVNjKee9LulUPAsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E028580006E;
        Thu, 25 Mar 2021 14:46:25 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE92260C2E;
        Thu, 25 Mar 2021 14:46:23 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain> <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
Date:   Thu, 25 Mar 2021 15:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 15:34, Michal Hocko wrote:
> On Thu 25-03-21 15:09:35, David Hildenbrand wrote:
>> On 25.03.21 15:08, Michal Hocko wrote:
>>> On Thu 25-03-21 13:40:45, David Hildenbrand wrote:
>>>> On 25.03.21 13:35, Michal Hocko wrote:
>>>>> On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
>>>>>> On 25.03.21 11:55, Oscar Salvador wrote:
>>> [...]
>>>>>>> - When moving the initialization/accounting to hot-add/hot-remove,
>>>>>>>       the section containing the vmemmap pages will remain offline.
>>>>>>>       It might get onlined once the pages get online in online_pages(),
>>>>>>>       or not if vmemmap pages span a whole section.
>>>>>>>       I remember (but maybe David rmemeber better) that that was a problem
>>>>>>>       wrt. pfn_to_online_page() and hybernation/kdump.
>>>>>>>       So, if that is really a problem, we would have to care of ot setting
>>>>>>>       the section to the right state.
>>>>>>
>>>>>> Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
>>>>>> because the memory is marked as offline and, thus, logically without any
>>>>>> valuable content.
> 
> ^^^^ THIS
> 
>>>>>
>>>>> Could you point me to the respective hibernation code please? I always
>>>>> get lost in that area. Anyway, we do have the same problem even if the
>>>>> whole accounting is handled during {on,off}lining, no?
>>>>
>>>> kernel/power/snapshot.c:saveable_page().
>>>
>>> Thanks! So this is as I've suspected. The very same problem is present
>>> if the memory block is marked offline. So we need a solution here
>>> anyway. One way to go would be to consider these vmemmap pages always
>>> online. pfn_to_online_page would have to special case them but we would
>>> need to identify them first. I used to have PageVmemmap or something
>>> like that in my early attempt to do this.
>>>
>>> That being said this is not an argument for one or the other aproach.
>>> Both need fixing.
>>
>> Can you elaborate? What is the issue there? What needs fixing?
> 
> offline section containing vmemmap will be lost during hibernation cycle
> IIU the above correctly.
> 

Can tell me how that is a problem with Oscars current patch? I only see 
this being a problem with what you propose - most probably I am missing 
something important here.

Offline memory sections don't have a valid memmap (assumption: garbage). 
On hibernation, the whole offline memory block won't be saved, including 
the vmemmap content that resides on the block. This includes the vmemmap 
of the vmemmap pages, which is itself.

When restoring, the whole memory block will contain garbage, including 
the whole vmemmap - which is marked to be offline and to contain garbage.

Oscars patch: Works as expected. Onlining the memory block will properly 
intiialize the vmemmap (including the vmemmap of the vmemmap), then mark 
the vmemmap to be valid (by marking the sections to be online).

Your porposal: Does not work as expected. Once we online the memory 
block we don't initialize the vmemmap of the vmemmap pages. There is 
garbage, which gets exposed to the system as soon as we mark the vmemmap 
to be valid (by marking the sections to be online).

-- 
Thanks,

David / dhildenb

