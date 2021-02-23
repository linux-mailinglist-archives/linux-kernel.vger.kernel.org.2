Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4BB323412
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhBWXAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232453AbhBWWuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:50:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14CA164DF2;
        Tue, 23 Feb 2021 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614120612;
        bh=gCT1COJKg1ZQddedw3a/5/wlGAq6rYRQHc94K4b5n+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFjhHr3aj7Ef8DoNg0iZXNKHIR+pb47yvpzZu4hv67auFwt/uK2ykOSCUEBgxAm49
         WJ483xaVMdfPfbaD++yrLagZVfz0R5vf70CUhliUbxN+XNm6tKexhGTMFmYwRr8r7l
         mI1iSgQMBBE0tQn1rqqCqfFupP89zepLcoTomzcc=
Date:   Tue, 23 Feb 2021 14:50:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-Id: <20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org>
In-Reply-To: <YBCUTinnVrlVVm6n@google.com>
References: <20210122220600.906146-1-yuzhao@google.com>
        <20210122220600.906146-4-yuzhao@google.com>
        <20210126220111.GO308988@casper.infradead.org>
        <YBCUTinnVrlVVm6n@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 15:14:38 -0700 Yu Zhao <yuzhao@google.com> wrote:

> On Tue, Jan 26, 2021 at 10:01:11PM +0000, Matthew Wilcox wrote:
> > On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
> > > +++ b/mm/swap.c
> > > @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> > >  	if (!PageUnevictable(page)) {
> > >  		del_page_from_lru_list(page, lruvec, page_lru(page));
> > >  		ClearPageActive(page);
> > > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > > +		add_page_to_lru_list_tail(page, lruvec);
> > >  		__count_vm_events(PGROTATED, thp_nr_pages(page));
> > >  	}
> > 
> > Is it profitable to do ...
> > 
> > -		del_page_from_lru_list(page, lruvec, page_lru(page));
> > +		enum lru_list lru = page_lru(page);
> > +		del_page_from_lru_list(page, lruvec, lru);
> > 		ClearPageActive(page);
> > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > +		lru &= ~LRU_ACTIVE;
> > +		add_page_to_lru_list_tail(page, lruvec, lru);
> 
> Ok, now we want to trade readability for size. Sure, I'll see how
> much we could squeeze.

As nothing has happened here and the code bloat issue remains, I'll
hold this series out of 5.12-rc1.

