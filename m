Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1735C85E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbhDLOJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:09:20 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:60239 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242221AbhDLOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:09:12 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id D5203FBAF7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:08:53 +0100 (IST)
Received: (qmail 10961 invoked from network); 12 Apr 2021 14:08:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 14:08:53 -0000
Date:   Mon, 12 Apr 2021 15:08:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <20210412140852.GZ3697@techsingularity.net>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:40:18PM +0200, Vlastimil Babka wrote:
> On 4/12/21 2:08 PM, Mel Gorman wrote:
> > zone_pcp_reset allegedly protects against a race with drain_pages
> > using local_irq_save but this is bogus. local_irq_save only operates
> > on the local CPU. If memory hotplug is running on CPU A and drain_pages
> > is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> > offers no protection.
> > 
> > This patch deletes IRQ disable/enable on the grounds that IRQs protect
> > nothing and assumes the existing hotplug paths guarantees the PCP cannot be
> > used after zone_pcp_enable(). That should be the case already because all
> > the pages have been freed and there is no page to put on the PCP lists.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Yeah the irq disabling here is clearly bogus, so:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks!

> But I think Michal has a point that we might best leave the pagesets around, by
> a future change. I'm have some doubts that even with your reordering of the
> reset/destroy after zonelist rebuild in v1 they cant't be reachable. We have no
> protection between zonelist rebuild and zonelist traversal, and that's why we
> just leave pgdats around.
> 
> So I can imagine a task racing with memory hotremove might see watermarks as ok
> in get_page_from_freelist() for the zone and proceeds to try_this_zone:, then
> gets stalled/scheduled out while hotremove rebuilds the zonelist and destroys
> the pcplists, then the first task is resumed and proceeds with rmqueue_pcplist().
> 
> So that's very rare thus not urgent, and this patch doesn't make it less rare so
> not a reason to block it.
> 

After v1 of the patch, the race was reduced to the point between the
zone watermark check and the rmqueue_pcplist but yes, it still existed.
Closing it completely was either complex or expensive. Setting
zone->pageset = &boot_pageset before the free would shrink the race
further but that still leaves a potential memory ordering issue.

While fixable, it's either complex, expensive or both so yes, just leaving
the pageset structures in place would be much more straight-forward
assuming the structures were not allocated in the zone that is being
hot-removed. As things stand, I had trouble even testing zone hot-remove
as there was always a few pages left behind and I did not chase down
why. The focus was getting rid of the bogus local_irq_save() because
it was clearly wrong and offering a false sense of safety and the last
problematic local_irq_save() user in page_alloc.c when local_lock is used
to protect the PCP structures.

-- 
Mel Gorman
SUSE Labs
