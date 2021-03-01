Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8181032A009
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575180AbhCBDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241351AbhCAWF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:05:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA236AB8C;
        Mon,  1 Mar 2021 22:05:14 +0000 (UTC)
Date:   Mon, 1 Mar 2021 23:05:12 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] mm/page_alloc: drop pr_info_ratelimited() in
 alloc_contig_range()
Message-ID: <20210301220512.GA4425@localhost.localdomain>
References: <20210301150945.77012-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301150945.77012-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:09:45PM +0100, David Hildenbrand wrote:
> The information that some PFNs are busy is:
> a) not helpful for ordinary users: we don't even know *who* called
>    alloc_contig_range(). This is certainly not worth a pr_info.*().
> b) not really helpful for debugging: we don't have any details *why*
>    these PFNs are busy, and that is what we usually care about.
> c) not complete: there are other cases where we fail alloc_contig_range()
>    using different paths that are not getting recorded.
> 
> For example, we reach this path once we succeeded in isolating pageblocks,
> but failed to migrate some pages - which can happen easily on
> ZONE_NORMAL (i.e., has_unmovable_pages() is racy) but also on ZONE_MOVABLE
> i.e., we would have to retry longer to migrate).
> 
> For example via virtio-mem when unplugging memory, we can create quite
> some noise (especially with ZONE_NORMAL) that is not of interest to
> users - it's expected that some allocations may fail as memory is busy.
> 
> Let's just drop that pr_info_ratelimit() and rather implement a dynamic
> debugging mechanism in the future that can give us a better reason why
> alloc_contig_range() failed on specific pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
