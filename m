Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703BC35F188
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhDNKd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:33:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:42510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhDNKdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:33:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618396379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4f9XVi08AUnEb2K13TH7oU76g65kV0XAZJ7MmHU+byU=;
        b=XJoXRkrBRwgetqxmgVhqJJnDosEI+hw98nimjUD/azguCxCfnAsanFB0n1WnfBjldlCycy
        8LL0mCJn39fjzqkr5pgIkTIFdSR3j0magWQP+mu76o6BvXE0ucE7oI73WU2fWznLqbv2N3
        4HqLfTjic1B2W+lEIlipjfUaMtz4Gus=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDF50AF31;
        Wed, 14 Apr 2021 10:32:59 +0000 (UTC)
Date:   Wed, 14 Apr 2021 12:32:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <YHbE2q/Otrdx1cgK@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
 <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz>
 <20210414100147.GD20886@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414100147.GD20886@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-04-21 12:01:47, Oscar Salvador wrote:
> On Wed, Apr 14, 2021 at 10:28:33AM +0200, Michal Hocko wrote:
> > You are right it doesn't do it there. But all struct pages, even those
> > that are allocated by the bootmem allocator should initialize its struct
> > pages. They would be poisoned otherwise, right? I would have to look at
> > the exact code path but IIRC this should be around the time bootmem
> > allocator state transitions to the page allocator.
> 
> Ok, you are right.
> struct pages are initialized a bit earlier through:
> 
> start_kernel
>  setup_arch
>   paging_init
>    zone_sizes_init
>     free_area_init
>      free_area_init_node
>       free_area_init_core
>        memmap_init_zone
>         memmap_init_range
>          __init_single_page
> 
> While the allocation of bootmem hugetlb happens
> 
> start_kernel
>  parse_args
>   ...
>    hugepages_setup
>     ...
>      hugetlb_hstate_alloc_pages
>       __alloc_bootmem_huge_page
> 
> which is after the setup_arch() call.

Thanks for pulling those paths. It is always painful to crawl that code.

> So by the time we get the page from __alloc_bootmem_huge_page(), fields are
> zeroed.
> I thought we might get in trouble because memblock_alloc_try_nid_raw() calls
> page_init_poison() which poisons the chunk with 0xff,e.g:
> 
> [    1.955471] boot: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> [    1.955476] boot: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> 
>  but it seems that does not the memmap struct page.

Well, to be precise it does the very same thing with memamp struct pages
but that is before the initialization code you have pointed out above.
In this context it just poisons the allocated content which is the GB
page storage.

> I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
> still zeroed, so I guess it should be safe to assume that we do not really need
> to clear the flag in __prep_new_huge_page() routine?

It would be quite nasty if the struct pages content would be undefined.
Maybe that is possible but then I would rather stick the initialization
into __alloc_bootmem_huge_page.

Thanks!
-- 
Michal Hocko
SUSE Labs
