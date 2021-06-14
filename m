Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90BF3A6A90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhFNPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:38:46 -0400
Received: from verein.lst.de ([213.95.11.211]:45022 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233644AbhFNPiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:38:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0F6C68AFE; Mon, 14 Jun 2021 17:36:03 +0200 (CEST)
Date:   Mon, 14 Jun 2021 17:36:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Will Deacon <will@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
Message-ID: <20210614153603.GA1998@lst.de>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com> <20210614083609.GA18701@willie-the-truck> <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com> <20210614145105.GC30667@arm.com> <6f897830-301f-3eb4-785f-de446476e676@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f897830-301f-3eb4-785f-de446476e676@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:34:05PM +0100, Robin Murphy wrote:
>> Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
>> ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
>> with system RAM regardless of the architecture. If the memory region is
>> nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
>> warn. But why is this specific only to arm (or arm64)?
>
> Didn't some ARMv7 implementations permit unexpected cache hits for the 
> non-cacheable address if the same PA has been speculatively fetched via the 
> cacheable alias?

If we care about that we need to change these platforms to change the
cache attributes of the kernel direct mapping instead of using vmap.
We already have code to do that for openrisc, someone just needs to
write the glue code for other platforms.
