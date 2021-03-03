Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A610B32C324
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhCCX7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbhCCTmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:42:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE66C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w7rnAtm+5rmUMrt1OegFvCAzCtgfl80a+yX/UPaOyPY=; b=HFX3Ree+HgwGP9YppDyjBu+56k
        LUsFOu01L/T5XS5UmatceiCZxATCw60R2G5ciblJbG1Nt6NG9OIW1g0ASfgMWGZ8RFKDy/XwgOkxB
        tbN+9LR01DA6SsvlLGy4bnfMUf+NQTVjBWS4TbE92TwtphqbllbdPeArDTgprPR/e4mHQCXO2a+vf
        GC5wSK93cFyubBVDc9pQf+ecQtkWKhDUyidXRh9iW1Ac5EtoNGoYjpFUEGCIEUPCDaaLqRyADXBXp
        jN6aag39uFyQQmm9DULLIHHAXVPTnOczhxLv/b173nGPF+STy9BCHzIYxwEx0yGWy83yy6XUZXPbU
        SMr9HIEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHXCg-003uht-L8; Wed, 03 Mar 2021 19:30:39 +0000
Date:   Wed, 3 Mar 2021 19:30:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
Message-ID: <20210303193038.GE2723601@casper.infradead.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
 <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
 <20210303142612.GC2723601@casper.infradead.org>
 <alpine.DEB.2.22.394.2103032012250.896915@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2103032012250.896915@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:15:58PM +0100, Christoph Lameter wrote:
> On Wed, 3 Mar 2021, Matthew Wilcox wrote:
> 
> > On Tue, Mar 02, 2021 at 10:14:53AM +0100, Christoph Lameter wrote:
> > > On Mon, 10 Aug 2020, Xunlei Pang wrote:
> > > > -	atomic_long_t partial_free_objs;
> > > > +	atomic_long_t __percpu *partial_free_objs;
> > >
> > > A percpu counter is never atomic. Just use unsigned long and use this_cpu
> > > operations for this thing. That should cut down further on the overhead.
> >
> > What about allocations from interrupt context?  Should this be a local_t
> > instead?
> 
> Can this be allocated in an interrupt context?
> 
> And I am not sure how local_t relates to that? Percpu counters can be used
> in an interrupt context without the overhead of the address calculations
> that are required by a local_t.

As I understand the patch, this counts the number of partially free slabs.
So if we start to free an object from a completely full slab in process
context, as "load x, add one to x, store x" and take an interrupt
between loading x and adding one to x, that interrupt handler might
free a different object from another completely full slab.  that would
also load the same x, add one to it and store x, but then the process
context would add one to the old x, overwriting the updated value from
interrupt context.

it's not the likeliest of races, and i don't know how important it is
that these counters remain accurate.  but using a local_t instead of
a percpu long would fix the problem.  i don't know why you think that
a local_t needs "address calculations".  perhaps you've misremembered
what a local_t is?
