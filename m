Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F1347622
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhCXKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:31:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhCXKbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3241AACBF;
        Wed, 24 Mar 2021 10:31:10 +0000 (UTC)
Date:   Wed, 24 Mar 2021 10:31:04 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] mm: activate access-more-than-once page via NUMA balancing
Message-ID: <20210324103104.GN15768@suse.de>
References: <20210324083209.527427-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210324083209.527427-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:32:09PM +0800, Huang Ying wrote:
> One idea behind the LRU page reclaiming algorithm is to put the
> access-once pages in the inactive list and access-more-than-once pages
> in the active list.  This is true for the file pages that are accessed
> via syscall (read()/write(), etc.), but not for the pages accessed via
> the page tables.  We can only activate them via page reclaim scanning
> now.  This may cause some problems.  For example, even if there are
> only hot file pages accessed via the page tables in the inactive list,
> we will enable the cache trim mode incorrectly to scan only the hot
> file pages instead of cold anon pages.
> 

I caution against this patch.

It's non-deterministic for a number of reasons. As it requires NUMA
balancing to be enabled, the pageout behaviour of a system changes when
NUMA balancing is active. If this led to pages being artificially and
inappropriately preserved, NUMA balancing could be disabled for the
wrong reasons.  It only applies to pages that have no target node so
memory policies affect which pages are activated differently. Similarly,
NUMA balancing does not scan all VMAs and some pages may never trap a
NUMA fault as a result. The timing of when an address space gets scanned
is driven by the locality of pages and so the timing of page activation
potentially becomes linked to whether pages are local or need to migrate
(although not right now for this patch as it only affects pages with a
target nid of NUMA_NO_NODE). In other words, changes in NUMA balancing
that affect migration potentially affect the aging rate.  Similarly,
the activate rate of a process with a single thread and multiple threads
potentially have different activation rates.

Finally, the NUMA balancing scan algorithm is sub-optimal. It potentially
scans the entire address space even though only a small number of pages
are scanned. This is particularly problematic when a process has a lot
of threads because threads are redundantly scanning the same regions. If
NUMA balancing ever introduced range tracking of faulted pages to limit
how much scanning it has to do, it would inadvertently cause a change in
page activation rate.

NUMA balancing is about page locality, it should not get conflated with
page aging.

-- 
Mel Gorman
SUSE Labs
