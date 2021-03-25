Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03FC34938F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhCYOCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCYOCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90A38ADAA;
        Thu, 25 Mar 2021 14:02:29 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:02:26 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFyX8jRWqfqCoGo/@localhost.localdomain>
References: <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <YFyBeulR04Oc7eu2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyBeulR04Oc7eu2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 01:26:34PM +0100, Michal Hocko wrote:
> Yeah, David has raised the contiguous flag for zone already. And to be
> completely honest I fail to see why we should shape a design based on an
> optimization. If anything we can teach set_zone_contiguous to simply
> ignore zone affiliation of vmemmap pages. I would be really curious if
> that would pose any harm to the compaction code as they are reserved and
> compaction should simply skip them.

No, compaction code is clever enough to skip over those pages as it
already does for any Reserved page.
My comment was more towards having the zone contiguous.

I know it is an optimization, but

 commit 7cf91a98e607c2f935dbcc177d70011e95b8faff
 Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
 Date:   Tue Mar 15 14:57:51 2016 -0700
 
 mm/compaction: speed up pageblock_pfn_to_page() when zone is contiguous

talks about 30% of improvment. I am not sure if those numbers would
still hold nowawadys, but it feels wrong to drop it to the ground when
we can do better there, and IMHO, it does not overly complicate things.

> THere is nothing like a proper zone.

I guess not, but for me it makes sense that vmemmap pages stay within
the same zone as the pages they describe.
Of course, this is a matter of opinions/taste.

> Not sure what you are referring to but if you have prior to f1dd2cd13c4b
> ("mm, memory_hotplug: do not associate hotadded memory to zones until
> online") then this was entirely a different story. Users do care where
> they memory goes because that depends on the usecase but do they care
> about vmemmap?

As I said, that is not what I am worried about.
Users do not really care where those pages end up, that is transparent
to them (wrt. vmemmap pages), but we (internally) kind of do.

So, as I said, I see advantatges of using your way, but I see downsides
as:

- I would like to consider zone, and for that we would have to pull
  some of the functions that check for the zone at an aearly stage, and
  the mere thought sounds ugly.
- Section containing vmemmap can remain offline and would have to come
  up to sort that out

Of course, the big advantatge is that we do things at its right time.

Now, doing things as David and I suggested (that is, create a helper to
do the accounting/initialization of vmemmap at online stage but without
populing online/offline_pages()) has the downside of messing with
different concepts that have different lifecycle, but I see an enormous
advantatge and that is it keeps things fairly simple.


I do not want to be seen that I am pushing back just for the sake of
doing so, and I am more than open to explore other means.
Actually, the code has evolved and re-shaped quite a lot since its beginning,
so nothing really speaks against it, but I think the idea of the helper
is less troublesome and simple.

-- 
Oscar Salvador
SUSE L3
