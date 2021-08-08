Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF48E3E3B3F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 18:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhHHQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHHQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:02:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3040C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XLXYcBeoKTT5ZkFSI8EZN5mp95T20OMCOy+Eix1Rw3k=; b=Q3EtDv9ZePEpF0v9ZRnKPrKRSi
        sGwwecqgRxr3YGcyu+7rnF1ZfycQpL0uAbdCkj/dhdVSaQpakWCge+7R9Fan4gvpeLxGfvUekMdvA
        iuI6+cPyP0Fa4/lM7jphXYaWoO+rRxoz90EzFM9gf9CwcWijIuG/neRXVibjJT8NBdxM93lKNs8xc
        zAquBx9crRMxdS5skLekAU8FEHPlcCS9hxkSawQ28OM821ONw/6MBq9ywN3KiMU1h0Jf6ksxtGCet
        IhpVcF0iSjGCH1yfYSzLTvyC/qdM0Grq1NAcmgq6MfIrxEsPaauXBF+rDPn/X8+aYDyVbUelIgKQi
        UsB7ReWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mClEa-00A6ZE-CY; Sun, 08 Aug 2021 16:01:33 +0000
Date:   Sun, 8 Aug 2021 17:01:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
Message-ID: <YQ//xFekzbMODFXy@casper.infradead.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
 <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
 <YQ3puWSgUvfvIYjv@casper.infradead.org>
 <36956352-246a-b3c2-3ade-2a6c22e2cd5a@linux.alibaba.com>
 <YQ+xQDFdU2SVSo5M@casper.infradead.org>
 <4f25b4e9-0069-1749-32cf-d4644f13be4e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f25b4e9-0069-1749-32cf-d4644f13be4e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 11:13:28PM +0800, Baolin Wang wrote:
> On 2021/8/8 18:26, Matthew Wilcox wrote:
> > On Sun, Aug 08, 2021 at 10:55:30AM +0800, Baolin Wang wrote:
> > > Hi,
> > > 
> > > > On Fri, Aug 06, 2021 at 11:07:18AM +0800, Baolin Wang wrote:
> > > > > Hi Matthew,
> > > > > 
> > > > > > On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
> > > > > > > We've got the expected count for anonymous page or file page by
> > > > > > > expected_page_refs() at the beginning of migrate_page_move_mapping(),
> > > > > > > thus we should move the page count validation a little forward to
> > > > > > > reduce duplicated code.
> > > > > > 
> > > > > > Please add an explanation to the changelog for why it's safe to pull
> > > > > > this out from under the i_pages lock.
> > > > > 
> > > > > Sure. In folio_migrate_mapping(), we are sure that the migration page was
> > > > > isolated from lru list and locked, so I think there are no race to get the
> > > > > page count without i_pages lock. Please correct me if I missed something
> > > > > else. Thanks.
> > > > 
> > > > Unless the page has been removed from i_pages, this isn't a correct
> > > > explanation.  Even if it has been removed from i_pages, unless an
> > > > RCU grace period has passed, another CPU may still be able to inc the
> > > > refcount on it (temporarily).  The same is true for the page tables,
> > > > by the way; if someone is using get_user_pages_fast(), they may still
> > > > be able to see the page.
> > > 
> > > I don't think this is an issue, cause now we've established a migration pte
> > > for this migration page under page lock. If the user want to get page by
> > > get_user_pages_fast(), it will wait for the page miggration finished by
> > > migration_entry_wait(). So I still think there is no need to check the
> > > migration page count under the i_pages lock.
> > 
> > I don't know whether the patch is correct or not, but you aren't nearly
> > paranoid enough.  Consider this sequence of events:
> 
> Thanks for describing this scenario.
> 
> > 
> > CPU 0:				CPU 1:
> > get_user_pages_fast()
> > lockless_pages_from_mm()
> > local_irq_save()
> > gup_pgd_range()
> > gup_p4d_range()
> > gup_pud_range()
> > gup_pmd_range()
> > gup_pte_range()
> > pte_t pte = ptep_get_lockless(ptep);
> > 				migrate_vma_collect_pmd()
> > 				ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl)
> > 				ptep_get_and_clear(mm, addr, ptep);
> > page = pte_page(pte);
> > 				set_pte_at(mm, addr, ptep, swp_pte);
> > 				migrate_page_move_mapping()
> > head = try_grab_compound_head(page, 1, flags);
> 
> On CPU0, after grab the page count, it will validate the PTE again. If swap
> PTE has been established for this page, it will drop the count and go to the
> slow path.
> if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> 	put_compound_head(head, 1, flags);
> 	goto pte_unmap;
> }
> 
> So CPU1 can not observe the abnormal higher refcount in this case if I did
> not miss anything.

This is a race between CPUs.  There is no synchronisation between them,
so CPU 1 can absolutely see the refcount higher temporarily.  Yes,
CPU 0 will eventually put the refcount, but CPU 1 can observe it high.
