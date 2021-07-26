Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E23D5378
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhGZGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:20:08 -0400
Received: from verein.lst.de ([213.95.11.211]:43938 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbhGZGUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:20:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA9D068B05; Mon, 26 Jul 2021 09:00:30 +0200 (CEST)
Date:   Mon, 26 Jul 2021 09:00:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
Message-ID: <20210726070030.GB9035@lst.de>
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723214031.3251801-4-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:40:29PM -0700, Atish Patra wrote:
> Currently, linux,dma-default is used to reserve a global non-coherent pool
> to allocate memory for dma operations. This can be useful for RISC-V as
> well as the ISA specification doesn't specify a method to modify PMA
> attributes or page table entries to define non-cacheable area yet.
> A non-cacheable memory window is an alternate options for vendors to
> support non-coherent devices.

Please explain why you do not want to use the simply non-cachable
window support using arch_dma_set_uncached as used by mips, niops2 and
xtensa.

> +static int __dma_init_global_coherent(phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)




>  {
>  	struct dma_coherent_mem *mem;
>  
> -	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> +	if (phys_addr == device_addr)
> +		mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> +	else
> +		mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);

Nak.  The phys_addr != device_addr support is goign away.  This needs
to be filled in using dma-ranges property hanging of the struct device.
