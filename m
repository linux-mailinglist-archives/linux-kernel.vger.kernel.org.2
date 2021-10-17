Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007A84309D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbhJQOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhJQOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:42:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C8C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80/t/c+UlQL/GFdmduRihZ3yN36jPN478cR6XUY8+rc=; b=EQf/D1wHYBCM3t9+mrYTWvCfzX
        rI3KoP/nNTFqiMfBT3ddBel9BWMSfC5E3yBXi1brZgOmnxOKvjeCVywhNP79wnQPA6DTIwrj1kQqp
        IicM1zc1+igaX1EfXsA5lF6YNBzCtcZb4JvwPqkrjMiDoyGFn8X182ZXfVoTn4vx62lmWsurJM//o
        4use1qlTTP8kK5fO+xnNNgYzs0bAoLN2a672XHjSzdF/aY+M0WU6LqbKmamlwGviQI+E5vLirNwmU
        EzH0Lh//jwGcFWchb7lgqENAftHA+weR0vullrovJcuH4ZpPH9wzlC/Ed63weY8l8ravGMKswcYN7
        RDSd1NKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mc7Jv-00ALY5-4T; Sun, 17 Oct 2021 14:39:34 +0000
Date:   Sun, 17 Oct 2021 15:39:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <YWw1n6y/AGED14HD@casper.infradead.org>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 01:57:08PM +0000, Hyeonggon Yoo wrote:
> On Sun, Oct 17, 2021 at 01:36:18PM +0000, Hyeonggon Yoo wrote:
> > On Sun, Oct 17, 2021 at 04:28:52AM +0000, Hyeonggon Yoo wrote:
> > > I've been reading SLUB/SLOB code for a while. SLUB recently became
> > > real time compatible by reducing its locking area.
> > > 
> > > for now, SLUB is the only slab allocator for PREEMPT_RT because
> > > it works better than SLAB on RT and SLOB uses non-deterministic method,
> > > sequential fit.
> > > 
> > > But memory usage of SLUB is too high for systems with low memory.
> > > So In my local repository I made SLOB to use segregated free list
> > > method, which is more more deterministic, to provide bounded latency.
> > > 
> > > This can be done by managing list of partial pages globally
> > > for every power of two sizes (8, 16, 32, ..., PAGE_SIZE) per NUMA nodes.
> > > minimal allocation size is size of pointers to keep pointer of next free object
> > > like SLUB.
> > > 
> > > By making objects in same page to have same size, there's no
> > > need to iterate free blocks in a page. (Also iterating pages isn't needed)
> > > 
> > > Some cleanups and more tests (especially with NUMA/RT configs) needed,
> > > but want to hear your opinion about the idea. Did not test on RT yet.
> > > 
> > > Below is result of benchmarks and memory usage. (on !RT)
> > > with 13% increase in memory usage, it's nine times faster and
> > > bounded fragmentation, and importantly provides predictable execution time.
> > > 
> > 
> > Hello linux-mm, I improved it and it uses lower memory
> > and 9x~13x faster than original SLOB. it shows much less fragmentation
> > after hackbench.
> > 
> > Rather than managing global freelist that has power of 2 sizes,
> > I made a kmem_cache to manage its own freelist (for each NUMA nodes) and
> > Added support for slab merging. So It quite looks like a lightweight SLUB now.
> > 
> > I'll send rfc patch after some testing and code cleaning.
> > 
> > I think it is more RT-friendly becuase it's uses more deterministic
> > algorithm (But lock is still shared among cpus). Any opinions for RT?
> 
> Hi there. after some thinking, I got a new question:
> If a lightweight SLUB is better than SLOB,
> Do we really need SLOB nowdays?

Better for what use case?  SLOB is for machines with 1-16MB of RAM.
