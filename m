Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C33BC2D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhGESsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhGESsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:48:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13506C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aNDwCscw1p86DkXqINJ193YMMwMojg7IqAtfTHOFrf0=; b=tli0JQf63aKNQuU6V30vDNoLKW
        xs1PRFkoJOOygR1Pe/ZKjRhuqlwLDKBN6y1ULUtJb/dYAbDQRHxf9AgySXqDNdzbFgtk8EDNx+JqV
        iO7ICp+tFdRpf1XWxhgO2SAOSEG8V0KORR1aUAAh6ROogwS3XXW0GzzsqGrRYRkjIA/dwN5XJRFgO
        DM6jIV+NFd2QqIpBA+rjPQS2f2455MclI6qONorqe5aHu8DjB3D4PlHvSMDCAVgzUNz+kAKyzX92g
        b13se+6qajfCbSwFF1hA9kH/PbvTj34O0SD3hPjiWrz/IL2Quv0N+M8pd9z2xTXqmep1hBEKHyPM8
        sX/mjbTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0Taw-00AW2c-IU; Mon, 05 Jul 2021 18:45:30 +0000
Date:   Mon, 5 Jul 2021 19:45:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <YONTRlrJugeVq6Fj@casper.infradead.org>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <YONJpQapR7BRnW/J@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YONJpQapR7BRnW/J@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:04:21AM -0700, Jaegeuk Kim wrote:
> On 07/05, Matthew Wilcox wrote:
> > I think freshly allocated pages have a page->private of 0.  ie this
> > code in mm/page_alloc.c:
> > 
> >                 page = rmqueue(ac->preferred_zoneref->zone, zone, order,
> >                                 gfp_mask, alloc_flags, ac->migratetype);
> >                 if (page) {
> >                         prep_new_page(page, order, gfp_mask, alloc_flags);
> > 
> > where prep_new_page() calls post_alloc_hook() which contains:
> >         set_page_private(page, 0);
> 
> Hmm, I can see it in 4.14 and 5.10 kernel.
> 
> The trace is on:
> 
>  30875 [ 1065.118750] c3     87  f2fs_migrate_page+0x354/0x45c
>  30876 [ 1065.123872] c3     87  move_to_new_page+0x70/0x30c
>  30877 [ 1065.128813] c3     87  migrate_pages+0x3a0/0x964
>  30878 [ 1065.133583] c3     87  compact_zone+0x608/0xb04
>  30879 [ 1065.138257] c3     87  kcompactd+0x378/0x4ec
>  30880 [ 1065.142664] c3     87  kthread+0x11c/0x12c
>  30881 [ 1065.146897] c3     87  ret_from_fork+0x10/0x18
> 
>  It seems compaction_alloc() gets a free page which doesn't reset the fields?

I'm not really familiar with the compaction code.  Mel, I see a call
to post_alloc_hook() in split_map_pages().  Are there other ways of
getting the compaction code to allocate a page which don't go through
split_map_pages()?
