Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A93D9D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhG2GT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhG2GT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:19:26 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521ADC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:19:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w17so8328184ybl.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2As2r29cAjix27xM0IHixqdDs9tV7d/JgCTxvY6wJ7E=;
        b=KQsHUXDo2JrnQKFkkEgufBVnAN8WtqG1UWGG9LepXJZoQvRxaunb1wCc2QVyHgzWId
         LbNxXs0YbMox683wCNfz4NqD+U9iy1W2EONV8vNczyxbM+UEoN5kPBxLTZHXJ6ydcUUc
         94ngrdaDgUTsq80cFrn3O2RbjR5KbLhruPTDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2As2r29cAjix27xM0IHixqdDs9tV7d/JgCTxvY6wJ7E=;
        b=jH+aerdtoJwmYDoqbDhVCU83eynZRqHNmNO4pMZAWrfjPOi/P7HeUudcvomJsp/7N+
         NsX7mr9MjLzagjI/RNli3OsBObVaHqMwcK0kANC540JR4epZDViBTUJDe5noJcUqtExK
         8DseZZ/mVdAxQb2Ao8t7e8CMIY9Ki/Dgs9NH2ODjMmSbGca8k84k8dDDn7wMJ4F8k93D
         GQhaXk3vOWUTRaA2ltNV42pnn23Lhhxqyr4LQ1L7QL5fjT9AJQFCFMLz6yV6NFvqlcOr
         ep2I8I5CyUamYHOKsV5tw7pnLcGu7R2VqHutUR312HoJ26tnF7lv4mAAdA1ySI7LDNdH
         o3gg==
X-Gm-Message-State: AOAM533UDnVJCxskh+QMKRag3djvi/aLfbt6klm3QsQGtlyCLCWKLCcy
        7Q+fK7FxMHasP8/cH6iXpGUbrgIipXJoZ6UZnr/Q
X-Google-Smtp-Source: ABdhPJyaa8M6KYiVtM5E2VQ1ZUNnTcXED7N3FCnJlH8PzWhOgx9TIYt8Sbb1Y0BHGiCXuutZCFC8st0SCIOslREgYlk=
X-Received: by 2002:a05:6902:1142:: with SMTP id p2mr4291303ybu.147.1627539563639;
 Wed, 28 Jul 2021 23:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
In-Reply-To: <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 28 Jul 2021 23:19:12 -0700
Message-ID: <CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com>
Subject: Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        devicetree <devicetree@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> > RISC-V privilege specification doesn't define an IOMMU or any method modify
> > PMA attributes or PTE entries to allow non-coherent mappings yet. In
> > the beginning, this approach was adopted assuming that most of the RISC-V
> > platforms would support full cache-coherent IO. Here is excerpt from the
> > priv spec section 3.6.5
> >
> > "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> > due to software complexity, performance, and energy impacts."
> >
> > While some of the RISC-V platforms adhere to the above suggestion, not all
> > platforms can afford to build to fully cache-coherent I/O devices. To
> > address DMA for non-coherent I/O devices, we need to mark a region of memory
> > as non-cacheable. Some of the platforms rely on a fixed region of uncached
> > memory that is remapped to the system memory while some other modify
> > the PTE entries to achieve that.
> >
> > The patch3 solves the issue for the fist use case by using a global
> > pool of memory that is reserved for DMA. The device access the reserved area
> > of the region while corresponding CPU address will be from uncached region
> > As the uncached region is remapped to the beginning of the system ram, both
> > CPU and device get the same view.
> >
> > To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> > cache operations. Any platform can use the generic ops to provide platform
> > specific cache management operations. Once the standard RISC-V CMO extension
> > is available, it will also use these generic ops.
> >
> > To address the second use case, Page Based Memory Attribute (PBMT) extension
> > is proposed. Once the extension is in good shape, we can leverage that
> > using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> > option. We will probably need another arch specific hooks to know if the
> > platform supports direct remap at runtime. For RISC-V, it will check the
> > presence of PBMT extension while other arch function will simply return true
>
> IIUC this is another extension that's not yet frozen or implemented in
> hardware?  Is this one compatible with what's in the c906, or is it
> doing things its own way?

Hi Palmer,
This series doesn't implement the PBMT extension which is still in discussion.
It simply reuse the existing non-coherent dma mapping support in
upstream kernel and enable
it for RISC-V. The current version uses a non-coherent global pool. I
will update it to use arch_set_uncached
as per Christoph's suggestion. It solves the non-coherent DMA problem
for beagleV and not c906.

I briefly mentioned the PBMT extension just to provide an idea how the
RISC-V Linux kernel
can support both unached window and PBMT extension. PBMT extension is
planned to be frozen
by the end of this year and none of the hardware has implemented it.

The implementation in c906 is a non-standard one and will not be
supported by the default PBMT
extension implementation.


>
> > if DIRECT_REMAP is enabled. This is required as arious different config
> > (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> > unified kernel image can boot on all RISC-V platforms.
> >
> > This patch series depends on Christoph's global pool support series[1].
> > Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> > at [2].
> > This series also solves the non-coherent DMA support on beagleV but requires
> > additional beagleV specific patches[3] which will be upstreamed soon.
> >
> >
> > [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> > [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> > [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
> >
> > Atish Patra (5):
> > RISC-V: Implement arch_sync_dma* functions
> > of: Move of_dma_get_range to of_address.h
> > dma-mapping: Enable global non-coherent pool support for RISC-V
> > dma-direct: Allocate dma pages directly if global pool allocation
> > fails
> > RISC-V: Support a new config option for non-coherent DMA
> >
> > arch/riscv/Kconfig                       |  8 +++
> > arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> > arch/riscv/mm/Makefile                   |  1 +
> > arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> > drivers/of/of_private.h                  | 10 ----
> > include/linux/of_address.h               | 12 +++++
> > kernel/dma/coherent.c                    | 49 +++++++++++++++---
> > kernel/dma/direct.c                      |  7 ++-
> > 8 files changed, 152 insertions(+), 20 deletions(-)
> > create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> > create mode 100644 arch/riscv/mm/dma-noncoherent.c
>
> Can you guys please make up your minds about how this is going to be
> supported at the ISA level?  I get a different answer every day here:
> sometimes it's that these systems are not compliant, sometimes that
> Linux is the compliance suite, sometimes that we're doing an ISA
> extension, and sometimes that we're doing the SBI stuff.
>

I am not sure whom you have talked to. I would be happy to set up a
meeting so that everybody is on
the same page if you are getting different answers every time.

> I don't really care all that much about what the decision is, but it's
> impossible to move forward without some semblance of a plan.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
