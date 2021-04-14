Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0689A35FB20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbhDNSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhDNSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:52:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF49C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cZGC7UnPezViYO3pgQBLAZLy4cqfJPUXcH3bLtytfbI=; b=QqC2HBPhkoCSQZtHJBvPNa4Jtb
        yLK+a+7o47jCu9gw490CAdhLPdBZ/LVZ468zdouGF8i8aSaybltc7S48pccqHA7+Ry/lv11qeFpji
        xfbDwuH5+k8q0zkzecAGaFcwCoyonXuLBNBLiGnYhVV/R7y+T8YDmbarl01ngFaqxhyp7j6UcVTr4
        7AqTJJzl5dk0niaUK3knKG+fsQzAgcwhKVuNA6JIVs0sP0A5qJ6uHXebY4hWrEJaReJqb3Jrx5y3S
        QqoDASiLY9kdAx0+elRanvbAHfkotGmboJJPIOczOZeGKPECfUJvCaiPXlZdplgW0gQaodabNQsNu
        ZYf+YAew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWkcH-007VAy-Ag; Wed, 14 Apr 2021 18:52:03 +0000
Date:   Wed, 14 Apr 2021 19:51:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Douglas Gilbert <dougg@torque.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: Optimise nth_page for contiguous memmap
Message-ID: <20210414185157.GU2531743@casper.infradead.org>
References: <20210413194625.1472345-1-willy@infradead.org>
 <67922c5b-0a7b-4eab-9fee-455acf555ebf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67922c5b-0a7b-4eab-9fee-455acf555ebf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:24:42PM +0200, David Hildenbrand wrote:
> On 13.04.21 21:46, Matthew Wilcox (Oracle) wrote:
> > +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >   #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> > +#else
> > +#define nth_page(page,n) ((page) + (n))
> > +#endif
> 
> For sparsemem we could optimize within a single memory section. But not sure
> if it's worth the trouble.

Not only is it not worth the trouble, I suspect it's more expensive to
test-and-branch than just unconditionally call pfn_to_page() and
page_to_pfn().  That said, I haven't measured.

SPARSEMEM_VMEMMAP is default Y, and enabled by arm64, ia64, powerpc,
riscv, s390, sparc and x86.  I mean ... do we care any more?

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
