Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7463CC20D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhGQImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhGQIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:42:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A8C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 01:39:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e20so17428031ljn.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/Ph4KXH21cp1cKWqCha4JghboKhxeBssRdrgGEsZ/g=;
        b=NFuCS2VLQWPpHzhymx9nA39Hfr7bWiXg/IN9dUX+ZiJ4zU2AcVuWqCxkeX430TJ57H
         F1HczOYd4Fqt5nMNvkujGGhZ7a6Yt3BzgJ1mEsDSK4dbswVO6I6ycwiRkB8dzw3WSNJ8
         i1Lde1EJD5oy0SXRCDwtPzqmdw4wC5iqWY4e7hE0pfb0jE8P23WSfRDoh2xfVw+UBYfX
         Q8n8aqRkqMrt3KEqKQ7EqoWuf8IbB/rBR7xbRSZYEZ0sclhldvqqcSUFMybD15jsW8j/
         N5oJ4eBNBJV278RQOPlJ8/CGf/Slr+xDsFLGv1Dg9aP4tg4SZ3aWwWKnci15i8i7VM+u
         rb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/Ph4KXH21cp1cKWqCha4JghboKhxeBssRdrgGEsZ/g=;
        b=i0AMB4atyBYm2faK9CPmFMfZyq8kW7q4Jmzet82ojgkBI7voLxZH9CLPRurWyBvWuw
         HDFN21ue+gxpZ+kPieTLPvISQU5C1L5OyFLSh4iV2l5e9zWRX8A8RfJ7hMtTDHLlMON0
         zQQoMAn6Tk5/ybSjdgGubquMdIBprCMY7nIosigegB1Vq03JHh5v8Sf/rcMb5ZrVDUpJ
         Dunw/GOXBn5ncR1dYmHzaZG6Z+rkKK5fyd3Wp5SpUhj0VYN2g1cSdbbiwRBx3+qxhyCU
         R3atiENtj4fWQHGgiDEoryWWBXaxT95ETBpEnMamuvdXBvMAcAWFxOsgUPJebF/lO2BO
         hIgw==
X-Gm-Message-State: AOAM5312hz3hT0bHfqtC6Eybfr+mpCDlYQJtS1QlNUen5JBJ+JVcjdNR
        HGNksgjAAPyvFZe+dmcQkTqRkzqYr3i1I5w6Kc8=
X-Google-Smtp-Source: ABdhPJyeRjTAQ3mrnLTYgab+MKBgvatMXBQP3Edmgnib1kkC6/oA7N1ZXSWANCX4akcXxJ45BHA43lcfioCMHsjfSIU=
X-Received: by 2002:a2e:700f:: with SMTP id l15mr12600105ljc.149.1626511172469;
 Sat, 17 Jul 2021 01:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de> <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de> <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
 <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Sat, 17 Jul 2021 11:39:21 +0300
Message-ID: <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Roman Skakun <Roman_Skakun@epam.com>,
        Roman Skakun <rm.skakun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We can merge this patch and create a new one for
> xen_swiotlb_free_coherent() later.
> Yeah, no worries, I didn't know that exposing dma_common_vaddr_to_page
> was problematic.
>
> This patch is fine by me.

Good. I'm agreed too. Waiting for Christoph.

=D0=BF=D1=82, 16 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 18:29, Stefano Sta=
bellini <sstabellini@kernel.org>:
>
> On Fri, 16 Jul 2021, Roman Skakun wrote:
> > > Technically this looks good.  But given that exposing a helper
> > > that does either vmalloc_to_page or virt_to_page is one of the
> > > never ending MM discussions I don't want to get into that discussion
> > > and just keep it local in the DMA code.
> > >
> > > Are you fine with me applying this version?
> >
> > Looks good to me, thanks!
> > But, Stefano asked me about using created helper in the
> > xen_swiotlb_free_coherent()
> > and I created a patch according to this mention.
> >
> > We can merge this patch and create a new one for
> > xen_swiotlb_free_coherent() later.
>
> Yeah, no worries, I didn't know that exposing dma_common_vaddr_to_page
> was problematic.
>
> This patch is fine by me.
>
>
> > =D0=BF=D1=82, 16 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 12:35, Christo=
ph Hellwig <hch@lst.de>:
> > >
> > > Technically this looks good.  But given that exposing a helper
> > > that does either vmalloc_to_page or virt_to_page is one of the
> > > never ending MM discussions I don't want to get into that discussion
> > > and just keep it local in the DMA code.
> > >
> > > Are you fine with me applying this version?
> > >
> > > ---
> > > From 40ac971eab89330d6153e7721e88acd2d98833f9 Mon Sep 17 00:00:00 200=
1
> > > From: Roman Skakun <Roman_Skakun@epam.com>
> > > Date: Fri, 16 Jul 2021 11:39:34 +0300
> > > Subject: dma-mapping: handle vmalloc addresses in
> > >  dma_common_{mmap,get_sgtable}
> > >
> > > xen-swiotlb can use vmalloc backed addresses for dma coherent allocat=
ions
> > > and uses the common helpers.  Properly handle them to unbreak Xen on
> > > ARM platforms.
> > >
> > > Fixes: 1b65c4e5a9af ("swiotlb-xen: use xen_alloc/free_coherent_pages"=
)
> > > Signed-off-by: Roman Skakun <roman_skakun@epam.com>
> > > Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
> > > [hch: split the patch, renamed the helpers]
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  kernel/dma/ops_helpers.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> > > index 910ae69cae77..af4a6ef48ce0 100644
> > > --- a/kernel/dma/ops_helpers.c
> > > +++ b/kernel/dma/ops_helpers.c
> > > @@ -5,6 +5,13 @@
> > >   */
> > >  #include <linux/dma-map-ops.h>
> > >
> > > +static struct page *dma_common_vaddr_to_page(void *cpu_addr)
> > > +{
> > > +       if (is_vmalloc_addr(cpu_addr))
> > > +               return vmalloc_to_page(cpu_addr);
> > > +       return virt_to_page(cpu_addr);
> > > +}
> > > +
> > >  /*
> > >   * Create scatter-list for the already allocated DMA buffer.
> > >   */
> > > @@ -12,7 +19,7 @@ int dma_common_get_sgtable(struct device *dev, stru=
ct sg_table *sgt,
> > >                  void *cpu_addr, dma_addr_t dma_addr, size_t size,
> > >                  unsigned long attrs)
> > >  {
> > > -       struct page *page =3D virt_to_page(cpu_addr);
> > > +       struct page *page =3D dma_common_vaddr_to_page(cpu_addr);
> > >         int ret;
> > >
> > >         ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> > > @@ -32,6 +39,7 @@ int dma_common_mmap(struct device *dev, struct vm_a=
rea_struct *vma,
> > >         unsigned long user_count =3D vma_pages(vma);
> > >         unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> > >         unsigned long off =3D vma->vm_pgoff;
> > > +       struct page *page =3D dma_common_vaddr_to_page(cpu_addr);
> > >         int ret =3D -ENXIO;
> > >
> > >         vma->vm_page_prot =3D dma_pgprot(dev, vma->vm_page_prot, attr=
s);
> > > @@ -43,7 +51,7 @@ int dma_common_mmap(struct device *dev, struct vm_a=
rea_struct *vma,
> > >                 return -ENXIO;
> > >
> > >         return remap_pfn_range(vma, vma->vm_start,
> > > -                       page_to_pfn(virt_to_page(cpu_addr)) + vma->vm=
_pgoff,
> > > +                       page_to_pfn(page) + vma->vm_pgoff,
> > >                         user_count << PAGE_SHIFT, vma->vm_page_prot);
> > >  #else
> > >         return -ENXIO;
> > > --
> > > 2.30.2
> > >
> >
> >
> > --
> > Best Regards, Roman.
> >



--=20
Best Regards, Roman.
