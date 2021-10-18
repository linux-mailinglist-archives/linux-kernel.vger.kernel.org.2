Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459A4324F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhJRR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJRR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:27:14 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46272C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:25:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v17so15953931qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VlN35XgI9PTndq7UxTnTEbK2ldcab2451jgEL0ZSqaM=;
        b=qK2G14Y736gLbmF8WeKdXEgMl+G2OGQsU1fCBVh2NbNOEaezcH6NAqAKw0aIYyZZCY
         D0KjQ9Om6zpzcSkUOCw7nfDWo0peXjwGkI0PVkNdxmJdgcW5VWEhKddNxgrVqT2nmUfy
         plc7yiDP5oXfPS1xwECNcCFkT6kGppEm6PjIDhQB4HmrdzxHbolj95y37Zx6CsefaQyQ
         xahU65jzImb6I9yVlbqmsRaIV1ZK4BK15bSrjRf+wdsBI/ttB6DKBEtBRe0DJFtAx6ko
         ZcotXe1B6wFxStVylYj/UWLQq+PxJ01ex7PfDAA/odqk54fL5GJROJWHYW0df8WX5/zE
         /9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlN35XgI9PTndq7UxTnTEbK2ldcab2451jgEL0ZSqaM=;
        b=GWw/QbQs3W1Cfm3sLJ38EwPb5xcZCfGbPvKNd9Co4PrL83+6zrHlcKDXs/EXw2gnbV
         fmSNwxjLtqtrbXGPG2si3ONJBP299GQdSqEGGTQoymKCl2ifylx7NjJcrkkXOV6zVt+C
         PAue7AsQlvSrmX2AuxEfNjfyKSFDCvFCnt5h9P+Ru47kb/vuRZDFvGXA3Z1fYWd+p4bW
         JQm+I+eP7jEmg1SSQugBUv7XVfdjtAlkZyNXHuYmoPvgIWtVHWKOUj5Z9Yw9vRZlQvbQ
         cZdDqkUcWp1kQXklAP2dSkC+UsSB4APUYpms15ePBG8XHR7t0V2+kclfjG6Y83ALtVf3
         O1bA==
X-Gm-Message-State: AOAM532ekJ2qXBnTesSsKF6HkyzxF5yv1zXY4YhH1zlUXKthv/hppDEi
        9yBH3uUcyZY4gSddR2ilrlzIpiiZCFDv5w==
X-Google-Smtp-Source: ABdhPJwbY21FHjl+4IYmDViZ0w3nIjwM1u55QjVUR+U+sgXEVNyv2YYgx3yFKvEqpM+tyxZO17JJRQ==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr31197902qta.256.1634577902431;
        Mon, 18 Oct 2021 10:25:02 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t24sm6891783qkj.38.2021.10.18.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:25:01 -0700 (PDT)
Date:   Mon, 18 Oct 2021 13:25:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW2t7Pq9AIOB2EgF@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWsi/ERcQzY765xj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWsi/ERcQzY765xj@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 08:07:40PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> >       mm/lru: Add folio LRU functions
> > 
> > 		The LRU code is used by anon and file and not needed
> > 		for the filesystem API.
> > 
> > 		And as discussed, there is generally no ambiguity of
> > 		tail pages on the LRU list.
> 
> One of the assumptions you're making is that the current code is suitable
> for folios.  One of the things that happens in this patch is:
> 
> -       update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> +       update_lru_size(lruvec, lru, folio_zonenum(folio),
> +                       folio_nr_pages(folio));
> 
> static inline long folio_nr_pages(struct folio *folio)
> {
>         return compound_nr(&folio->page);
> }
> 
> vs
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> static inline int thp_nr_pages(struct page *page)
> {
>         VM_BUG_ON_PGFLAGS(PageTail(page), page);
>         if (PageHead(page))
>                 return HPAGE_PMD_NR;
>         return 1;
> }
> #else
> static inline int thp_nr_pages(struct page *page)
> {
>         VM_BUG_ON_PGFLAGS(PageTail(page), page);
>         return 1;
> }
> #endif
> 
> So if you want to leave all the LRU code using pages, all the uses of
> thp_nr_pages() need to be converted to compound_nr().  Or maybe not all
> of them; I don't know which ones might be safe to leave as thp_nr_pages().
> That's one of the reasons I went with a whitelist approach.

All of them. The only compound pages that can exist on the LRUs are
THPs, and the only THP pages that can exist on the LRUs are
compound. There is no plausible scenario where those two functions
would disagree in the LRU code.

Or elsewhere in the kernel, for that matter. Where would
thp_nr_pages() returning compound_nr() ever be wrong? How else are we
implementing THPs? I'm not sure that would make sense.
