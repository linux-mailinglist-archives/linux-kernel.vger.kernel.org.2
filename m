Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5606831DE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhBQRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234453AbhBQRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613583258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpc/1mlUzLnmcczpO47H6GSp0ZG9steVwoYmgJ68hFo=;
        b=IBTpvJIObMuZf9apaobn04p4LKxKrgsIQIXTtIdsYrgVLLSdBmc4JURP2JcHw3tamEzzXl
        xr1GLIP/wT6+vfcb/ijGcp3mtTsQuYLl2/HLTyUUwT0QaFh3XxzX51Ob6Aknrb63H6psaN
        cDZqj6GD70bMbMut526ulNVJ7rg3iAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-mrA4KtbZOMiY7rnmbxHPqw-1; Wed, 17 Feb 2021 12:34:16 -0500
X-MC-Unique: mrA4KtbZOMiY7rnmbxHPqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D51100962D;
        Wed, 17 Feb 2021 17:34:15 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE62B5D72F;
        Wed, 17 Feb 2021 17:34:13 +0000 (UTC)
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
 <854d4ec8-1eb9-3595-b867-3e50f5a0e6a8@redhat.com>
 <YC1RtmdhUR40gAzq@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <0f201a5a-caaf-2861-59f2-b66152fe9c53@redhat.com>
Date:   Wed, 17 Feb 2021 18:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC1RtmdhUR40gAzq@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 18:26, Minchan Kim wrote:
> On Wed, Feb 17, 2021 at 05:51:27PM +0100, David Hildenbrand wrote:
>> On 17.02.21 17:36, Minchan Kim wrote:
>>> alloc_contig_range is usually used on cma area or movable zone.
>>> It's critical if the page migration fails on those areas so
>>> dump more debugging message like memory_hotplug unless user
>>> specifiy __GFP_NOWARN.
>>>
>>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>>> ---
>>>    mm/page_alloc.c | 16 +++++++++++++++-
>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 0b55c9c95364..67f3ee3a1528 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -8486,6 +8486,15 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>>>    				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>>>    	}
>>>    	if (ret < 0) {
>>> +		if (!(cc->gfp_mask & __GFP_NOWARN)) {
>>> +			struct page *page;
>>> +
>>> +			list_for_each_entry(page, &cc->migratepages, lru) {
>>> +				pr_warn("migrating pfn %lx failed ret:%d ",
>>> +						page_to_pfn(page), ret);
>>> +				dump_page(page, "migration failure");
>>> +			}
>>
>> This can create *a lot* of noise. For example, until huge pages are actually
>> considered, we will choke on each end every huge page - and might do so over
>> and over again.
> 
> I am not familiar with huge page status at this moment but why couldn't
> they use __GFP_NOWARN if they are supposed to fail frequently?

any alloc_contig_range() user will fail on hugetlbfs pages right now 
when they are placed into CMA/ZONE_MOVABLE. Oscar is working on that 
upstream.

> 
>>
>> This might be helpful for debugging, but is unacceptable for production
>> systems for now I think. Maybe for now, do it based on CONFIG_DEBUG_VM.
> 
> If it's due to huge page you mentioned above and caller passes
> __GFP_NOWARN in that case, couldn't we enable always-on?

It would make sense to add that for virito-mem when calling 
alloc_contig_range(). For now I didn't do so, because there were not 
that many messages yet - alloc_contig_range() essentially didn't 
understand __GFP_NOWARN.

We should then also stop printing the "PFNs busy ..." part from 
alloc_contig_range() with __GFP_NOWARN.

> 
> Actually, I am targeting cma allocation failure, which should
> be rather rare compared to other call sites but critical to fail.
> If it's concern to emit too many warning message, I will scope
> down for site for only cma allocation.

If you add "__GFP_NOWARN" when !ZONE_MOVABLE, how would you ever print 
something for CMA? What am I missing? CMA is usually not on ZONE_MOVABLE.

-- 
Thanks,

David / dhildenb

