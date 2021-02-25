Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA45324FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhBYMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhBYMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:13:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B99C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 04:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2kQOHAtExAXN9R7ZqFlbGG4l/kVsDVtdNUTjvtMTBM=; b=Mph664UogEaRWHjnRI1mGxwAxQ
        lb4JaWQZcccyCrNbxNJk4hGSoBNSw3dKNxRCjXEQEWsNTPfckm7141v+vOpDYm0NS2U+5Bg8noZnU
        hYdZvfIhRLG+OQ5cCNlksriaX7MzKkGNioV5bD8cpqwQoWAIHYyb2d6Vie13PbkH5P1Npr4wMqK02
        ct3ZaVvIg3R17CfrwbyFqfiyyw70x2r6K87Iiekg1alEvNU3bfl0/b8tK+2y6HW9e20Vxd5cs1fBZ
        dy7BasmQWBiwvGrOiadBN4yb6UnuVc834Zu7cZ0u6OIfQZfq22P2aQ2AOo3lLsiBR3I8STxB8iIJU
        RPags8YA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFFV1-00Ag7L-LW; Thu, 25 Feb 2021 12:12:10 +0000
Date:   Thu, 25 Feb 2021 12:12:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <20210225121207.GY2858050@casper.infradead.org>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
 <YDbUaJ0j2YisyyuK@google.com>
 <20210224224846.GU2858050@casper.infradead.org>
 <YDbmT87E106uS1Xa@google.com>
 <20210225035553.GX2858050@casper.infradead.org>
 <YDc0Hqk+A4wvN7jg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDc0Hqk+A4wvN7jg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:22:38PM -0700, Yu Zhao wrote:
> On Thu, Feb 25, 2021 at 03:55:53AM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 24, 2021 at 04:50:39PM -0700, Yu Zhao wrote:
> > > Let me work out something *conceptually* smaller first, and if you
> > > think folio is absolutely more suitable even for this specific issue,
> > > I'll go review and test the four patches you listed. Sounds good?
> > 
> > Umm.  It seems to me that no matter what you do, it'll be equivalent to
> > this, only without the type-safety?
> 
> I'm thinking about something trivial but still very effective. So far
> I've only tested it with PG_{active,unevictable}, and I'm already
> seeing a 4KB gain less the 2KB loss from page_lru().
> 
> I didn't go with this at the beginning because it's also time-
> consuming. I need to go over every single use of
> PG_{active,unevictable,swapbacked,lru}.

Well, yes.  If you went with the folio, it'd also be typesafe.
What you've done here makes it a runtime error, and it's only detected
if you enable CONFIG_DEBUG_VM_PGFLAGS, which people don't do, in general.

> +++ b/fs/proc/task_mmu.c
> @@ -1712,6 +1712,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
>                         unsigned long nr_pages)
>  {
>         int count = page_mapcount(page);
> +       struct page *head = compound_head(page);
>  
>         md->pages += nr_pages;
>         if (pte_dirty || PageDirty(page))

... if you went full-on folio in this function, you could also make this
FolioDirty, saving another call to compound_head.

> @@ -1720,7 +1721,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
>         if (PageSwapCache(page))
... ditto ...
>                 md->swapcache += nr_pages;
>  
> -       if (PageActive(page) || PageUnevictable(page))
> +       if (PageActive(head) || PageUnevictable(head))
>                 md->active += nr_pages;
>  
>         if (PageWriteback(page))
... ditto...
