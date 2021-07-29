Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC03DA0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhG2KR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhG2KRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:17:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0687C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:17:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r17so10028661lfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXIpgpDKWbPbcNkG2dNNt5Cm/6h4seJQ12NmUxex3VI=;
        b=ixDe9DEzvJT3GNrG6sd8nZ0dMqhEBzRdvDa2qi1gcvZPMQuLiyUYGrBZkHMiYzDc4q
         MVK00Tch8pEyNp5CCkOL2juHmsHHMj/mGQ/r+yTIJy3ayEVmx9PrGDNjvybuMw6p0kAI
         KkALVoLLgisef8ftDy3kY+lF8dp4ec9xJs8ULTVhYu6kT93lxPnmH8kyRkqv0+b5CqxF
         Oll6V/zPYc2xFDbtBUsdC2cfW8Swe7F53sKGiESCTI+tgVnV3Ko3XTz6s6lbzEdCIfwN
         l3pxNMoUzl9ibAd9b7uxw5gc78FJK3uyfWVRMwaZS9VmWI8+x7cni/PHCcdvqmGE7B2M
         QpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXIpgpDKWbPbcNkG2dNNt5Cm/6h4seJQ12NmUxex3VI=;
        b=UHnkWnoUyO+5MPRMiUppjK/GXv71vmlN9XMODiIFrumPVHaRQTHDkOY1cNZt+LJAoL
         WrUNlMxh5yVG7X94EFJy8+yI5qO8NIHwKjpPrXO2Jzf5/e5wl6HGR9LSfuV9eeH17lFf
         6UP/JXf1Q8FCkdJlyy8QdIxZB9H7hZSgxy2nwoaQxbEF1QwZvevLgILTuQIC/aG8DROM
         5X+MRNcFUZqgXB3Q6NmytjnAVfsUJx90763LFRXnw9VSTOE6NRhD7hmA9QmLbC7vwj+E
         aZEXkaF3GNujTfxXQAZoaYX3daMhUi9o67mIvUJaH/09tFCmDU9EfegVvyPx2Scp/73z
         xVzQ==
X-Gm-Message-State: AOAM5319yp44BMNU6jGFpp1aLbX708tQ9pnOmpdfek4isa/9y/Xv/YQx
        e24xlfMavPmiDrGAkqX2F/bPjUwd72LUeemlEVE=
X-Google-Smtp-Source: ABdhPJxOC4twswUSAFRe3iPHlwAeCnVaeZ0RUAwFCHfdasp6unUrsj1RSp870lwZLb8qEPCJX8Vb9ioXQMptGuXCAgM=
X-Received: by 2002:a05:6512:321c:: with SMTP id d28mr3190353lfe.203.1627553840300;
 Thu, 29 Jul 2021 03:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <YPz+qQ6dbZVDbMwu@infradead.org> <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
 <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com> <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Thu, 29 Jul 2021 13:17:09 +0300
Message-ID: <CADu_u-OG0pMQN_nD5ayYOmNRWDn1VSPT05s5ddSQkoemYf_Sew@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Roman Skakun <roman_skakun@epam.com>,
        Roman Skakun <rm.skakun@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefano!

> I don't know on which platform Roman Skakun (CC'ed) found the problem.
> But if we look at arch/arm/mm/dma-mapping.c:__dma_alloc, one of the
> possible options is the "remap_allocator", which calls
> __alloc_remap_buffer, which calls dma_common_contiguous_remap, which
> calls vmap.

Using  Renesas R-car H3 platform.
I have tested this case on 1:1 dom0 with < 4GB memory, but this case
still exists.
I'm still wondering why xen-swiotlb mapped vmalloc'ed addresses for
low memory DMA addresses.

=D0=BF=D0=BD, 26 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 23:03, Stefano Sta=
bellini <sstabellini@kernel.org>:
>
> On Mon, 26 Jul 2021, Boris Ostrovsky wrote:
> > On 7/25/21 12:50 PM, Linus Torvalds wrote:
> > > On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org=
> wrote:
> > >
> > >>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
> > >>     (Roman Skakun)
> > > I've pulled this, but my reaction is that we've tried to avoid this i=
n
> > > the past. Why is Xen using vmalloc'ed addresses and passing those in
> > > to the dma mapping routines?
> > >
> > > It *smells* to me like a Xen-swiotlb bug, and it would have been
> > > better to try to fix it there. Was that just too painful?
> >
> >
> > Stefano will probably know better but this appears to have something to=
 do with how Pi (and possibly more ARM systems?) manage DMA memory: https:/=
/lore.kernel.org/xen-devel/CADz_WD5Ln7Pe1WAFp73d2Mz9wxspzTE3WgAJusp5S8LX4=
=3D83Bw@mail.gmail.com/.
>
> The original issue was found on the Raspberry Pi 4, and the fix was in
> swiotlb-xen.c, commit 8b1e868f6. More recently, Roman realized that
> dma_common_mmap might also end up calling virt_to_page on a vmalloc
> address. This is the fix for that.
>
>
> Why is Xen using vmalloc'ed addresses with dma routines at all?
>
> Xen is actually just calling the regular dma_direct_alloc to allocate
> pages (xen_swiotlb_alloc_coherent -> xen_alloc_coherent_pages ->
> dma_direct_alloc). dma_direct_alloc is the generic implementation. Back
> when the original issue was found, dma_direct_alloc returned a vmalloc
> address on RPi4.
>
> The original analysis was "xen_alloc_coherent_pages() eventually calls
> arch_dma_alloc() in remap.c which successfully allocates pages from
> atomic pool." See https://marc.info/?l=3Dxen-devel&m=3D158878173207775.
>
>
> I don't know on which platform Roman Skakun (CC'ed) found the problem.
> But if we look at arch/arm/mm/dma-mapping.c:__dma_alloc, one of the
> possible options is the "remap_allocator", which calls
> __alloc_remap_buffer, which calls dma_common_contiguous_remap, which
> calls vmap.
>
> So unfortunately it seems that on certain arch/platforms
> dma_alloc_coherent can return a vmap'ed address. So I would imagine this
> issue could also happen on native (without Xen), at least in theory.



--=20
Best Regards, Roman.
