Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73730F50D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhBDOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236658AbhBDOb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:31:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F6F564DDD;
        Thu,  4 Feb 2021 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612449074;
        bh=Q3tSj3k5RgYOiGbv7iOvJxUQ4L1+b07VOWx7Yec4fvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDwGuOreW092lBC4s22o/u/Ou7dzP5kXPOcjuc/uEmPD0+dKb01WWUDchmpaYgf+l
         ucvAb+KoWg19k6IB4/71zGDBzCLu065P9vDjbJiYRccdPp3C+Wb2ylir8ejqoAtU0E
         8B29egoR1qiIUCUuJxZv/2JNmH2mnSKtF3OKV2L5AlYp1PZAiCtgFd+B6qtSAjNLQa
         wHzG8rydoLlYFfSZ+puE/2qfx0ihpVkDYX1VbIieI7rIETSjhYZxmLIXdjqa71xIxe
         /7ErNUVL2gN24XCOsmJUik9XTtOhKJsZ/1RylLAZPsS13KbJ4o2y1lX030Igy78GyE
         +GxQ0S/63GbGg==
Date:   Thu, 4 Feb 2021 14:31:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 12/26] KVM: arm64: Introduce a Hyp buddy page
 allocator
Message-ID: <20210204143106.GA20792@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBrsep4xK1F4YRWb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 06:33:30PM +0000, Quentin Perret wrote:
> On Tuesday 02 Feb 2021 at 18:13:08 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:10PM +0000, Quentin Perret wrote:
> > > + *   __find_buddy(pool, page 0, order 0) => page 1
> > > + *   __find_buddy(pool, page 0, order 1) => page 2
> > > + *   __find_buddy(pool, page 1, order 0) => page 0
> > > + *   __find_buddy(pool, page 2, order 0) => page 3
> > > + */
> > > +static struct hyp_page *__find_buddy(struct hyp_pool *pool, struct hyp_page *p,
> > > +				     unsigned int order)
> > > +{
> > > +	phys_addr_t addr = hyp_page_to_phys(p);
> > > +
> > > +	addr ^= (PAGE_SIZE << order);
> > > +	if (addr < pool->range_start || addr >= pool->range_end)
> > > +		return NULL;
> > 
> > Are these range checks only needed because the pool isn't required to be
> > an exact power-of-2 pages in size? If so, maybe it would be more
> > straightforward to limit the max order on a per-pool basis depending upon
> > its size?
> 
> More importantly, it is because pages outside of the pool are not
> guaranteed to be covered by the hyp_vmemmap, so I really need to make
> sure I don't dereference them.

Wouldn't having a per-pool max order help with that?

> > > +	return hyp_phys_to_page(addr);
> > > +}
> > > +
> > > +static void __hyp_attach_page(struct hyp_pool *pool,
> > > +			      struct hyp_page *p)
> > > +{
> > > +	unsigned int order = p->order;
> > > +	struct hyp_page *buddy;
> > > +
> > > +	p->order = HYP_NO_ORDER;
> > 
> > Why is this needed?
> 
> If p->order is say 3, I may be able to coalesce with the buddy of order
> 3 to form a higher order page of order 4. And that higher order page
> will be represented by the 'first' of the two order-3 pages (let's call
> it the head), and the other order 3 page (let's say the tail) will be
> assigned 'HYP_NO_ORDER'.
> 
> And basically at this point I don't know if 'p' is going be the head or
> the tail, so I set it to HYP_NO_ORDER a priori so I don't have to think
> about this in the loop below. Is that helping?
> 
> I suppose this could use more comments as well ...

Comments would definitely help, but perhaps even having a simple function to
do the coalescing, which you could call from the loop body and which would
deal with marking the tail pages as HYP_NO_ORDER?

> > > +	for (; order < HYP_MAX_ORDER; order++) {
> > > +		/* Nothing to do if the buddy isn't in a free-list */
> > > +		buddy = __find_buddy(pool, p, order);
> > > +		if (!buddy || list_empty(&buddy->node) || buddy->order != order)
> > 
> > Could we move the "buddy->order" check into __find_buddy()?
> 
> I think might break __hyp_extract_page() below. The way I think about
> __find_buddy() is as a low level function which gives you the buddy page
> blindly if it exists in the hyp_vmemmap, and it's up to the callers to
> decide whether the buddy is in the right state for their use or not.

Just feels a bit backwards having __find_buddy() take an order parameter,
yet then return a page of the wrong order! __hyp_extract_page() always
passes the p->order as the order, so I think it would be worth having a
separate function that just takes the pool and the page for that.

Will
