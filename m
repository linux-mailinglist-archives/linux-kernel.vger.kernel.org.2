Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82C4410E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 03:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhITB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhITB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 21:56:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0399C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 18:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mcG2GyjY+30D4uFBWjd8stKr6bjD50FppNHIO6OVqmA=; b=fae2GH1rQ7d/WSurj5Xhc1shOa
        PuTIVXK+q0mYuoNtzOZ7bs3B0UA+Uwl4l/Y+eqevgHJsBrdJlm8hSGYSmr9q40e0/dxOTvDYyQEOv
        2KLUxmC5aj5MWKtD3xp6GMvU24mg64xT17MyH5sPdOTUM5vIshfhs+AquWR6NciRZ4a8yaT3r3jNu
        rmBijV9ZO9yxas/L23oWm1vpa2e2EnazhCW/8f4AqdAmEfPGp6mX9g6c1pDbGvRITP4c4ETqrBtZy
        kLTphQVhI2teotSA9fUdsk/3JjA9smVJ0V8B1fSRwEnoPon5xQoSV20w5DnJHz+iMuqUbRSn5TVqC
        bCNEY1HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mS8Uw-002J3m-Kt; Mon, 20 Sep 2021 01:53:44 +0000
Date:   Mon, 20 Sep 2021 02:53:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <YUfpniK6ZVeNhaX2@casper.infradead.org>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
> Hello Matthew, Thanks to give me a comment! I appreciate it.
> 
> On Sun, Sep 19, 2021 at 08:17:44PM +0100, Matthew Wilcox wrote:
> > On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
> > > It is just simple proof of concept, and not ready for submission yet.
> > > There can be wrong code (like wrong gfp flags, or wrong error handling,
> > > etc) it is just simple proof of concept. I want comment from you.
> > 
> > Have you read:
> > 
> > https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/
> > The relevant part of that paper is section 3, magazines.  We should have
> > low and high water marks for number of objects
> 
> I haven't read that before, but after reading it seems not different from
> SLAB's percpu queuing.
>  
> > and we should allocate
> > from / free to the slab allocator in batches.  Slab has bulk alloc/free
> > APIs already.
> > 
> 
> There's kmem_cache_alloc_{bulk,free} functions for bulk
> allocation. But it's designed for large number of allocation
> to reduce locking cost, not for percpu lockless allocation.

What I'm saying is that rather than a linked list of objects, we should
have an array of, say, 15 pointers per CPU (and a count of how many
allocations we have).  If we are trying to allocate and have no objects,
call kmem_cache_alloc_bulk() for 8 objects.  If we are trying to free
and have 15 objects already, call kmem_cache_free_bulk() for the last
8 objects and set the number of allocated objects to 7.

(maybe 8 and 15 are the wrong numbers.  this is just an example)

> Yeah, we can implement lockless cache using kmem_cache_alloc_{bulk, free}
> but kmem_cache_alloc_{free,bulk} is not enough.
> 
> > I'd rather see this be part of the slab allocator than a separate API.
> 
> And I disagree on this. for because most of situation, we cannot
> allocate without lock, it is special case for IO polling.
> 
> To make it as part of slab allocator, we need to modify existing data
> structure. But making it part of slab allocator will be waste of memory
> because most of them are not using this.

Oh, it would have to be an option.  Maybe as a new slab_flags_t flag.
Or maybe a kmem_cache_alloc_percpu_lockless().
