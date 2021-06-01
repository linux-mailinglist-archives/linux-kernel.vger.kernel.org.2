Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5228C3976C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhFAPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhFAPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:36:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CB9F613AE;
        Tue,  1 Jun 2021 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622561682;
        bh=PjDaT7Lg11rLOIV5SBNPMB8T9/bYRvzPUa+R9IUPVco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qmo9y17C0edARAItgd5EUpS1j5pfmjl0Tlu+jJLC2H167WnkuOl/k9giu2uc8n1tY
         8zFr+riirYDKLvIuS2mxKvANmuCxEpyO1Ddi41rT0efPQgWroR+HwwgczdUFnYTbjS
         bXfV0wpr2Ntl971+02BLsCymUfH2spUHJPEoUartYa30elS4gt3D+SgGI+t/OUp3e5
         mzTz29wpj4lTR1JAmNM4xeGRY9nUQutaRWg5OqJkDdvC1xuktO4eAG/AjWuX6h6jnp
         Sc+CSD3SdXCLxJQsytOpqcr1JoB8e7G+8AXN5eNTugGFu95x6XCbVdjMxsfooHfldI
         du+ldsFqhIwIg==
Received: by mail-qk1-f169.google.com with SMTP id c124so9907848qkd.8;
        Tue, 01 Jun 2021 08:34:42 -0700 (PDT)
X-Gm-Message-State: AOAM532UsPNzieqKKvr3aV9mqO//bS6j9twcQKmgHNAzoHQeMVihW9q6
        /0XwAr1ZrnzaKHBbIedaCDY4yODxLqbV+UkYzQ==
X-Google-Smtp-Source: ABdhPJwHkdngmta7lGz7KigItmGOLHj9xTT2xxiK+diFNAzEccij8DF8KawDF2asaJYbOjS/NcHmGasu3trn3AzD2rU=
X-Received: by 2002:a05:620a:12a6:: with SMTP id x6mr22128113qki.364.1622561681384;
 Tue, 01 Jun 2021 08:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210527223217.1572631-1-robh@kernel.org> <e477c3a3-5180-8a5c-7b1d-d429e45d7dc5@infradead.org>
 <93bcda31-00ad-e97f-f700-b84977ede981@infradead.org>
In-Reply-To: <93bcda31-00ad-e97f-f700-b84977ede981@infradead.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Jun 2021 10:34:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKtNJdjWF6i05kXPzZn7NwOTGW-2jbhcPGQc_deJKuQ0A@mail.gmail.com>
Message-ID: <CAL_JsqKtNJdjWF6i05kXPzZn7NwOTGW-2jbhcPGQc_deJKuQ0A@mail.gmail.com>
Subject: Re: [PATCH] of: Drop reserved mem dependency on DMA_DECLARE_COHERENT
 and DMA_CMA
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 5:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/28/21 3:09 PM, Randy Dunlap wrote:
> > On 5/27/21 3:32 PM, Rob Herring wrote:
> >> Reserved memory regions can be used for more than just DMA regions, so
> >> only enabling on DMA_DECLARE_COHERENT (via HAS_DMA) or DMA_CMA is wrong.
> >> This effectively doesn't matter except for the few cases arches select
> >> NO_DMA.
> >>
> >> At least, these users of RESERVEDMEM_OF_DECLARE depend on reserved memory
> >> support:
> >>
> >> arch/riscv/mm/init.c:RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> >> drivers/memory/tegra/tegra210-emc-table.c:RESERVEDMEM_OF_DECLARE(tegra210_emc_table, "nvidia,tegra210-emc-table",
> >> drivers/soc/fsl/qbman/bman_ccsr.c:RESERVEDMEM_OF_DECLARE(bman_fbpr, "fsl,bman-fbpr", bman_fbpr);
> >> drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
> >> drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);
> >>
> >> Let's simplify things and enable OF_RESERVED_MEM when OF_EARLY_FLATTREE is
> >> enabled.
> >>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Hi Rob,
> >
> > I'm OK with this patch, but with or without this patch,
> > compiling kernel/dma/coherent.c without HAS_IOMEM (!)
> > has build errors:
> >
> > s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
> > coherent.c:(.text+0x5ae): undefined reference to `memremap'
> > s390-linux-ld: coherent.c:(.text+0x7a4): undefined reference to `memunmap'
> > s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
> > coherent.c:(.text+0xd84): undefined reference to `memunmap'
> >
> >
> > along with a slew of other build errors (arch/s390/, CONFIG_PCI is not set,
> > CONFIG_HAS_IOMEM is not set):
> >
> > s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
> > irq-al-fic.c:(.init.text+0x6a0): undefined reference to `iounmap'
> > s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
> > xillybus_of.c:(.text+0x2c8): undefined reference to `devm_platform_ioremap_resource'
> > s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> > cistpl.c:(.text+0x87a): undefined reference to `ioremap'
> > s390-linux-ld: cistpl.c:(.text+0x99a): undefined reference to `iounmap'
> > s390-linux-ld: cistpl.c:(.text+0xa34): undefined reference to `iounmap'
> > s390-linux-ld: cistpl.c:(.text+0xaa6): undefined reference to `ioremap'
> > s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> > cistpl.c:(.text+0x2976): undefined reference to `iounmap'
> > s390-linux-ld: drivers/of/address.o: in function `of_iomap':
> > address.c:(.text+0x1f02): undefined reference to `ioremap'
> > s390-linux-ld: drivers/of/address.o: in function `of_io_request_and_map':
> > address.c:(.text+0x2030): undefined reference to `ioremap'
> >
>
> Oops, sorry. I should have said that this is also with my
> experimental path that I thought you suggested earlier this
> week (although I could have misunderstood you):

Yes, that's what I'd like, but no doubt that change alone will make
things worse.

> --- linux-next-20210526.orig/drivers/of/Kconfig
> +++ linux-next-20210526/drivers/of/Kconfig
> @@ -64,7 +64,7 @@ config OF_DYNAMIC
>
>  config OF_ADDRESS
>         def_bool y
> -       depends on !SPARC && (HAS_IOMEM || UML)
> +       depends on !SPARC
>
>  config OF_IRQ
>         def_bool y
>
> [rebuild]
>
> OK, even without this small patch, the result is about the same (just
> a few different function names):
>
> s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
> coherent.c:(.text+0x5ae): undefined reference to `memremap'
> s390-linux-ld: coherent.c:(.text+0x7a4): undefined reference to `memunmap'
> s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
> coherent.c:(.text+0xd84): undefined reference to `memunmap'
>
> s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
> irq-al-fic.c:(.init.text+0x64): undefined reference to `of_iomap'
> s390-linux-ld: irq-al-fic.c:(.init.text+0x6a0): undefined reference to `iounmap'
> s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
> xillybus_of.c:(.text+0x2c8): undefined reference to `devm_platform_ioremap_resource'
> s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> cistpl.c:(.text+0x87a): undefined reference to `ioremap'
> s390-linux-ld: cistpl.c:(.text+0x99a): undefined reference to `iounmap'
> s390-linux-ld: cistpl.c:(.text+0xa34): undefined reference to `iounmap'
> s390-linux-ld: cistpl.c:(.text+0xaa6): undefined reference to `ioremap'
> s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> cistpl.c:(.text+0x2976): undefined reference to `iounmap'

Empty stubs for ioremap, iounmap, memremap, and memunmap would fix all
these, right? Though maybe adding stubs is more complicated than I'm
thinking given all the architecture specifics.

Rob
