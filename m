Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD83FC783
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhHaMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:45:48 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:50671 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhHaMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:45:47 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id D3A76FA925
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:44:50 +0100 (IST)
Received: (qmail 23353 invoked from network); 31 Aug 2021 12:44:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2021 12:44:50 -0000
Date:   Tue, 31 Aug 2021 13:44:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Stuck looping on list_empty(list) in free_pcppages_bulk()
Message-ID: <20210831124449.GB4128@techsingularity.net>
References: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 04:12:51PM -0700, Sultan Alsawaf wrote:
> I apologize in advance for reporting a bug on an EOL kernel. I don't see any
> changes as of 5.14 that could address something like this, so I'm emailing in
> case whatever happened here may be a bug affecting newer kernels.
> 
> With gdb, it appears that the CPU got stuck in the list_empty(list) loop inside
> free_pcppages_bulk():
> ----------------8<----------------
> 	do {
> 		batch_free++;
> 		if (++migratetype == MIGRATE_PCPTYPES)
> 			migratetype = 0;
> 		list = &pcp->lists[migratetype];
> 	} while (list_empty(list));
> ---------------->8----------------
> 
> Although this code snippet is slightly different in 5.14, it's still ultimately
> the same. Side note: I noticed that the way `migratetype` is incremented causes
> `&pcp->lists[1]` to get looked at first rather than `&pcp->lists[0]`, since
> `migratetype` will start out at 1. This quirk is still present in 5.14, though
> the variable in question is now called `pindex`.
> 
> With some more gdb digging, I found that the `count` variable was stored in %ESI
> at the time of the stall. According to register dump in the splat, %ESI was 7.
> 
> It looks like, for some reason, the pcp count was 7 higher than the number of
> pages actually present in the pcp lists.
> 

That's your answer -- the PCP count has been corrupted or misaccounted.
Given this is a Fedora kernel, check for any patches affecting
mm/page_alloc.c that could be accounting related or that would affect
the IRQ disabling or zone lock acquisition for problems. Another
possibility is memory corruption -- either kernel or the hardware
itself.

> I tried to find some way that this could happen, but the only thing I could
> think of was that maybe an allocation had both __GFP_RECLAIMABLE and
> __GFP_MOVABLE set in its gfp mask, in which case the rmqueue() call in
> get_page_from_freelist() would pass in a migratetype equal to MIGRATE_PCPTYPES
> and then pages could be added to an out-of-bounds pcp list while still
> incrementing the overall pcp count. This seems pretty unlikely though.

It's unlikely because it would be an outright bug to specify both flags.

> As
> another side note, it looks like there's nothing stopping this from occurring;
> there's only a VM_WARN_ON() in gfp_migratetype() that checks if both bits are
> set.
> 

There is no explicit check for it because they should not be both set.
I don't think this happens in kernel but if an out-of-tree module did
it, it might corrupt adjacent PCPs.

-- 
Mel Gorman
SUSE Labs
