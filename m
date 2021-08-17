Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801273EE511
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHQD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhHQD31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:29:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E5C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:28:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m193so36867192ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tzdzktn6eJFw4s49wHe5WL1ljzPbWd0BSnO2ChJenyg=;
        b=iRigEkOU/lq2H7+3rXhuYnpJrvUTCZEtP+sT9oh7jzX60yWEA71GljsuFR2qdsTxk4
         1D4Xgi/8lzLK3hT/eODEXv/fg27FhlfLLMBQv4c+Le/u+cRKoE+XNCuUFzAPVOZ3Cu5A
         5mALnvxWLki1/8rU9dGV2+5xRSfzrb20HkgH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tzdzktn6eJFw4s49wHe5WL1ljzPbWd0BSnO2ChJenyg=;
        b=RvSEauHHul+rh8+9OuJHE4XuTjlJslAx1E1nMrBamaZ2bnCOylN/WDdWHVsTd/dHod
         vpGbc1sXuoOifRrzoty4ra/s0m855AnmuTQdWm0jgXYxVW0VwoOy75pFg8ua8iLbptyW
         YRdCWzbwAp/cAVcLfbVf9qf6CIlj5NmzJeoc9f9aADThXBWFWEBAAZo0hvIua6WSJxIU
         A+jEkero6tHx93bugjIKFWeSSPwA6/HqrQd1clgqBxZpEjtX0R3CoZK9XLLxBjek9gTY
         raXJikHPeNZbh/Y+DLFVUl+k9Rg+WN4SFpx9ynFbP+U2JViFo5xZWCFC6fFAyH7pOM+i
         CfsA==
X-Gm-Message-State: AOAM532lYfLOhoKux/aeWoU/RbCzyfFfsdq6KKXqv3Aq3b/XFry2enfB
        10DD1GaprGikY4/qRxQSJTd5n353LJlmHJhE6xfH
X-Google-Smtp-Source: ABdhPJxY/kyjIoitYQP7LbNOYUmWUtLe5137taPE2EVRs8WcUZFYmzjCLuRjV3W07whRbk3VUEXR56mjqhO8zaWABGs=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr1729383yba.442.1629170934402;
 Mon, 16 Aug 2021 20:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
 <CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com> <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSMtj05cduTZ6jEqDXtaG0QTY743MRQrv08B4cocZbXJQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 16 Aug 2021 20:28:43 -0700
Message-ID: <CAOnJCUKPitLD1g1LocTw8H+G7hg04-=Dd3biHGgDPMwer2cFpw@mail.gmail.com>
Subject: Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        iommu@lists.linux-foundation.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 6:37 PM Guo Ren <guoren@kernel.org> wrote:
>
> 1
>
> On Thu, Jul 29, 2021 at 2:19 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> > > > RISC-V privilege specification doesn't define an IOMMU or any method modify
> > > > PMA attributes or PTE entries to allow non-coherent mappings yet. In
> > > > the beginning, this approach was adopted assuming that most of the RISC-V
> > > > platforms would support full cache-coherent IO. Here is excerpt from the
> > > > priv spec section 3.6.5
> > > >
> > > > "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> > > > due to software complexity, performance, and energy impacts."
> > > >
> > > > While some of the RISC-V platforms adhere to the above suggestion, not all
> > > > platforms can afford to build to fully cache-coherent I/O devices. To
> > > > address DMA for non-coherent I/O devices, we need to mark a region of memory
> > > > as non-cacheable. Some of the platforms rely on a fixed region of uncached
> > > > memory that is remapped to the system memory while some other modify
> > > > the PTE entries to achieve that.
> > > >
> > > > The patch3 solves the issue for the fist use case by using a global
> > > > pool of memory that is reserved for DMA. The device access the reserved area
> > > > of the region while corresponding CPU address will be from uncached region
> > > > As the uncached region is remapped to the beginning of the system ram, both
> > > > CPU and device get the same view.
> > > >
> > > > To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> > > > cache operations. Any platform can use the generic ops to provide platform
> > > > specific cache management operations. Once the standard RISC-V CMO extension
> > > > is available, it will also use these generic ops.
> > > >
> > > > To address the second use case, Page Based Memory Attribute (PBMT) extension
> > > > is proposed. Once the extension is in good shape, we can leverage that
> > > > using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> > > > option. We will probably need another arch specific hooks to know if the
> > > > platform supports direct remap at runtime. For RISC-V, it will check the
> > > > presence of PBMT extension while other arch function will simply return true
> > >
> > > IIUC this is another extension that's not yet frozen or implemented in
> > > hardware?  Is this one compatible with what's in the c906, or is it
> > > doing things its own way?
> >
> > Hi Palmer,
> > This series doesn't implement the PBMT extension which is still in discussion.
> > It simply reuse the existing non-coherent dma mapping support in
> > upstream kernel and enable
> > it for RISC-V. The current version uses a non-coherent global pool. I
> > will update it to use arch_set_uncached
> > as per Christoph's suggestion. It solves the non-coherent DMA problem
> > for beagleV and not c906.
> >
> > I briefly mentioned the PBMT extension just to provide an idea how the
> > RISC-V Linux kernel
> > can support both unached window and PBMT extension. PBMT extension is
> > planned to be frozen
> > by the end of this year and none of the hardware has implemented it.
> >
> > The implementation in c906 is a non-standard one and will not be
> > supported by the default PBMT
> > extension implementation.
> The default PBMT & c908 PBMT are similar, only BIT definitions are
> different. I propose to support default PBMT first and give the back
> door to modify the PBMT definition during boot.
> The "protection_map[] = (__P000, __P001 ..__S000, __S001)" in
> mm/mmap.c has been modified by arch/mips, arm, sparc, x86, so I think
> it's proper solution direction.
>
> The reset problem is how to passing custom PBMT at the very early boot
> stage. Now I'm trying to use the DTS parsing instead of boot param hdr
> which Anup objected to.
>

IIRC, c906 has a compatible mode that has the compliant PTE bit modifications.
Can you use that mode in the Allwinner D1 board to boot Linux ? I am
not sure if you have any fallback method for non-coherent DMA
if custom DMA_COHERENT bits are not enabled through enhanced mode ?

> ref: https://lore.kernel.org/linux-riscv/1623693067-53886-1-git-send-email-guoren@kernel.org/
>
> Any comments are welcome.
>
> >
> >
> > >
> > > > if DIRECT_REMAP is enabled. This is required as arious different config
> > > > (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> > > > unified kernel image can boot on all RISC-V platforms.
> > > >
> > > > This patch series depends on Christoph's global pool support series[1].
> > > > Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> > > > at [2].
> > > > This series also solves the non-coherent DMA support on beagleV but requires
> > > > additional beagleV specific patches[3] which will be upstreamed soon.
> > > >
> > > >
> > > > [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> > > > [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> > > > [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
> > > >
> > > > Atish Patra (5):
> > > > RISC-V: Implement arch_sync_dma* functions
> > > > of: Move of_dma_get_range to of_address.h
> > > > dma-mapping: Enable global non-coherent pool support for RISC-V
> > > > dma-direct: Allocate dma pages directly if global pool allocation
> > > > fails
> > > > RISC-V: Support a new config option for non-coherent DMA
> > > >
> > > > arch/riscv/Kconfig                       |  8 +++
> > > > arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> > > > arch/riscv/mm/Makefile                   |  1 +
> > > > arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> > > > drivers/of/of_private.h                  | 10 ----
> > > > include/linux/of_address.h               | 12 +++++
> > > > kernel/dma/coherent.c                    | 49 +++++++++++++++---
> > > > kernel/dma/direct.c                      |  7 ++-
> > > > 8 files changed, 152 insertions(+), 20 deletions(-)
> > > > create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> > > > create mode 100644 arch/riscv/mm/dma-noncoherent.c
> > >
> > > Can you guys please make up your minds about how this is going to be
> > > supported at the ISA level?  I get a different answer every day here:
> > > sometimes it's that these systems are not compliant, sometimes that
> > > Linux is the compliance suite, sometimes that we're doing an ISA
> > > extension, and sometimes that we're doing the SBI stuff.
> > >
> >
> > I am not sure whom you have talked to. I would be happy to set up a
> > meeting so that everybody is on
> > the same page if you are getting different answers every time.
> >
> > > I don't really care all that much about what the decision is, but it's
> > > impossible to move forward without some semblance of a plan.
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish
