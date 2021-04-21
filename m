Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147C1366698
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhDUIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:01:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:49556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhDUIBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:01:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 303F8B127;
        Wed, 21 Apr 2021 08:00:39 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:00:36 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
Message-ID: <20210421080036.GC22456@linux>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-4-osalvador@suse.de>
 <YH6i09ieDte+xog8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6i09ieDte+xog8@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:45:55AM +0200, Michal Hocko wrote:
> On Fri 16-04-21 13:24:06, Oscar Salvador wrote:
> > From: David Hildenbrand <david@redhat.com>
> > 
> > Let's have a single place (inspired by adjust_managed_page_count()) where
> > we adjust present pages.
> > In contrast to adjust_managed_page_count(), only memory onlining/offlining
> > is allowed to modify the number of present pages.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Not sure self review counts ;)

Uhm, the original author is David, I just added my signed-off-by as a deliverer.
I thought that in that case was ok to stick my Reviewed-by.
Or maybe my signed-off-by carries that implicitly.

> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Btw. I strongly suspect the resize lock is quite pointless here.
> Something for a follow up patch.

What makes you think that?
I have been thinking about this, let us ignore this patch for a moment.

If I poked the code correctly, node_size_lock is taken in:

remove_pfn_range_from_zone()
move_pfn_range_to_zone()

both of them handling {zone,node}->spanned_pages

Then we take it in {offline,online}_pages() for {zone,node}->present_pages.

The other places where we take it are __init functions, so not of interest.

Given that {offline,online}_pages() is serialized by the memory_hotplug lock,
I would say that {node,zone}->{spanned,present}_pages is, at any time, stable?
So, no need for the lock even without considering this patch?

Now, getting back to this patch.
adjust_present_page_count() will be called from memory_block_online(), which
is not holding the memory_hotplug lock yet.
But, we only fiddle with present pages out of {online,offline}_pages() if
we have vmemmap pages, and since that operates on the same memory block,
its lock should serialize that.

I think I went down a rabbit hole, I am slightly confused now.


-- 
Oscar Salvador
SUSE L3
