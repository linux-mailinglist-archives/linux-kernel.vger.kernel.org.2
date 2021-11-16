Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6F452D66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhKPJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232486AbhKPJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637053108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4284vAzYHLAxGcEEtHPUG4T3Bgo3Ms3nj1In/yM7t9U=;
        b=RilFCKKXJ+OsMz9k9GYBNHcHPqIPDy3vcSUG/1H52dpUpziF4YQFgvtTByCC8FlWxL/bmB
        3qxPjHJ3wVtq6DI/QSjoHJoB4qmZw1DbCMQhlAZfqAC6sXRgeJfpgVSNxvgyGSnq6oZlhA
        YeMaSXIUCBezI+YIy8pWcnoJCrBOnBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-dSPrh5XBMWCUnaQ4f_pH1A-1; Tue, 16 Nov 2021 03:58:26 -0500
X-MC-Unique: dSPrh5XBMWCUnaQ4f_pH1A-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so897599wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=4284vAzYHLAxGcEEtHPUG4T3Bgo3Ms3nj1In/yM7t9U=;
        b=EJfv5w/ZWX1QEldvhqOiw5aQSUlejWqRKNzcgV8qSuEZEZLDUXytrCjBH74Usx4AHt
         KTTRyC0wlNn7samtqTNFnsVbU6Emw7DYXIT73/kmU30N68qvOTUUTNRVxvpK0gm6hbrQ
         N/4mxKO605lHUduSVJACkTI+a0JJBo6MHWXe05EshogVo49B0+3ZxDsK2EFcK1YxLRVQ
         0s+M6S9yUf2kZrqzc9fIyqs+kerFlJTXf+Mq351aj/6cKD6E+FFgdYShZDuqqiNxz5Vw
         f5klaEwKexMILXJ4zarRq+eOh68j/qQmcj6QqDOQcS9AQaMtU4JGD92xpqrkmARv3ZTw
         i+ew==
X-Gm-Message-State: AOAM5312+jQOGlBOMz7L5dbPw68OHBJlvcfx+rBSAw1R4kw94HDe7aBs
        hLWmsV4Agrxm/EzqsH9iJz8x7sI2klOESTkV74pCINUXWgVCCYOmdF8NTqKeXe7jjMD3KcWd925
        bQmsmDua51GxhSA1hxnmB1Mkv
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr7111268wrn.135.1637053105602;
        Tue, 16 Nov 2021 00:58:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNnhYnmoiEKmhWbgITaAMbH06RYzALBRVXN/xZ5keEiGtxNnsHeJdzCkwXHAfqWjFKt7cxCw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr7111233wrn.135.1637053105277;
        Tue, 16 Nov 2021 00:58:25 -0800 (PST)
Received: from [192.168.3.132] (p4ff23d3a.dip0.t-ipconnect.de. [79.242.61.58])
        by smtp.gmail.com with ESMTPSA id r17sm2015005wmq.11.2021.11.16.00.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 00:58:24 -0800 (PST)
Message-ID: <d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com>
Date:   Tue, 16 Nov 2021 09:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
References: <20211115193725.737539-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.21 20:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,

Hi,

thanks for looking into this.

> 
> You suggested to make alloc_contig_range() deal with pageblock_order instead of
> MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
> patchset is my attempt to achieve that. Please take a look and let me know if
> I am doing it correctly or not.
> 
> From what my understanding, cma required alignment of
> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
> __free_one_page() does not prevent merging two different pageblocks, when
> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
> does prevent that. It should be OK to just align cma to pageblock_order.
> alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
> pageblock_order as alignment too.

I wonder if that's sufficient. Especially the outer_start logic in
alloc_contig_range() might be problematic. There are some ugly corner
cases with free pages/allocations spanning multiple pageblocks and we
only isolated a single pageblock.


Regarding CMA, we have to keep the following cases working:

a) Different pageblock types (MIGRATE_CMA and !MIGRATE_CMA) in MAX_ORDER
   - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume either pageblock 0 is MIGRATE_CMA or pageblock 1 is MIGRATE_CMA,
but not both. We have to make sure alloc_contig_range() keeps working
correctly. This should be the case even with your change, as we won't
merging pages accross differing migratetypes.

b) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume both are MIGRATE_CMA. Assume we want to either allocate from
pageblock 0 or pageblock 1. Especially, assume we want to allocate from
pageblock 1. While we would isolate pageblock 1, we wouldn't isolate
pageblock 0.

What happens if we either have a free page spanning the MAX_ORDER - 1
range already OR if we have to migrate a MAX_ORDER - 1 page, resulting
in a free MAX_ORDER - 1 page of which only the second pageblock is
isolated? We would end up essentially freeing a page that has mixed
pageblocks, essentially placing it in !MIGRATE_ISOLATE free lists ... I
might be wrong but I have the feeling that this would be problematic.

c) Concurrent allocations:
    [       MAX_ ORDER - 1     ]
    [ pageblock 0 | pageblock 1]

Assume b) but we have two concurrent CMA allocations to pageblock 0 and
pageblock 1, which would now be possible as start_isolate_page_range()
isolate would succeed on both.


Regarding virtio-mem, we care about the following cases:

a) Allocating parts from completely movable MAX_ ORDER - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume pageblock 0 and pageblock 1 are either free or contain only
movable pages. Assume we allocated pageblock 0. We have to make sure we
can allocate pageblock 1. The other way around, assume we allocated
pageblock 1, we have to make sure we can allocate pageblock 0.

Free pages spanning both pageblocks might be problematic.

b) Allocate parts of partially movable MAX_ ORDER - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume pageblock 0 contains unmovable data but pageblock 1 not: we have
to make sure we can allocate pageblock 1. Similarly, assume pageblock 1
contains unmovable data but pageblock 0 no: we have to make sure we can
allocate pageblock 1. has_unmovable_pages() might allow for that.

But, we want to fail early in case we want to allocate a single
pageblock but it contains unmovable data. This could be either directly
or indirectly.

If we have an unmovable (compound) MAX_ ORDER - 1 and we'd try isolating
pageblock 1, has_unmovable_pages() would always return "false" because
we'd simply be skiping over any tail pages, and not detect the
un-movability.

c) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:

Same concern as for CMA b)


So the biggest concern I have is dealing with migrating/freeing >
pageblock_order pages while only having isolated a single pageblock.

> 
> In terms of virtio_mem, if I understand correctly, it relies on
> alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
> guest memory size. As the result of alloc_contig_range() alignment change,
> virtio_mem should be able to just align PFNs to pageblock_order.

For virtio-mem it will most probably be desirable to first try
allocating the MAX_ORDER -1 range if possible and then fallback to
pageblock_order. But that's an additional change on top in virtio-mem code.



My take to teach alloc_contig_range() to properly handle would be the
following:

a) Convert MIGRATE_ISOLATE into a separate pageblock flag

We would want to convert MIGRATE_ISOLATE into a separate pageblock
flags, such that when we isolate a page block we preserve the original
migratetype. While start_isolate_page_range() would set that bit,
undo_isolate_page_range() would simply clear that bit. The buddy would
use a single MIGRATE_ISOLATE queue as is: the original migratetype is
only used for restoring the correct migratetype. This would allow for
restoring e.g., MIGRATE_UNMOVABLE after isolating an unmovable pageblock
(below) and not simply setting all such pageblocks to MIGRATE_MOVABLE
when un-isolating.

Ideally, we'd get rid of the "migratetype" parameter for
alloc_contig_range(). However, even with the above change we have to
make sure that memory offlining and ordinary alloc_contig_range() users
will fail on MIGRATE_CMA pageblocks (has_unmovable_page() checks that as
of today). We could achieve that differently, though (e.g., bool
cma_alloc parameter instead).


b) Allow isolating pageblocks with unmovable pages

We'd pass the actual range of interest to start_isolate_page_range() and
rework the code to check has_unmovable_pages() only on the range of
interest, but considering overlapping larger allocations. E.g., if we
stumble over a compound page, lookup the head an test if that page is
movable/unmovable.

c) Change alloc_contig_range() to not "extend" the range of interest to
include pageblock of different type. Assume we're isolating a
MIGRATE_CMA pageblock, only isolate a neighboring MIGRATE_CMA pageblock,
not other pageblocks.


So we'd keep isolating complete MAX_ORDER - 1 pages unless c) prevents
it. We'd allow isolating even pageblocks that contain unmovable pages on
ZONE_NORMAL, and check via has_unmovable_pages() only if the range of
interest contains unmovable pages, not the whole MAX_ORDER -1 range or
even the whole pageblock. We'd not silently overwrite the pageblock type
when restoring but instead restore the old migratetype.

-- 
Thanks,

David / dhildenb

