Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D290744534B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhKDMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhKDMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3FBD60EE9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636030056;
        bh=O89SG59ERFkapOwq86PzKcmSXMmROh38ILRsxSPw7zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FUvx4DVOJMgsgc8Dclim6uiPNanlCw5L3gLp5PVRYWaoNB9rczDaMyOu74b5oF1d4
         AHQF0P2QUe/aKt1at2I3AWfbFZ99fftU7/5wpYdVqsnnHuI/KpFI/ENXZez8TbJFb4
         5TS6iTqKetd4Skk5at9pKxYakuM5yK4ng3Jdk71JGqsTnKlLuGhsWwFWtNfIFAKjFQ
         cyJuzZCeLF6on0nF5PCFzmBT7h8dRN7nAbyXaHB8drhluEVwshEhKQjWhhuHXt15VG
         d3Qzpw5oaHVDaArQs6B3Z7jd2EO/RgHBiPRqHM1jWw/Z0bJql4Pe26pacZ0L+oNTgI
         3MfAezPvDs5Sg==
Received: by mail-ot1-f42.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so4893139otv.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 05:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM5315eAcQf593qWBAT3fl1daBLIeAt3yQTMuuroQEdcm2FDfenUNl
        teqZ7oCp72jRrcRUtmnzPOu5hn/UtUr4yaDR5E8=
X-Google-Smtp-Source: ABdhPJxhWjJHaSYxFkhh2iWefDx6Z+2GQYHsj7ZwDXxYFvelaU3rJtXffw/e5rsmEHaDNyuzdbd+XCXcawBw+m5Y8K0=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr39447582oth.30.1636030056196;
 Thu, 04 Nov 2021 05:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
 <20211104085336.GA24260@lst.de> <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
 <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
In-Reply-To: <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Nov 2021 13:47:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
Message-ID: <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
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

On Thu, 4 Nov 2021 at 13:31, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Thu, 2021-11-04 at 09:57 +0100, Ard Biesheuvel wrote:
> > On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > > > diff --git a/include/linux/set_memory.h
> > > > b/include/linux/set_memory.h
> > > > index f36be5166c19..6c7d1683339c 100644
> > > > --- a/include/linux/set_memory.h
> > > > +++ b/include/linux/set_memory.h
> > > > @@ -7,11 +7,16 @@
> > > >
> > > >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> > > >  #include <asm/set_memory.h>
> > > > +
> > > > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > >
> > > This is an arm64-specific symbol, and one that only controls a
> > > default.  I don't think it is suitable to key off stubs in common
> > > code.
> > >
> > > > +static inline int set_memory_valid(unsigned long addr, int
> > > > numpages, int enable) { return 0; }
> > >
> > > Pleae avoid overly long lines.
> > >
> > > > +             if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED))
> > > > {
> > > > +                     kaddr = (unsigned
> > > > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> > >
> > > This can just use page_address.
> > >
> > > > +                     /* page remove kernel mapping for arm64 */
> > > > +                     set_memory_valid(kaddr, size >> PAGE_SHIFT,
> > > > 0);
> > > > +             }
> > >
> > > But more importantly:  set_memory_valid only exists on arm64, this
> > > will break compile everywhere else.  And this API is complete crap.
> > > Passing kernel virtual addresses as unsigned long just sucks, and
> > > passing an integer argument for valid/non-valid also is a horrible
> > > API.
> > >
> >
> > ... and as I pointed out before, you can still pass rodata=off on
> > arm64, and get the old behavior, in which case bad things will happen
> > if you try to use an API that expects to operate on page mappings
> > with
> > a 1 GB block mapping.
> >
>
> Thanks for your suggestion.
>
>
> > And you still haven't explained what the actual problem is: is this
> > about CPU speculation corrupting non-cache coherent inbound DMA?
>
> No corrupiton, only cpu read it, we hope to fix the behavior.
>

Fix which behavior? Please explain

1) the current behavior
2) why the current behavior is problematic for you
3) how this patch changes the current behavior
4) why the new behavior fixes your problem.

There is no penalty for using too many words.
