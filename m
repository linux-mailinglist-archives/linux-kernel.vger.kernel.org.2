Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018FD3F7B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhHYRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232493AbhHYRQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD50F61076;
        Wed, 25 Aug 2021 17:15:55 +0000 (UTC)
Date:   Wed, 25 Aug 2021 18:15:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210825171552.GH3420@arm.com>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
 <20210825105510.GB3420@arm.com>
 <547785ff-e02f-df28-7f9c-9ad4f5b3cc77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547785ff-e02f-df28-7f9c-9ad4f5b3cc77@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:12:37PM +0200, David Hildenbrand wrote:
> On 25.08.21 12:55, Catalin Marinas wrote:
> > On Wed, Aug 25, 2021 at 12:38:31PM +0200, David Hildenbrand wrote:
> > > On 25.08.21 12:20, Catalin Marinas wrote:
> > > > I can see the documentation for pfn_valid() does not claim anything more
> > > > than the presence of an memmap entry. But I wonder whether the confusion
> > > > is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
> > > > assumes __va() can be used on pfn_valid(), though I suspect it relies on
> > > > the calling function to check that the resource was RAM. The arm64
> > > > kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
> > > > standard memcpy on it, which wouldn't work for I/O (should we change
> > > > this check to pfn_is_map_memory() for arm64?).
> > > 
> > > kern_addr_valid() checks that there is a direct map entry, and that the
> > > mapped address has a valid mmap. (copied from x86-64)
> > 
> > It checks that there is a va->pa mapping, not necessarily in the linear
> > map as it walks the page tables. So for some I/O range that happens to
> > be mapped but which was in close proximity to RAM so that pfn_valid() is
> > true, kern_addr_valid() would return true. I don't thin that was the
> > intention.
> > 
> > > Would you expect to have a direct map for memory holes and similar (IOW,
> > > !System RAM)?
> > 
> > No, but we with the generic pfn_valid(), it may return true for mapped
> > MMIO (with different attributes than the direct map).
> 
> Ah, right. But can we actually run into that via kcore?
> 
> kcore builds the RAM list via walk_system_ram_range(), IOW the resource
> tree. And we end up calling kern_addr_valid() only on KCORE_RAM,
> KCORE_VMEMMAP and KCORE_TEXT.

It's probably fine but I'd rather do some check of the other call sites
before attempting to move arm64 to the generic pfn_valid() again.

-- 
Catalin
