Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED93A6956
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhFNOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232852AbhFNOxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A31186128C;
        Mon, 14 Jun 2021 14:51:07 +0000 (UTC)
Date:   Mon, 14 Jun 2021 15:51:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
Message-ID: <20210614145105.GC30667@arm.com>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
 <20210614083609.GA18701@willie-the-truck>
 <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 06:07:04PM +0800, Dong Aisheng wrote:
> On Mon, Jun 14, 2021 at 4:36 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
> > > Coherent dma on ARM64 also can't work with mapped system ram,
> > > that means 'no-map' property must be specified in dts.
> > > Add the missing check for ARM64 platforms as well.
> > > Besides 'no-map' checking, 'linux,dma-default' feature is also
> > > enabled for ARM64 along with this patch.
> >
> > Please can you explain _why_ it can't work? We don't need to tear down
> > aliases from the linear map for the streaming DMA API, so why is this
> > case different? Also, coherent devices wouldn't need this either way,
> > would they? What problem are you solving here?
> >
> 
> Not sure if i get your point correctly. Here is my understanding. (fix
> me if wrong)
> In current implementation, the coherent dma memory will be remapped as
> writecombine and uncached type which can't reuse the linear mapping.
> The prerequisite to do this is the memory must not be mapped System RAM.
> e.g. reserved memory with no-map property and invisible to the buddy system.

The architecture allows the system RAM to be mapped in the linear map
while there's another writecombine alias, as long as there are no dirty
cache lines that could be evicted randomly. This works fine with the DMA
API (and we have some cache maintenance when the non-cacheable mapping
is first created).

Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
with system RAM regardless of the architecture. If the memory region is
nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
warn. But why is this specific only to arm (or arm64)?

Is the "shared-dma-pool" property only meant for Normal Non-cacheable
memory (hence the MEMREMAP_WC flag)? If a system is fully cache
coherent, does this check still make sense or the DT is not supposed to
have such nodes?

> This seems a little different from CMA which the memory is still
> underlying managed by the buddy system in order to support migration.
> 
> The patch here does not resolve a real issue but just open the sanity check for
> ARM64 case as well as ARM  which reports the issue a little bit earlier at
> rmem_dma_setup() time.

I think we first need to figure out what the real issue is and then try
to solve it.

-- 
Catalin
