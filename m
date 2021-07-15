Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835F33C99BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhGOHmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:42:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B6C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:39:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b26so8255677lfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RbV1qy6tsLWfKrDuSsvc9bUACKfeR7Oc9sX7ozt1Vx0=;
        b=DLguvjWEMocTkdw1rblF0HMFSj1ky99nS7jKdXxcdsmfL5WNLppbK2a5L62XX7xpsU
         KEAP2P0+N6TYxa8X5G2v/a6subexhIk6QcKhffawY5rVpEeJ/JFyAFDDI/qo7pK6tVoV
         1pzXW3DX6bVdPzr6qJWa1AOHBSgfnGJKsis9mISoD7CMkttMkkBVJNdIYq+fn3JvACyK
         APZY+c579zDSUj7wTOA7ccCGu6iTZ6wi+hRorumUhXfY4IAMGie4l7IPFSyxOhyota72
         +RyQcWGfyszpsRdPe8UksD/iwFTivOa6I8587sKl68G8gmfoBlR3sQQ/bDG1DqBrps2N
         ZCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RbV1qy6tsLWfKrDuSsvc9bUACKfeR7Oc9sX7ozt1Vx0=;
        b=XzoobE21ch9JQBbaDsGRAz9xIbcYIitUlIS2Dk/4sjEp1eCRQXegnqNJYrDUokEJw2
         +oL/araBD4XjcVFv8KdPC1bUakwtLjkEwvPMdeX0q7S9qFpc6MmjCOPkH+XF1M53W3of
         Kl2PpcQiD6m5dK3kcLa7G3JQ/JKrM3pKGGcWdxCNeoBxHiNUuWR3w59TfuQ+qM9z9DCc
         dAMjMKl5FD0k/8leRSNtMfJLvaLiFgmR5+Y6+WFous7Hjx41s/BnJ6vXoumo0BRQnoxx
         eyKoMMdEgIpejs5BMK/TpekEC/nF6uPECPnFbF8Dw3Jwy5pEd3XwDjmQeuQzpdV6Ja5u
         GkHA==
X-Gm-Message-State: AOAM533MEGmdUTH1Zrc9HORuavfWFERgfN1hI77Lxa+Q3al/GrO9u5RS
        cFLrRCJnLZ10t8/EdMgZvDGeBLoaW4stuSYwgTY=
X-Google-Smtp-Source: ABdhPJzctcCKvkmJCdAvVZwAE6A94bEK5hPH90lNgU/YTADVTWx+ppiFHflOJl1Ygu8geOZO+p5upB7wdV/pJibMWgA=
X-Received: by 2002:a19:c1d5:: with SMTP id r204mr2381718lff.594.1626334788911;
 Thu, 15 Jul 2021 00:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210616154436.GA7619@lst.de> <20210622133414.132754-1-rm.skakun@gmail.com>
 <YO4si0to/XYximwM@fedora>
In-Reply-To: <YO4si0to/XYximwM@fedora>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Thu, 15 Jul 2021 10:39:38 +0300
Message-ID: <CADu_u-OMx6Pj4DQDoOsdh6aNAzYys-+R=o+OzHYtLm=nECgkyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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

> This looks like it wasn't picked up? Should it go in rc1?

Hi, Konrad!

This looks like an unambiguous bug, and should be in rc1.

Cheers!

=D1=81=D1=80, 14 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 03:15, Konrad Rzes=
zutek Wilk <konrad.wilk@oracle.com>:
>
> On Tue, Jun 22, 2021 at 04:34:14PM +0300, Roman Skakun wrote:
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
>
> This looks like it wasn't picked up? Should it go in rc1?
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
> > +
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
