Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68241EF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353953AbhJAOI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353565AbhJAOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:08:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E858C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v+V/r4h62iC1rLKsrgjisVTgoRvyIjeKcO+78KSD2u0=; b=VnlExgmhWtdxvYcUEVXhVCT9Qk
        T4cMuYA8ClUydes7ClaGaL+wnYjI04npl7GXoOG50t1Koma97//S5Nb7p3IB8gnWkn5EcGelp+wwb
        fwfJpyzHUMhVgeo+2dXD4x6SSwmVEG1lyCkhbcDVJeSBTR3Fsd5ovrT06uTr7PasXMHeQGh5RkCW9
        PMdx67+T/F8r79PU5A+6DnnR/cw9wRZADlsSr+Lt0sZ8m2rU1j06rZcSu8LO/nDVwZ3qqR6T5JHg5
        CGsFK213eb+tiMXUl3fRNGe7yqnWSAGJj0Tsd8hQjg3K3ySv53OeAD506E+A/X6yYfxKBpGMISj19
        hB6CzlKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWJAS-00Dxk8-98; Fri, 01 Oct 2021 14:06:04 +0000
Date:   Fri, 1 Oct 2021 15:05:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kasan: Fix tag for large allocations when using
 CONFIG_SLAB
Message-ID: <YVcVtNLnyJModOhn@casper.infradead.org>
References: <20211001024105.3217339-1-willy@infradead.org>
 <CA+fCnZfSUxToYKUfHwQT0r3bC9NYZNc2iC3PXv+GciuW0Fm79A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfSUxToYKUfHwQT0r3bC9NYZNc2iC3PXv+GciuW0Fm79A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 03:29:29PM +0200, Andrey Konovalov wrote:
> On Fri, Oct 1, 2021 at 4:42 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > If an object is allocated on a tail page of a multi-page slab, kasan
> > will get the wrong tagbecause page->s_mem is NULL for tail pages.
> 
> Interesting. Is this a known property of tail pages? Why does this
> happen? I failed to find this exception in the code.

Yes, it's a known property of tail pages.  kmem_getpages() calls
__alloc_pages_node() which returns a pointer to the head page.
All the tail pages are initialised to point to the head page.
Then in alloc_slabmgmt(), we set ->s_mem of the head page, but
we never set ->s_mem of the tail pages.  Instead, we rely on
people always passing in the head page.  I have a patch in the works
to change the type from struct page to struct slab so you can't
make this mistake.  That was how I noticed this problem.

> The tag value won't really be "wrong", just unexpected. But if s_mem
> is indeed NULL for tail pages, your fix makes sense.
> 
> > I'm not quite sure what the user-visible effect of this might be.
> 
> Everything should work, as long as tag values are assigned
> consistently based on the object address.

OK, maybe this doesn't need to be backported then?  Actually, why
subtract s_mem in the first place?  Can we just avoid that for all
tag calculations?
