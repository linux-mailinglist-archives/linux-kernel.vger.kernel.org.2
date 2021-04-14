Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE235F12F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbhDNKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:03:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346091AbhDNKCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43ECCAED7;
        Wed, 14 Apr 2021 10:01:50 +0000 (UTC)
Date:   Wed, 14 Apr 2021 12:01:47 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <20210414100147.GD20886@linux>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
 <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHansW/OnNT6/i9d@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:28:33AM +0200, Michal Hocko wrote:
> You are right it doesn't do it there. But all struct pages, even those
> that are allocated by the bootmem allocator should initialize its struct
> pages. They would be poisoned otherwise, right? I would have to look at
> the exact code path but IIRC this should be around the time bootmem
> allocator state transitions to the page allocator.

Ok, you are right.
struct pages are initialized a bit earlier through:

start_kernel
 setup_arch
  paging_init
   zone_sizes_init
    free_area_init
     free_area_init_node
      free_area_init_core
       memmap_init_zone
        memmap_init_range
         __init_single_page

While the allocation of bootmem hugetlb happens

start_kernel
 parse_args
  ...
   hugepages_setup
    ...
     hugetlb_hstate_alloc_pages
      __alloc_bootmem_huge_page

which is after the setup_arch() call.

So by the time we get the page from __alloc_bootmem_huge_page(), fields are
zeroed.
I thought we might get in trouble because memblock_alloc_try_nid_raw() calls
page_init_poison() which poisons the chunk with 0xff,e.g:

[    1.955471] boot: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
[    1.955476] boot: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff

 but it seems that does not the memmap struct page.

I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
still zeroed, so I guess it should be safe to assume that we do not really need
to clear the flag in __prep_new_huge_page() routine?

-- 
Oscar Salvador
SUSE L3
