Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65C336C508
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhD0L1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhD0L1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:27:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B3AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7jRpqar9SQV8YDRO6fEObuydnQktt3oGyEBIeNr8C2Y=; b=uft5BnsdR+cxu63relHri/o/dC
        1oydk+1v/Xa0mTUxScG5CEcyKOUSD3+QP7yjBdd4jYiTdp78lreavZPffw1BPuXiP+i/VcLV9LfMF
        rJiebDefsRamz8Ok/eVZSuzBiaIaauXGwOfzDcTc1+JduO5QRWaJPZeJYaSksb+fy5YRudomSa3By
        Xs8UcBfZPboxhyV1scpQn7icBKVSJ/nihbM/FAy6+ojmpvg3T0TUADPHGUYUOWaD7Uwr85GJnN9zm
        D+7jWZcNZJlFbn1XPB34u3ULf+nhnbd2QrQizfRw2MeUZ8VYsZXV37HRRjcGNgQkGQM+CCvZXvAeR
        /FAqr1LA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbLqJ-006qFz-SO; Tue, 27 Apr 2021 11:25:33 +0000
Date:   Tue, 27 Apr 2021 12:25:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
Message-ID: <20210427112527.GX235567@casper.infradead.org>
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org>
 <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org>
 <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
 <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:30:48PM +0800, Xiongwei Song wrote:
> Hi Mattew,
> 
> One more thing I should explain, the kmalloc_order() appends the
> __GFP_COMP flags,
> not by the caller.
> 
> void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> {
> ...........................................................
> 
> flags |= __GFP_COMP;
> page = alloc_pages(flags, order);
> ...........................................................
> return ret;
> }
> EXPORT_SYMBOL(kmalloc_order);
> 
> #ifdef CONFIG_TRACING
> void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> {
> void *ret = kmalloc_order(size, flags, order);
> trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
> return ret;
> }
> EXPORT_SYMBOL(kmalloc_order_trace);
> #endif

Yes, I understood that.  What I don't understand is why appending the
__GFP_COMP to the trace would have been less confusing for you.

Suppose I have some code which calls:

	kmalloc(10 * 1024, GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC);

and I see in my logs 

     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000 bytes_req=10176 bytes_alloc=16384 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC|__GFP_COMP

That seems to me _more_ confusing because I would wonder "Where did that
__GFP_COMP come from?"

> 
> Regards,
> Xiongwei
> 
> On Tue, Apr 27, 2021 at 12:11 PM Xiongwei Song <sxwjean@gmail.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 11:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 11:29:32AM +0800, Xiongwei Song wrote:
> > > > On Tue, Apr 27, 2021 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> > > > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > > > >
> > > > > > When calling kmalloc_order, the flags should include __GFP_COMP here,
> > > > > > so that trace_malloc can trace the precise flags.
> > > > >
> > > > > I suppose that depends on your point of view.
> > > > Correct.
> > > >
> > > > Should we report the
> > > > > flags used by the caller, or the flags that we used to allocate memory?
> > > > > And why does it matter?
> > > > When I capture kmem:kmalloc events on my env with perf:
> > > > (perf record -p my_pid -e kmem:kmalloc)
> > > > I got the result below:
> > > >      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000
> > > > bytes_req=10176 bytes_alloc=16384
> > > > gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
> > >
> > > Hmm ... if you have a lot of allocations about this size, that would
> > > argue in favour of adding a kmem_cache of 10880 [*] bytes.  That way,
> > > we'd get 3 allocations per 32kB instead of 2.
> > I understand you. But I don't think our process needs this size. This size
> > may be a bug in our code or somewhere, I don't know the RC for now.
> >
> > > [*] 32768 / 3, rounded down to a 64 byte cacheline
> > >
> > > But I don't understand why this confused you.  Your caller at
> > > ffffffff851d0cb0 didn't specify __GFP_COMP.  I'd be more confused if
> > > this did report __GFP_COMP.
> > >
> > I just wanted to save some time when debugging.
> >
> > Regards
