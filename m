Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643923B7C69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 06:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhF3EKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:10:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD687C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:07:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t12so1517650ile.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CihQJs+V2hzOjNrHEUutiYZNJeDLEZFfM+aC788Ls8Y=;
        b=hJf8jbdNdk8vtynuUvXJ5WOrCidPZV0ovCwVJiPYwT8VAp2CGtXqIImAWtyYArBKqS
         VGpM2s2BD09PWsOu5wPYUcfeExYjrVlwTEbifmekSaMQetnUaCjGZMDQp+yMXtFfbK8A
         ID3GlMsw+AcrU4wP0WdIEOG6w/0A4ocVeY0l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CihQJs+V2hzOjNrHEUutiYZNJeDLEZFfM+aC788Ls8Y=;
        b=Cp/zeicyw5SCPkyEHwMBjiNuxypjODCPdNqpTCZir3mqTy3AoRJ7mNMSUEpmpL2RkD
         5LF+ARFTA7ZA5YmVav9YMa1Gwwapbb5ePty6yxG6vBTbvd1QlpA/aFAwNhP93wR39G2t
         AZaDyRytELpUpZA0mHyvMQDbXOyi8ty/SZavCZRGxmYaX1Dbv9eFDvTjXxhx1kPm6Pxc
         j6Rq1Xbca+UKrFspLilCMYaHd3O5LT5+9jDlHjyYGm6kFC0zqzXIHDxjn8ztvt4WQRvg
         K3AMG/4xVk7IVSZoLbhWZ+s0Yr/51I0koUN2Jh1ap9p6V2alSAjnUm1Z9pNT4h3jbq5i
         aeFQ==
X-Gm-Message-State: AOAM531u8HpmOYC5MixjmfBPHtgMt9pM9PkFbrcTXppWBhA0uwMdEWSa
        PtSVwe6kVkOCCAJ//Ce2gZAdwm/xbs56SA==
X-Google-Smtp-Source: ABdhPJzaYxWikUaGviCMBCScH32rZBwQzPRTuuK4RH2rxxjzn8lNwGyTNCUZucUXePQ4KI1rJO14Zw==
X-Received: by 2002:a05:6e02:1246:: with SMTP id j6mr25047279ilq.30.1625026072124;
        Tue, 29 Jun 2021 21:07:52 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id a12sm3980023ilt.3.2021.06.29.21.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s11so286330ilt.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d10:: with SMTP id i16mr5467198ila.5.1625026071072;
 Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210629121625.3633999-1-tientzu@chromium.org> <7f544c68-721c-bbcc-3614-cbadce7261a9@arm.com>
In-Reply-To: <7f544c68-721c-bbcc-3614-cbadce7261a9@arm.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 30 Jun 2021 12:07:40 +0800
X-Gmail-Original-Message-ID: <CALiNf2-WcZo=fyaZqw2axyE-KTmGT0HRqvKiN0NZ5=VKmvA0bQ@mail.gmail.com>
Message-ID: <CALiNf2-WcZo=fyaZqw2axyE-KTmGT0HRqvKiN0NZ5=VKmvA0bQ@mail.gmail.com>
Subject: Re: [PATCH v2] swiotlb: fix implicit debugfs_create_dir declaration
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 8:52 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-29 13:16, Claire Chang wrote:
> > Remove the ifdef to fix implicit function declaration for other pools.
> >
> > Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
>
> There doesn't appear to be a problem with that commit - AFAICS it's
> 461021875c50 ("swiotlb: Add restricted DMA pool initialization") which
> introduces a reference to debugfs_create_dir() outside the existing
> #ifdef guards.
>
> FWIW (assuming it's the real problem) I'd be inclined to factor out the
> debugfs bits from rmem_swiotlb_device_init() into a separate
> rmem_swiotlb_debugfs_init() (or similar) function which can live
> alongside the others under the #ifdef and be stubbed out in an #else case.

v3 here: https://lore.kernel.org/patchwork/patch/1452807/

>
> Robin.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   kernel/dma/swiotlb.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 0ffbaae9fba2..8ae0bef392c3 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -36,9 +36,7 @@
> >   #include <linux/scatterlist.h>
> >   #include <linux/mem_encrypt.h>
> >   #include <linux/set_memory.h>
> > -#ifdef CONFIG_DEBUG_FS
> >   #include <linux/debugfs.h>
> > -#endif
> >   #ifdef CONFIG_DMA_RESTRICTED_POOL
> >   #include <linux/io.h>
> >   #include <linux/of.h>
> > @@ -686,7 +684,6 @@ bool is_swiotlb_active(struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(is_swiotlb_active);
> >
> > -#ifdef CONFIG_DEBUG_FS
> >   static struct dentry *debugfs_dir;
> >
> >   static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
> > @@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
> >
> >   late_initcall(swiotlb_create_default_debugfs);
> >
> > -#endif
> > -
> >   #ifdef CONFIG_DMA_RESTRICTED_POOL
> >   struct page *swiotlb_alloc(struct device *dev, size_t size)
> >   {
> >
