Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597AB348E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCYKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhCYKzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:55:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 333A8ADD7;
        Thu, 25 Mar 2021 10:55:04 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:55:01 +0100
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
Message-ID: <YFxsBRORtgqUF/FZ@localhost.localdomain>
References: <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:17:33AM +0100, Michal Hocko wrote:
> Why do you think it is wrong to initialize/account pages when they are
> used? Keep in mind that offline pages are not used until they are
> onlined. But vmemmap pages are used since the vmemmap is established
> which happens in the hotadd stage.

Yes, that is true.
vmemmap pages are used right when we populate the vmemmap space.

> > plus the fact that I dislike to place those pages in
> > ZONE_NORMAL, although they are not movable.
> > But I think the vmemmap pages should lay within the same zone the pages
> > they describe, doing so simplifies things, and I do not see any outright
> > downside.
> 
> Well, both ways likely have its pros and cons. Nevertheless, if the
> vmemmap storage is independent (which is the case for normal hotplug)
> then the state is consistent over hotadd, {online, offline} N times,
> hotremove cycles.  Which is conceptually reasonable as vmemmap doesn't
> go away on each offline.
> 
> If you are going to bind accounting to the online/offline stages then
> the accounting changes each time you go through the cycle and depending
> on the onlining type it would travel among zones. I find it quite
> confusing as the storage for vmemmap hasn't changed any of its
> properties.

That is a good point I guess.
vmemmap pages do not really go away until the memory is unplugged.

But I see some questions to raise:

- As I said, I really dislike it tiding vmemmap memory to ZONE_NORMAL
  unconditionally and this might result in the problems David mentioned.
  I remember David and I discussed such problems but the problems with
  zones not being contiguos have also been discussed in the past and
  IIRC, we reached the conclusion that a maximal effort should be made
  to keep them that way, otherwise other things suffer e.g: compaction
  code.
  So if we really want to move the initialization/account to the
  hot-add/hot-remove stage, I would really like to be able to set the
  proper zone in there (that is, the same zone where the memory will lay).

- When moving the initialization/accounting to hot-add/hot-remove,
  the section containing the vmemmap pages will remain offline.
  It might get onlined once the pages get online in online_pages(),
  or not if vmemmap pages span a whole section.
  I remember (but maybe David rmemeber better) that that was a problem
  wrt. pfn_to_online_page() and hybernation/kdump.
  So, if that is really a problem, we would have to care of ot setting
  the section to the right state.

- AFAICS, doing all the above brings us to former times were some
  initialization/accounting was done in a previous stage, and I remember
  it was pushed hard to move those in online/offline_pages().
  Are we ok with that?
  As I said, we might have to set the right zone in hot-add stage, as
  otherwise problems might come up.
  Being that case, would not that also be conflating different concepts
  at a wrong phases?

Do not take me wrong, I quite like Michal's idea, and from a
conceptually point of view I guess it is the right thing to do.
But when evualating risks/difficulty, I am not really sure.

If we can pull that off while setting the right zone (and must be seen
what about the section state), and the outcome is not ugly, I am all for
it.
Also a middel-ground might be something like I previously mentioned(having
a helper in memory_block_action() to do the right thing, so
offline/online_pages() do not get pouled.

 
-- 
Oscar Salvador
SUSE L3
