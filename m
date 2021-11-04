Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1634450B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhKDI7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:59:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F65061168
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636016235;
        bh=9GnYflMSk1zGFDWqohvW6i+zYCvs8Ks+GwVIYMqi16Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TBjb9Yu61yn/io080EO5vexYHENH6T7Lc7zLulpV4rVCAMEzD+5IYIl9FCopcoxGX
         hLn1N6Kl9HU56L3Kt5pg8tWCJyZLVItmlLVmFQVeKtAsPg4qTTpJzGki/i7C/CB/JX
         l4F5cpuY8O4obR0uYFU7oKhS4gB2gTOzbUBRI/KYHRdABd9wWNZKqHl0l+k6zHnv9J
         EqYXt6LB0IVoLQuFoepOMNsuCafp6++z218lKGjaczRzHb8M23EA6+XeGwbtF4L70b
         K4BULyibwTZfQh8ApaDsqsULqUzVX9FwzPNN1jsUPHDlLIj89R9Vw7CbywbjAmW4PJ
         xGG7TO/NgsioQ==
Received: by mail-oo1-f41.google.com with SMTP id j6-20020a4aab46000000b002bb88bfb594so1709630oon.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:57:15 -0700 (PDT)
X-Gm-Message-State: AOAM530tfZC+paMpCv/9dMzimknQVxTm3SuSShP6mKC4Ei4TIoCCnJOA
        JoHEpGqMCgwN9lYnF9L0UWgCN1Ti1pcatjUSBHE=
X-Google-Smtp-Source: ABdhPJydgSUDDybkK0rHy627UMULvyYtlQWf9i2EfDmp2/C1uqN/3mY4roW+glGzK3Rt8ZzaI1IEXHbY8JpIAFCo8f4=
X-Received: by 2002:a4a:e1a3:: with SMTP id 3mr2689882ooy.32.1636016234879;
 Thu, 04 Nov 2021 01:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com> <20211104085336.GA24260@lst.de>
In-Reply-To: <20211104085336.GA24260@lst.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Nov 2021 09:57:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
Message-ID: <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
To:     Christoph Hellwig <hch@lst.de>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> > index f36be5166c19..6c7d1683339c 100644
> > --- a/include/linux/set_memory.h
> > +++ b/include/linux/set_memory.h
> > @@ -7,11 +7,16 @@
> >
> >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> >  #include <asm/set_memory.h>
> > +
> > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
>
> This is an arm64-specific symbol, and one that only controls a
> default.  I don't think it is suitable to key off stubs in common
> code.
>
> > +static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }
>
> Pleae avoid overly long lines.
>
> > +             if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> > +                     kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle));
>
> This can just use page_address.
>
> > +                     /* page remove kernel mapping for arm64 */
> > +                     set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> > +             }
>
> But more importantly:  set_memory_valid only exists on arm64, this
> will break compile everywhere else.  And this API is complete crap.
> Passing kernel virtual addresses as unsigned long just sucks, and
> passing an integer argument for valid/non-valid also is a horrible
> API.
>

... and as I pointed out before, you can still pass rodata=off on
arm64, and get the old behavior, in which case bad things will happen
if you try to use an API that expects to operate on page mappings with
a 1 GB block mapping.

And you still haven't explained what the actual problem is: is this
about CPU speculation corrupting non-cache coherent inbound DMA?
