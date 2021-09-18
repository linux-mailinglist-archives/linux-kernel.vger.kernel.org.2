Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1D410429
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhIRFUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:20:11 -0400
Received: from verein.lst.de ([213.95.11.211]:46950 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhIRFUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:20:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A44E867357; Sat, 18 Sep 2021 07:18:43 +0200 (CEST)
Date:   Sat, 18 Sep 2021 07:18:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210918051843.GA16104@lst.de>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com> <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org> <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com> <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com> <20210825102044.GA3420@arm.com> <YUUHJ5EI+6Mop4Wu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUUHJ5EI+6Mop4Wu@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:22:47AM +0300, Mike Rapoport wrote:
> I did some digging and it seems that the most "generic" way to check if a
> page is in RAM is page_is_ram(). It's not 100% bullet proof as it'll give
> false negatives for architectures that do not register "System RAM", but
> those are not using dma_map_resource() anyway and, apparently, never would.

The downside of page_is_ram is that it looks really expensiv for
something done at dma mapping time.
