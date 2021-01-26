Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F4304FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhA0Dea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbhAZVfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:35:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C76C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:34:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e22so36750392iog.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0BazbN3zFoYEieJvOdqBczlntMQ4FaDm3tAmPmmj7Yk=;
        b=A0GJB4qhcOedblwFVisFFz7/cFTwwVG/sqocGdUcal2iJcT4/Yqd8j3o9YM2ChKbkM
         aCUZcqs0POsdK0zV2NQdHPq0LLNGDP5NYn8V1xghoCivTtZuChrCAjA0/NxhMe5fnB5y
         0ywB0HyxTQtROqQ2lUvl+LY0mbGU+80jpcuJD4Ekz0uiku6vnAhS07W+J8A1Qcbz7qe7
         +742zkPgNAvD9ykuSZYRRk+4T8rTYUW9SsF8j5+gSYOl67394R6GDw330oL4nO6CJcig
         YSiFk4R+ddk4AXuHI94Hi4Uy+HgDGQES48uYeYdjOf4ct7FcOsGDxJJ674rHhuv9QqQh
         k8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BazbN3zFoYEieJvOdqBczlntMQ4FaDm3tAmPmmj7Yk=;
        b=cm9+kXUWca8KAHnAOMdYCoS7tdr3Gvr6I1i2api2RQ+43p+yFe6LFtkkvLZ0L3YACD
         F8xYR3sb1/pIfGCkvPYz6LwvodWfVyErf6iqqDgouRK6D33loKysyeP4W9nGSHkfSjF7
         ZRsgxxwiUTeiqHQizodTVKj/RPUxG7sq+N+SHwzyuQJKwD7spz/0Ra051nyBwKIoPBrj
         qg+KmQ8aVpRchZgLIVoA/tIWe9dWG4MI2Xddf7FDK0EZq91ilFKvpqSw2+o+U7a4jpaK
         cJpq+kr4+YB8zMYNstuxHLrydykbgVGRHBE3llCufE1sPyaCg0IzytJ5EdQSzoHeom23
         MEaw==
X-Gm-Message-State: AOAM531eXUwKJWLmyi2ZZ5G+5iDcJKNSrvZMQA6jyrsC6+LuJdnjThLu
        wHp8LP/d9ua06g513gJQBwaX3g==
X-Google-Smtp-Source: ABdhPJzO/w+Y46ojG4C9tSaQshc1ux6VZuxdppv2oPUJV5QERG8n2DiFhRJ3sH00TA3m1GHKStJ/Cw==
X-Received: by 2002:a05:6e02:5d1:: with SMTP id l17mr6187542ils.154.1611696889970;
        Tue, 26 Jan 2021 13:34:49 -0800 (PST)
Received: from google.com ([2620:15c:183:200:697e:4b38:5872:adfe])
        by smtp.gmail.com with ESMTPSA id c20sm12668405ilj.22.2021.01.26.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:34:49 -0800 (PST)
Date:   Tue, 26 Jan 2021 14:34:44 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-ID: <YBCK9OcUCbbgsFaj@google.com>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 08:13:11PM +0100, Vlastimil Babka wrote:
> On 1/22/21 11:05 PM, Yu Zhao wrote:
> > The "enum lru_list" parameter to add_page_to_lru_list() and
> > add_page_to_lru_list_tail() is redundant in the sense that it can
> > be extracted from the "struct page" parameter by page_lru().
> 
> Okay, however, it means repeated extraction of a value that we already knew. The
> result of compilation is rather sad. This is bloat-o-meter on mm/built-in.a
> (without CONFIG_DEBUG_VM, btw) between patch 2 and 5:

Thanks for noticing this, Vlastimil. Should I drop the rest of the
series except the first patch?

> add/remove: 0/0 grow/shrink: 10/5 up/down: 1837/-60 (1777)
> Function                                     old     new   delta
> lru_deactivate_file_fn                       932    1368    +436
> lru_lazyfree_fn.part                         629     953    +324
> check_move_unevictable_pages                1171    1424    +253
> __activate_page.part                         735     984    +249
> lru_deactivate_fn.part                       593     822    +229
> perf_trace_mm_lru_insertion                  458     560    +102
> trace_event_raw_event_mm_lru_insertion       412     500     +88
> __page_cache_release                         479     558     +79
> release_pages                               1430    1499     +69
> pagevec_move_tail_fn.part                    761     769      +8
> isolate_lru_page                             471     470      -1
> __bpf_trace_mm_lru_insertion                   7       5      -2
> __traceiter_mm_lru_insertion                  55      47      -8
> isolate_migratepages_block                  3200    3185     -15
> __pagevec_lru_add_fn                        1092    1058     -34
> 
> 
> > A caveat is that we need to make sure PageActive() or
> > PageUnevictable() is correctly set or cleared before calling
> > these two functions. And they are indeed.
> > 
> > Link: https://lore.kernel.org/linux-mm/20201207220949.830352-4-yuzhao@google.com/
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  include/linux/mm_inline.h |  8 ++++++--
> >  mm/swap.c                 | 15 +++++++--------
> >  mm/vmscan.c               |  6 ++----
> >  3 files changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 2889741f450a..130ba3201d3f 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -106,15 +106,19 @@ static __always_inline enum lru_list page_lru(struct page *page)
> >  }
> >  
> >  static __always_inline void add_page_to_lru_list(struct page *page,
> > -				struct lruvec *lruvec, enum lru_list lru)
> > +				struct lruvec *lruvec)
> >  {
> > +	enum lru_list lru = page_lru(page);
> > +
> >  	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> >  	list_add(&page->lru, &lruvec->lists[lru]);
> >  }
> >  
> >  static __always_inline void add_page_to_lru_list_tail(struct page *page,
> > -				struct lruvec *lruvec, enum lru_list lru)
> > +				struct lruvec *lruvec)
> >  {
> > +	enum lru_list lru = page_lru(page);
> > +
> >  	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
> >  	list_add_tail(&page->lru, &lruvec->lists[lru]);
> >  }
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 490553f3f9ef..4b058ef37add 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> >  	if (!PageUnevictable(page)) {
> >  		del_page_from_lru_list(page, lruvec, page_lru(page));
> >  		ClearPageActive(page);
> > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > +		add_page_to_lru_list_tail(page, lruvec);
> >  		__count_vm_events(PGROTATED, thp_nr_pages(page));
> >  	}
> >  }
> > @@ -313,8 +313,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
> >  
> >  		del_page_from_lru_list(page, lruvec, lru);
> >  		SetPageActive(page);
> > -		lru += LRU_ACTIVE;
> > -		add_page_to_lru_list(page, lruvec, lru);
> > +		add_page_to_lru_list(page, lruvec);
> >  		trace_mm_lru_activate(page);
> >  
> >  		__count_vm_events(PGACTIVATE, nr_pages);
> > @@ -543,14 +542,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
> >  		 * It can make readahead confusing.  But race window
> >  		 * is _really_ small and  it's non-critical problem.
> >  		 */
> > -		add_page_to_lru_list(page, lruvec, lru);
> > +		add_page_to_lru_list(page, lruvec);
> >  		SetPageReclaim(page);
> >  	} else {
> >  		/*
> >  		 * The page's writeback ends up during pagevec
> >  		 * We moves tha page into tail of inactive.
> >  		 */
> > -		add_page_to_lru_list_tail(page, lruvec, lru);
> > +		add_page_to_lru_list_tail(page, lruvec);
> >  		__count_vm_events(PGROTATED, nr_pages);
> >  	}
> >  
> > @@ -570,7 +569,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
> >  		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
> >  		ClearPageActive(page);
> >  		ClearPageReferenced(page);
> > -		add_page_to_lru_list(page, lruvec, lru);
> > +		add_page_to_lru_list(page, lruvec);
> >  
> >  		__count_vm_events(PGDEACTIVATE, nr_pages);
> >  		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> > @@ -595,7 +594,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
> >  		 * anonymous pages
> >  		 */
> >  		ClearPageSwapBacked(page);
> > -		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
> > +		add_page_to_lru_list(page, lruvec);
> >  
> >  		__count_vm_events(PGLAZYFREE, nr_pages);
> >  		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
> > @@ -1005,7 +1004,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
> >  			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
> >  	}
> >  
> > -	add_page_to_lru_list(page, lruvec, lru);
> > +	add_page_to_lru_list(page, lruvec);
> >  	trace_mm_lru_insertion(page, lru);
> >  }
> >  
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 19875660e8f8..09e4f97488c9 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1867,7 +1867,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  		 * inhibits memcg migration).
> >  		 */
> >  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> > -		add_page_to_lru_list(page, lruvec, page_lru(page));
> > +		add_page_to_lru_list(page, lruvec);
> >  		nr_pages = thp_nr_pages(page);
> >  		nr_moved += nr_pages;
> >  		if (PageActive(page))
> > @@ -4282,12 +4282,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
> >  
> >  		lruvec = relock_page_lruvec_irq(page, lruvec);
> >  		if (page_evictable(page) && PageUnevictable(page)) {
> > -			enum lru_list lru = page_lru_base_type(page);
> > -
> >  			VM_BUG_ON_PAGE(PageActive(page), page);
> >  			ClearPageUnevictable(page);
> >  			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
> > -			add_page_to_lru_list(page, lruvec, lru);
> > +			add_page_to_lru_list(page, lruvec);
> >  			pgrescued += nr_pages;
> >  		}
> >  		SetPageLRU(page);
> > 
> 
