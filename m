Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE136B721
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhDZQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhDZQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:44:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:44:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 8so23380484qkv.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlgosoMJOAaR/ET01AhknsNf3mj6gtcliiDg0dLL1e0=;
        b=FfxC6YTfTyKRjULzScvZeh080rowzObsgfkNkB6PbFU85WK18TorFZb3nTplFpotQN
         FCzKzeHFiWHC6SAAz0H1ZvobWir4E6RenbNbEqtrFbyTUyimRczwWol0BDixJHUTha+x
         eXWW6lC9g26ZhTBX/V5pk140gf+3zGj/JaWxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlgosoMJOAaR/ET01AhknsNf3mj6gtcliiDg0dLL1e0=;
        b=toBtHq0iPz/ATchwd8M6aPNac/V5UTH9pGkHRjyqW4exylYVdsAuF8tbuLHyNtBZHL
         YW1d/7mKo9BFrEJ+q4CG6MV1vSj64Yxu56rp2svtU4Ar6+B3coPUeUL0smNLDbLmrpvL
         E4EV32vZ/STL/edhY8eTjToX0yRLrRZ9w2uNufn7arU7xe3tSLiQ3fYchq1WIBkIoMzV
         maI4s/xmCv+dwUFk4KWNAb4VoirdSSW+rNs//kJctODqNLvQO59yXlk5pQnnk75zXSLe
         Zv1KYs07zaBbfgtKQU3eRn0YrMZzEeMBS/EWdnQhr1HuHxUWsRb4CXyMCRlqTfIOWdqa
         UJ1w==
X-Gm-Message-State: AOAM532BXKLJQBP7b41n9i5n2Bi12xfvl0e7mYbIZeCmYx4+mnf7pjb+
        eXTYGkmi2Yd5zT2nDCpD4dTrVia0dUalUg==
X-Google-Smtp-Source: ABdhPJxWtowEfKf8HZ0+CPgajbB/hNDXcFrWAJLIbao2LFUBvFuWspeye+ZvNs7MIgup97zwXjJe7g==
X-Received: by 2002:a37:e06:: with SMTP id 6mr18708102qko.373.1619455440475;
        Mon, 26 Apr 2021 09:44:00 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 7sm6189626qtu.38.2021.04.26.09.44.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:44:00 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id z5so3916719qts.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:44:00 -0700 (PDT)
X-Received: by 2002:a05:6638:68b:: with SMTP id i11mr17242768jab.90.1619455099476;
 Mon, 26 Apr 2021 09:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-17-tientzu@chromium.org> <03c5bc8a-3965-bf1d-01a4-97d074dfbe2b@arm.com>
In-Reply-To: <03c5bc8a-3965-bf1d-01a4-97d074dfbe2b@arm.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 27 Apr 2021 00:38:08 +0800
X-Gmail-Original-Message-ID: <CALiNf28ExE8OLsuDaN9nC=eAi-iG0rct_TJCCxAcWW4+_pdj2g@mail.gmail.com>
Message-ID: <CALiNf28ExE8OLsuDaN9nC=eAi-iG0rct_TJCCxAcWW4+_pdj2g@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] of: Add plumbing for restricted DMA pool
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:35 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-04-22 09:15, Claire Chang wrote:
> > If a device is not behind an IOMMU, we look up the device node and set
> > up the restricted DMA when the restricted-dma-pool is presented.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   drivers/of/address.c    | 25 +++++++++++++++++++++++++
> >   drivers/of/device.c     |  3 +++
> >   drivers/of/of_private.h |  5 +++++
> >   3 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 54f221dde267..fff3adfe4986 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/logic_pio.h>
> >   #include <linux/module.h>
> >   #include <linux/of_address.h>
> > +#include <linux/of_reserved_mem.h>
> >   #include <linux/pci.h>
> >   #include <linux/pci_regs.h>
> >   #include <linux/sizes.h>
> > @@ -1109,6 +1110,30 @@ bool of_dma_is_coherent(struct device_node *np)
> >   }
> >   EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> >
> > +int of_dma_set_restricted_buffer(struct device *dev)
> > +{
> > +     struct device_node *node;
> > +     int count, i;
> > +
> > +     if (!dev->of_node)
> > +             return 0;
> > +
> > +     count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> > +                                             sizeof(phandle));
> > +     for (i = 0; i < count; i++) {
> > +             node = of_parse_phandle(dev->of_node, "memory-region", i);
> > +             /* There might be multiple memory regions, but only one
> > +              * restriced-dma-pool region is allowed.
> > +              */
>
> What's the use-case for having multiple regions if the restricted pool
> is by definition the only one accessible?

There might be a device coherent pool (shared-dma-pool) and
dma_alloc_attrs might allocate memory from that pool [1].
I'm not sure if it makes sense to have another device coherent pool
while using restricted DMA pool though.

[1] https://elixir.bootlin.com/linux/v5.12/source/kernel/dma/mapping.c#L435


>
> Robin.
>
> > +             if (of_device_is_compatible(node, "restricted-dma-pool") &&
> > +                 of_device_is_available(node))
> > +                     return of_reserved_mem_device_init_by_idx(
> > +                             dev, dev->of_node, i);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * of_mmio_is_nonposted - Check if device uses non-posted MMIO
> >    * @np:     device node
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index c5a9473a5fb1..d8d865223e51 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
> >
> >       arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> >
> > +     if (!iommu)
> > +             return of_dma_set_restricted_buffer(dev);
> > +
> >       return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> > index d717efbd637d..e9237f5eff48 100644
> > --- a/drivers/of/of_private.h
> > +++ b/drivers/of/of_private.h
> > @@ -163,12 +163,17 @@ struct bus_dma_region;
> >   #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
> >   int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map);
> > +int of_dma_set_restricted_buffer(struct device *dev);
> >   #else
> >   static inline int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map)
> >   {
> >       return -ENODEV;
> >   }
> > +static inline int of_dma_get_restricted_buffer(struct device *dev)
> > +{
> > +     return -ENODEV;
> > +}
> >   #endif
> >
> >   #endif /* _LINUX_OF_PRIVATE_H */
> >
