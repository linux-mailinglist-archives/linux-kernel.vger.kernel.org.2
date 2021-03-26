Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4734AB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCZPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhCZPbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:31:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616772666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l85zI45pbuMWoAzo0p6ErM5hujVeJN58V0g4dKqDYX0=;
        b=qYtYmd+SLUuGER2fN/XkEBE/ShbUtbsYenhkTWB0XfZVa7WFtv0e6ydialAj50NSX4ji84
        7CYO8J0TfRMqDrCKDXylc7YQlESNTYnMl+i+sluxnohZunFpPfJPT9i+CjV4L3JzYWBG6i
        O1Hv9sNg5pfblfgZFqMJHbw5aKHraOA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EF78AD8D;
        Fri, 26 Mar 2021 15:31:06 +0000 (UTC)
Date:   Fri, 26 Mar 2021 16:31:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF3+OWstWA9LIX95@dhcp22.suse.cz>
References: <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
 <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
 <5be95091-b4ac-8e05-4694-ac5c65f790a4@redhat.com>
 <YF3x8BW1+2o50mds@dhcp22.suse.cz>
 <0e735ea7-b3d9-615e-6bba-fa3a16883226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e735ea7-b3d9-615e-6bba-fa3a16883226@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-03-21 15:53:41, David Hildenbrand wrote:
> On 26.03.21 15:38, Michal Hocko wrote:
> > On Fri 26-03-21 09:52:58, David Hildenbrand wrote:
[...]
> > > 2. We won't allocate kasan shadow memory. We most probably have to do it
> > > explicitly via kasan_add_zero_shadow()/kasan_remove_zero_shadow(), see
> > > mm/memremap.c:pagemap_range()
> > 
> > I think this is similar to the above. Does kasan has to know about
> > memory which will never be used for anything?
> 
> IIRC, kasan will track read/writes to the vmemmap as well. So it could
> theoretically detect if we read from the vmemmap before writing
> (initializing) it IIUC.
> This is also why mm/memremap.c does a kasan_add_zero_shadow() before the
> move_pfn_range_to_zone()->memmap_init_range() for the whole region,
> including altmap space.
> 
> Now, I am no expert on KASAN, what would happen in case we have access to
> non-tracked memory.
> 
> commit 0207df4fa1a869281ddbf72db6203dbf036b3e1a
> Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Date:   Fri Aug 17 15:47:04 2018 -0700
> 
>     kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN
> 
> indicates that kasan will crash the system on "non-existent shadow memory"

Interesting. Thanks for the pointer.

> > > Further a locking rework might be necessary. We hold the device hotplug
> > > lock, but not the memory hotplug lock. E.g., for get_online_mems(). Might
> > > have to move that out online_pages.
> > 
> > Could you be more explicit why this locking is needed? What it would
> > protect from for vmemmap pages?
> > 
> 
> One example is in mm/kmemleak.c:kmemleak_scan(), where we scan the vmemmap
> for pointers. We don't want the vmemmap to get unmapped while we are working
> on it (-> fault).
 
Hmm, but they are not going away during offline. They just have a less
defined state. Or what exactly do you mean by unmapped?
-- 
Michal Hocko
SUSE Labs
