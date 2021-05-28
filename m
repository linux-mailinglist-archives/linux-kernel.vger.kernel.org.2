Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5639488C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhE1WKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1WKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:10:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C09C061574;
        Fri, 28 May 2021 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=CVXb9dNJzyXGNbOvoP655f3ZuQpvhuD+/o7kMCRaLYs=; b=xpXUMxNuLROnBau154IT9ZtPAK
        6DGY/tLeoeX1IGzCmr77et49F232CEO2vg92guOf7IDpYK5QG4bjfx4tT8+zNg80EuKcsal+GFLtd
        vumMmjhPZhQjfVQrI1r1nY0Nn19ROAub+BxxZKDh2BvcAQECO+JcptAHF+JqBVuYKzSnSi+F7+k72
        uT45rd1OaON+4+vmwiDU/eS21Lq1pYQt/w7uwqj05B3hUbFLPm0yRkSrGRl4ChrNN5GPz1kw/0FRP
        G6JDA8+xNNhpuO34t4JqAU132yNhixQkEheBbqSi/iWkwFnBOVLuFtfYl3ADgs3VV2MWugSG7qco1
        xephVtXA==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmkf9-001P24-RG; Fri, 28 May 2021 22:09:03 +0000
Subject: Re: [PATCH] of: Drop reserved mem dependency on DMA_DECLARE_COHERENT
 and DMA_CMA
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210527223217.1572631-1-robh@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e477c3a3-5180-8a5c-7b1d-d429e45d7dc5@infradead.org>
Date:   Fri, 28 May 2021 15:09:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527223217.1572631-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 3:32 PM, Rob Herring wrote:
> Reserved memory regions can be used for more than just DMA regions, so
> only enabling on DMA_DECLARE_COHERENT (via HAS_DMA) or DMA_CMA is wrong.
> This effectively doesn't matter except for the few cases arches select
> NO_DMA.
> 
> At least, these users of RESERVEDMEM_OF_DECLARE depend on reserved memory
> support:
> 
> arch/riscv/mm/init.c:RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> drivers/memory/tegra/tegra210-emc-table.c:RESERVEDMEM_OF_DECLARE(tegra210_emc_table, "nvidia,tegra210-emc-table",
> drivers/soc/fsl/qbman/bman_ccsr.c:RESERVEDMEM_OF_DECLARE(bman_fbpr, "fsl,bman-fbpr", bman_fbpr);
> drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
> drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);
> 
> Let's simplify things and enable OF_RESERVED_MEM when OF_EARLY_FLATTREE is
> enabled.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Rob Herring <robh@kernel.org>

Hi Rob,

I'm OK with this patch, but with or without this patch,
compiling kernel/dma/coherent.c without HAS_IOMEM (!)
has build errors:

s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
coherent.c:(.text+0x5ae): undefined reference to `memremap'
s390-linux-ld: coherent.c:(.text+0x7a4): undefined reference to `memunmap'
s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
coherent.c:(.text+0xd84): undefined reference to `memunmap'


along with a slew of other build errors (arch/s390/, CONFIG_PCI is not set,
CONFIG_HAS_IOMEM is not set):

s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
irq-al-fic.c:(.init.text+0x6a0): undefined reference to `iounmap'
s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
xillybus_of.c:(.text+0x2c8): undefined reference to `devm_platform_ioremap_resource'
s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
cistpl.c:(.text+0x87a): undefined reference to `ioremap'
s390-linux-ld: cistpl.c:(.text+0x99a): undefined reference to `iounmap'
s390-linux-ld: cistpl.c:(.text+0xa34): undefined reference to `iounmap'
s390-linux-ld: cistpl.c:(.text+0xaa6): undefined reference to `ioremap'
s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
cistpl.c:(.text+0x2976): undefined reference to `iounmap'
s390-linux-ld: drivers/of/address.o: in function `of_iomap':
address.c:(.text+0x1f02): undefined reference to `ioremap'
s390-linux-ld: drivers/of/address.o: in function `of_io_request_and_map':
address.c:(.text+0x2030): undefined reference to `ioremap'

> ---
> This is needed to prevent build break on UML with this patch:
> 
> https://lore.kernel.org/lkml/20210527193841.1284169-1-robh@kernel.org/
> 
>  drivers/of/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 18450437d5d5..3dfeae8912df 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -75,9 +75,7 @@ config OF_NET
>  	def_bool y
>  
>  config OF_RESERVED_MEM
> -	bool
> -	depends on OF_EARLY_FLATTREE
> -	default y if DMA_DECLARE_COHERENT || DMA_CMA
> +	def_bool OF_EARLY_FLATTREE
>  
>  config OF_RESOLVE
>  	bool
> 


-- 
~Randy

