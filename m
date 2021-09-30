Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0FC41D2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348149AbhI3FsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:48:24 -0400
Received: from verein.lst.de ([213.95.11.211]:58224 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348126AbhI3FsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:48:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3107468AFE; Thu, 30 Sep 2021 07:46:38 +0200 (CEST)
Date:   Thu, 30 Sep 2021 07:46:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20210930054637.GA22287@lst.de>
References: <20210930013039.11260-1-rppt@kernel.org> <20210930013039.11260-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930013039.11260-2-rppt@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 04:30:38AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for a
> PFN but it does not ensure that the PFN is actually backed by RAM.
> 
> As dma_map_resource() is the only method in DMA mapping APIs that has this
> check, simply drop the pfn_valid() test from dma_map_resource().
> 
> Link: https://lore.kernel.org/all/20210824173741.GC623@arm.com/
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

We'll lose a bit of a sanity check with this, but given the problems it
caused:

Reviewed-by: Christoph Hellwig <hch@lst.de>
