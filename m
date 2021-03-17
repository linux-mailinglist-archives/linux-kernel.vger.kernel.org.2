Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C533F2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhCQOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbhCQOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615991750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmIgP4UWwJgCHils66nz5G9rnZUX+iOdxhYSZqPnsE8=;
        b=V3KmXxzEdGgHqL1JJlaWEL7TOaW5yMgYO4fEVUVKl/p2P9/226dCYVuzz/ZjuaGMEg9aMV
        S/XJvw5SNTExUlw2RGVZLGe5MyTBHPZfH3jSbndZYpO1VkszFH+m34sLe0NtMKVd4o34g5
        a01XLfnruEe2BM/ezrytl4vpiLlN/lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-aqXzifotNNaEf8RYfHpfkw-1; Wed, 17 Mar 2021 10:35:46 -0400
X-MC-Unique: aqXzifotNNaEf8RYfHpfkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C51108BD07;
        Wed, 17 Mar 2021 14:35:44 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 151FC1001281;
        Wed, 17 Mar 2021 14:35:41 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
 <20210317140847.GA20407@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
Date:   Wed, 17 Mar 2021 15:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317140847.GA20407@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 15:08, Oscar Salvador wrote:
> On Tue, Mar 16, 2021 at 06:45:17PM +0100, David Hildenbrand wrote:
>>> I find that cross reference to vmemmap code a little hard to digest.
>>> I would have assume that we don't have to care about PMDs in this
>>> code here at all. The vmemmap population code should handle that.
>>>
>>> I think I already mentioned that somewhere, I think it should be like this:
>>>
>>> a) vmemmap code should *never* populate more memory than requested for
>>> a single memory section when we are populating from the altmap.
>>> If that cannot be guaranteed for PMDs, then we have to fallback
>>> to populating base pages. Populating PMDs from an altmap with
>>> sizeof(struct page) == 64 is highly dangerous.
> 
> I guess you meant sizeof(struct page) != 64
> 

Yes!

> But other usecases of using altmap (ZONE_DEVICE stuff) might not care whether
> they have sub-populated PMDs when populating sections from altmap?

Just assume you have two ranges

[ ZONE_DEVICE 0 ][ ZONE_DEVICE 1]

If the vmemmap of ZONE_DEVICE 1 could be taken from the altmap of 
ZONE_DEVICE 0, we could be in trouble, as both parts can be 
removed/repurposed independently ...

> 
> Current vmemmap code populates PMD with PMD_SIZE if empty, and with basepages
> if there are still holes.
> 
>>> Assume we have sizeof(struct page) == 56. A 128 MiB section
>>> spans 32768 pages -  we need 32768 * sizeof(struct page)
>>> space for the vmemmap.
>>> With 64k pages we *can* use exactly one PMD. With 56k pages
>>> we need 448 individual (full!) pages for the vmemmap.
>>>
>>> IOW, we don't care how vmemmap code will do the mapping.
>>> vmemmap code has to get it right. IMHO, asserting it in
>>> this code is wrong.
>>>
>>>
>>> b) In this code, we really should only care about what
>>> memory onlining/offlining code can or can't do.
>>> We really only care that
>>>
>>> 1) size == memory_block_size_bytes()
>>> 2) remaining_size
>>> 3) IS_ALIGNED(remaining_size, pageblock_size);
> 
> I agree with the above, but see below:
> 
>>> Okay, please document the statement about single sections, that's
>>> important to understand what's happening.
>>>
>>> My take would be
>>>
>>> bool mhp_supports_memmap_on_memory(unsigned long size)
>>> {
>>> 	/*
>>> 	 * Note: We calculate for a single memory section. The calculation
>>> 	 */
>>> 	unsigned long nr_vmemmap_pages = SECTION_SIZE / PAGE_SIZE;
>>> 	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>>> 	unsigned long remaining_size = size - vmemmap_size;
> 
> While it might be true that we need to back off from populating with altmap in
> case PMDs are not going to be fully populated because of the size of the struct
> page (I am not still not sure though as I said above, other usecases might not
> care at all), I would go __for now__ with placing vmemmap_size == PMD_SIZE in
> the check below as well.
> 
> If the check comes true, we know that we fully populate PMDs when populating
> sections, so the feature can be used.
> 
> Then I commit to have a look whether we need to back off in vmemmap-populating
> code in case altmap && !NOT_FULLY_POPULATED_PMDS.
> 
> What do you think?

If we check for

IS_ALIGNED(nr_vmemmap_pages, PMD_SIZE), please add a proper TODO comment 
that this is most probably the wrong place to take care of this.


-- 
Thanks,

David / dhildenb

