Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CFB34AC50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhCZQJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:09:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A607761A26;
        Fri, 26 Mar 2021 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616774973;
        bh=3/Hwt+1yo2BE6llfw3ccgcVv3CP6bjLi789k3A1nvJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pFDHUbIWX0XQ2bffCr3Ni+c/thTO8WyCrkV2Xa99Tsz7QUERvF/83/ddOlUFO+/cv
         LPkEP93MLXWF+R9dW3gubMBAG4MwTC4nVNMcw15071cUA5O5nr373Pg94WkrN5yMbU
         yMTAjHlY9e8JXqsA1u5TNC5XcMSmWIfpKXSlynsORnnup5U3yALbuysdspV8N1FpRN
         NlYrc/9JetjKSxjexDQRyf8xo9OiTfhAW9vaXRwHmgMxTK4b9Bn2g9biuiytpLkxaC
         bvaoP793Hlm/wbn6wR6N3/Evl6I6q/gAgVF5HeqbYhMM2L4xZx0GQYBptg0OJAP7DA
         KJ0jjvAShuBnQ==
Received: by mail-oi1-f178.google.com with SMTP id x207so6201764oif.1;
        Fri, 26 Mar 2021 09:09:33 -0700 (PDT)
X-Gm-Message-State: AOAM533xPdSslg4n0Pndkm8m4QbaPtteLA96fUTCmVyNRAjpekLYpTj6
        PD2tk/TCQBurck7V3nBt/UtssvRyzDmqZCg406w=
X-Google-Smtp-Source: ABdhPJzbtKWXDRaV1Cue/5KoUdiom8nvmS77pXZB0AAzADNPV10yiYUw9jZFMqTVgfMq1yfLJ7qTG1dwaVRF/NWkIGw=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr10383952oie.4.1616774972941;
 Fri, 26 Mar 2021 09:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com> <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
In-Reply-To: <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Mar 2021 17:09:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0w1VisRvAQsHugZdzwpW-nc7Qb0pgNziz+MHfXNJcxQw@mail.gmail.com>
Message-ID: <CAK8P3a0w1VisRvAQsHugZdzwpW-nc7Qb0pgNziz+MHfXNJcxQw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     sven@svenpeter.dev, Rob Herring <robh@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 4:59 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Arnd Bergmann <arnd@kernel.org>
> > Date: Thu, 25 Mar 2021 22:41:09 +0100
> >
> > On Thu, Mar 25, 2021 at 8:53 AM Sven Peter <sven@svenpeter.dev> wrote:
> > > On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
> > >
> > > I'm probably just confused or maybe the documentation is outdated but I don't
> > > see how I could specify "this device can only use DMA addresses from
> > > 0x00100000...0x3ff00000 but can map these via the iommu to any physical
> > > address" using 'dma-ranges'.
> >
> > It sounds like this is a holdover from the original powerpc iommu,
> > which also had a limited set of virtual addresses in the iommu.
> >
> > I would think it's sufficient to describe it in the iommu itself,
> > since the limitation is more "addresses coming into the iommu must
> > be this range" than "this device must use that address range for
> > talking to the iommu".
> >
> > If the addresses are allocated by the iommu driver, and each iommu
> > only has one DMA master attached to it, having a simple range
> > property in the iommu node should do the trick here. If there might
> > be multiple devices on the same iommu but with different address
> > ranges (which I don't think is the case), then it could be part of
> > the reference to the iommu.
>
> The ADT has properties on the iommu node that describe the adresses it
> accepts for translation ("vm-base" and "vm-size").  So I think we can
> safely assume that the same limits apply to all DMA masters that are
> attached to it.  We don't know if the range limit is baked into the
> silicon or whether it is related to how the firmware sets things up.
> Having the properties on the iommu node makes it easy for m1n1 to
> update the properties with the right values if necessary.

Ok.

> Some of the DARTs provide a bypass facility.  That code make using the
> standard "dma-ranges" property tricky.  That property would need to
> contain the bypass address range.  But that would mean that if the
> DART driver needs to look at that property to figure out the address
> range that supports translation it will need to be able to distinguish
> between the translatable address range and the bypass address range.

I'm not following here. Do you mean the bus address used for bypass is
different from the upstream address that gets programmed into the iommu
when it is active?

          Arnd
