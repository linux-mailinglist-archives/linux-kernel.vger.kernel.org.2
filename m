Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D753D69C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhGZWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhGZWHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:07:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660FC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:48:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v46so17520843ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvsqUUy/O01l4CBRzfrPE1Jc7wO/JNGVxsEuCcHSCWw=;
        b=Oj1mDz93drUb82Y4dwGcG6EgM1Z32HcAKJ4YfgJCNUqNIvF/kV3bQ3NHUCklnTy4SW
         1GD2cx3JJGrezXOK+L9wjvpJ96IV67qydn4ANvKcp7SDWJs80YFbIdORNMRlexi21vaX
         bIzr8ywtm1/QqdYt2jpgnb8HNzTEWOFg+DmXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvsqUUy/O01l4CBRzfrPE1Jc7wO/JNGVxsEuCcHSCWw=;
        b=UOb9SmrPzYhtm9TupFiEOKxapxCxzp8oVCLIlx0vmW6jFPW6Anenan1MBShJFjQ32h
         LPnjJWyAjdGKsPXXOjfmGCaQVu1Gr6Sh1gLEPYkEZ3gDmq2TnkQo5nsmETc2bFhdR+0q
         D2R/gJKKFUbXkBo4mbaic8JS7Sm+3IiDOXOG0lF7LfYy+E+ZPdDgGu5rOIn9TtSL4Pk0
         keHPzOIQHBjdSPcLtCahYreFd+b7jnEyt2rWTMmqkEwLGaJ4Ni7tdqjHkp9erBC1tBcL
         XRyGWX58xHV7IGqJLYNODW/iTYK5h3BtIBEZG5dCi3GgKFvfr/WIs6uDeDuU/AG+RSbO
         /c9A==
X-Gm-Message-State: AOAM530b/VfgO0Vy4tymJE07SvKVPydwlNeTJxhyq8fcLZi3W1WfLI1g
        0K1UiMXFyDoXpD9cN6VvokWC2B12831/lGjS6/tQ
X-Google-Smtp-Source: ABdhPJz2EUkj2zAeJLmOGn6kDSu8McU02FKdlq3ZbpM5EcX89ffvE35I5g7gwLzw3lEJ0O8h/gzUiEZysEgj2Z7EPDA=
X-Received: by 2002:a25:3289:: with SMTP id y131mr5835871yby.317.1627339684970;
 Mon, 26 Jul 2021 15:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-4-atish.patra@wdc.com>
 <20210726070030.GB9035@lst.de>
In-Reply-To: <20210726070030.GB9035@lst.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 26 Jul 2021 15:47:54 -0700
Message-ID: <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
To:     Christoph Hellwig <hch@lst.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 23, 2021 at 02:40:29PM -0700, Atish Patra wrote:
> > Currently, linux,dma-default is used to reserve a global non-coherent pool
> > to allocate memory for dma operations. This can be useful for RISC-V as
> > well as the ISA specification doesn't specify a method to modify PMA
> > attributes or page table entries to define non-cacheable area yet.
> > A non-cacheable memory window is an alternate options for vendors to
> > support non-coherent devices.
>
> Please explain why you do not want to use the simply non-cachable
> window support using arch_dma_set_uncached as used by mips, niops2 and
> xtensa.
>

arch_dma_set_uncached works as well in this case. However, mips,
niops2 & xtensa uses a
fixed (via config) value for the offset. Similar approach can't be
used here because the platform specific
offset value has to be determined at runtime so that a single kernel
image can boot on all platforms.
That's why we need the following additional changes for RISC-V to make it work.

1. a new DT property so that arch specific code is aware of the
non-cacheable window offset.
    - either under /chosen node or a completely separate node with
multiple non-cacheable window support
   We also need to define how it is going to referenced from
individual device if a per-device non-cacheable
   window support is required in future. As of now, the beagleV memory
region lies in 0x10_0000_00000 - x17_FFFF_FFFF
   which is mapped to start of DRAM 0x80000000. All of the
non-coherent devices can do 32bit DMA only.

2. Use the dma-ranges and modify the arch_dma_set_uncached function to
pass the struct device as an argument.

Either way, we will need arch specific hook ups and additional changes
while the global non-coherent pool
provides a more elegant solution without any additional arch specific code.

If arch_dma_set_uncached is still preferred way to solve this problem,
I can revise the patch with either approach 1 or approach 2

> > +static int __dma_init_global_coherent(phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
>
>
>
>
> >  {
> >       struct dma_coherent_mem *mem;
> >
> > -     mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> > +     if (phys_addr == device_addr)
> > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> > +     else
> > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
>
> Nak.  The phys_addr != device_addr support is goign away.  This needs

ok.

> to be filled in using dma-ranges property hanging of the struct device.

struct device is only accessible in rmem_dma_device_init. I couldn't
find a proper way to access it during
dma_reserved_default_memory setup under global pool.

Does that mean we should use a per-device memory pool instead of a
global non-coherent pool ?

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Regards,
Atish
