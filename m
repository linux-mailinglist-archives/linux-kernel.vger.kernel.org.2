Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5945937B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhKVQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:57:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhKVQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:57:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DFEFF1FD39;
        Mon, 22 Nov 2021 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637600067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC1y7/6XwmZKnT4bImFqmCWjnQi+LoIW+FctDlpkILs=;
        b=ci1wPlUVm4xzwrECdtfjDFXPnlOQ0wLLLkZ4jDIs1Nli4RF+0szVwHv1NQPjXCIPf+xX6b
        o0jW2aX/QsxMvfwWx99maXWkCL7BvfifPm5YciHInPk0yPPpO2dJO90GZB99XOi2zz/cqO
        Uuzos5pZ1sGZZCXtQqVPkNXafYaeWMo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0139A3B85;
        Mon, 22 Nov 2021 16:54:27 +0000 (UTC)
Date:   Mon, 22 Nov 2021 17:54:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZvLQyjIyBafYEPV@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZUBIbALcSHn4Rub@casper.infradead.org>
 <163727727803.13692.15470049610672496362@noble.neil.brown.name>
 <YZewStgII83phKtA@casper.infradead.org>
 <163740548025.13692.6428652897557849182@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163740548025.13692.6428652897557849182@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 20-11-21 21:51:20, Neil Brown wrote:
> On Sat, 20 Nov 2021, Matthew Wilcox wrote:
> > On Fri, Nov 19, 2021 at 10:14:38AM +1100, NeilBrown wrote:
> > > On Thu, 18 Nov 2021, Matthew Wilcox wrote:
> > > > Surely this should be gfpflags_allow_blocking() instead of poking about
> > > > in the innards of gfp flags?
> > > 
> > > Possibly.  Didn't know about gfpflags_allow_blocking().  From a quick
> > > grep in the kernel, a whole lot of other people don't know about it
> > > either, though clearly some do.
> > > 
> > > Maybe we should reaname "__GFP_DIRECT_RECLAIM" to
> > > "__GFP_ALLOW_BLOCKING", because that is what most users seems to care
> > > about.
> > 
> > I tend towards the school of thought that the __GFP flags should make
> > sense to the implementation and users should use either GFP_ or functions.
> > When we see users adding or subtracting __GFP flags, that's a problem.
> 
> Except __GFP_NOWARN of course, or __GFP_ZERO, or __GFP_NOFAIL.
> What about __GFP_HIGHMEM?  __GFP_DMA?  __GFP_HIGH?
> 
> They all seem to be quite meaningful to the caller - explicitly
> specifying properties of the memory or properties of the service.
> (But maybe you would prefer __GFP_HIGH be spelled "__GFP_LOW_WATERMARK"
> so it would make more sense to the implementation).
> 
> __GFP_DIRECTRECLAIM seems to me to be more the exception than the rule -
> specifying internal implementation details.

I do not think it is viable to fix up gfp flags to be consistent :/
Both __GFP_DIRECT_RECLAIM and __GFP_KSWAPD_RECLAIM are way too lowlevel
but historically we've had requests to inhibit kswapd for a particular
requests because that has led to problems - fun reading caf491916b1c1.
__GFP_ALLOW_BLOCKING would make a lot of sense but I am not sure it
would be a good match to __GFP_KSWAPD_RECLAIM.

> Actually ... I take it back about __GFP_NOWARN.  That probably shouldn't
> exist at all.  Warnings should be based on how stressed the mm system is,
> not on whether the caller wants thinks failure is manageable.

Unless we change the way when allocation warnings are triggered then we
really need this. There are many opportunistic allocations with a
fallback behavior which do not want to swamp kernel logs with failures
that are of no use. Think of a THP allocation that really want to be
just very quick and falls back to normal base pages otherwise. Deducing
context which is just fine to not report failures is quite tricky and it
can get wrong easily. Callers should know whether warning can be of any
use in many cases.
-- 
Michal Hocko
SUSE Labs
