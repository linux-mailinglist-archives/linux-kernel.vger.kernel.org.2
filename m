Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF5E3C9290
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhGNUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGNUyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 480C1613D6;
        Wed, 14 Jul 2021 20:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626295911;
        bh=xAyIdXe/5fhq34AXTyvgdjHjmK5ndfv86zQ48bk0AJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WLPrmbY+/4G0TvI9fg6g5W/gH96ZMYa8lj/uZ1BhLE7SH6PB/P5a9HYbijdqUuTaL
         sKsL7R7hmGI11aE99N7FLPfwE3VMeU1/b1xpb5GNPUMfW8ydK8bson3RLBs3XgvcSW
         j+QxsuNrxkwlwLiPecBRrXHTMYmQDrJuxcdq4u3+yBdIOcUfsSR++EYhTBXZTzH9Fw
         cgAYzwKQ1QEUqUsmDwWaiYAdNscr3871knlhHMs5zteG+7IXqtoyalqWc9OBCnjGK2
         eDSOoI4b/akid9ZOzp/NBUWMJMmuDVllwd3O7bRU2DVDv22glZx6Dda2Foy75q6uvd
         bmHQoij/psogw==
Received: by mail-wm1-f44.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so4712657wmi.2;
        Wed, 14 Jul 2021 13:51:51 -0700 (PDT)
X-Gm-Message-State: AOAM532mKi7LkyGM3mmln76qhIzZOytr9zuKImsB5vgj6MmwP/b3QEtl
        5+zwvm2YWvC1hCi8aN4TJgyOFVx00YKBNxBKxOc=
X-Google-Smtp-Source: ABdhPJz63KW2Ft3EbkVjZmLO4vq5WYRyfYEAftI+sXxudBSXv9441/KxGl10WXB7ZvaYYnopUapzerEF9J1s+q7gcgU=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr6068054wmh.120.1626295909914;
 Wed, 14 Jul 2021 13:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210627143405.77298-1-sven@svenpeter.dev> <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
In-Reply-To: <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 14 Jul 2021 22:51:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
Message-ID: <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Apple M1 DART IOMMU driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        DTML <devicetree@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 8:21 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-27 15:34, Sven Peter wrote:
> [...]
> > In the long term, I'd like to extend the dma-iommu framework itself to
> > support iommu pagesizes with a larger granule than the CPU pagesize if that is
> > something you agree with.
>
> BTW this isn't something we can fully support in general. IOMMU API
> users may expect this to work:
>
> iommu_map(domain, iova, page_to_phys(p1), PAGE_SIZE, prot);
> iommu_map(domain, iova + PAGE_SIZE, page_to_phys(p2), PAGE_SIZE, prot);
>
> Although they do in principle have visibility of pgsize_bitmap, I still
> doubt anyone is really prepared for CPU-page-aligned mappings to fail.
> Even at the DMA API level you could hide *some* of it (at the cost of
> effectively only having 1/4 of the usable address space), but there are
> still cases like where v4l2 has a hard requirement that a page-aligned
> scatterlist can be mapped into a contiguous region of DMA addresses.

I think that was the same conclusion we had earlier: the dma-mapping
interfaces should be possible for large iotlb pages, but any driver directly
using the IOMMU API, such as VFIO, would not work.

The question is how we can best allow one but not the other.

         Arnd
