Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2E3E39DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhHHK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 06:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhHHK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 06:27:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB6C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nJSEr6dgSE+SMhKjhRnVer4kjNRkJDPVR9Jv8j+ruPQ=; b=l7WuTEAsSXMuiRzv2lbDsuF6Lg
        aVxQWuFcSrR9Yep16udEPOdBE+BdlO43Li5RBxB8ujatBbcGhwd08/fwTGcUnmqWFrpEFhNa5aCwY
        1oEkh2CZJrOnPFQQyVR7e8VjfIvy0aQGLjXe1WAhvFafyeZIR+hRFr+tOFz1CyenHD6Ish/Bx/tuy
        yNlVME9ArpNRBPyblHrKWVLpZTHDNe1VFz2jUHkT5JMjEU3gX2ye1n2d/A2fHWcVALnzu4zbYew94
        mOhJzxaBPyR5sUal76A25754PrgRErJ4B3GlTZk1fmxnFv/TmQ+obqzFa4bWlTVTho3vGHWBjlkiY
        KILq2m2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCg0O-009urQ-Rb; Sun, 08 Aug 2021 10:26:17 +0000
Date:   Sun, 8 Aug 2021 11:26:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
Message-ID: <YQ+xQDFdU2SVSo5M@casper.infradead.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
 <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
 <YQ3puWSgUvfvIYjv@casper.infradead.org>
 <36956352-246a-b3c2-3ade-2a6c22e2cd5a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36956352-246a-b3c2-3ade-2a6c22e2cd5a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 10:55:30AM +0800, Baolin Wang wrote:
> Hi,
> 
> > On Fri, Aug 06, 2021 at 11:07:18AM +0800, Baolin Wang wrote:
> > > Hi Matthew,
> > > 
> > > > On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
> > > > > We've got the expected count for anonymous page or file page by
> > > > > expected_page_refs() at the beginning of migrate_page_move_mapping(),
> > > > > thus we should move the page count validation a little forward to
> > > > > reduce duplicated code.
> > > > 
> > > > Please add an explanation to the changelog for why it's safe to pull
> > > > this out from under the i_pages lock.
> > > 
> > > Sure. In folio_migrate_mapping(), we are sure that the migration page was
> > > isolated from lru list and locked, so I think there are no race to get the
> > > page count without i_pages lock. Please correct me if I missed something
> > > else. Thanks.
> > 
> > Unless the page has been removed from i_pages, this isn't a correct
> > explanation.  Even if it has been removed from i_pages, unless an
> > RCU grace period has passed, another CPU may still be able to inc the
> > refcount on it (temporarily).  The same is true for the page tables,
> > by the way; if someone is using get_user_pages_fast(), they may still
> > be able to see the page.
> 
> I don't think this is an issue, cause now we've established a migration pte
> for this migration page under page lock. If the user want to get page by
> get_user_pages_fast(), it will wait for the page miggration finished by
> migration_entry_wait(). So I still think there is no need to check the
> migration page count under the i_pages lock.

I don't know whether the patch is correct or not, but you aren't nearly
paranoid enough.  Consider this sequence of events:

CPU 0:				CPU 1:
get_user_pages_fast()
lockless_pages_from_mm()
local_irq_save()
gup_pgd_range()
gup_p4d_range()
gup_pud_range()
gup_pmd_range()
gup_pte_range()
pte_t pte = ptep_get_lockless(ptep);
				migrate_vma_collect_pmd()
				ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl)
				ptep_get_and_clear(mm, addr, ptep);
page = pte_page(pte);
				set_pte_at(mm, addr, ptep, swp_pte);
				migrate_page_move_mapping()
head = try_grab_compound_head(page, 1, flags);

... now page's refcount is temporarily higher than it should be.  CPU 0
will notice the PTE is no longer the PTE that it used to be and drop
the reference, but in the meantime, CPU 1 can observe the higher refcount.

None of this has anything to do with the i_pages lock.  Holding it does
not protect from this race, but you need to know this kind of thing to
decide if changing how we test a page's refcount is safe or not.
