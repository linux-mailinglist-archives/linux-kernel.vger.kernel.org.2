Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED7232499E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhBYD5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhBYD5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:57:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D358C061756
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+VTPtIMpGcN6w4RmHgdNd6IeFShUVJwNrk2/joKyueI=; b=Ix980A7Htoh/OVX8qDJG1830M0
        534uvDXukdDuARYmNGKRCsAPzCSY0/FaIZ7C9K3IFEX/87LZcG5yvzefbOVgc0Dxgo8HNHqI32pUO
        Y7Bqa9N4Od4d/Xnvtb6HRS+UHubyn83ex3t25iC0FCBQ6TvUTu4ZjAjw0Cs2R5/mwtwSXyBYu77R+
        c3dl9eG05Oa6VBYWscUONyPBIBB2sAnVAStyKcCItwcvER9L5e2HXxHs42K76fFrTkligVOBmnWIo
        1xen+66NsgqfNF47qGt8JtWfvXQNF8MmfBlzmeOqa/LGVgSXJOMGR+0L3gK4qjfZhu0WaTHQWUXlT
        5JkjGxKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF7kn-00AEba-SP; Thu, 25 Feb 2021 03:55:58 +0000
Date:   Thu, 25 Feb 2021 03:55:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <20210225035553.GX2858050@casper.infradead.org>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
 <YDbUaJ0j2YisyyuK@google.com>
 <20210224224846.GU2858050@casper.infradead.org>
 <YDbmT87E106uS1Xa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDbmT87E106uS1Xa@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:50:39PM -0700, Yu Zhao wrote:
> On Wed, Feb 24, 2021 at 10:48:46PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 24, 2021 at 03:34:16PM -0700, Yu Zhao wrote:
> > > > If only somebody were working on a patch series to get rid of
> > > > all those calls to compound_head()!  Some reviews on
> > > > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > > > would be nice.
> > > 
> > > I'm on board with the idea and have done some research in this
> > > direction. We've found that the ideal *anon* page size for Chrome OS
> > > is not 4KB or 2MB, but 32KB. I hope we could leverage the folio to
> > > support flexible anon page size to reduce the number of page faults
> > > (vs 4KB) or internal fragmentation (vs 2MB).
> > > 
> > > That being said, it seems to me this is a long term plan and right
> > > now we need something smaller. So if you don't mind, I'll just go
> > > ahead and remove compound_head() from Page{LRU,Active,Unevictable,
> > > SwapBacked} first?
> > 
> > It's really not a big change I'm suggesting here.  You need
> > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > https://lore.kernel.org/linux-mm/20210128070404.1922318-5-willy@infradead.org/
> > https://lore.kernel.org/linux-mm/20210128070404.1922318-8-willy@infradead.org/
> > and then the patch I sent above to create folio_lru().
> > 
> > Then any changes you want to make to use folios more broadly will
> > incrementally move us towards your goal of 32kB anon pages.
> 
> Well, these patches introduce a new concept which I'm on board with.

It's not really a new concept ... it's a new type for an existing concept
(a head page).

> Assume everybody else is too, it still seems to me it's an overkill
> to employee folio to just get rid of unnecessary compound_head()
> in page_lru() -- this is not a criticism but a compliment.

It's not overkill, that really is the point of a folio!  If you
think about it, only head pages can be on the LRU list (because the
compound_head is in the union with the lru list_head).  So it
always makes sense to talk about folios on the LRU list.

> Let me work out something *conceptually* smaller first, and if you
> think folio is absolutely more suitable even for this specific issue,
> I'll go review and test the four patches you listed. Sounds good?

Umm.  It seems to me that no matter what you do, it'll be equivalent to
this, only without the type-safety?
