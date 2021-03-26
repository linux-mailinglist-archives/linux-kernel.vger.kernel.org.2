Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F335434A6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCZMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:16:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:47056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhCZMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:15:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0767CAD8D;
        Fri, 26 Mar 2021 12:15:47 +0000 (UTC)
Date:   Fri, 26 Mar 2021 13:15:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF3QcJ2Hd8LNMEgU@localhost.localdomain>
References: <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
 <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
 <YF2iBxueewnKIG3V@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF2iBxueewnKIG3V@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 09:57:43AM +0100, Oscar Salvador wrote:
> On Fri, Mar 26, 2021 at 09:52:58AM +0100, David Hildenbrand wrote:
> > Might have to set fully spanned section online. (vmemmap >= SECTION_SIZE)

Bleh, this morning I was in a rush and I could not think straight.
I got what you mean now.

Yes, if vmemmap pages fully span a section, we need to online that
section before calling online_pages(), otherwise we would left that
section offline.


> > We'll not call the memory notifier (e.g., MEM_ONLINE) for the vmemmap. The

Well, since it is not actual memory we might do not need to, but

> > 1. We won't allocate extended struct pages for the range. Don't think this
> > is really problematic (pages are never allocated/freed, so I guess we don't
> > care - like ZONE_DEVICE code).

Probably not worth for vmemmap

> > 
> > 2. We won't allocate kasan shadow memory. We most probably have to do it
> > explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
> > mm/memremap.c:pagemap_range()

we should be calling those kasan_{add,remove}.
We can stuff that into the vmemmap helpers, so everything remains
contained.

> > 
> > 
> > Further a locking rework might be necessary. We hold the device hotplug
> > lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
> > have to move that out online_pages.

That is a good point.
I yet have to think about it further, but what about moving those
mem_hotplug_{begin,done} to memory_block_{offline,online}.

Something like:

 static int memory_block_online(...)
 {
         int ret;
 
         mem_hotplug_begin();
 
         if (nr_vmemmap_pages)
                 vmemmap_hotplug_init();
 
         ret = online_pages(...);
         if (ret)
 	/*
 	 * Cleanup stuff
 	 */
 
         mem_hotplug_done();
 }
	 
As you said, you finished cleaning up those users who were calling
{online,offline}_pages() directly, but is this something that we will
forbidden in the future too?
My question falls within "Are we sure we will not need that locking back
in those functions because that is something we will not allow to
happen?"
        

-- 
Oscar Salvador
SUSE L3
