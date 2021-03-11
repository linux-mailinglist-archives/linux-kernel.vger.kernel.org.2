Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9623337D30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCKTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhCKTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615489622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Z7LSgZqphYn16bRiHEIFqGbkZk+Pw5ovVT+gdK3G5g=;
        b=hJ8q3/5vUof/JetrKvTIHem9gKePH33f1XdZDnxpNp7b78wFtv+3iyAs9W4qa7u1Z+XUpL
        b8LfDxJxJsooiBCra7N2C2yHTDkAeyPJ6uy2wRVr5SeSP1kGKPArSR3MMhQkJSKXgIi0Xu
        fe7ESvOkqeHEwJrXukT86KtIT+5u7nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-H7kCqYhDPsib_lVwJpy_1w-1; Thu, 11 Mar 2021 14:06:58 -0500
X-MC-Unique: H7kCqYhDPsib_lVwJpy_1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414F6100C671;
        Thu, 11 Mar 2021 19:06:56 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72E0E7A431;
        Thu, 11 Mar 2021 19:06:54 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
Date:   Thu, 11 Mar 2021 20:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309175546.5877-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks essentially good to me, except some parts in 
mhp_supports_memmap_on_memory()

>   
> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
> +	unsigned long remaining_mem = size - PMD_SIZE;

This looks weird. I think what you want to test is that


a) "nr_vmemmap_pages * sizeof(struct page)" spans complete PMDs (IOW, we 
won't map too much via the altmap when populating a PMD in the vmemmap)

b) "remaining = size - nr_vmemmap_pages * sizeof(struct page)" spans 
complete pageblock.

right?

> +
> +	/*
> +	 * Besides having CONFIG_MHP_MEMMAP_ON_MEMORY, we need a few more
> +	 * assumptions to hold true:
> +	 * - we are working on a single memory block granularity
> +	 * - the size of struct page is multiple of PMD.

That's not what you are checking. (and the way it is phrase, I don;t 
think it makes sense)

> +	 * - the remaining memory after having used part of the range
> +	 *   for vmemmap pages is pageblock aligned.
> +	 *
> +	 * The reason for the struct page to be multiple of PMD is because
> +	 * otherwise two sections would intersect a PMD. This would go against
> +	 * memmap-on-memory premise, as memory would stay pinned until both
> +	 * sections were removed.
> +	 *
> +	 * And the reason for the remaining memory to be pageblock aligned is
> +	 * because mm core functions work on pageblock granularity in order to
> +	 * change page's migratetype.
> +	 */
> +	return memmap_on_memory &&
> +	       size == memory_block_size_bytes() &&
> +	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> +	       !(PMD_SIZE % sizeof(struct page)) &&
> +	       remaining_mem &&
> +	       IS_ALIGNED(remaining_mem, pageblock_size);
> +}
> +

I suggest a restructuring, compressing the information like:

"
Besides having arch support and the feature enabled at runtime, we need 
a few more assumptions to hold true:

a) We span a single memory block: memory onlining/offlining happens in 
memory block granularity. We don't want the vmemmap of online memory 
blocks to reside on offline memory blocks. In the future, we might want 
to support variable-sized memory blocks to make the feature more versatile.

b) The vmemmap pages span complete PMDs: We don't want vmemmap code to 
populate memory from the altmap for unrelated parts (i.e., other memory 
blocks).

c) The vmemmap pages (and thereby the pages that will be exposed to the 
buddy) have to cover full pageblocks: memory onlining/offlining code 
requires applicable ranges to be page-aligned, for example, to set the 
migratetypes properly.
"

Do we have to special case / protect against the vmemmap optimization 
for hugetlb pages? Or is that already blocked somehow and I missed it?

-- 
Thanks,

David / dhildenb

