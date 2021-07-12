Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852553C4EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbhGLHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:21:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbhGLG4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:56:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 30F8E1FD58;
        Mon, 12 Jul 2021 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626072794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNwOMLlKi66VGmHIEbOBTG2Q2a8j2sNDoQXhXFwpAR4=;
        b=IXDNvguctsJNRlVZYB5/iqcdnyk4ksoJh4wgcYvvL38b8rwNbkaY4dKfOL5OnDhQfvOoGQ
        5yvc4yGRQrtqcLYd07XqgUI3n0eoIdPpe090BX+65Bgwo8Hd8ecuhgY1S4aAT3YL7DJGGe
        aaLWCt+/xHFLyzo26PEr6ZdyUAtGMyM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6BF5A4E93;
        Mon, 12 Jul 2021 06:53:13 +0000 (UTC)
Date:   Mon, 12 Jul 2021 08:53:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <YOvm2faBUjKmZI7Q@dhcp22.suse.cz>
References: <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
 <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
 <20210707095706.GT3840@techsingularity.net>
 <fc0de0c2-a3b6-df91-5b90-524768a85d82@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0de0c2-a3b6-df91-5b90-524768a85d82@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-07-21 16:11:38, Chao Yu wrote:
> On 2021/7/7 17:57, Mel Gorman wrote:
> > I think it would work but it would be preferable to find out why the
> > tail page has an order set in the first place. I've looked over
> 
> Agreed.
> 
> > mm/page_alloc.c and mm/compaction.c a few times and did not spot where
> > set_private_page(page, 0) is missed when it should be covered by
> > clear_page_guard or del_page_from_free_list :(
> 
> I didn't enable CONFIG_DEBUG_PAGEALLOC, so we will expect page private
> should be cleared by del_page_from_free_list(), but I guess it only clears
> the buddy's private field rather than original page's, so I added below
> diff and check the dmesg, it looks stall private value in original page
> will be left commonly... Let me know if I missed something?

Page private should be cleared when the page is freed to the allocator.
Have a look at PAGE_FLAGS_CHECK_AT_FREE.

> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a06bcfe6f786..1e7031ff548e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1029,6 +1029,7 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long combined_pfn;
>  	unsigned int max_order;
>  	struct page *buddy;
> +	struct page *orig_page = page;
>  	bool to_tail;
> 
>  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
> @@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,
> 
>  done_merging:
>  	set_buddy_order(page, order);
> +	if (orig_page != page) {
> +		if (WARN_ON_ONCE(orig_page->private))
> +			pr_info("2order:%x, origpage.private:%x", order, orig_page->private);
> +	}

Why is this expected? Buddy allocator uses page private to store order.
Whether we are merging to the freed page or coalesce it to a different
page is not all that important.
-- 
Michal Hocko
SUSE Labs
