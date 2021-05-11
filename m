Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135B37AC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEKQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhEKQs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:48:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7733C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:47:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c13so3067900pfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6jrKLJf+SUK032/zz9tWYcN5Rhay3mFZvhqIWgxNBs=;
        b=L/Y31OZjVAvXas4gAOFGDpY1O+WckxTleHtLR2a6rScOLannRZ4axVg75JGljNN3EA
         40xB287W01zuvyDHYZFS2WLSs1CG9A82KNV8OVT7o92X2FrRRw8J292qbL27/DexCkE7
         qg4XvM9gaQyzYYNGyObKTqbnr0WqygwnwiYxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6jrKLJf+SUK032/zz9tWYcN5Rhay3mFZvhqIWgxNBs=;
        b=L1AnKvFljIIfzeivpxzvDsfnNR7OWcX5caI7dkrhWSp7FKIwGWN6UAuw5VdPcqArP8
         15RuE6M1DoY4APOB7FGcF4ks5rHP5eWch1is8SYaFGmUSTGtAuB9J7jgURLCGzL5wjfp
         LcgOEkt8orkADNCtjeMadm6+vYZt69dO2Db3uOLxG7kjP1pNdsYCcBU6IEo0JAL2WHp8
         6usyfmlar2BygVoTBRHSEShPS9urF6tlavojjGv35Y1Io16u/Hn07tYMgR3tDuflRw0a
         DTRqgBwKpB8IJle+5bBWEOXzYmHPYjt5Be3a3X+hd3IPHkHZMrYPpygMClLiT0WKXV96
         s0lA==
X-Gm-Message-State: AOAM531mgqp8Sn/J5LOHL6gdhBOQNVku/Ry7RGRzDZ6L3PqJb8zB9SyH
        bbLVxDc4qR68LSbTP7QGIzpLX6sw8X134g==
X-Google-Smtp-Source: ABdhPJwHdo0uFhyKb2jVkqvLD7l9r+WPgQK/yGI0O5hiamu/xceDE2ZmJ/MgbDOwS3LOokots7r/JA==
X-Received: by 2002:a65:6103:: with SMTP id z3mr12990681pgu.61.1620751669170;
        Tue, 11 May 2021 09:47:49 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id ne20sm14541670pjb.52.2021.05.11.09.47.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 09:47:48 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id c13so3067866pfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:47:48 -0700 (PDT)
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr22174004iop.50.1620751352978;
 Tue, 11 May 2021 09:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095026.3477496-1-tientzu@chromium.org>
 <20210510095026.3477496-6-tientzu@chromium.org> <20210510150342.GD28066@lst.de>
In-Reply-To: <20210510150342.GD28066@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 12 May 2021 00:42:22 +0800
X-Gmail-Original-Message-ID: <CALiNf2_7mHuMG5DTQD0GsriN=vuX0ytyUn4rxEmsK2iP3PKV+w@mail.gmail.com>
Message-ID: <CALiNf2_7mHuMG5DTQD0GsriN=vuX0ytyUn4rxEmsK2iP3PKV+w@mail.gmail.com>
Subject: Re: [PATCH v6 05/15] swiotlb: Add a new get_io_tlb_mem getter
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
> > +static inline struct io_tlb_mem *get_io_tlb_mem(struct device *dev)
> > +{
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +     if (dev && dev->dma_io_tlb_mem)
> > +             return dev->dma_io_tlb_mem;
> > +#endif /* CONFIG_DMA_RESTRICTED_POOL */
> > +
> > +     return io_tlb_default_mem;
>
> Given that we're also looking into a not addressing restricted pool
> I'd rather always assign the active pool to dev->dma_io_tlb_mem and
> do away with this helper.

Where do you think is the proper place to do the assignment? First
time calling swiotlb_map? or in of_dma_configure_id?
