Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC16834A373
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCZIxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCZIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616748787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snShQz8EXjjPJgp2ULZFPA/A2D46xCzf1Hq2y3U4qug=;
        b=OsaAJ1erAD1LYIyYxsbBhbisUdaXsyfH0k8Cui1p1RfaP7gCezZgRFdNMhvdM7WJjLx6wa
        fDspS8+gpEAAfHZZYR5acTe+b0BV5anhEaHciL08VQ9xcMYsXyB/3Vzl4u4r5BqYolp+ug
        h4IN4yQdw824hJpEjoKXCXlYQcrtb4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Ve0gsv2kNa6dnPMAREF3Cg-1; Fri, 26 Mar 2021 04:53:03 -0400
X-MC-Unique: Ve0gsv2kNa6dnPMAREF3Cg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C187853EC3;
        Fri, 26 Mar 2021 08:53:01 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5993D891D0;
        Fri, 26 Mar 2021 08:52:59 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz> <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz> <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain> <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
Date:   Fri, 26 Mar 2021 09:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 09:35, Michal Hocko wrote:
> On Thu 25-03-21 23:06:50, Oscar Salvador wrote:
>> On Thu, Mar 25, 2021 at 05:47:30PM +0100, Michal Hocko wrote:
>>> On Thu 25-03-21 17:36:22, Michal Hocko wrote:
>>>> If all it takes is to make pfn_to_online_page work (and my
>>>> previous attempt is incorrect because it should consult block rather
>>>> than section pfn range)
>>>
>>> This should work.
>>
>> Sorry, but while this solves some of the issues with that approach, I really
>> think that overcomplicates things and buys us not so much in return.
>> To me it seems that we are just patching things to make it work that
>> way.
> 
> I do agree that special casing vmemmap areas is something I do not
> really like but we are in that schrödinger situation when this memory is
> not onlineable unless it shares memory section with an onlineable
> memory. There are two ways around that, either special case it on
> pfn_to_online_page or mark the vmemmap section online even though it is
> not really.
> 
>> To be honest, I dislike this, and I guess we can only agree to disagree
>> here.
> 
> No problem there. I will not insist on my approach unless I can convince
> you that it is a better solution. It seems I have failed and I can live
> with that.
> 
>> I find the following much easier, cleaner, and less risky to encounter
>> pitfalls in the future:
>>
>> (!!!It is untested and incomplete, and I would be surprised if it even
>> compiles, but it is enough as a PoC !!!)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 5ea2b3fbce02..799d14fc2f9b 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -169,6 +169,60 @@ int memory_notify(unsigned long val, void *v)
>>   	return blocking_notifier_call_chain(&memory_chain, val, v);
>>   }
>>
>> +static int memory_block_online(unsigned long start_pfn, unsigned long nr_pages,
>> +			       unsigned long nr_vmemmap_pages, int online_type,
>> +			       int nid)
>> +{
>> +	int ret;
>> +	/*
>> +	 * Despite vmemmap pages having a different lifecycle than the pages
>> +	 * they describe, initialiating and accounting vmemmap pages at the
>> +	 * online/offline stage eases things a lot.
> 
> This requires quite some explaining.
> 
>> +	 * We do it out of {online,offline}_pages, so those routines only have
>> +	 * to deal with pages that are actual usable memory.
>> +	 */
>> +	if (nr_vmemmap_pages) {
>> +		struct zone *z;
>> +
>> +		z = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
>> +		move_pfn_range_to_zone(z, start_pfn, nr_vmemmap_pages, NULL,
>> +				       MIGRATE_UNMOVABLE);
>> +		/*
>> +		 * The below could go to a helper to make it less bulky here,
>> +		 * so {online,offline}_pages could also use it.
>> +		 */
>> +		z->present_pages += nr_pages;
>> +		pgdat_resize_lock(z->zone_pgdat, &flags);
>> +		z->zone_pgdat->node_present_pages += nr_pages;
>> +		pgdat_resize_unlock(z->zone_pgdat, &flags);

Might have to set fully spanned section online. (vmemmap >= SECTION_SIZE)

>> +	}
>> +
>> +	ret = online_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages,
>> +			   online_type);
>> +
>> +	/*
>> +	 * In case online_pages() failed for some reason, we should cleanup vmemmap
>> +	 * accounting as well.
>> +	 */
>> +	return ret;
>> +}
> 
> Yes this is much better! Just a minor suggestion would be to push
> memory_block all the way to memory_block_online (it oline a memory
> block). I would also slightly prefer to provide 2 helpers that would make
> it clear that this is to reserve/cleanup the vmemamp space (defined in
> the memory_hotplug proper).
> 
> Thanks!
> 

Something else to note:


We'll not call the memory notifier (e.g., MEM_ONLINE) for the vmemmap. 
The result is that

1. We won't allocate extended struct pages for the range. Don't think 
this is really problematic (pages are never allocated/freed, so I guess 
we don't care - like ZONE_DEVICE code).

2. We won't allocate kasan shadow memory. We most probably have to do it 
explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see 
mm/memremap.c:pagemap_range()


Further a locking rework might be necessary. We hold the device hotplug 
lock, but not the memory hotplug lock. E.g., for get_online_mems(). 
Might have to move that out online_pages.

-- 
Thanks,

David / dhildenb

