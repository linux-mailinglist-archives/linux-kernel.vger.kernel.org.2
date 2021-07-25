Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252973D4F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGYQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:56:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A181C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VWlRNY3LlmubsZmgJXQ96OY7Q2TJYsaXTfyxii0FK9E=; b=kEoCBUbJ66NGZotknOlYmGqFPg
        wlFmNe2NWjqIltXcoSf3v7dCsWDjXXqxroveipRGwjEdIUHCg1plfT6DsE/AVe2VQV2Q9Dt5u+Hd6
        4AV1dSJTKRnBKNDa33zK8Wlxv+2M+uRzxrMN4sbOR4B0TPBuF+UrjLxXcdqWH0gBZuyTQDc5x5lt0
        cw+QA1zx/9Tuv2G+cg2WscdhSbMW96GddtYwbuZh0GfKFJ6JNpoEyVsDHxsQgo/czJUh/d6rYBOXD
        Gj/pT1YsMZ8ir4UwHxdIJ8jDQSazGiv718ydYzF0PXmJv9ULJNfeaUCgOTv3ak+yNk3pWWI63rQ0h
        g9y9KuGA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7i2u-00DDRb-Gh; Sun, 25 Jul 2021 17:36:24 +0000
Date:   Sun, 25 Jul 2021 18:36:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
Message-ID: <YP2hDMf8/KQBaPbd@infradead.org>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
 <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 09:50:29AM -0700, Linus Torvalds wrote:
> On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > dma-mapping fix for Lonux 5.14
> 
> We're calling it "Lonux" now?

Only on weekends :)

> >   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
> >     (Roman Skakun)
> 
> I've pulled this, but my reaction is that we've tried to avoid this in
> the past. Why is Xen using vmalloc'ed addresses and passing those in
> to the dma mapping routines?
> 
> It *smells* to me like a Xen-swiotlb bug, and it would have been
> better to try to fix it there. Was that just too painful?

vmalloc (or rather vmap) addresses actually are the most common
way to provide uncachable mappings on architectures that are not
cache coherent.  The only Xen part here is that swiotlb-xen is a mess
and gets the address from the dma-direct allocator which does vmapping
for arm/arm64, but then uses the common helpers later due to a variety
of issues that will take a while to address.
