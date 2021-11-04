Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2900445732
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKDQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhKDQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:25:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3BAF61244
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636042959;
        bh=P3rnnoNdYJk+6i+LZOXAgcPbirulOacewaSkMDXsPs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tpsZ8hOvhbnElC8qkOuCbY6ub2S+0VZPb5Z9ZLo6MhNuTAypmrJ2wGteYG8Vvb2ya
         GOUBrhoF08ZLaB+mD9/2DFF9t8kyc9vgFCtWXSZoOX1XPXykxc0kXJPP7cemZpwpsd
         WDraozpTmJ2+2mbUE+WENVKQ+4Cz9BtNrpBUFq8dYUgEnKM/BAE7yesEIvjf/QnLjB
         6VDwYBBwNwPHq7ReGZKl6goBT9l/7u7Ixk7/b4m0+0wg6yeWJ0ySixhuI9QsuzIfwy
         vTXNwwfVJEl1VyuG0x+XTp0IRV5SfA8QkRoa2iHDbb8KZ0t8fTmKVjHcp0u19xdpyE
         vswS0lx3zynpw==
Received: by mail-oi1-f173.google.com with SMTP id l15so10062113oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:22:39 -0700 (PDT)
X-Gm-Message-State: AOAM533MKIufWN5UuYco3plz7E+UTky+8G/G0WzP5SczgBgNr/5sEBNU
        I1mQ+fHZaLiHlEMAxp3nXqW4pOHha/3I9MjTNcs=
X-Google-Smtp-Source: ABdhPJxsY85yy3v6ZutAz3NirxoHWcEYpbh3E2JXSFxjxTMgcKXQkwTDTl2c3zzTDK6ObyR4H61EG3aXz2evOvt6DgQ=
X-Received: by 2002:a05:6808:b2b:: with SMTP id t11mr12272034oij.47.1636042958945;
 Thu, 04 Nov 2021 09:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
 <20211104085336.GA24260@lst.de> <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
 <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
 <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com> <9da413e95727a3b48ea35ec576aa1b1b57ffc9b9.camel@mediatek.com>
In-Reply-To: <9da413e95727a3b48ea35ec576aa1b1b57ffc9b9.camel@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Nov 2021 17:22:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtdS5-b_XyDyP_V9jkYDfRZdUpHXZgvWfXE=1rJK019A@mail.gmail.com>
Message-ID: <CAMj1kXFtdS5-b_XyDyP_V9jkYDfRZdUpHXZgvWfXE=1rJK019A@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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

On Thu, 4 Nov 2021 at 14:40, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Thu, 2021-11-04 at 13:47 +0100, Ard Biesheuvel wrote:
> > On Thu, 4 Nov 2021 at 13:31, Walter Wu <walter-zh.wu@mediatek.com>
> > wrote:
> > >
> > > On Thu, 2021-11-04 at 09:57 +0100, Ard Biesheuvel wrote:
> > > > On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de>
> > > > wrote:
> > > > >
> > > > > On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > > > > > diff --git a/include/linux/set_memory.h
> > > > > > b/include/linux/set_memory.h
> > > > > > index f36be5166c19..6c7d1683339c 100644
> > > > > > --- a/include/linux/set_memory.h
> > > > > > +++ b/include/linux/set_memory.h
> > > > > > @@ -7,11 +7,16 @@
> > > > > >
> > > > > >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> > > > > >  #include <asm/set_memory.h>
> > > > > > +
> > > > > > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > > > >
> > > > > This is an arm64-specific symbol, and one that only controls a
> > > > > default.  I don't think it is suitable to key off stubs in
> > > > > common
> > > > > code.
> > > > >
> > > > > > +static inline int set_memory_valid(unsigned long addr, int
> > > > > > numpages, int enable) { return 0; }
> > > > >
> > > > > Pleae avoid overly long lines.
> > > > >
> > > > > > +             if
> > > > > > (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED))
> > > > > > {
> > > > > > +                     kaddr = (unsigned
> > > > > > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> > > > >
> > > > > This can just use page_address.
> > > > >
> > > > > > +                     /* page remove kernel mapping for arm64
> > > > > > */
> > > > > > +                     set_memory_valid(kaddr, size >>
> > > > > > PAGE_SHIFT,
> > > > > > 0);
> > > > > > +             }
> > > > >
> > > > > But more importantly:  set_memory_valid only exists on arm64,
> > > > > this
> > > > > will break compile everywhere else.  And this API is complete
> > > > > crap.
> > > > > Passing kernel virtual addresses as unsigned long just sucks,
> > > > > and
> > > > > passing an integer argument for valid/non-valid also is a
> > > > > horrible
> > > > > API.
> > > > >
> > > >
> > > > ... and as I pointed out before, you can still pass rodata=off on
> > > > arm64, and get the old behavior, in which case bad things will
> > > > happen
> > > > if you try to use an API that expects to operate on page mappings
> > > > with
> > > > a 1 GB block mapping.
> > > >
> > >
> > > Thanks for your suggestion.
> > >
> > >
> > > > And you still haven't explained what the actual problem is: is
> > > > this
> > > > about CPU speculation corrupting non-cache coherent inbound DMA?
> > >
> > > No corrupiton, only cpu read it, we hope to fix the behavior.
> > >
> >
> > Fix which behavior? Please explain
> >
> > 1) the current behavior
> We call dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING to get the
> allocated buffer and the kernel mapping is exist. Our goal is this
> buffer doesn't allow to be accessed by cpu. Unfortunately, we see cpu
> speculation to read it. So we need to fix it and don't use no-map the
> way.
>
> > 2) why the current behavior is problematic for you
> dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING have kernel mapping,
> so it still has cpu speculation read the buffer. Although we have
> hardware to protect the buffer, we still hope use software to fix it.
>

But *why* is this a problem? You are saying that the speculative
accesses are not causing corruption, so they are causing other issues
that you want to address. So which issues are we talking about here?


> > 3) how this patch changes the current behavior
> When call dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING, then
> remove the kernel mapping which belong to the buffer.
>
> > 4) why the new behavior fixes your problem.
> If I understand correctly, want to block cpu speculation, then need
> unmap the buffer at stage 1 and stage 2 page table and tlb invalidate.
> This patch is to do stage 1 unmap at EL1.
>
> >
> > There is no penalty for using too many words.
>
> Thanks.
> Walter
>
