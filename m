Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4C3C99A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhGOHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhGOHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:34:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DCAC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:31:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u14so7462717ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K8osTs2DVP81bWLnJgqBO39HigXBsHyE99jXtdAy7Ck=;
        b=e4thDoip3So+zUGXVuZ3czCNeKnmxTKncBRIpcHknmPV8HmNATF4XWuTZzz9r2P7qj
         2EPDtObBuadoHf5lkQYiQGTjXgj9eU5PKQIwtzUmjGsNEhw2crz3FNvxzGWM36a5WFKL
         r/DC7AAvzNPsFJyaLu+Y1J3d35p96DpuLmFcLkMH4GUBDFLRaddIs+BL6WO7wkFx9wyn
         WSGHhacaCcXD8DaGVpauURNumQe/WfKvCWr7+TwOCCgTSFBzYsKuUuvDVsL39YKcsU3R
         yQIeO3QmLwxQ80Hj3WLoCcuTwEdJT+DIg4fUwqORrKuhRyP5VXsInrcgJrBaCU5wffBl
         1NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K8osTs2DVP81bWLnJgqBO39HigXBsHyE99jXtdAy7Ck=;
        b=XRTeXGxXh/pUxZ89rMOc7gaciVfFRb0d1jVagPPEXcStb3MBs+a1xoudiY/BrKk7Q0
         x3BhLfdKx71issh1h8k30xALCTOB8D+0G9OjZBYHoJAD+DxBMPIxCnD0H+QCXllEniKO
         S5aNRK5EN4zVSOLNpxCIvaty1hMY8ZDb40n4T+H0TyjG+rBpMzBGhXeaLvAtHKhOb385
         ijBefAU2CTAKG+fjmdelKPSlDOD/I/F4JkAZbEqalXdLqtVi1gjt6Nsh7UI7K4ny1AhG
         xMQ0uiuHb0vXn3xgdZVOA4kQPdHnGkUAWx1JXedbIkJTWUuBaUiaY2cfURI5FpPrljAk
         muow==
X-Gm-Message-State: AOAM533BmHbooSHeULUF+z58OBjQ08JtBSn24WGr+NsT/DizRkBivinM
        ClrGixOZHxfkcsnyb4i9AbRTzJN3EX0Po5T74mI=
X-Google-Smtp-Source: ABdhPJzmxqtsUzwbzYkDtsTr2HSTMIkMdacfOEcefezuZ+ZE8STiIZEEO5Kf66+xThd7iXoX0lnDercSzytDWl7FGJY=
X-Received: by 2002:a05:651c:1587:: with SMTP id h7mr2639334ljq.285.1626334306805;
 Thu, 15 Jul 2021 00:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210616154436.GA7619@lst.de> <20210622133414.132754-1-rm.skakun@gmail.com>
 <alpine.DEB.2.21.2107131822040.23286@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107131822040.23286@sstabellini-ThinkPad-T480s>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Thu, 15 Jul 2021 10:31:36 +0300
Message-ID: <CADu_u-MxpRVm92yL_d0mWS06KBv_dv6jJ+OHt8KdjsSup_0j5g@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefano!

> We have the same thing in xen_swiotlb_free_coherent. Can we find a way
> to call cpu_addr_to_page() from xen_swiotlb_free_coherent?
> Maybe we can make cpu_addr_to_page non-static?

Yes, right, If we want to reuse this helper instead of the same code
block in xen_swiotlb_free_coherent() need to make cpu_addr_to_page() as
global and add a new declaration for this helper in include/linux/dma-map-o=
ps.h.
What do you think?

Cheers!

=D1=81=D1=80, 14 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 04:23, Stefano Sta=
bellini <sstabellini@kernel.org>:
>
> On Tue, 22 Jun 2021, Roman Skakun wrote:
> > This commit is dedicated to fix incorrect conversion from
> > cpu_addr to page address in cases when we get virtual
> > address which allocated in the vmalloc range.
> > As the result, virt_to_page() cannot convert this address
> > properly and return incorrect page address.
> >
> > Need to detect such cases and obtains the page address using
> > vmalloc_to_page() instead.
> >
> > Signed-off-by: Roman Skakun <roman_skakun@epam.com>
> > Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
> > ---
> > Hey!
> > Thanks for suggestions, Christoph!
> > I updated the patch according to your advice.
> > But, I'm so surprised because nobody catches this problem
> > in the common code before. It looks a bit strange as for me.
> >
> >
> >  kernel/dma/ops_helpers.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> > index 910ae69cae77..782728d8a393 100644
> > --- a/kernel/dma/ops_helpers.c
> > +++ b/kernel/dma/ops_helpers.c
> > @@ -5,6 +5,14 @@
> >   */
> >  #include <linux/dma-map-ops.h>
> >
> > +static struct page *cpu_addr_to_page(void *cpu_addr)
> > +{
> > +     if (is_vmalloc_addr(cpu_addr))
> > +             return vmalloc_to_page(cpu_addr);
> > +     else
> > +             return virt_to_page(cpu_addr);
> > +}
>
> We have the same thing in xen_swiotlb_free_coherent. Can we find a way
> to call cpu_addr_to_page() from xen_swiotlb_free_coherent? Maybe we can
> make cpu_addr_to_page non-static? No problem if it is too much trouble.
>
>
> >  /*
> >   * Create scatter-list for the already allocated DMA buffer.
> >   */
> > @@ -12,7 +20,7 @@ int dma_common_get_sgtable(struct device *dev, struct=
 sg_table *sgt,
> >                void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                unsigned long attrs)
> >  {
> > -     struct page *page =3D virt_to_page(cpu_addr);
> > +     struct page *page =3D cpu_addr_to_page(cpu_addr);
> >       int ret;
> >
> >       ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> > @@ -43,7 +51,7 @@ int dma_common_mmap(struct device *dev, struct vm_are=
a_struct *vma,
> >               return -ENXIO;
> >
> >       return remap_pfn_range(vma, vma->vm_start,
> > -                     page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgo=
ff,
> > +                     page_to_pfn(cpu_addr_to_page(cpu_addr)) + vma->vm=
_pgoff,
> >                       user_count << PAGE_SHIFT, vma->vm_page_prot);
> >  #else
> >       return -ENXIO;
> > --
> > 2.25.1
> >



--=20
Best Regards, Roman.
