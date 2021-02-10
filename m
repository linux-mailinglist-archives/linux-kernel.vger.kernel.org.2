Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED83168E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBJOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhBJOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612966271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn1IsOxdNPBelHhZW7f4PmGjNa98OU+S7o5svQG0e4w=;
        b=X1p/IID9/CxL631ccY5qokpjbtfrnj9wUJZ6CWSMisYwksTaWef7zLIdN4jnHGm7zAGMUv
        btyPD1rWKA5SJgJo7t1GC+XY/TCw+ASZ6BAYix3ybEpbeZOOctd/Gj0WMzGAALZL9DXHn2
        6odiLjxHru2mnQ16uq1zXwTDcg74uOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-xzMdaoeYNqOlmaSAh7AdyA-1; Wed, 10 Feb 2021 09:11:09 -0500
X-MC-Unique: xzMdaoeYNqOlmaSAh7AdyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FEA4107ACE8;
        Wed, 10 Feb 2021 14:11:08 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCEF95C1BD;
        Wed, 10 Feb 2021 14:11:06 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle
 in-use hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-2-osalvador@suse.de>
 <6aa21eb3-7bee-acff-8f3c-7c13737066ba@redhat.com>
 <20210210140941.GA3636@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d38527b5-140d-15e5-c1c4-f381602eab46@redhat.com>
Date:   Wed, 10 Feb 2021 15:11:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210140941.GA3636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.21 15:09, Oscar Salvador wrote:
> On Wed, Feb 10, 2021 at 09:56:37AM +0100, David Hildenbrand wrote:
>> On 08.02.21 11:38, Oscar Salvador wrote:
>>> alloc_contig_range is not prepared to handle hugetlb pages and will
>>> fail if it ever sees one, but since they can be migrated as any other
>>> page (LRU and Movable), it makes sense to also handle them.
>>>
>>> For now, do it only when coming from alloc_contig_range.
>>>
>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>> ---
>>>    mm/compaction.c | 17 +++++++++++++++++
>>>    mm/vmscan.c     |  5 +++--
>>>    2 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index e5acb9714436..89cd2e60da29 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>    			goto isolate_fail;
>>>    		}
>>> +		/*
>>> +		 * Handle hugetlb pages only when coming from alloc_contig
>>> +		 */
>>> +		if (PageHuge(page) && cc->alloc_contig) {
>>> +			if (page_count(page)) {
>>
>> I wonder if we should care about races here. What if someone concurrently
>> allocates/frees?
>>
>> Note that PageHuge() succeeds on tail pages, isolate_huge_page() not, i
>> assume we'll have to handle that as well.
>>
>> I wonder if it would make sense to move some of the magic to hugetlb code
>> and handle it there with less chances for races (isolate if used,
>> alloc-and-dissolve if not).
> 
> Yes, it makes sense to keep the magic in hugetlb code.
> Note, though, that removing all races might be tricky.
> 
> isolate_huge_page() checks for PageHuge under hugetlb_lock,
> so there is a race between a call to PageHuge(x) and a subsequent
> call to isolate_huge_page().
> But we should be fine as isolate_huge_page will fail in case the page is
> no longer HugeTLB.
> 
> Also, since isolate_migratepages_block() gets called with ranges
> pageblock aligned, we should never be handling tail pages in the core
> of the function. E.g: the same way we handle THP:

Gigantic pages? (spoiler: see my comments to next patch :) )

-- 
Thanks,

David / dhildenb

