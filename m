Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3233794B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhCKQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:27:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234532AbhCKQ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:26:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615480014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZ0PtrodtSFeTEipYW7mvjHwoefyVlEAYBMe9XX6QM8=;
        b=aekJaOlAAG6CNJAyUaRWxlaKLeGTHlmTXhd6YKWemSgqKFo9loFGMoNnyRJ2sXwW2CsB0H
        Rhwu+OHtuIDJ8ND1vv5lvSZVjz3CRXC9LeibGRWLKlgNGdilqgfNjs6cL7ritguwRhI+7E
        8d2GnruXAWGp0zswaFW9yi/ZmBCF86I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCB63AE1F;
        Thu, 11 Mar 2021 16:26:54 +0000 (UTC)
Date:   Thu, 11 Mar 2021 17:26:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEpEzZ1CdXvc5JMt@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
 <20210309123255.GI3479805@casper.infradead.org>
 <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz>
 <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz>
 <YEo1gz6wuYl1Fuqt@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEo1gz6wuYl1Fuqt@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-03-21 10:21:39, Johannes Weiner wrote:
> On Thu, Mar 11, 2021 at 09:37:02AM +0100, Michal Hocko wrote:
> > Johannes, Hugh,
> > 
> > what do you think about this approach? If we want to stick with
> > split_page approach then we need to update the missing place Matthew has
> > pointed out.
> 
> I find the __free_pages() code quite tricky as well. But for that
> reason I would actually prefer to initiate the splitting in there,
> since that's the place where we actually split the page, rather than
> spread the handling of this situation further out.
> 
> The race condition shouldn't be hot, so I don't think we need to be as
> efficient about setting page->memcg_data only on the higher-order
> buddies as in Willy's scratch patch. We can call split_page_memcg(),
> which IMO should actually help document what's happening to the page.
> 
> I think that function could also benefit a bit more from step-by-step
> documentation about what's going on. The kerneldoc is helpful, but I
> don't think it does justice to how tricky this race condition is.
> 
> Something like this?
> 
> void __free_pages(struct page *page, unsigned int order)
> {
> 	/*
> 	 * Drop the base reference from __alloc_pages and free. In
> 	 * case there is an outstanding speculative reference, from
> 	 * e.g. the page cache, it will put and free the page later.
> 	 */
> 	if (likely(put_page_testzero(page))) {
> 		free_the_page(page, order);
> 		return;
> 	}
> 
> 	/*
> 	 * The speculative reference will put and free the page.
> 	 *
> 	 * However, if the speculation was into a higher-order page
> 	 * that isn't marked compound, the other side will know
> 	 * nothing about our buddy pages and only free the order-0
> 	 * page at the start of our chunk! We must split off and free
> 	 * the buddy pages here.
> 	 *
> 	 * The buddy pages aren't individually refcounted, so they
> 	 * can't have any pending speculative references themselves.
> 	 */
> 	if (!PageHead(page) && order > 0) {
> 		split_page_memcg(page, 1 << order);
> 		while (order-- > 0)
> 			free_the_page(page + (1 << order), order);
> 	}
> }

Fine with me. Mathew was concerned about more places that do something
similar but I would say that if we find out more places we might
reconsider and currently stay with a reasonably clear model that it is
only head patch that carries the memcg information and split_page_memcg
is necessary to break such page into smaller pieces.

-- 
Michal Hocko
SUSE Labs
