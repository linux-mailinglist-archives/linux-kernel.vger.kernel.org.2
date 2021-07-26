Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A173D67D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhGZTX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhGZTX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA84E60F6E;
        Mon, 26 Jul 2021 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627329836;
        bh=Wz9/1UR+NNm1PWmlemY6+S+vta0TSAKrTaG4D9BMtVU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ItiA4mf5ZlUSB7NEffLS/Ciydpncc8l8pOdGbITmrzKgIJkUUPs7R7WnKNHCWStGr
         UMVpaQdvW8JE+VQFNBHDaQsB8mcFjo+olM/SYE0Nw3dBEBTSoPiE/kuP+51PJDAHbc
         9LyxycyrPeKTiTHLQZXVMrTpXqm2vuSnU74u++9SnVjKnGi1ovv/O4P1G3bNRLhGZN
         xo9loHiTbvMdHtlivPsvwg5TqAsSJDlabH6OVICoR3gNqsT8O9DuLsOB+BvkpnwtBK
         1uYAZioNvM3X2whk38QJIYZ8yKznb03/U39coBfHVAAtVt3g5neSe41arfYpzXCh+q
         3xQ0VIy+aUH4g==
Date:   Mon, 26 Jul 2021 13:03:55 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        rm.skakun@gmail.com
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
In-Reply-To: <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
Message-ID: <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
References: <YPz+qQ6dbZVDbMwu@infradead.org> <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com> <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021, Boris Ostrovsky wrote:
> On 7/25/21 12:50 PM, Linus Torvalds wrote:
> > On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> >>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
> >>     (Roman Skakun)
> > I've pulled this, but my reaction is that we've tried to avoid this in
> > the past. Why is Xen using vmalloc'ed addresses and passing those in
> > to the dma mapping routines?
> >
> > It *smells* to me like a Xen-swiotlb bug, and it would have been
> > better to try to fix it there. Was that just too painful?
> 
> 
> Stefano will probably know better but this appears to have something to do with how Pi (and possibly more ARM systems?) manage DMA memory: https://lore.kernel.org/xen-devel/CADz_WD5Ln7Pe1WAFp73d2Mz9wxspzTE3WgAJusp5S8LX4=83Bw@mail.gmail.com/.

The original issue was found on the Raspberry Pi 4, and the fix was in
swiotlb-xen.c, commit 8b1e868f6. More recently, Roman realized that
dma_common_mmap might also end up calling virt_to_page on a vmalloc
address. This is the fix for that.


Why is Xen using vmalloc'ed addresses with dma routines at all?

Xen is actually just calling the regular dma_direct_alloc to allocate
pages (xen_swiotlb_alloc_coherent -> xen_alloc_coherent_pages ->
dma_direct_alloc). dma_direct_alloc is the generic implementation. Back
when the original issue was found, dma_direct_alloc returned a vmalloc
address on RPi4.

The original analysis was "xen_alloc_coherent_pages() eventually calls
arch_dma_alloc() in remap.c which successfully allocates pages from
atomic pool." See https://marc.info/?l=xen-devel&m=158878173207775.


I don't know on which platform Roman Skakun (CC'ed) found the problem.
But if we look at arch/arm/mm/dma-mapping.c:__dma_alloc, one of the
possible options is the "remap_allocator", which calls
__alloc_remap_buffer, which calls dma_common_contiguous_remap, which
calls vmap.

So unfortunately it seems that on certain arch/platforms
dma_alloc_coherent can return a vmap'ed address. So I would imagine this
issue could also happen on native (without Xen), at least in theory.
