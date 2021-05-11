Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3537B1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEKWeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/Z5K3U5WC9FDDIUlCEk/fWAgWuXH3EOg7ra2fe+BOg=; b=mCUcAL5DLLPoSN5JB4sIsU7mVg
        5bJu0gCKjYPDPr14t8Bg/dzbOxWAuc33h8bxFs4N5dW7VK2NFgUG5ASotRI9Rd8hU2LdZwbIjR1Io
        75Mf3kj5p1M6NxlyOn3Dp8dpaw7lRhMTvFRHNDTg4/ThrUuwpbmllJ1AE2baNVupXhPMi7rJ5tmpl
        +7qpYIDgzLiYgh31HSEPPvFpj90wkbxDZ8ChYNEPJhjKXi7lyjTvlYTRzDjAyd9ATKLkI8sVTlSJ4
        kB1JpnzErLwpO3zzvwZjE0ZsE+7RTHd6BwpO5C9kt0G++aiyOMxQr4G5TccCEoMAzrWN4OiAnXWLC
        ircPteBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgavi-007jiU-Lu; Tue, 11 May 2021 22:32:45 +0000
Date:   Tue, 11 May 2021 23:32:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] mm/migrate: Add folio_migrate_mapping
Message-ID: <YJsGCu+zvqSR7WV1@casper.infradead.org>
References: <20210510232308.1592750-1-willy@infradead.org>
 <20210510232308.1592750-2-willy@infradead.org>
 <DD640D43-3101-4291-9882-57A89C74866E@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD640D43-3101-4291-9882-57A89C74866E@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:04:21PM -0400, Zi Yan wrote:
> On 10 May 2021, at 19:23, Matthew Wilcox (Oracle) wrote:
> > +++ b/mm/migrate.c
> > @@ -355,7 +355,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
> >  	 */
> >  	expected_count += is_device_private_page(page);
> >  	if (mapping)
> > -		expected_count += thp_nr_pages(page) + page_has_private(page);
> > +		expected_count += compound_nr(page) + page_has_private(page);
> 
> Why this change? Is it because you are passing folio->page to expected_page_refs() below
> and the nr_pages for the folio should be checked with folio_nr_pages() which just returns
> compound_nr()?
> 
> The change seems to imply that folio can be compound page and migrated even when THP is
> disabled. Is it the case or something else?

That's exactly right.

In general, I don't like to pass &folio->page to functions, but this one
might be handling device private pages (apparently), and they have bogus
refcounts, so devmap pages are explicitly disallowed from being folios
until the refcount problem gets fixed.

