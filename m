Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E843F73C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhHYKzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239811AbhHYKzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B3DE610D0;
        Wed, 25 Aug 2021 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629888891;
        bh=43dMkUgGcDYcyzWnolvQYPW9uYzAg+QlRlBiAYcHEqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTPiJObERgLnfoiCA+F1nMwZZ86Km8eMk/fEw72ai9DIWymU2fxJhScwVftlUfCBz
         2nFJNucUUqJRrqJsXwboQwWqVBHyE1/KR1xSezpLFqa4Zsafe6QVI1sjQi1vwfLS3K
         LOefmynFQuDZO2qS0HQMaf/cI5YiKayJ07+n9DbL2N2vQUXG9DS37Pd6eUhrUavVPx
         SFN7Tfdo5cEyW4pvGTChmeFAtI9bnm+6DP8nhSnJgNOFvGns7UlNAd+shdGBOl+ZuZ
         B4ttJCYCo61dFcyiPpde6NMyaSFHFrgwIWkoCuvH4SMTJrWIhrMEyP+tbXA/n4flKW
         vbTbvJxvor/RA==
Date:   Wed, 25 Aug 2021 13:54:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YSYhdT+fP59b17GE@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:38:31PM +0200, David Hildenbrand wrote:
> On 25.08.21 12:20, Catalin Marinas wrote:
>
> > I can see the documentation for pfn_valid() does not claim anything more
> > than the presence of an memmap entry. But I wonder whether the confusion
> > is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
> > assumes __va() can be used on pfn_valid(), though I suspect it relies on
> > the calling function to check that the resource was RAM. The arm64
> > kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
> > standard memcpy on it, which wouldn't work for I/O (should we change
> > this check to pfn_is_map_memory() for arm64?).
> 
> kern_addr_valid() checks that there is a direct map entry, and that the
> mapped address has a valid mmap. (copied from x86-64)
> 
> Would you expect to have a direct map for memory holes and similar (IOW,
> !System RAM)?

I don't see where will it bail out for an IOMEM mapping before doing the
pfn_valid() check...
 
-- 
Sincerely yours,
Mike.
