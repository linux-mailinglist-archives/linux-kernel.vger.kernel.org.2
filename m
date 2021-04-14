Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413A635EE92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbhDNHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349701AbhDNHl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:41:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0D6FAE72;
        Wed, 14 Apr 2021 07:41:34 +0000 (UTC)
Date:   Wed, 14 Apr 2021 09:41:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <20210414074132.GB20401@linux>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:04:21AM +0200, Michal Hocko wrote:
> On Tue 13-04-21 14:19:03, Mike Kravetz wrote:
> > On 4/13/21 6:23 AM, Michal Hocko wrote:
> > The only place where page->private may not be initialized is when we do
> > allocations at boot time from memblock.  In this case, we will add the
> > pages to the free list via put_page/free_huge_page so the appropriate
> > flags will be cleared before anyone notices.
> 
> Pages allocated by the bootmem should be pre initialized from the boot,
> no?

I guess Mike means:

hugetlb_hstate_alloc_pages
 alloc_bootmem_huge_page
  __alloc_bootmem_huge_page
   memblock_alloc_try_nid_raw

and AFAICS, memblock_alloc_try_nid_raw() does not zero the memory.

Then these pages are initialized in:

gather_bootmem_prealloc
 prep_compound_huge_page
 prep_new_huge_page

But as can be noticed, no one touches page->private when coming from that
path.

-- 
Oscar Salvador
SUSE L3
