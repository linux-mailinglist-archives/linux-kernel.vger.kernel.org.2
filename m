Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058823FF9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhICFOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhICFOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:14:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DBC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UlEAUZgNSV9IiQxtgDAees0K8I+nSxX4MJTd8gGCXJc=; b=vC+CSNqDPT1bhBqU5aJKaRQbS1
        U52C9gFObhniRYFawQnGL0W00xVwUumU8YScqRD4xha1utnGeSo9qd1ArsjU0oN+hKd22AQdd0a6t
        KB4DdbRUeDx3AlqIJqLuINuXqzzBMU+aC38THWM27Q53TSymgHc6d5CsGY0malYVUATv1cwLYELsV
        Lc07ETsCyiYAqlr7WsCt+Z6RsppiCJCMex3RV04lEHe4YmzbMJHO60eQs1lk84beemj6fyuy+jWI0
        uT1yhCS7/23rajV1k5uhIXwLP9zpQ6IhU7cUs7h1oioywDnfcB3SVls546zKVYoHjwxzy4pIVMEmY
        yIpoAClg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM1SS-0049W4-90; Fri, 03 Sep 2021 05:09:57 +0000
Date:   Fri, 3 Sep 2021 06:09:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
Message-ID: <YTGuGGxAoWMB9/Mg@infradead.org>
References: <YS/r5eaf/ps5ekie@localhost.localdomain>
 <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
 <bceb9212-8fb0-be6e-997f-82962f855081@arm.com>
 <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 05:42:11PM -0700, Linus Torvalds wrote:
> On Thu, Sep 2, 2021 at 2:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Not to defend the state things have got into - frankly I've found it
> > increasingly hard to follow for some time now too - but I believe the
> > unwritten story is of the one true dma-direct trying to be all things to
> > all users, and there are several aspects at play here which are mutually
> > exclusive in practice.
> 
> Ugh.
> 
> Some of that "mutual exclusion" seems to be encoded in peoples heads,
> not in the code itself.

Some of it is.  This is mostly because we're still most in stage 1
of the grand plan:

  "consolidate 100% identical concepts various architectures reimplement"

which will slowly give way to actually clean up various mostly the same
concepts.  And the big items here is the various pools.  This simple
coherent pool and the one we use for GFP_ATOMIC alloctions for
not coherent devices would be a very obvious first step.  Swiotlb would
be the next one, but it is much more complicated as swiotlb is messy
and has a rather "special" allocator algorithm.

> 
> > The global pool is essentially for noMMU, so should not be expected to
> > overlap with SWIOTLB at all, much less systems using restricted DMA.
> 
> If I read that right, you're saying that in this case, the possible
> mis-merge doesn't matter?

Currently (and for the foreseeable future) it does not matter.


> Except the dispatch logic ends up being all those different cases that
> have nothing to do with each other, because people have very clearly
> tried to avoid code duplication by just saying "ok, in these two
> entirely unrelated situations, we do the same thing".

Not just that.  There are plenty of cases where architectures need
multiple of these cases depending on runtime checks.

But yes, this funtion turned into a mess, and we can improve both
the overall structure and the omments explaining it a fair bit.
