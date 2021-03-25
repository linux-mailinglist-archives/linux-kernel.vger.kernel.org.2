Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DE349935
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCYSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhCYSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616695740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drU5tvVMYvfs+I6S2meKDKFJotJ/fm7RW4NXE7uUIV0=;
        b=aeykNZaSajnBxrghl5lAjmjpWxBOwGFQHaG7ewnu6OUU7DssCTKNZbL3NcrkEt3S6RcZ2T
        IaxA/4jghDJkNUhQSH/K4MDexkEm0TWfPej2Y5CHgrrkqnpIvbLdDVSPsI/l+0OqXAtgND
        A6HQ8AR4bes2R5rx1V1jSqHbgz7omjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-oRnjcgSyPHi1ps1zZeKWrg-1; Thu, 25 Mar 2021 14:08:54 -0400
X-MC-Unique: oRnjcgSyPHi1ps1zZeKWrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FBD1835B74;
        Thu, 25 Mar 2021 18:08:08 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 924EE1A8F2;
        Thu, 25 Mar 2021 18:08:06 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <5a755ff6-4085-da64-08d5-49dd232029eb@redhat.com>
Date:   Thu, 25 Mar 2021 19:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFy8ARml4R7/snVs@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 17:36, Michal Hocko wrote:
> On Thu 25-03-21 17:20:23, David Hildenbrand wrote:
>> On 25.03.21 17:07, Michal Hocko wrote:
>>> On Thu 25-03-21 16:35:58, Michal Hocko wrote:
>>> [...]
>>>> So there is indeed a difference. One way around that would be to mark
>>>> vmemmap pages (e.g. PageReserved && magic value stored somewhere in the
>>>> struct page - resembling bootmem vmemmaps) or mark section fully backing
>>>> vmemmaps as online (ugly).
>>>
>>> I am not yet ready to give up on this. Here is a quick stab at the
>>> pfn_to_online_page approach. It is not great but it is not really
>>> terrible either. I think we can do better and skip
>>
>> We both seem to have a different taste, to phrase it in a nice way :) ; but
>> well, you seem to have set your mind (just like I seem to have set mine when
>> trying to find a nice and somewhat-clean way to handle this when discussing
>> it in the past).
> 
> I definitely do not want to fight for a certain solution just for the
> sake of it. I really dislike how the lifetime of the reserved space and
> its accounting are completely detached. But hey, I do understand that
> a worse solution from the design perspective can be better due to
> practical reasons or constrains.
> 
> I haven't seen the hibernation problem before and I do recognize it is
> a nasty one. If all it takes is to make pfn_to_online_page work (and my
> previous attempt is incorrect because it should consult block rather
> than section pfn range) and there are no other downsides then I would
> still prefer to go with my proposal.  If there are still other things to
> plug then, well, practicality is going to win.
> 
> So before I give up on the "proper" design card, are there more
> subtleties to watch for? You have certainly given this much more thought
> than I have.
> 

"Just one more thing" :)

With the pfn_to_online_page() change, I think what remains is


1. The contiguous zone thingy, which we discussed is not a deal breaker, 
although sub-optimal and most probably not to be optimized in the future.

2. There corner cases issue with /dev/mem use case with offline memory 
blocks I mentioned. Existing setups (!memmap_on_memory) are not 
affected, so I guess we're fine.

3. valid_zones_show() has to be taught to only look at the !vmemmap 
part, otherwise we'll no longer indicate "movable" after onlining to the 
movable zone. Should be fairly easy.


We'll have pfn_to_online_section() succeed without SECTION_IS_ONLINE. I 
think I/we removed all such code that purely relied on that flag for 
optimizations like

if (!online_section(s))
	continue;


I can give it some more thought, it could fly. At least zone shrinking 
and hibernation should continue working as expected, which is a relief.

-- 
Thanks,

David / dhildenb

