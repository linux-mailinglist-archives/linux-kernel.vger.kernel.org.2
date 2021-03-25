Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548F43487ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCYEeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:34:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:16247 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYEdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:33:53 -0400
IronPort-SDR: 8NhqkR12VuZuz81RaWDvTU8vii4T/cVt2dPgOPHnGCdcEgzo8LZoiSzqbez0fM7MLbTHJit6AC
 po9nOYAOezbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170196236"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="170196236"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 21:33:52 -0700
IronPort-SDR: tHzt6cDrvoXuM/B9IGFOlkl8C4CZ/SkFxnqjMFGxCrgd2mWO858Q7kA6kMaAfmyJxC890w06V1
 zMkd7Ssg1j+g==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="452882743"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 21:33:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] mm: activate access-more-than-once page via NUMA balancing
References: <20210324083209.527427-1-ying.huang@intel.com>
        <20210324103104.GN15768@suse.de>
Date:   Thu, 25 Mar 2021 12:33:45 +0800
In-Reply-To: <20210324103104.GN15768@suse.de> (Mel Gorman's message of "Wed,
        24 Mar 2021 10:31:04 +0000")
Message-ID: <87a6qrj1hy.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Thanks for comment!

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Mar 24, 2021 at 04:32:09PM +0800, Huang Ying wrote:
>> One idea behind the LRU page reclaiming algorithm is to put the
>> access-once pages in the inactive list and access-more-than-once pages
>> in the active list.  This is true for the file pages that are accessed
>> via syscall (read()/write(), etc.), but not for the pages accessed via
>> the page tables.  We can only activate them via page reclaim scanning
>> now.  This may cause some problems.  For example, even if there are
>> only hot file pages accessed via the page tables in the inactive list,
>> we will enable the cache trim mode incorrectly to scan only the hot
>> file pages instead of cold anon pages.
>> 
>
> I caution against this patch.
>
> It's non-deterministic for a number of reasons. As it requires NUMA
> balancing to be enabled, the pageout behaviour of a system changes when
> NUMA balancing is active. If this led to pages being artificially and
> inappropriately preserved, NUMA balancing could be disabled for the
> wrong reasons.  It only applies to pages that have no target node so
> memory policies affect which pages are activated differently. Similarly,
> NUMA balancing does not scan all VMAs and some pages may never trap a
> NUMA fault as a result. The timing of when an address space gets scanned
> is driven by the locality of pages and so the timing of page activation
> potentially becomes linked to whether pages are local or need to migrate
> (although not right now for this patch as it only affects pages with a
> target nid of NUMA_NO_NODE). In other words, changes in NUMA balancing
> that affect migration potentially affect the aging rate.  Similarly,
> the activate rate of a process with a single thread and multiple threads
> potentially have different activation rates.
>
> Finally, the NUMA balancing scan algorithm is sub-optimal. It potentially
> scans the entire address space even though only a small number of pages
> are scanned. This is particularly problematic when a process has a lot
> of threads because threads are redundantly scanning the same regions. If
> NUMA balancing ever introduced range tracking of faulted pages to limit
> how much scanning it has to do, it would inadvertently cause a change in
> page activation rate.
>
> NUMA balancing is about page locality, it should not get conflated with
> page aging.

I understand your concerns about binding the NUMA balancing and page
reclaiming.  The requirement of the page locality and page aging is
different, so the policies need to be different.  This is the wrong part
of the patch.

From another point of view, it's still possible to share some underlying
mechanisms (and code) between them.  That is, scanning the page tables
to make pages unaccessible and capture the page accesses via the page
fault.  Now these page accessing information is used for the page
locality.  Do you think it's a good idea to use these information for
the page aging too (but with a different policy as you pointed out)?

From yet another point of view :-), in current NUMA balancing
implementation, it's assumed that the node private pages can fit in the
accessing node.  But this may be not always true.  Is it a valid
optimization to migrate the hot private pages first?

Best Regards,
Huang, Ying
