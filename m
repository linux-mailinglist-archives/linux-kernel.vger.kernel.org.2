Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00E43C7DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhGNFCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:02:30 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47076
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhGNFC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:02:29 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 59D614054E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626238777;
        bh=IuNCZleIvRlLDBhEJUxcoa5xesWkXuXCrji39Y/aMPw=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=oRphYpdinUW/r8iLyGw3EUSNu2NsivHyjeqX2j8GRgZ8bjLta2Ygj4h0Ajz4Fi4y/
         n+vldnmywXFuU7cbngTgTso66ZWOhjlvOPRiK27haqSN0xFEh/4QhCeSJCkqIXtYjn
         37jOMvptS2FCK50fYlXaNcCKp11RlGtE1RmmNK2hro8W0QkhZqX/BOMGrYY6B0dxHF
         CHI9No5i0VhlyNUIH7XmCJ3JLuCpY9UuBiNl6bJBlRI+YTcsxGuz/07+r3tFHpPCPl
         To5ngp+FPR/yQan+hAHm2FaVhH7KqdRWBM6kNRwYmvhxOAJeg8gAfq894Ot8MKIyGl
         iraVwnxcqjEpA==
Received: by mail-ed1-f71.google.com with SMTP id v4-20020a50a4440000b02903ab1f22e1dcso546057edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 21:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuNCZleIvRlLDBhEJUxcoa5xesWkXuXCrji39Y/aMPw=;
        b=cbmbNHAvG/BxapAqr3v/XH15KO/J/MFWshzIsfsvG+x7/+0IDUJyRfEvonmFavzp2u
         F9Cc3mQ0kvhOtyN+v9EClyzjrvGk1aJ079oLl6Ei2MIEeAxZ25Yd//zwB+zg/dIvu+w+
         hkxq9MGUoefoC2kbxp6dHbq4/Xm+TjrptE0qDouQlk9iKATWVPqfTMEKrlMW9xtTcAyz
         SIeirmOfiXJg6dpP3YVGj383XAep9P3HrCZu9i7lH1+wcc2sz0c7FvwBxAzZ2pTUdznT
         ELBNgv3zJqAQCHwx3YRcKZaDtn2xQwSzHnj7zROa9QbxRkEMb9UK+0/9OqmT5U5UbxA/
         8K2Q==
X-Gm-Message-State: AOAM531OGFfBXYl4O8Zk+MfbGVh6WYncgrXOmOXH2rSi9y5/dZDyJNS8
        Elk0cbLpp+yfaAi6iMbJGhdotzTEXqtCEXcvC8QRDNM3LXuAkCL1kFTOhoY8Ga6U/Yz2nEPOnfy
        C1tT97/fAfl8tbXsiYlSTxl90VBmJhOxz6q4LDRagofZ2wOAU6TlDIUw4/Q==
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr10478505ejc.192.1626238777054;
        Tue, 13 Jul 2021 21:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRbJHePPsqGNhB2jafTmgA7eCmZexPsfPxuY56irzwgXiVYXY8NchRXgcLJLBngqftlOI645bXKZZ6n8PRSoc=
X-Received: by 2002:a17:907:724b:: with SMTP id ds11mr10478490ejc.192.1626238776826;
 Tue, 13 Jul 2021 21:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com> <YO4odF0EwqxfNLFq@fedora>
In-Reply-To: <YO4odF0EwqxfNLFq@fedora>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Jul 2021 12:59:25 +0800
Message-ID: <CAAd53p4jgKGuLOyZH+KEzz-KiR2D0Th4MCBo13m4JO+a=n2Lhw@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 7:57 AM Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:
>
> On Thu, Jul 08, 2021 at 03:43:42PM +0100, Robin Murphy wrote:
> > On 2021-07-08 14:57, Kai-Heng Feng wrote:
> > > On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 2021-07-08 10:28, Joerg Roedel wrote:
> > > > > On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> > > > > > @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
> > > > > >
> > > > > >               iommu = amd_iommu_rlookup_table[dev_data->devid];
> > > > > >               dev_data->iommu_v2 = iommu->is_iommu_v2;
> > > > > > +
> > > > > > +            if (dev_data->iommu_v2)
> > > > > > +                    swiotlb = 1;
> > > > >
> > > > > This looks like the big hammer, as it will affect all other systems
> > > > > where the AMD GPUs are in their own group.
> > > > >
> > > > > What is needed here is an explicit check whether a non-iommu-v2 device
> > > > > is direct-mapped because it shares a group with the GPU, and only enable
> > > > > swiotlb in this case.
> > > >
> > > > Right, it's basically about whether any DMA-limited device might at any
> > > > time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
> > > > possibility of device hotplug and the user being silly with the sysfs
> > > > interface, I don't think we can categorically determine that at boot time.
> > > >
> > > > Also note that Intel systems are likely to be similarly affected (in
> > > > fact intel-iommu doesn't even have the iommu_default_passthough() check
> > > > so it's probably even easier to blow up).
> > >
> > > swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> > > disable it.
> >
> > Oh, right... I did say I found this dance hard to follow. Clearly I
> > shouldn't have trusted what I thought I remembered from looking at it
> > yesterday :)
> >
> > Also not helped by the fact that it sets iommu_detected which *does* disable
> > SWIOTLB, but only on IA-64.
> >
> > > I wonder if we can take the same approach in amd-iommu?
> >
> > Certainly if there's a precedent for leaving SWIOTLB enabled even if it
> > *might* be redundant, that seems like the easiest option (it's what we do on
> > arm64 too, but then we have system topologies where some devices may not be
> > behind IOMMUs even when others are). More fun would be to try to bring it up
> > at the first sign of IOMMU_DOMAIN_IDENTITY if it was disabled previously,
> > but I don't have the highest hope of that being practical.
>
> <scratches his head>
> It is kind of silly to enable SWIOTLB which will just eat 64MB of memory
> "just in case".
>
> The SWIOTLB does have support to do late initialization (xen-pcifront
> does that for example - so if you add devices that can't do 64-bit it
> will allocate something like 4MB).
>
> Would that be a better choice going forward - that is allocate this
> under those conditions?

But how to practically do swiotlb late init on 32-bit capable devices?
On the first DMA map requested by the driver?

Kai-Heng

> >
> > Robin.
