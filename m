Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EDA3BC85A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGFJOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:14:52 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:42290 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbhGFJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:14:51 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 9CBFE18E069
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 10:12:12 +0100 (IST)
Received: (qmail 24893 invoked from network); 6 Jul 2021 09:12:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jul 2021 09:12:12 -0000
Date:   Tue, 6 Jul 2021 10:12:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <20210706091211.GR3840@techsingularity.net>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YONTRlrJugeVq6Fj@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 07:45:26PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 11:04:21AM -0700, Jaegeuk Kim wrote:
> > On 07/05, Matthew Wilcox wrote:
> > > I think freshly allocated pages have a page->private of 0.  ie this
> > > code in mm/page_alloc.c:
> > > 
> > >                 page = rmqueue(ac->preferred_zoneref->zone, zone, order,
> > >                                 gfp_mask, alloc_flags, ac->migratetype);
> > >                 if (page) {
> > >                         prep_new_page(page, order, gfp_mask, alloc_flags);
> > > 
> > > where prep_new_page() calls post_alloc_hook() which contains:
> > >         set_page_private(page, 0);
> > 
> > Hmm, I can see it in 4.14 and 5.10 kernel.
> > 
> > The trace is on:
> > 
> >  30875 [ 1065.118750] c3     87  f2fs_migrate_page+0x354/0x45c
> >  30876 [ 1065.123872] c3     87  move_to_new_page+0x70/0x30c
> >  30877 [ 1065.128813] c3     87  migrate_pages+0x3a0/0x964
> >  30878 [ 1065.133583] c3     87  compact_zone+0x608/0xb04
> >  30879 [ 1065.138257] c3     87  kcompactd+0x378/0x4ec
> >  30880 [ 1065.142664] c3     87  kthread+0x11c/0x12c
> >  30881 [ 1065.146897] c3     87  ret_from_fork+0x10/0x18
> > 
> >  It seems compaction_alloc() gets a free page which doesn't reset the fields?
> 
> I'm not really familiar with the compaction code.  Mel, I see a call
> to post_alloc_hook() in split_map_pages().  Are there other ways of
> getting the compaction code to allocate a page which don't go through
> split_map_pages()?

I don't *think* so but I didn't look too hard as I had limited time
available before a meeting. compaction_alloc calls isolate_freepages
and that calls split_map_pages whether fast or slow isolating pages. The
problem *may* be in split_page because only the head page gets order set
to 0 but it's a bad fit because tail pages should be cleared of private
state by del_page_from_free_list. It might be worth adding a debugging
patch to split_pages that prints a warning once if a tail page has private
state and dump the contents of private to see if it looks like an order.

-- 
Mel Gorman
SUSE Labs
