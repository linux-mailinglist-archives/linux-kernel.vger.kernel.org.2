Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9E31DF40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhBQSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:51:17 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:35219 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232565AbhBQSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:51:11 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 7AAE9FA8EE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 18:50:17 +0000 (GMT)
Received: (qmail 21941 invoked from network); 17 Feb 2021 18:50:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2021 18:50:17 -0000
Date:   Wed, 17 Feb 2021 18:50:16 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, compaction: make fast_isolate_freepages() stay
 within zone
Message-ID: <20210217185015.GF3697@techsingularity.net>
References: <20210217173300.6394-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210217173300.6394-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 06:33:00PM +0100, Vlastimil Babka wrote:
> Compaction always operates on pages from a single given zone when isolating
> both pages to migrate and freepages. Pageblock boundaries are intersected with
> zone boundaries to be safe in case zone starts or ends in the middle of
> pageblock. The use of pageblock_pfn_to_page() protects against non-contiguous
> pageblocks.
> 
> The functions fast_isolate_freepages() and fast_isolate_around() don't
> currently protect the fast freepage isolation thoroughly enough against these
> corner cases, and can result in freepage isolation operate outside of zone
> boundaries:
> 
> - in fast_isolate_freepages() if we get a pfn from the first pageblock of a
>   zone that starts in the middle of that pageblock, 'highest' can be a pfn
>   outside of the zone. If we fail to isolate anything in this function, we
>   may then call fast_isolate_around() on a pfn outside of the zone and there
>   effectively do a set_pageblock_skip(page_to_pfn(highest)) which may currently
>   hit a VM_BUG_ON() in some configurations
> - fast_isolate_around() checks only the zone end boundary and not beginning,
>   nor that the pageblock is contiguous (with pageblock_pfn_to_page()) so it's
>   possible that we end up calling isolate_freepages_block() on a range of pfn's
>   from two different zones and end up e.g. isolating freepages under the wrong
>   zone's lock.
> 
> This patch should fix the above issues.
> 
> Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
