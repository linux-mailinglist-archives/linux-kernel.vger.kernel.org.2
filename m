Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8D33D98A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhCPQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:36:10 -0400
Received: from casper.infradead.org ([90.155.50.34]:44556 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbhCPQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=garaw7nLATePLtgkpZrGbhONhmMZwtuDPbU6Qhsl7Ow=; b=PaihaR5dpl3fXlb0g5BPWuOqqt
        fsWPlPNZbrV9tE0ua8idQIyBSP9NgaE3nL1JJb9oTYq3hG1PwG2L10BHcn4czOJpNPdNMLyDA/pAN
        ONzous7FSTl8hBwmT9sdsWd0+rI6lLG7Pawy9KJ5SLTOLakjtoLWFYYBtlZNMu/TPoKj079YxI1L6
        K3KID+ReEE+e6G84LcZ8hVwpUGwA1yTplXQwDGZjuNwPw9IjS80q+QBUy4rZ3dteYsJj3RlrOENEP
        RDsNsmxj2UnWZN4frcmVlAlsys3jNolzaLZa9OIZKsYaB0XTgxL+vGfSVQkg9lWww9/IgyNSSyHoU
        HpDXNl4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMCeT-000Jql-OC; Tue, 16 Mar 2021 16:34:41 +0000
Date:   Tue, 16 Mar 2021 16:34:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 11/14] mm: multigenerational lru: page activation
Message-ID: <20210316163437.GB3420@casper.infradead.org>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-12-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313075747.3781593-12-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:57:44AM -0700, Yu Zhao wrote:
> In the page fault path, we want to add pages to the per-zone lists
> index by max_seq as they cannot be evicted without going through
> the aging first. For anon pages, we rename
> lru_cache_add_inactive_or_unevictable() to lru_cache_add_page_vma()
> and add a new parameter, which is set to true in the page fault path,
> to indicate whether they should be added to the per-zone lists index
> by max_seq. For page/swap cache, since we cannot differentiate the
> page fault path from the read ahead path at the time we call
> lru_cache_add() in add_to_page_cache_lru() and
> __read_swap_cache_async(), we have to add a new function
> lru_gen_activate_page(), which is essentially activate_page(), to move
> pages to the per-zone lists indexed by max_seq at a later time.
> Hopefully we would find pages we want to activate in lru_pvecs.lru_add
> and simply set PageActive() on them without having to actually move
> them.
> 
> In the reclaim path, pages mapped around a referenced PTE may also
> have been referenced due to spatial locality. We add a new function
> lru_gen_scan_around() to scan the vicinity of such a PTE.
> 
> In addition, we add a new function page_is_active() to tell whether a
> page is active. We cannot use PageActive() because it is only set on
> active pages while they are not on multigenerational lru. It is
> cleared while pages are on multigenerational lru, in order to spare
> the aging the trouble of clearing it when an active generation becomes
> inactive. Internally, page_is_active() compares the generation number
> of a page with max_seq and max_seq-1, which are active generations and
> protected from the eviction. Other generations, which may or may not
> exist, are inactive.

If we go with this multi-LRU approach, it feels like PageActive and
PageInactive should go away as tests.  We should have a LRU field in
the page flags with some special values:

 - Not managed through LRU list
 - Not currently on any LRU list
 - Unevictable
 - Active list 1
 - Active list 2
 - ...
 - Active list 5

Now you don't need any extra bits in the page flags.  Or if you want to
have 13 lists instead of 5, you can use just one extra bit.  I'm not
quite sure whether it makes sense to have that many lists, so I need
to try to understand that better.

I'd like to echo the comments from others that it'd be nice to split apart
the multigenerational part of this and the physical scanning part of this.
It's possible they don't make performance sense without each other,
but from a review point of view, they seem entirely separate things.
