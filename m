Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBD3063DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbhA0TL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344381AbhA0TKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:10:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C984A64DCA;
        Wed, 27 Jan 2021 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611774579;
        bh=CxVDcZVJbTgcZjdsMfJhxJ/yjKbh0SkOEhIy1FhN6KI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dMLi9XGhBP7sr8rYS8BJ6RsXQgysILPqv1nJNJw5qZ2DyBAUhNdQHjQzvgV8VDl5V
         i9ALC6nJBeYrDal6V0wxRS4Oj1rRdlQYA2H+6vx80Ni8//ZnxbR84eJSWfwHwrfZ+m
         huSnvJCgYsqg1ZdsYmI36XpPssTAyzZXC+4+K+R4HGTQDEa3D+1wQRcxlMx60l4siq
         AfiYedGDWYh3rdmwOf3EskK8mgLe27CYkM02ik5LmlsDCtLrT6rKv/7dbdltGG8jZf
         /EYeZUc7HMTHGMwYIun5xzt1qfY9eHYEiUSksWtwoi1uycXl8bbKrxFsjyJ+0QBHbZ
         W+EkVBD/JX9uw==
Received: by mail-ed1-f46.google.com with SMTP id f1so3751203edr.12;
        Wed, 27 Jan 2021 11:09:38 -0800 (PST)
X-Gm-Message-State: AOAM533ee0bvwVtjxOHRSPUstARXrusgjWfaHvh6j6X6pI80TFi5R4Qg
        iTnnoL1iHMyfl+PBj8afjaftyZbpImDXpHPFPw==
X-Google-Smtp-Source: ABdhPJxDhEsE7SeDYEXoCEJP81XWI54Z2K7fxKs16oNcCLHvf630uv8EyH4cluj/eac/SPi55kJ7fCq1wMrnsmcwKMs=
X-Received: by 2002:a05:6402:1751:: with SMTP id v17mr10650676edx.289.1611774577245;
 Wed, 27 Jan 2021 11:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20210119105203.15530-1-yong.wu@mediatek.com> <YBFj9whLvqlV2erm@aptenodytes>
 <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
In-Reply-To: <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 27 Jan 2021 13:09:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
Message-ID: <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 7:13 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> [ + Christoph, Marek ]
>
> On 2021-01-27 13:00, Paul Kocialkowski wrote:
> > Hi,
> >
> > On Tue 19 Jan 21, 18:52, Yong Wu wrote:
> >> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> >> supplanting dma_pfn_offset") always update dma_range_map even though it was
> >> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> >> This patch avoid this(Updating it only when dev has valid dma-ranges).
> >>
> >> Meanwhile, dma_range_map contains the devices' dma_ranges information,
> >> This patch moves dma_range_map before of_iommu_configure. The iommu
> >> driver may need to know the dma_address requirements of its iommu
> >> consumer devices.
> >
> > Just a gentle ping on this issue, it would be nice to have this fix merged
> > ASAP, in the next RC :)
>
> Ack to that - Rob, Frank, do you want to take this through the OF tree,
> or shall we take it through the DMA-mapping tree like the original culprit?

I've already got some fixes queued up and can take it.

Suggested-by doesn't mean you are happy with the implementation. So
Acked-by or Reviewed-by?

Rob
