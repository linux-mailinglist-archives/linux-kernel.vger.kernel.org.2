Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDB3EE3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHQBoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHQBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:44:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VZLYaWKmYtLNVXAtgShz18RzUou/JEjRVOzmdS9rnms=; b=qjF8SH+qaG2Bvpuc9PuwsfYYZN
        eBP6TXaXA0Zp3BsfTQQ+nEzgQl/+TyWwsxFRn9c6o/5DZ4MF9aI0QcxT/g+W60MtMuYQPHtfZ3ScQ
        yCu2nYpeU8v0mvwlH6tMdxm4+thfFIqfx4NhXOuAQs7PiFD/4ZDTajrOzN/xAeWEtJitZQNZIqFKp
        3t3ia8dtWwoNzOvi+Ok48j/7lS/SLyic8FX6BNg8/3RzA2ZOO0iLCL7GM7doGCSSGnCtOdgK2H/RB
        h4nnSWAtRqQsHWSzTxlE8Jxr57ZQYmJWk4MyyhyqMO5hUQHfSBgGeBLu/FMyYTfcE0EBZSqyCr3+a
        8bMrpkGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFo8E-0020mp-Gj; Tue, 17 Aug 2021 01:43:16 +0000
Date:   Tue, 17 Aug 2021 02:43:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yanghui <yanghui.def@bytedance.com>, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and
 mpol_rebind_task
Message-ID: <YRsULowKJtUKJhJ+@casper.infradead.org>
References: <20210815061034.84309-1-yanghui.def@bytedance.com>
 <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:59:52PM -0700, Andrew Morton wrote:
> On Sun, 15 Aug 2021 14:10:34 +0800 yanghui <yanghui.def@bytedance.com> wrote:
> 
> > Servers happened below panic:
> > Kernel version:5.4.56
> > BUG: unable to handle page fault for address: 0000000000002c48
> > RIP: 0010:__next_zones_zonelist+0x1d/0x40
> > [264003.977696] RAX: 0000000000002c40 RBX: 0000000000100dca RCX: 0000000000000014
> > [264003.977872] Call Trace:
> > [264003.977888]  __alloc_pages_nodemask+0x277/0x310
> > [264003.977908]  alloc_page_interleave+0x13/0x70
> > [264003.977926]  handle_mm_fault+0xf99/0x1390
> > [264003.977951]  __do_page_fault+0x288/0x500
> > [264003.977979]  ? schedule+0x39/0xa0
> > [264003.977994]  do_page_fault+0x30/0x110
> > [264003.978010]  page_fault+0x3e/0x50
> > 
> > The reason of panic is that MAX_NUMNODES is passd in the third parameter
> > in function __alloc_pages_nodemask(preferred_nid). So if to access
> > zonelist->zoneref->zone_idx in __next_zones_zonelist the panic will happen.
> > 
> > In offset_il_node(), first_node() return nid from pol->v.nodes, after
> > this other threads may changed pol->v.nodes before next_node().
> > This race condition will let next_node return MAX_NUMNODES.So put
> > pol->nodes in a local variable.
> > 
> > The race condition is between offset_il_node and cpuset_change_task_nodemask:
> > CPU0:                                     CPU1:
> > alloc_pages_vma()
> >   interleave_nid(pol,)
> >     offset_il_node(pol,)
> >       first_node(pol->v.nodes)            cpuset_change_task_nodemask
> >                       //nodes==0xc          mpol_rebind_task
> >                                               mpol_rebind_policy
> >                                                 mpol_rebind_nodemask(pol,nodes)
> >                       //nodes==0x3
> >       next_node(nid, pol->v.nodes)//return MAX_NUMNODES
> > 
> >
> > ...
> >
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1965,17 +1965,26 @@ unsigned int mempolicy_slab_node(void)
> >   */
> >  static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
> >  {
> > -	unsigned nnodes = nodes_weight(pol->nodes);
> > -	unsigned target;
> > +	nodemask_t nodemask = pol->nodes;
> 
> Ouch.  nodemask_t can be large - up to 128 bytes I think.  This looks
> like an expensive thing to be adding to fast paths (alloc_pages_vma()).

Copying a fixed-size 128 bytes to the stack isn't going to be _that_
expensive.

> Plus it consumes a lot of stack.

alloc_pages_vma() tends to be a leaf function, so not that bad.

> > +	unsigned int target, nnodes;
> >  	int i;
> >  	int nid;
> > +	/*
> > +	 * The barrier will stabilize the nodemask in a register or on
> > +	 * the stack so that it will stop changing under the code.
> > +	 *
> > +	 * Between first_node() and next_node(), pol->nodes could be changed
> > +	 * by other threads. So we put pol->nodes in a local stack.
> > +	 */
> > +	barrier();

I think this could be an smp_rmb()?

> > +	nnodes = nodes_weight(nodemask);
> >  	if (!nnodes)
> >  		return numa_node_id();
> >  	target = (unsigned int)n % nnodes;
> > -	nid = first_node(pol->nodes);
> > +	nid = first_node(nodemask);
> >  	for (i = 0; i < target; i++)
> > -		nid = next_node(nid, pol->nodes);
> > +		nid = next_node(nid, nodemask);
> >  	return nid;
> >  }
> 
> The whole idea seems a bit hacky and fragile to be.  We're dealing with
> a potentially stale copy of the nodemask, yes?

Correct.  Also potentially a nodemask in the middle of being changed,
so it may be some unholy amalgam of previous and next.

> Ordinarily this is troublesome because there could be other problems
> caused by working off stale data and a better fix would be to simply
> avoid using stale data!
> 
> But I guess that if the worst case is that once in a billion times,
> interleaving hands out a page which isn't on the intended node then we
> can live with that.
> 
> And if this guess is correct and it is indeed the case that this is the
> worst case, can we please spell all this out in the changelog.

I think that taking a lock here is worse than copying to the stack.
But that seems like the kind of thing that could be measured?

I don't think that working off stale / amalgam data is a bad thing,
we only need consistency.  This is, after all, interleaved allocation.
The user has asked for us, more or less, to choose a node at random to
allocate from.

What ruffles my feathers more is that we call next_node() up to n-2 times,
and on average (n-1)/2 times (where n is the number of permitted nodes).
I can't help but feel that we could do better to randomly distribute
pages between nodes.  Even having a special case for all-bits-set or
n-contiguous-bits-set-and-all-other-bits-clear would go a long way to
speed this up.

I don't know if anyone has a real complaint about how long this takes
to choose a node, though.  I'm loathe to optimise this without data.
