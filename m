Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F63D718C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhG0Iws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:52:48 -0400
Received: from verein.lst.de ([213.95.11.211]:48928 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235885AbhG0Iwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:52:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A8A16736F; Tue, 27 Jul 2021 10:52:44 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:52:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Christoph Hellwig <hch@lst.de>, Atish Patra <atish.patra@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
Message-ID: <20210727085244.GA20609@lst.de>
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-4-atish.patra@wdc.com> <20210726070030.GB9035@lst.de> <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 03:47:54PM -0700, Atish Patra wrote:
> arch_dma_set_uncached works as well in this case. However, mips,
> niops2 & xtensa uses a
> fixed (via config) value for the offset. Similar approach can't be
> used here because the platform specific
> offset value has to be determined at runtime so that a single kernel
> image can boot on all platforms.

Nothing in the interface requires a fixed offset.  And using the offset
has one enormous advantage in that there is no need to declare a
statically sized pool - allocations are fully dynamic.  And any kind of
fixed pool tends to cause huge problems.

> 1. a new DT property so that arch specific code is aware of the
> non-cacheable window offset.

Yes.

> individual device if a per-device non-cacheable
>    window support is required in future. As of now, the beagleV memory

If you require a per-device noncachable area you can use the per-device
coherent pools.  But why would you want that?

> region lies in 0x10_0000_00000 - x17_FFFF_FFFF
>    which is mapped to start of DRAM 0x80000000. All of the
> non-coherent devices can do 32bit DMA only.

Adjust ZONE_DMA32 so that it takes the uncached offset into account.

> > > -     mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> > > +     if (phys_addr == device_addr)
> > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> > > +     else
> > > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
> >
> > Nak.  The phys_addr != device_addr support is goign away.  This needs
> 
> ok.
> 
> > to be filled in using dma-ranges property hanging of the struct device.
> 
> struct device is only accessible in rmem_dma_device_init. I couldn't
> find a proper way to access it during
> dma_reserved_default_memory setup under global pool.
> 
> Does that mean we should use a per-device memory pool instead of a
> global non-coherent pool ?

Indeed, that would be a problem in this case.  But if we can just
use the uncached offset directly I think everything will be much
simpler.
