Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF1305000
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhA0DkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbhAZWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:03:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nt9yKUXomDG8uLOcOikYEqr2InI/DibgiRpwpXD2IgY=; b=SkEWbAkylDaIJYoorL3DBzwrFe
        DnzLBZxI6n9mOZNh8sxsvc8iCIg/uMqXEVeyh0j+5uCsYWv9l56RFBJ4512MxVkk3h8xwhOaxmVSm
        C3McFHe3ENKal3y/2GpbXOAUPhzqEtCJkw9QJ6HLWYjnlndMVSHwTZUkoCwQQwzgS5HZPyTkXbbAe
        ZeMJKFAKCO36xCtJ1KSvdCGpWfnt8hk99EU+xTEhXqt5JPzVjBBAKyi9+yOQyU1RIS+B55Bxd3kph
        Snqwcx3BokFqqa269TeLZOQH6Y4WaWgiKAuPLWjYsxUrnUGmqllJSUMSfgrVxEhqxhqdAQzjh1Ocw
        Q20fedmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4WOd-006JeE-V6; Tue, 26 Jan 2021 22:01:36 +0000
Date:   Tue, 26 Jan 2021 22:01:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-ID: <20210126220111.GO308988@casper.infradead.org>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122220600.906146-4-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
> +++ b/mm/swap.c
> @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>  	if (!PageUnevictable(page)) {
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		ClearPageActive(page);
> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> +		add_page_to_lru_list_tail(page, lruvec);
>  		__count_vm_events(PGROTATED, thp_nr_pages(page));
>  	}

Is it profitable to do ...

-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		enum lru_list lru = page_lru(page);
+		del_page_from_lru_list(page, lruvec, lru);
		ClearPageActive(page);
-		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
+		lru &= ~LRU_ACTIVE;
+		add_page_to_lru_list_tail(page, lruvec, lru);

