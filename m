Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F03CB78A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbhGPM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbhGPM4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:56:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:53:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x19so5138281ljc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qIXbeXJh4xnnEzuHiviZSGnyTwYzRolVv7/vAGelNEs=;
        b=q2rZp/6nSgaheqyIunCgxYXSuuGtsUM9Kxe6YSWEUSVa8m4HR9M550GEna0DbKCld4
         NFPhETlg88j3zKUvUNJDQOTs9OOrvzJ0Yw31Ft7lIDvZh46LIN8B/QDdymrB+R9kngdn
         iSMvIHQIPlRnh7vjcM0rRipTcoWTZJwTCricYH6j1WyYW9QfHw6qR35NAiyKmfiJbU4p
         B+YdqUrrl5oWJQr//Rlq8MFhObpPHhitazQ7PMXwAAYBHlTNyhcDe0mdAwmfbrYyviTv
         +msCwjHytPxKeR4FGfbgaX4epcky1MgE3ET35AyE9x2OEs1ysmWcNyKsAKwWIHDeX0Sl
         9qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qIXbeXJh4xnnEzuHiviZSGnyTwYzRolVv7/vAGelNEs=;
        b=Kl4BdJM0aSbc28G3uMofElhHsNE1msDnj7A+ACcFWf7D/7+P6BAUZJ1FL83ossFoda
         McIVu+913AkFh5NN/6HFfxmnxYohjIE1mzAI2CRx90fi09q7UZBSqX7ounWZqTI4/oS/
         AluPfvkuqdtRk7Duh/3UcAneRlnowEKYPLl50D3Jj3Rxcp2jqryubqx4KCtn7GlYZfaN
         XCyw8ItTkuOQcAmUo7BD45EpmLSiV3/ufDpUqN6Zq/88ZSlNgm+znqtVB/0mhwl7f8N/
         TszItU+YaQLJ9yi4OmaMqyPMy5ahTT+L9HUQefLoYJaFTnzQpAF23y12lUnYbAjN1J+R
         P5zw==
X-Gm-Message-State: AOAM530rTRr5qzESnKISf3AQnLMO7P29EeWxiAleaYD/QW2PCGcLF+l3
        05S354a8BXNd0XypJ53r9aA/zeFWvciYMppP04wJ+0mpDcX22dNRkMA2ZA==
X-Google-Smtp-Source: ABdhPJz6XvfF9zHYInIIdr4DqTpU+AALXgxYTbgQHJoS1YdKtGx6AiJE1OQvdOZmYfk51pX27uPsiE/B8leffF7w82w=
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr9033565ljp.66.1626440032739;
 Fri, 16 Jul 2021 05:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de> <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de>
In-Reply-To: <20210716093551.GA17981@lst.de>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Fri, 16 Jul 2021 15:53:41 +0300
Message-ID: <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
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

> Technically this looks good.  But given that exposing a helper
> that does either vmalloc_to_page or virt_to_page is one of the
> never ending MM discussions I don't want to get into that discussion
> and just keep it local in the DMA code.
>
> Are you fine with me applying this version?

Looks good to me, thanks!
But, Stefano asked me about using created helper in the
xen_swiotlb_free_coherent()
and I created a patch according to this mention.

We can merge this patch and create a new one for
xen_swiotlb_free_coherent() later.

=D0=BF=D1=82, 16 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 12:35, Christoph H=
ellwig <hch@lst.de>:
>
> Technically this looks good.  But given that exposing a helper
> that does either vmalloc_to_page or virt_to_page is one of the
> never ending MM discussions I don't want to get into that discussion
> and just keep it local in the DMA code.
>
> Are you fine with me applying this version?
>
> ---
> From 40ac971eab89330d6153e7721e88acd2d98833f9 Mon Sep 17 00:00:00 2001
> From: Roman Skakun <Roman_Skakun@epam.com>
> Date: Fri, 16 Jul 2021 11:39:34 +0300
> Subject: dma-mapping: handle vmalloc addresses in
>  dma_common_{mmap,get_sgtable}
>
> xen-swiotlb can use vmalloc backed addresses for dma coherent allocations
> and uses the common helpers.  Properly handle them to unbreak Xen on
> ARM platforms.
>
> Fixes: 1b65c4e5a9af ("swiotlb-xen: use xen_alloc/free_coherent_pages")
> Signed-off-by: Roman Skakun <roman_skakun@epam.com>
> Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
> [hch: split the patch, renamed the helpers]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/ops_helpers.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> index 910ae69cae77..af4a6ef48ce0 100644
> --- a/kernel/dma/ops_helpers.c
> +++ b/kernel/dma/ops_helpers.c
> @@ -5,6 +5,13 @@
>   */
>  #include <linux/dma-map-ops.h>
>
> +static struct page *dma_common_vaddr_to_page(void *cpu_addr)
> +{
> +       if (is_vmalloc_addr(cpu_addr))
> +               return vmalloc_to_page(cpu_addr);
> +       return virt_to_page(cpu_addr);
> +}
> +
>  /*
>   * Create scatter-list for the already allocated DMA buffer.
>   */
> @@ -12,7 +19,7 @@ int dma_common_get_sgtable(struct device *dev, struct s=
g_table *sgt,
>                  void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                  unsigned long attrs)
>  {
> -       struct page *page =3D virt_to_page(cpu_addr);
> +       struct page *page =3D dma_common_vaddr_to_page(cpu_addr);
>         int ret;
>
>         ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> @@ -32,6 +39,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_=
struct *vma,
>         unsigned long user_count =3D vma_pages(vma);
>         unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
>         unsigned long off =3D vma->vm_pgoff;
> +       struct page *page =3D dma_common_vaddr_to_page(cpu_addr);
>         int ret =3D -ENXIO;
>
>         vma->vm_page_prot =3D dma_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -43,7 +51,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_=
struct *vma,
>                 return -ENXIO;
>
>         return remap_pfn_range(vma, vma->vm_start,
> -                       page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgo=
ff,
> +                       page_to_pfn(page) + vma->vm_pgoff,
>                         user_count << PAGE_SHIFT, vma->vm_page_prot);
>  #else
>         return -ENXIO;
> --
> 2.30.2
>


--=20
Best Regards, Roman.
