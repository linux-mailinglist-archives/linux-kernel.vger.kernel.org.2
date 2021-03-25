Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91043348B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYIHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:07:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhCYIHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:07:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8E8FAA55;
        Thu, 25 Mar 2021 08:07:06 +0000 (UTC)
Date:   Thu, 25 Mar 2021 09:07:03 +0100
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
Message-ID: <YFxEp0cfcJmcz5bP@localhost.localdomain>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:16:53PM +0100, David Hildenbrand wrote:
> > > 1. If the underlying memory block is offline, all sections are offline. Zone
> > > shrinking code will happily skip over the vmemmap pages and you can end up
> > > with out-of-zone pages assigned to the zone. Can happen in corner cases.
> > 
> > You are right. But do we really care? Those pages should be of no
> > interest to anybody iterating through zones/nodes anyway.
> 
> Well, we were just discussing getting zone/node links + span right for all
> pages (including for special reserved pages), because it already resulted in
> BUGs. So I am not convinced that we *don't* have to care.
> 
> However, I agree that most code that cares about node/zone spans shouldn't
> care - e.g., never call set_pfnblock_flags_mask() on such blocks.
> 
> But I guess there are corner cases where we would end up with
> zone_is_empty() == true, not sure what that effect would be ... at least the
> node cannot vanish as we disallow offlining it while we have a memory block
> linked to it.

Having quickly looked at Michal's change, I have to say that it does not
look that bad, but I think it is doing the initialization/accounting at
the wrong stage, plus the fact that I dislike to place those pages in
ZONE_NORMAL, although they are not movable.
But I think the vmemmap pages should lay within the same zone the pages
they describe, doing so simplifies things, and I do not see any outright
downside.

Back in the old days, we used to have this sort of
unitilization/tearing-down of pages at hot-add/hot-remove stage, and we
moved from there because of many problems we had.
While we might not encounter those problems with vmemmap pages because of
their nature, I think that not sticking with the right place might bring
problems as David outlined.

IMHO, initizalization and accounting should be done in online/offline
stage.
Now, the problems seems to be that doing it right in
offline_pages()/online_pages() seems a bad practice and conflates with
different concept.

This is just an idea I did not get to think carefully, but what if we
do it in helpers right before calling online_pages()/offline_pages()
in memory_block_action() ?
I have to confess that I do not really like the idea, but would solve do
the right things at the right stage.

One last thing.
Let us try to avoid things like "we do not care". Hotplug code was full
of "we do not care" assumptions that bit us in the ass at some point.



-- 
Oscar Salvador
SUSE L3
