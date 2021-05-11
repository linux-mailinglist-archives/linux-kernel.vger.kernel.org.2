Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1567637AC35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhEKQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEKQn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:43:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:42:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p11so18746854iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll12iwWOH+g7rF+Qcvmc/ZPVWK50RY5A+TnwOnViek8=;
        b=jF9yywweDau5byF0sr7SVkFA9hoYDaWzF8iy+wyA9wHf9oOaCvA+67rLL4jVjSY9gn
         QoY25mdgO7IV1eEXpAEk5s63+vTygeFS39HRXfLrmhNXD74fIDm9qeLodCWWHbiJG3ic
         G2KrYNbeLupAhGANRLweLDvdOuGV9VrSQUJi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll12iwWOH+g7rF+Qcvmc/ZPVWK50RY5A+TnwOnViek8=;
        b=Nf35qe17IqfwvjKnIB25tRQ7n7RflOs9kM8FrUaIVgwDlmB+mWLISsrBUe05NTlddl
         NsHf/Ug203zZPCY0P46vKsm3PFHXIKFlmMHySgWEgRMhYd0sa88S7Hygqc3VWLVKvbP/
         Nk8ZkTjjkFVGHeAHQkx8GYSx3Mpqu3g1q4O0ThbxdO9N+CAvdLcEtymKbBFzykzinxl+
         VE+Inf9/dYDcarFc3ffj6k8l/FQ54M6fwh/iz97d5h0O+ryW7pDeIazgXZJ0TUq+nFFo
         6lQuoJGjsin7BYssGAZst3FWCappvz294QK/tH/i+PwyROx4Jn3XgRIMGRE99ylgRK9o
         RGuQ==
X-Gm-Message-State: AOAM53077l7IphmUfLXbU2iBYNJ0sOkqLfynIPaS6N4Son/B9GrEsE6s
        7pWhYRIESEegFjcEoOhHjvLOHFOBvCWLkQ==
X-Google-Smtp-Source: ABdhPJzE4xtUFVos3HvbCeUx5Jdvthe7xKLaM3vlqJWRAyNe+geJPOCXmGJSwdBPYtbmZS3Uc5VudA==
X-Received: by 2002:a02:5b85:: with SMTP id g127mr27871218jab.80.1620751371653;
        Tue, 11 May 2021 09:42:51 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id q1sm9797678ilj.4.2021.05.11.09.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 09:42:51 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id o9so12583828ilh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:42:50 -0700 (PDT)
X-Received: by 2002:a05:6e02:e82:: with SMTP id t2mr17831684ilj.18.1620751359226;
 Tue, 11 May 2021 09:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095026.3477496-1-tientzu@chromium.org>
 <20210510095026.3477496-5-tientzu@chromium.org> <20210510150256.GC28066@lst.de>
In-Reply-To: <20210510150256.GC28066@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 12 May 2021 00:42:28 +0800
X-Gmail-Original-Message-ID: <CALiNf28jgAU7zN4pwgPKgaecM-KXRHHqwHj4sPXVf_3M0-goMQ@mail.gmail.com>
Message-ID: <CALiNf28jgAU7zN4pwgPKgaecM-KXRHHqwHj4sPXVf_3M0-goMQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] swiotlb: Add restricted DMA pool initialization
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
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

On Mon, May 10, 2021 at 11:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/slab.h>
> > +#endif
>
> I don't think any of this belongs into swiotlb.c.  Marking
> swiotlb_init_io_tlb_mem non-static and having all this code in a separate
> file is probably a better idea.

Will do in the next version.

>
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> > +                                 struct device *dev)
> > +{
> > +     struct io_tlb_mem *mem = rmem->priv;
> > +     unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
> > +
> > +     if (dev->dma_io_tlb_mem)
> > +             return 0;
> > +
> > +     /* Since multiple devices can share the same pool, the private data,
> > +      * io_tlb_mem struct, will be initialized by the first device attached
> > +      * to it.
> > +      */
>
> This is not the normal kernel comment style.

Will fix this in the next version.

>
> > +#ifdef CONFIG_ARM
> > +             if (!PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> > +                     kfree(mem);
> > +                     return -EINVAL;
> > +             }
> > +#endif /* CONFIG_ARM */
>
> And this is weird.  Why would ARM have such a restriction?  And if we have
> such rstrictions it absolutely belongs into an arch helper.

Now I think the CONFIG_ARM can just be removed?
The goal here is to make sure we're using linear map and can safely
use phys_to_dma/dma_to_phys.

>
> > +             swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
> > +
> > +             rmem->priv = mem;
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +             if (!debugfs_dir)
> > +                     debugfs_dir = debugfs_create_dir("swiotlb", NULL);
> > +
> > +             swiotlb_create_debugfs(mem, rmem->name, debugfs_dir);
>
> Doesn't the debugfs_create_dir belong into swiotlb_create_debugfs?  Also
> please use IS_ENABLEd or a stub to avoid ifdefs like this.

Will move it into swiotlb_create_debugfs and use IS_ENABLED in the next version.
