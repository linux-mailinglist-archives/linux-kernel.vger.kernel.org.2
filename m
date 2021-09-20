Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D037F411332
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhITK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhITK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7885B60F3A;
        Mon, 20 Sep 2021 10:58:01 +0000 (UTC)
Date:   Mon, 20 Sep 2021 11:57:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YUhpNgwwttW1ewez@arm.com>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
 <YUWlO2tZC5IwCAHV@kernel.org>
 <YUXQBV6KKi+/Q6gX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUXQBV6KKi+/Q6gX@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 02:39:49PM +0300, Mike Rapoport wrote:
> On Sat, Sep 18, 2021 at 11:37:22AM +0300, Mike Rapoport wrote:
> > On Sat, Sep 18, 2021 at 07:18:43AM +0200, Christoph Hellwig wrote:
> > > On Sat, Sep 18, 2021 at 12:22:47AM +0300, Mike Rapoport wrote:
> > > > I did some digging and it seems that the most "generic" way to check if a
> > > > page is in RAM is page_is_ram(). It's not 100% bullet proof as it'll give
> > > > false negatives for architectures that do not register "System RAM", but
> > > > those are not using dma_map_resource() anyway and, apparently, never would.
> > > 
> > > The downside of page_is_ram is that it looks really expensiv for
> > > something done at dma mapping time.
> > 
> > Indeed :(
> > But pfn_valid is plain wrong...
> > I'll keep digging.
> 
> I did some more archaeology and it that check for pfn_valid() was requested
> by arm folks because their MMU may have troubles with alias mappings with
> different attributes and so they made the check to use a false assumption
> that pfn_valid() == "RAM".
> 
> As this WARN_ON(pfn_valid()) is only present in dma_map_resource() it's
> probably safe to drop it entirely. 

I agree, we should drop it. IIUC dma_map_resource() does not create any
kernel mapping to cause problems with attribute aliasing. You'd need a
prior devm_ioremap_resource() if you want access to that range from the
CPU side. For arm64 at least, the latter ends up with a
pfn_is_map_memory() check.

-- 
Catalin
