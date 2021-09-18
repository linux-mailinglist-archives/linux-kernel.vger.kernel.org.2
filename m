Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC03410615
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhIRLlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhIRLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:41:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95D1B61244;
        Sat, 18 Sep 2021 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631965196;
        bh=BzRo8ApXY7trnCJ4YSP1u1W1GLdyywjRf4lzNkQ9II0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rk5GtKtSkrKOa37Armo/WbiMF40SMYf8Z/yR7wQLJ4tq9WvlEnBIZRkh/v7avyV+1
         F3jWBZaBjcyK3s4MIFrizkLVTv3itkj4orR1Mq67lK2PEa9dn09GJS3+kyQJ5Ek1k0
         jDipUzBhNz72d8ZC/6axWHaQV/QZJgpAOpSiGdC+SlkNm4f/n/D8CKTX2p15oT2QM2
         0TAsWlAbZWDnB4N4h513W1swEMpj+nQs7sW0PNjH5scL+6KIqqW+Tn+1ZyL6RhO3OQ
         UcZfnBAVhOCmMQjNufRvsycfCDXV/v2wltAP2a8387XaTVOCoMThTvANyB2vffLdSt
         dxUydgSy7D22Q==
Date:   Sat, 18 Sep 2021 14:39:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YUXQBV6KKi+/Q6gX@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
 <YUWlO2tZC5IwCAHV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUWlO2tZC5IwCAHV@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 11:37:22AM +0300, Mike Rapoport wrote:
> On Sat, Sep 18, 2021 at 07:18:43AM +0200, Christoph Hellwig wrote:
> > On Sat, Sep 18, 2021 at 12:22:47AM +0300, Mike Rapoport wrote:
> > > I did some digging and it seems that the most "generic" way to check if a
> > > page is in RAM is page_is_ram(). It's not 100% bullet proof as it'll give
> > > false negatives for architectures that do not register "System RAM", but
> > > those are not using dma_map_resource() anyway and, apparently, never would.
> > 
> > The downside of page_is_ram is that it looks really expensiv for
> > something done at dma mapping time.
> 
> Indeed :(
> But pfn_valid is plain wrong...
> I'll keep digging.

I did some more archaeology and it that check for pfn_valid() was requested
by arm folks because their MMU may have troubles with alias mappings with
different attributes and so they made the check to use a false assumption
that pfn_valid() == "RAM".

As this WARN_ON(pfn_valid()) is only present in dma_map_resource() it's
probably safe to drop it entirely. 

Otherwise the simplest way would be to hide it behind something like
ARCH_WANTS_DMA_NOT_RAM and make arm/arm64 select it.

Thoughts?

-- 
Sincerely yours,
Mike.
