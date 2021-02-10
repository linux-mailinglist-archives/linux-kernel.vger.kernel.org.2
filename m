Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02DC316906
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBJOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhBJOYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612966958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKGNdoeE42XjyVSZ4Q+TFvmhULCMg2nknuM5NfQEDVM=;
        b=DmGc35xI5po+UTQt6y5U3celghd8pQAPvcFw7oQyKo248MpiQQ3VXisqL3EMViNni6Jloi
        hi9vJijmQzOtVsdkIECOAKk946GAB/0N87PhoNPWA1HiUsKJsFfgaNJ4BfT5hVdIwjqZZV
        RlA9PbtZk+bI5VW9EyrtFUMFEQjYmfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-UVuQvXOOMO2s5-ylVlVaSw-1; Wed, 10 Feb 2021 09:22:33 -0500
X-MC-Unique: UVuQvXOOMO2s5-ylVlVaSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 769F2801A9A;
        Wed, 10 Feb 2021 14:22:09 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31CA5C6AB;
        Wed, 10 Feb 2021 14:22:07 +0000 (UTC)
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
 <d38527b5-140d-15e5-c1c4-f381602eab46@redhat.com>
 <20210210141425.GB3636@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e3e35cfb-738d-0f80-32de-a7fbbf3e331c@redhat.com>
Date:   Wed, 10 Feb 2021 15:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210141425.GB3636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.21 15:14, Oscar Salvador wrote:
> On Wed, Feb 10, 2021 at 03:11:05PM +0100, David Hildenbrand wrote:
>> On 10.02.21 15:09, Oscar Salvador wrote:
>>> On Wed, Feb 10, 2021 at 09:56:37AM +0100, David Hildenbrand wrote:
>>>> On 08.02.21 11:38, Oscar Salvador wrote:
>>>>> alloc_contig_range is not prepared to handle hugetlb pages and will
>>>>> fail if it ever sees one, but since they can be migrated as any other
>>>>> page (LRU and Movable), it makes sense to also handle them.
>>>>>
>>>>> For now, do it only when coming from alloc_contig_range.
>>>>>
>>>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>>>> ---
>>>>>     mm/compaction.c | 17 +++++++++++++++++
>>>>>     mm/vmscan.c     |  5 +++--
>>>>>     2 files changed, 20 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>> index e5acb9714436..89cd2e60da29 100644
>>>>> --- a/mm/compaction.c
>>>>> +++ b/mm/compaction.c
>>>>> @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>>>     			goto isolate_fail;
>>>>>     		}
>>>>> +		/*
>>>>> +		 * Handle hugetlb pages only when coming from alloc_contig
>>>>> +		 */
>>>>> +		if (PageHuge(page) && cc->alloc_contig) {
>>>>> +			if (page_count(page)) {
>>>>
>>>> I wonder if we should care about races here. What if someone concurrently
>>>> allocates/frees?
>>>>
>>>> Note that PageHuge() succeeds on tail pages, isolate_huge_page() not, i
>>>> assume we'll have to handle that as well.
>>>>
>>>> I wonder if it would make sense to move some of the magic to hugetlb code
>>>> and handle it there with less chances for races (isolate if used,
>>>> alloc-and-dissolve if not).
>>>
>>> Yes, it makes sense to keep the magic in hugetlb code.
>>> Note, though, that removing all races might be tricky.
>>>
>>> isolate_huge_page() checks for PageHuge under hugetlb_lock,
>>> so there is a race between a call to PageHuge(x) and a subsequent
>>> call to isolate_huge_page().
>>> But we should be fine as isolate_huge_page will fail in case the page is
>>> no longer HugeTLB.
>>>
>>> Also, since isolate_migratepages_block() gets called with ranges
>>> pageblock aligned, we should never be handling tail pages in the core
>>> of the function. E.g: the same way we handle THP:
>>
>> Gigantic pages? (spoiler: see my comments to next patch :) )
> 
> Oh, yeah, that sucks.
> We had the same problem in scan_movable_pages/has_unmovable_pages
> with such pages.
> 
> Uhm, I will try to be more careful :-)
> 

Gigantic pages are a minefield. Not your fault :)

-- 
Thanks,

David / dhildenb

