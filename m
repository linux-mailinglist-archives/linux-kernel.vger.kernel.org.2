Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1F3FD465
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbhIAHXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242494AbhIAHXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:23:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAB4B60E98;
        Wed,  1 Sep 2021 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630480971;
        bh=ROvubnIZ7CG7NtmC524Rg5/WiRX8ZoyaERotUEZbRL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwvGS0g9Rk3Sbnr9PqhqnIqsnpglwcimyj5PYWZl+ld0I8CY15MKMWHd3uVhtm18y
         DXLWffZNKZCSjJ8MwZVNT4VI130Pw8HnmI1QDiG8OZafTNCe3l/J1Ck1ZXFGIrPrSU
         iW5bZiqaaPZkiTXAqz3RcDIyqE2xSDcKxm57tPE83v8pIPwp2+xP3lRaYHWo4/M9na
         i5AaXBZHxFAJdF4sv7rwX33WBPT6fOVKQJVlZXJJK8Jn9D8e/ml2Jhye3d88jqtHVw
         qJ1ivQ9AhefJSJF9A5hafWAMdfJRsLXUNDadIIMh4dglT0cmfW1f8BVhpF1m9biuBY
         +bKu2nmjT8KOg==
Date:   Wed, 1 Sep 2021 10:22:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>
Subject: Re: [RFC PATCH v2 11/19] mm/sparsemem: Use alloc_table() for table
 allocations
Message-ID: <YS8qRHrGzevns32P@kernel.org>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
 <20210830235927.6443-12-rick.p.edgecombe@intel.com>
 <YS3uhdT88XFvP9n3@kernel.org>
 <f77f3312a1b17b8f8de2ccf0f40f9f19f4a9f151.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77f3312a1b17b8f8de2ccf0f40f9f19f4a9f151.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 06:25:23PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2021-08-31 at 11:55 +0300, Mike Rapoport wrote:
> > On Mon, Aug 30, 2021 at 04:59:19PM -0700, Rick Edgecombe wrote:
> <trim> 
> > > -static void * __meminit vmemmap_alloc_block_zero(unsigned long
> > > size, int node)
> > > +static void * __meminit vmemmap_alloc_table(int node)
> > >  {
> > > -	void *p = vmemmap_alloc_block(size, node);
> > > +	void *p;
> > > +	if (slab_is_available()) {
> > > +		struct page *page = alloc_table_node(GFP_KERNEL |
> > > __GFP_ZERO, node);
> > 
> > This change removes __GFP_RETRY_MAYFAIL|__GFP_NOWARN from the
> > original gfp
> > vmemmap_alloc_block() used.
> Oh, yea good point. Hmm, I guess grouped pages could be aware of that
> flag too. Would be a small addition, but it starts to grow
> unfortunately.
> 
> > Not sure __GFP_RETRY_MAYFAIL is really needed in
> > vmemmap_alloc_block_zero()
> > at the first place, though.
> Looks like due to a real issue:
> 055e4fd96e95b0eee0d92fd54a26be7f0d3bcad0

I believe the issue was with memory map blocks rather than with page
tables, but since sparse-vmemmap uses the same vmemmap_alloc_block() for
both, the GFP flag got stick with both.

I'm not really familiar with reclaim internals to say if
__GFP_RETRY_MAYFAIL would help much for order-0 allocation.

Vlastimil, can you comment on this?
 
> I think it should not affect PKS tables for now, so maybe I can make
> separate logic instead. I'll look into it. Thanks.
> > 
> > More broadly, maybe it makes sense to split boot time and memory
> > hotplug
> > paths and use pxd_alloc() for the latter.
> > 
> > > +
> > > +		if (!page)
> > > +			return NULL;
> > > +		return page_address(page);
> > > +	}
> > >  
> > > +	p = __earlyonly_bootmem_alloc(node, PAGE_SIZE, PAGE_SIZE,
> > > __pa(MAX_DMA_ADDRESS));
> > 
> > Opportunistically rename to __earlyonly_memblock_alloc()? ;-)
> > 
> Heh, I can. Just grepping, there are several other instances of
> foo_bootmem() only calling foo_memblock() pattern scattered about. Or
> maybe I'm missing the distinction.

Heh, I didn't do s/bootmem/memblock/g, so foo_bootmem() are reminders we
had bootmem allocator once.
Maybe it's a good time to remove them :)
 
> <trim>

-- 
Sincerely yours,
Mike.
