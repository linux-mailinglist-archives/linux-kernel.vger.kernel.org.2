Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1B30EAD7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhBDDTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBDDTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:19:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB1C061573;
        Wed,  3 Feb 2021 19:18:53 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id j5so1693493iog.11;
        Wed, 03 Feb 2021 19:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZiFYdS72YXSF/YcGe+WmP/kvp/Q5JIvKaSw7pcHJWA=;
        b=hH6n317tODhtW1eRiw0q6H0BcGIlYcbBt8e4FRq2vp5JHlhLTnWrH82VZR7jnSXyA6
         5UOKoKnnfc5XEgNSJ3owPgQnppne7gFAnl8/8vs9jYRsdDyRjd/tt/iauK+6fSli3Dlp
         R9U0Bnggmj7z/QcLYisWXTMeYBRZCADdTygmtuXM9I9kDJm7UCGn3GCKZtRHFxWgXySl
         fd1RSPgWL2i3kRmFmckrXEnzdzU5oINDAlS5uNq1vV1sdKcgudsgMT+26ZjOIT/bxdPG
         F0tbP/0OUxgvtoTn7xCLJTwC5S8LGC5MUMo4tHWKdxhJGST7IJ9NRhb78pZ+ug5gVHty
         cMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZiFYdS72YXSF/YcGe+WmP/kvp/Q5JIvKaSw7pcHJWA=;
        b=iD/66i0UKsrB7ZiMTjLie658ITjwPa5w5o2FRs4ln19k5SMe9hqCY8cNs8u/ky16oJ
         gxCnE9zo0CXIe2y2/YKdIo5qIJHdJir/IM+Hl0TlT/Yp1nRA5bHrABpFZbrcoUhTZ19O
         U2CztpWhcIsqXutP6dS+gERO7nB7VjjTCDDBbzfVaJDl7eUc5egy+lDveYgPZubwK/X3
         EGLFf3KSzVayWBk928BB7PMBeG0J4NvU6BQRPIyxGOnzZp15iRfBkGQLoMS51OYKaCXc
         4WKM6qBJO04cmKiTnxC5+27pTwHsY+JGCjSCxc8oov+8zYj9F1V5eMYD2pg0772Fp5tC
         RxkA==
X-Gm-Message-State: AOAM531xKDnEEFynkt7ylSRFxy+vTllRAbVW5CABOiEngmsw4MtSKh+l
        KWiyh4jO7i8RF5moZwya2N5M5cXCv6sAodt1jZU=
X-Google-Smtp-Source: ABdhPJxbxiBXBnRWIlSF2MVAG+Lc4eNFMSRSxXep/mfEYl/G3WZThA77PSJaoeG4ONXxqjQkCICKjiim+guzwid5Ng4=
X-Received: by 2002:a05:6638:35a3:: with SMTP id v35mr6064046jal.36.1612408732602;
 Wed, 03 Feb 2021 19:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-3-zhang.lyra@gmail.com>
 <eb55a1de-2816-9029-b642-b3067e311417@infradead.org>
In-Reply-To: <eb55a1de-2816-9029-b642-b3067e311417@infradead.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 4 Feb 2021 11:18:16 +0800
Message-ID: <CAAfSe-sKqzub08kBgYNimBwbaf5s-Ed=Ef3PcMvA_8YTYsDwUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iommu: add Unisoc iommu basic driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 01:44, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 1:07 AM, Chunyan Zhang wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 192ef8f61310..99e7712f3903 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -408,4 +408,16 @@ config VIRTIO_IOMMU
> >
> >         Say Y here if you intend to run this kernel as a guest.
> >
> > +config SPRD_IOMMU
> > +     tristate "Unisoc IOMMU Support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     select IOMMU_API
> > +     help
> > +       Support for IOMMU on Unisoc's SoCs, this iommu can be used by
>
>         s/iommu/IOMMU/ please

Sure, thanks.

Chunyan

>
> > +       Unisoc's multimedia devices, such as display, Image codec(jpeg)
> > +       and a few signal processors, including VSP(video), GSP(graphic),
> > +       ISP(image), and CPP(camera pixel processor), etc.
> > +
> > +       Say Y here if you want to use the multimedia devices listed above.
>
>
> --
> ~Randy
