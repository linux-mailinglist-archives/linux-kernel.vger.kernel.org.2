Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2283A66E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhFNMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhFNMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:49:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C916C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 05:47:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn21so20022247ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUObwUNWvgk8Ic1w7m2h32Aq1YfuXrxksajQxqaMrIs=;
        b=rj6ZqtY0hWRNdi47dSpXnG5VlOgr15kVbYhmu6VWU8u6FjoktZ8tvzKvzlkPnDP+pV
         XO3nhrT0y6qyTJZjPH5sSQnLiK2So2RyVxzuj8bZTSrohk/KJTgF8P077y+Fvbm3p3MS
         adrMOeNBlgRIAQ8M4JksRyHAk91ctiTVHRxKE+Ysd4cv7fxq0GrTjF2zot+++owhWgOZ
         akrE4+2kZBZEEm5a4N3TOZdjIGXh/Ipfb6XTfSeGKR/mE8wojx+WFi//AUD6f13s38T+
         dh0ynmjkc4C4o/Er1BLAEQaXeS2zTdDzm++TKc2dXCS2gvmp9hROmv+KiK5rYRK9W/Lu
         mMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUObwUNWvgk8Ic1w7m2h32Aq1YfuXrxksajQxqaMrIs=;
        b=lZBsLmrGeVYs6f9RbW6xLuL2TBQctIz45cBkkvQptkN+Kv43qry+2h6/YinY7ZjRAl
         TBa0CpVadi1pA7mal8US4Tfpwp/uqPc7iIpG7FJvn3q6GFRsbacR5aYcXXpXHFEN8TcW
         VIzu6hHPZ1loB6ihyNv9L3axS8FaKQqNqQ3E147CEjyQ6LVxus0rC7FnZC7csJI2lhWd
         eHNjFXyojJRf1hbB4bFMtBXfCvAhsjjbYNFiYW40oadnpSixm0MBC9zvvebHeiD/r7Gi
         +obsWU6c9kdU9j+kzgdXPmot1KQZ8W9FXHft/uVXgzcfr/506Wf+qApUcrWcSzgsf4SQ
         Q6Hw==
X-Gm-Message-State: AOAM53251Zo/bhXF/KYM71XWZ0YlPvNh08b/0gyd6EJFocxOGWn7P+tP
        Lm0qIMW0mCjYEOSAL0N+WhgZCjur4YR9FKzVu50=
X-Google-Smtp-Source: ABdhPJxC86d8VXC4py9RRymEPfI5ESRE2fKe8HepltlfpWhz75a3A3JMLKsQJcx2NkZi9XGq2Uggz8yzDs460UQlrTk=
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr13710166ljp.66.1623674855928;
 Mon, 14 Jun 2021 05:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611095528.9230-1-roman_skakun@epam.com> <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
In-Reply-To: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Mon, 14 Jun 2021 15:47:25 +0300
Message-ID: <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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

Hey, Boris!
Thanks for the review.

I have an additional question about current implementation that disturbed m=
e.
I think, that we can have cases when mapped memory can not be
physically contiguous.
In order to proceed this correctly need to apply some additional steps
to current implementation as well.

In mmap() :
1. Is the memory region physically contiguous?
2. Remap multiple ranges if it is not.

In get_sgtable() :
1. Is the memory region physically contiguous?
2. Create sgt that will be included multiple contiguous ranges if it is not=
.

What do you think about it?

Cheers!
Roman


=D0=BF=D1=82, 11 =D0=B8=D1=8E=D0=BD. 2021 =D0=B3. =D0=B2 18:20, Boris Ostro=
vsky <boris.ostrovsky@oracle.com>:
>
>
> On 6/11/21 5:55 AM, Roman Skakun wrote:
> >
> > +static int
> > +xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> > +             void *cpu_addr, dma_addr_t dma_addr, size_t size,
> > +             unsigned long attrs)
> > +{
> > +     unsigned long user_count =3D vma_pages(vma);
> > +     unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +     unsigned long off =3D vma->vm_pgoff;
> > +     struct page *page;
> > +
> > +     if (is_vmalloc_addr(cpu_addr))
> > +             page =3D vmalloc_to_page(cpu_addr);
> > +     else
> > +             page =3D virt_to_page(cpu_addr);
> > +
> > +     vma->vm_page_prot =3D dma_pgprot(dev, vma->vm_page_prot, attrs);
> > +
> > +     if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
> > +             return -ENXIO;
> > +
> > +     if (off >=3D count || user_count > count - off)
> > +             return -ENXIO;
> > +
> > +     return remap_pfn_range(vma, vma->vm_start,
> > +                     page_to_pfn(page) + vma->vm_pgoff,
> > +                     user_count << PAGE_SHIFT, vma->vm_page_prot);
> > +}
>
>
> I suggest you create a helper for computing page value and then revert 92=
2659ea771b3fd728149262c5ea15608fab9719 and pass result of the helper instea=
d of cpu_addr. Here and in xen_swiotlb_dma_get_sgtable().
>
>
> And use this new helper in xen_swiotlb_free_coherent() too. I am curious =
though why this was not a problem when Stefano was looking at the problem t=
hat introduced this vmalloc check (i.e. 8b1e868f66076490189a36d984fcce286cd=
d6295). Stefano?
>
>
> -boris



--=20
Best Regards, Roman.
