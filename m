Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8163493BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhCYOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231264AbhCYOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616681384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByfSI5VQlkUqIXhFO5RAp8f/3O7Cm7NtKxYn964lR8s=;
        b=Qkn6STlhqshY7KpU0ir8SMoAEo74UAiNR7uHJP6zGHUs7qQjA28XMWg7WVCJpP+BlH/7FK
        pBtCcw7TPd3bUFsbVHSpQPqelpRvV7J2hUTKbPDKza5pk86ZADmLoBRs4v8qnPhcSP//Lp
        1YMygj/bOQpzopzlQcKKI3HqrYG9rxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-XJftUXH_Nf2r6LqaUjWvUw-1; Thu, 25 Mar 2021 10:09:40 -0400
X-MC-Unique: XJftUXH_Nf2r6LqaUjWvUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A367B190D341;
        Thu, 25 Mar 2021 14:09:38 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A799C5D736;
        Thu, 25 Mar 2021 14:09:36 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain> <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
Date:   Thu, 25 Mar 2021 15:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 15:08, Michal Hocko wrote:
> On Thu 25-03-21 13:40:45, David Hildenbrand wrote:
>> On 25.03.21 13:35, Michal Hocko wrote:
>>> On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
>>>> On 25.03.21 11:55, Oscar Salvador wrote:
> [...]
>>>>> - When moving the initialization/accounting to hot-add/hot-remove,
>>>>>      the section containing the vmemmap pages will remain offline.
>>>>>      It might get onlined once the pages get online in online_pages(),
>>>>>      or not if vmemmap pages span a whole section.
>>>>>      I remember (but maybe David rmemeber better) that that was a problem
>>>>>      wrt. pfn_to_online_page() and hybernation/kdump.
>>>>>      So, if that is really a problem, we would have to care of ot setting
>>>>>      the section to the right state.
>>>>
>>>> Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
>>>> because the memory is marked as offline and, thus, logically without any
>>>> valuable content.
>>>
>>> Could you point me to the respective hibernation code please? I always
>>> get lost in that area. Anyway, we do have the same problem even if the
>>> whole accounting is handled during {on,off}lining, no?
>>
>> kernel/power/snapshot.c:saveable_page().
> 
> Thanks! So this is as I've suspected. The very same problem is present
> if the memory block is marked offline. So we need a solution here
> anyway. One way to go would be to consider these vmemmap pages always
> online. pfn_to_online_page would have to special case them but we would
> need to identify them first. I used to have PageVmemmap or something
> like that in my early attempt to do this.
> 
> That being said this is not an argument for one or the other aproach.
> Both need fixing.

Can you elaborate? What is the issue there? What needs fixing?

-- 
Thanks,

David / dhildenb

